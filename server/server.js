import express from 'express';

import {getRoutes} from './routes';

function startServer(port = process.env.PORT || 3000) {
  const app = express();
  app.use(express.urlencoded({ extended: true }));
  app.use(express.json());
  app.use('/', getRoutes());


  return new Promise(resolve => {
    const server = app.listen(port, () => {
      console.log(`listening on http://localhost:${port}`)
    })
  })
}

export {startServer};