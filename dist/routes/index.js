"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.getRoutes = getRoutes;

var _express = _interopRequireDefault(require("express"));

var _reviews = require("./reviews");

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function getRoutes() {
  const router = _express.default.Router();

  router.use('/reviews', (0, _reviews.reviewsRoutes)());
  return router;
}