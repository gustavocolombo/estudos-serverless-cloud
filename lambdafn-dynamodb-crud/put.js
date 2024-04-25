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
    Key: {
      id: parseInt(event["taskId"], 10),
    },
    UpdateExpression: "set #a = :x, #b = :d",
    ExpressionAttributeNames: {
      "#a": "done",
      "#b": "updatedAt",
    },
    ExpressionAttributeValues: {
      ":x": data.done,
      ":d": new Date().toISOString(),
    },
  };

  try {
    await dynamo.update(params).promise();

    console.log({
      message: "Task updated",
      data: JSON.stringify(params),
    });

    return response(200, "Record updated");
  } catch (err) {
    console.log(err);
    throw new response(500, "Operation failed");
  }
};
