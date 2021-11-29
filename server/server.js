import express from 'express';

import {getRoutes} from './routes';

function startServer({port = process.env.PORT} = {}) {
  const app = express();
  app.use(express.urlencoded({ extended: true }));
  app.use(express.json());
  app.use('/', getRoutes());


  return new Promise(resolve => {
    const server = app.listen(port, () => {
      console.log(`listening on http://localhost:${server.address().port}`);

      const originalClose = server.close.bind(server);
      server.close = () => {
        return new Promise(resolveClose => {
          originalClose(resolveClose);
        })
      }

      resolve(server);
    })
  })
}

export {startServer};