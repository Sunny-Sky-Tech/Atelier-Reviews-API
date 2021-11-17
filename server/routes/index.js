import express from 'express';

import {reviewsRoutes} from './reviews';

function getRoutes() {
  const router = express.Router();

  router.use('/reviews', reviewsRoutes());

  return router;
}

export {getRoutes};