import express from 'express';
import db from '../../database/db';

function reviewsRoutes() {
  const router = express.Router();

  router.get('/', getReviewsPaginated);
  router.get('/meta', getReviewMeta);
  router.post('/', postReview);
  router.put('/:review_id/helpful', putHelpfulness);
  router.put('/:review_id/report', putReported);
  return router;
}

function getReviewsPaginated(req, res) {
  const {product_id, page, count } = req.query;
  db.getReviewsPaginated(req.query)
    .then((reviews) => res.send({"product": product_id, "page": page, "count": count, "results": reviews[0][0]}))
    .catch((err) => res.status(500).send(err));
};

function getReviewMeta(req, res) {
  db.getReviewMeta(req.query)
    .then((results) => res.send(results[0][0]))
    .catch((err) => res.status(500).send(err));
};

function postReview(req, res) {
  db.postReview(req.body)
    .then(() => res.status(201).send('success'))
    .catch((err) => res.status(500).send(err));
};

function putHelpfulness(req, res) {
  db.putHelpfulness(req.params)
    .then(() => res.status(204).send('success'))
    .catch((err) => res.status(500).send(err));
};

function putReported(req, res) {
  db.putReported(req.params)
    .then(() => res.status(204).send('success'))
    .catch((err) => res.status(500).send(err));
};





export {reviewsRoutes};