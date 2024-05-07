const axios = require("axios");

exports.handler = async (event) => {
  console.log({
    message: "Received event",
    data: event,
  });

  try {
    const randomPoke = Math.floor(Math.random() * 100);

    const response = await axios(
      `https://pokeapi.co/api/v2/pokemon/${randomPoke}/`
    );

    const pokeName = response.data.forms[0].name;

    return {
      status: 200,
      data: pokeName,
    };
  } catch (error) {
    console.log(error);
    throw new Error(error);
  }
};
