import connection from './index.js';

const db = {
  getReviewsPaginated: async function({page = 0, count = 10, sort = 'helpfulness', product_id}) {
    console.log('querying for paginated reviews...');
    const sql_query = 'CALL getReviewsPaginated(?,?,?,?)';
    const params = [product_id, page, count, sort];
    return await connection.promise().query(sql_query, params);
  },

  getReviewMeta: async function({product_id}) {
    console.log('querying for review meta info...');
    const sql_query = `CALL getReviewsMeta(?);`;
    const params = [product_id];
    return await connection.promise().query(sql_query, params);
  },

  postReview: async function({product_id, rating, summary, recommend, response, body, email, reviewer_name, helpfulness, characteristics, photos}) {
    console.log('posting review...');
    const review_query = `CALL postReviewTest(?,?,?,?,?,?,?,?,?);`
    const params = [product_id, rating, summary, body, recommend, reviewer_name, email, JSON.stringify(photos), JSON.stringify(characteristics)];
    return await connection.promise().query(review_query, params);
  },

  // postReviewUnused: function({product_id, rating, summary, recommend, response, body, email, reviewer_name, helpfulness, characteristics, photos}) {
  //   console.log('posting review...');
  //   const review_query = `CALL postReview(?,?,?,?,?,?,?, @Id); SELECT @Id;`
  //   const params = [product_id, rating, summary, body, recommend, reviewer_name, email];
  //   let reviewId;

  //   return new Promise((resolve, reject) => {
  //     connection.promise().query(review_query, params)
  //       .then((row) => {
  //         reviewId = row[0][1][0]['@Id'];
  //         for (let i = 0; i < photos.length; i++) {
  //           const photo_query = `CALL postPhoto(?,?)`;
  //           connection.promise().query(photo_query, [reviewId, photos[i]]);
  //         }
  //         for(let key of Object.keys(characteristics)) {
  //           const review_char_query = `CALL insertReviewsCharacteristics(?,?,?)`;
  //           connection.promise().query(review_char_query, [key, reviewId, characteristics[key]]);
  //         }
  //       })
  //       .then(() => resolve() )
  //       .catch((err) => reject(err));
  //   });
  // },

  putHelpfulness: async function({review_id}) {
    console.log('increasing helpfulness...');
    const sql_query = `CALL putHelpfulness(?)`;
    const params = [review_id];
    return await connection.promise().query(sql_query, params);
  },

  putReported: async function({review_id}) {
    console.log('increaing reported...');
    const sql_query = `CALL putReported(?)`;
    const params = [review_id];
    return await connection.promise().query(sql_query, params);
  }
}

export default db;