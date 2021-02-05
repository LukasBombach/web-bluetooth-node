const events = require("events");
const util = require("util");

const NobleMac = require("./native/binding").NobleMac;

module.exports = new NobleMac();
