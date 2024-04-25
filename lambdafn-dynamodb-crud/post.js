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

  const { data } = normalizer(event);

  const params = {
    TableName: table,
    Item: {
      ...data,
      createdAt: new Date().toISOString(),
    },
  };

  try {
    await dynamo.put(params).promise();

    console.log({
      message: "Task created successfuly",
      data: JSON.stringify(params),
    });

    return response(201, "Record created successfuly");
  } catch (err) {
    console.log(err);
    return response(500, "Operation failed");
  }
};
