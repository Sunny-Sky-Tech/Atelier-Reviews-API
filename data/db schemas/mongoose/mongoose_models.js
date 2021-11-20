"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.models = void 0;

var _mongoose = _interopRequireDefault(require("mongoose"));

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

const {
  Schema
} = _mongoose.default;
const reviewSchema = new Schema({
  product_id: Number,
  rating: Number,
  summary: String,
  recommend: Boolean,
  response: String,
  body: String,
  date: {
    type: Date,
    default: Date.now
  },
  email: String,
  reviewer_name: String,
  helpfulness: Number,
  photos: [{
    url: String
  }]
});
const metaSchema = new Schema({
  product_id: Number,
  //calculate
  ratings: {
    1: Number,
    2: Number,
    3: Number,
    4: Number,
    5: Number
  },
  recommended: {
    true: Number,
    false: Number
  },
  characteristics: Schema.Types.Mixed
});
const models = {
  Review: _mongoose.default.model('Review', reviewSchema),
  Meta: _mongoose.default.model('Meta', metaSchema)
};
exports.models = models;