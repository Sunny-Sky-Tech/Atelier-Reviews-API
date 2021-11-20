"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.reviewsRoutes = reviewsRoutes;

var _express = _interopRequireDefault(require("express"));

var _db = _interopRequireDefault(require("../../database/db"));

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function reviewsRoutes() {
  const router = _express.default.Router();

  router.get('/', getReviews);
  router.get('/meta', doSomethingElse);
  router.post('/', postReview);
  return router;
}

async function postReview(req, res) {
  const review = req.body;
  console.log(review);
  const {
    rating,
    recommend,
    characteristics
  } = review;

  _db.default.saveReview(review); //also increment meta info


  res.send('inserted review');
}

function getReviews(req, res) {
  const reviews = _db.default.getReviews();

  res.send('what');
}

async function doSomethingElse(req, res) {
  const message = 'hello you have reached reviews meta';
  res.send(message);
}