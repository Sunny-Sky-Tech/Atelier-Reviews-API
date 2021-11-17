import express from 'express';
import {db} from '../db';

function reviewsRoutes() {
  const router = express.Router();

  router.get('/', getReviews);
  router.get('/meta', doSomethingElse);
  router.post('/', postReview);
  return router;
}

async function postReview(req, res) {
  const review = req.body;
  console.log(review);
  const { rating, recommend, characteristics } = review;
  db.saveReview(review);
  //also increment meta info

  res.send('inserted review');
}

async function getReviews(req, res) {
  const message = 'hello you have reached reviews';
  res.send(message);
}

async function doSomethingElse(req, res) {
  const message = 'hello you have reached reviews meta';
  res.send(message);
}

export {reviewsRoutes};