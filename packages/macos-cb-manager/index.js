const { CPPBridge } = require("./build/Release/ble_mm");

const cppBridge = new CPPBridge();

cppBridge.init();
