const { EventEmitter } = require("events");
const { inherits } = require("util");
const { CPPBridge } = require("./build/Release/ble_mm");

inherits(CPPBridge, EventEmitter);

const cppBridge = new CPPBridge();

cppBridge.on("stateChange", state => {
  console.log("got event", "stateChange", state);
});
