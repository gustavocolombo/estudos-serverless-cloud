const AWS = require("aws-sdk");
const dynamo = new AWS.DynamoDB.DocumentClient();

const normalizer = require("./normalizer");
const response = require("./response");

exports.handler = async (event) => {
  if (process.env.DEBUG) {
    console.log({
      message: "Event received",
      data: JSON.stringify(event),
    });
  }

  const table = event.table || process.env.TABLE;

  if (!table) {
    throw new Error("No table received to perform operations");
  }

  const { pathParameters } = normalizer(event);

  const params = {
    TableName: table,
  };

  try {
    let data = {};
    if (pathParameters && pathParameters["taskId"]) {
      data = await dynamo
        .get({
          ...params,
          Key: {
            id: parseInt(pathParameters["taskId"], 10),
          },
        })
        .promise();
    } else {
      data = await dynamo.scan(params).promise();
    }

    return response(200, data);
  } catch (err) {
    console.log(err);
    throw new response(500, "Operation failed");
  }
};
