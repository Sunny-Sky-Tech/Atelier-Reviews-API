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

async function getReviewsPaginated(req, res) {
  const {product_id, page, count } = req.query
  db.getReviewsPaginated(req.query, (err, response) => {
    if(err) res.status(500).send(err);
    res.send(response);
  });
};

async function getReviewMeta(req, res) {
  await db.getReviewMeta(req.query)
    .then((results) => {
      res.send(results[0][0]);
    })
    .catch((err) => {
      console.log(err);
      res.status(500).send(err);
    })
};

async function postReview(req, res) {
  db.postReview(req.body, (err) => {
    if(err) res.status(500).send(err);
    res.status(201).send('success');
  });
};

async function putHelpfulness(req, res) {
  await db.putHelpfulness(req.params)
    .then(() => { res.status(204).send() })
    .catch((err) => { res.status(500).send(err) });
};

async function putReported(req, res) {
  await db.putReported(req.params)
  .then(() => { res.status(204).send() })
  .catch((err) => { res.status(500).send(err) });
};





export {reviewsRoutes};