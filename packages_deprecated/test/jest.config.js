module.exports = {
  collectCoverage: true,
  coverageProvider: "babel",
  errorOnDeprecated: true,
  notify: true,
  testEnvironment: "node",
  coverageThreshold: {
    global: {
      branches: 100,
      functions: 100,
      lines: 100,
      statements: 100,
    },
  },
  // notifyMode: "failure-change",
  // projects: undefined,
  // verbose: undefined,
};
