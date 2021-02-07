const { CPPBridge } = require("./build/Release/ble_mm");

const cppBridge = new CPPBridge();

cppBridge.init();

setTimeout(() => console.log("done"), 3000);
