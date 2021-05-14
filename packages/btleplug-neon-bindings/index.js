const { ble } = require(".");

console.log("### before ble");
console.log(ble());
console.log("### after ble");
setTimeout(() => console.log("done"), 5000);
