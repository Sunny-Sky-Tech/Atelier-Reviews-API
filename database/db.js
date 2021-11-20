import connection from './index.js';

const db = {
  getReviews: async function({page, count, sort, product_id} = data) {
    connection.connect();
    const result = await connection.promise().query(`CALL getReviewsTest(?,?,?,?)`, [product_id, count, page, sort]);
    // const result = await connection.promise().query(`SELECT * FROM reviews LIMIT 10`);
    console.log(result);
    return result;
  }
}

export default db;