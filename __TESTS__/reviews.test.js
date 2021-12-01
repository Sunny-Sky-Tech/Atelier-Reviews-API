import {startServer} from '../server/server';
import axios from 'axios';

jest.setTimeout(25000);
let server, baseURL, product_id;
beforeAll(async () => {
  server = await startServer();
  baseURL = `http://localhost:${server.address().port}/reviews/`;
  product_id = '?product_id=999993';
});

afterAll(() => server.close());

describe('paginated reviews endpoint', () => {
  it('should return a 200 when given a valid product id', async () => {
    const response = await axios.get(`${baseURL}${product_id}`);
    expect(response.status).toBe(200);
  });

  it('should return less than 10 reviews by default', async () => {
    const response = await axios.get(`${baseURL}${product_id}`);
    expect(response.data.results.length).toBeLessThan(11);
  });

  it('page 0 by default', async () => {
    const response = await axios.get(`${baseURL}${product_id}`);
    expect(response.data.page).toBe(0);
  });

  it('count 10 by default', async () => {
    const response = await axios.get(`${baseURL}${product_id}`);
    expect(response.data.count).toBe(10);
  });
});

