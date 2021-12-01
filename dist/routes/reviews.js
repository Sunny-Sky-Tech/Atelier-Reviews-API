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

  router.get('/', getReviewsPaginated);
  router.get('/meta', getReviewMeta);
  router.post('/', postReview);
  router.put('/:review_id/helpful', putHelpfulness);
  router.put('/:review_id/report', putReported);
  return router;
}

async function getReviewsPaginated(req, res) {
  await _db.default.getReviewsPaginated(req.query).then(results => {
    res.send(results[0][0]);
  }).catch(err => {
    console.log(err);
    res.status(500).send(err);
  });
}

async function getReviewMeta(req, res) {
  await _db.default.getReviewMeta(req.query).then(results => {
    res.send(results[0][0]);
  }).catch(err => {
    console.log(err);
    res.status(500).send(err);
  });
}

async function postReview(req, res) {
  _db.default.postReview(req.body, err => {
    if (err) res.status(500).send(err);
    console.log('post review error: ', err);
    res.status(201).send('success');
  });
}

async function putHelpfulness(req, res) {
  await _db.default.putHelpfulness(req.params).then(() => {
    res.status(204).send();
  }).catch(err => {
    res.status(500).send(err);
  });
}

async function putReported(req, res) {
  await _db.default.putReported(req.params).then(() => {
    res.status(204).send();
  }).catch(err => {
    res.status(500).send(err);
  });
}