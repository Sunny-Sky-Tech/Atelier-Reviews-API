import express from 'express';
import compression from 'compression';
import {getRoutes} from './routes';
import {} from 'dotenv/config';

function startServer(port = process.env.PORT || 3000) {
  const app = express();
  app.use(compression());
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
        });
      }

      resolve(server);
    })
  })
}

export {startServer};