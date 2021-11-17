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
  review_id: ObjectId,
  rating: Decimal128,
  summary: String,
  recommend: Boolean,
  response: String,
  body: String,
  date: Date,
  email: String,
  reviewer_name: String,
  helpfulness: Number,
  photos: [{
    id: ObjectId,
    url: String
  }]
});
const metaSchema = new Schema({
  product_id: ObjectId,
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
const characteristicSchema = new Schema({
  characteristic_id: ObjectId,
  name: String,
  reviews: [ObjectId]
});
const models = {
  Review: _mongoose.default.model('Review', reviewSchema),
  Meta: _mongoose.default.model('Meta', metaSchema),
  Characteristic: _mongoose.default.model('Characteristic', characteristicSchema)
};
exports.models = models;