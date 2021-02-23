const { EventEmitter } = require("events");
const { inherits } = require("util");
const { CPPBridge } = require("./build/Release/ble_mm");

inherits(CPPBridge, EventEmitter);

const cppBridge = new CPPBridge();

cppBridge.on("message", msg => {
  console.log("message", msg);

  if (msg === "poweredOn") {
    cppBridge.scan();
  }
});
