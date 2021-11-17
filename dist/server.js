"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.startServer = startServer;

var _express = _interopRequireDefault(require("express"));

var _routes = require("./routes");

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function startServer(port = process.env.PORT || 3000) {
  const app = (0, _express.default)();
  console.log(process.env.PORT);
  app.use('/', (0, _routes.getRoutes)());
  return new Promise(resolve => {
    const server = app.listen(port, () => {
      console.log(`listening on http://localhost:${port}`);
    });
  });
}