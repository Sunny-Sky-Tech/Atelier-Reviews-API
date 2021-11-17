"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.db = void 0;

var _mongoose = _interopRequireDefault(require("mongoose"));

var _models = _interopRequireDefault(require("./models"));

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

main.catch(err => console.log(err));

async function main() {
  await _mongoose.default.connect('mongodb://localhost:27017/reviews');
}

const db = {
  save: data => {
    const review = new _models.default.Review(data);
    review.save();
  }
};
exports.db = db;