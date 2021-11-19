"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.db = void 0;

var _mongoose = _interopRequireDefault(require("mongoose"));

var _models = require("./models");

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

_mongoose.default.connect('mongodb://localhost:27017/reviews');

const db = {
  saveReview: data => {
    // console.log(data);
    const review = new _models.models.Review(data); // console.log(review);

    review.save().then(data => {
      console.log(data);
    });
  },
  saveMeta: data => {
    const meta = new _models.models.Meta(data);
    console.log(data);
  }
};
exports.db = db;