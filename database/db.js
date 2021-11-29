import connection from './index.js';

const db = {
  getReviewsPaginated: async function({page = 0, count = 10, sort = 'helpfulness', product_id}, cb) {
    console.log('querying for paginated reviews...');
    const sql_query = 'CALL getReviewsPaginated(?,?,?,?)';

    await connection.promise().query(sql_query, [product_id, page, count, sort])
    .then((reviews) => {
      cb(null, {"product": product_id, "page": page, "count": count, "results": reviews[0][0]});
    })
    .catch((err) => cb(err));


  },

  getReviewMeta: async function({product_id}) {
    console.log('querying for review meta info...');
    const sql_query = `CALL getReviewsMeta(?);`;
    return await connection.promise().query(sql_query, [product_id]);
  },

  postReview: async function({product_id, rating, summary, recommend, response, body, email, reviewer_name, helpfulness, characteristics, photos}, cb) {
    console.log('posting review...');
    const review_query = `CALL postReview(?,?,?,?,?,?,?, @Id); SELECT @Id;`
    const params = [product_id, rating, summary, body, recommend, reviewer_name, email];
    let reviewId;
    await connection.promise().query(review_query, params)
      .then((row) => {
        reviewId = row[0][1][0]['@Id'];
      })
      .then(async () => {
        for (let i = 0; i < photos.length; i++) {
          const photo_query = `CALL postPhoto(?,?,@Id)`;
          await connection.promise().query(photo_query, [reviewId, photos[i].url]);
        }
        for(let key of Object.keys(characteristics)) {
          const review_char_query = `CALL insertReviewsCharacteristics(?,?,?,@Id)`;
          await connection.promise().query(review_char_query, [key, reviewId, characteristics[key]]);
        }
      })
      .then(() => cb())
      .catch((err) => {
        cb(err);
      });
  },

  putHelpfulness: async function({review_id}) {
    console.log('increasing helpfulness...')
    const sql_query = `CALL putHelpfulness(?)`;
    return await connection.promise().query(sql_query, [review_id]);
  },

  putReported: async function({review_id}) {
    console.log('increaing reported...')
    const sql_query = `CALL putReported(?)`;
    return await connection.promise().query(sql_query, [review_id]);
  }
}

export default db;