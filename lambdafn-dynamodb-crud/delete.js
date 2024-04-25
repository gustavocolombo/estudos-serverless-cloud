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
    throw new Error("No table received to perform operation");
  }

  const {
    data: { id },
  } = normalizer(event);

  const params = {
    TableName: table,
    Key: {
      id: parseInt(id, 10),
    },
  };

  try {
    await dynamo.delete(params).promise();

    console.log({
      message: "Task deleted",
      data: JSON.stringify(params),
    });

    return response(200, data);
  } catch (err) {
    console.log(err);
    throw new response(500, "Operation failed");
  }
};
