import http from 'k6/http';
import { sleep } from 'k6';

const baseURL = `http://localhost:3000/reviews/`;
const product_id = '?product_id=999993';

const body = JSON.stringify({
  "product_id": 61593,
  "rating": 5.0,
  "summary": "Sample Summary",
  "recommend": true,
  "response": "Sample Response",
  "body": "Sample Body",
  "email": "test@test.com",
  "reviewer_name": "Zach",
  "helpfulness": 0,
  "characteristics": {
    "12": 5,
    "15": 3.5,
    "2": 4
  },
  "photos": [{
    "url": "photo.com"
  }]
});

const params = {
  headers: { 'Content-Type': 'application/json' },
};

export const options = {
  insecureSkipTLSVerify: true,
  noConnectionReuse: false,
  stages: [
    { duration: '10s', target: 100 },
    { duration: '1m', target: 100 },
    { duration: '10s', target: 1400 },
    { duration: '3m', target: 1400 },
    { duration: '10s', target: 100 },
    { duration: '2m', target: 100 },
    { duration: '10s', target: 0 },
  ],
};

export default () => {
  http.batch([
    ['POST', `${baseURL}`, body, params],
    ['GET', `${baseURL}${product_id}`],
    ['GET', `${baseURL}/meta/${product_id}`],
    ['PUT', `${baseURL}/999993/helpful`],
    ['PUT', `${baseURL}/999993/report`]
  ]);

  sleep(1);
};

function teardown() {

};

