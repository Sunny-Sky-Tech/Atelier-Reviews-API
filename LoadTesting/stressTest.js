import http from 'k6/http';
import { sleep } from 'k6';

const baseURL = `http://localhost:3000/reviews/`;
const product_id = '?product_id=100003';

const body = JSON.stringify({
  "product_id": 79415,
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
  "photos": ["photo1.com", "photo2.com"]
});

const params = {
  headers: { 'Content-Type': 'application/json' },
};

export const options = {
  insecureSkipTLSVerify: true,
  noConnectionReuse: false,
  stages: [
    { duration: '2m', target: 100 },
    // { duration: '5m', target: 100 },
    { duration: '2m', target: 200 },
    // { duration: '5m', target: 200 },
    { duration: '2m', target: 300 },
    // { duration: '5m', target: 300 },
    { duration: '2m', target: 400 },
    // { duration: '5m', target: 400 },
    { duration: '5m', target: 0 },
  ],
  thresholds: {
    http_req_failed: ['rate<0.01'],
    http_req_duration: ['p(95)<200'],
  },
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

