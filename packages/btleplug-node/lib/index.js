const addon = require("../native/index.node");

const john = new addon.Employee(1, "John");
console.log("id", john.id());
console.log("name", john.name());
