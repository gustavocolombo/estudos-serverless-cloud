module.exports = function (status, body) {
  return {
    statusCode: status,
    body: JSON.stringify(body),
    headers: {
      "Content-type": "application/json",
    },
  };
};
