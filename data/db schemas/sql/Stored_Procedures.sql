 -- ---
 -- Stored Procedures
 --
 -- ---

 -- ---
 -- Get Reviews
 -- Pagination / Sorting
 -- ---
DROP PROCEDURE IF EXISTS getReviews;
DELIMITER //
CREATE PROCEDURE getReviews(IN product_id INT, offset INT, results INT, sort VARCHAR(20))

-- test
-- CALL getReviews(999993, 0, 10, 'relevance');

BEGIN

  SELECT r.id, r.rating, r.summary, r.recommend, r.response, r.body, FROM_UNIXTIME(r.date / 1000) AS date, r.reviewer_name, r.helpfulness, p.id, p.url

    FROM reviews r
    LEFT JOIN photos p ON p.review_id = r.id
    WHERE r.product_id = product_id
    ORDER BY
      CASE WHEN sort = 'newest' THEN date END DESC,
      CASE WHEN sort = 'helpfulness' THEN helpfulness END DESC,
      CASE WHEN sort = 'relevance' THEN date END DESC,
      CASE WHEN sort = 'relevance' THEN helpfulness END DESC
    LIMIT results OFFSET offset;

END //
DELIMITER ;

 -- ---
 -- Get Reviews TEST
 -- Pagination / Sorting
 -- ---
DROP PROCEDURE IF EXISTS getReviewsTest;
DELIMITER //
CREATE PROCEDURE getReviewsTest(IN product_id INT, offset INT, results INT, sort VARCHAR(20))

-- test
-- CALL getReviewsTest(999993, 0, 10, 'helpfulness');

BEGIN

  SELECT r.id,
    r.rating,
    r.summary,
    r.recommend,
    r.response,
    r.body,
    FROM_UNIXTIME(r.date / 1000) AS date,
    r.reviewer_name,
    r.helpfulness,
    (
      SELECT
        JSON_ARRAYAGG(JSON_OBJECT(id, url))
      FROM photos
      WHERE review_id = r.id
    ) AS photos
    FROM reviews r
    WHERE r.product_id = product_id
    ORDER BY
      CASE WHEN sort = 'newest' THEN date END DESC,
      CASE WHEN sort = 'helpfulness' THEN helpfulness END DESC,
      CASE WHEN sort = 'relevance' THEN date END DESC,
      CASE WHEN sort = 'relevance' THEN helpfulness END DESC
    LIMIT results OFFSET offset;

END //
DELIMITER ;
 -- ---
 -- Get Reviews/meta
 --
 -- ---

DROP PROCEDURE IF EXISTS getReviewsMeta;
DELIMITER //
CREATE PROCEDURE getReviewsMeta(IN product_id INT)

-- test
-- CALL getReviewsMeta(999993);

BEGIN
SELECT
(SELECT JSON_OBJECT(
  "1",
    (SELECT COUNT(*)
    FROM reviews r
    WHERE r.rating = 1
    AND r.product_id = product_id),
  "2",
    (SELECT COUNT(*)
    FROM reviews r
    WHERE r.rating = 2
    AND r.product_id = product_id),
  "3",
    (SELECT COUNT(*)
    FROM reviews r
    WHERE r.rating = 3
    AND r.product_id = product_id),
  "4",
    (SELECT COUNT(*)
    FROM reviews r
    WHERE r.rating = 4
    AND r.product_id = product_id),
  "5",
    (SELECT COUNT(*)
    FROM reviews r
    WHERE r.rating = 5
    AND r.product_id = product_id)
)) AS ratings,
(SELECT JSON_OBJECT(
  "1",
    (SELECT COUNT(*)
    FROM reviews r
    WHERE r.recommend = true
    AND r.product_id = product_id),
  "0",
    (SELECT COUNT(*)
    FROM reviews r
    WHERE r.recommend = false
    AND r.product_id = product_id)
)) AS recommend,
(
  SELECT JSON_OBJECTAGG(c.name, JSON_OBJECT('id', c.id, 'value', rc.value))
  FROM characteristics c
  INNER JOIN reviews_characteristics rc
  ON c.product_id = product_id
  AND rc.characteristic_id = c.id
) AS characteristics;

END //
DELIMITER ;


 -- ---
 -- POST Review
 --
 -- ---

DROP PROCEDURE IF EXISTS postReview;
DELIMITER //
CREATE PROCEDURE postReview(
   IN _product_id INT,
   IN _rating INT,
   IN _summary VARCHAR(150),
   IN _body VARCHAR(500),
   IN _recommend TINYINT,
   IN _reviewer_name VARCHAR(50),
   IN _reviewer_email VARCHAR(100)
)

-- CALL

BEGIN
  INSERT INTO reviews (
      product_id,
      rating,
      summary,
      body,
      recommend,
      reviewer_name,
      reviewer_email
  )

  VALUES (
    _product_id,
    _rating,
    _summary,
    _body,
    _recommend,
    _reviewer_name,
    _reviewer_email
  );

END //
DELIMITER ;

-- ---
 -- POST photos
 --
 -- ---

 -- ---
 -- POST characteristics
 --
 -- ---

 -- ---
 -- Put Review Helpful
 --
 -- ---

 -- ---
 -- Put Review Reported
 --
 -- ---
