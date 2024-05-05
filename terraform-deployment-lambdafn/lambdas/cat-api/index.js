const got = require("got");

exports.handler = async (event) => {
  console.log({
    message: "Received event",
    data: event,
  });

  try {
    const response = await got("https://aws.random.cat/meow");

    console.log(response.data);

    return {
      status: 200,
      body: JSON.parse(response.body),
    };
  } catch (error) {
    console.log(error);
    throw new Error(error);
  }
};
