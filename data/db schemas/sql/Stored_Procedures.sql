 -- ---
 -- Stored Procedures
 --
 -- ---

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Get Reviews SIMPLE
--
-- ---
DROP PROCEDURE IF EXISTS getReviewsSimple;
DELIMITER //
CREATE PROCEDURE getReviewsSimple(IN productId INT)

-- test
-- CALL getReviewsSimple();

BEGIN

  SELECT * FROM reviews
  WHERE product_id = productId
  LIMIT 10;

END //
DELIMITER ;


-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
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

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Get Reviews TEST
-- Pagination / Sorting
-- ---
DROP PROCEDURE IF EXISTS getReviewsPaginated;
DELIMITER //
CREATE PROCEDURE getReviewsPaginated(IN _product_id INT, _offset INT, _results INT, _sort VARCHAR(20))

-- test
-- CALL getReviewsPaginated(999993, 0, 10, 'helpfulness');

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
        JSON_ARRAYAGG(JSON_OBJECT('id', id, 'url', url))
      FROM photos
      WHERE review_id = r.id
    ) AS photos
  FROM reviews r
  WHERE r.product_id = _product_id
  ORDER BY
    CASE
      WHEN _sort = 'newest' THEN date
      WHEN _sort = 'helpfulness' THEN helpfulness
      WHEN _sort = 'relevance' THEN date
      WHEN _sort = 'relevance' THEN helpfulness
    END DESC
  LIMIT _results OFFSET _offset;

END //
DELIMITER ;

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Get Reviews/meta
--
-- ---

DROP PROCEDURE IF EXISTS getReviewsMeta;
DELIMITER //
CREATE PROCEDURE getReviewsMeta(IN _product_id INT)

-- test
-- CALL getReviewsMeta(999993);

BEGIN
SELECT
(SELECT JSON_OBJECT(
  "1",
    (SELECT COUNT(*)
    FROM reviews r
    WHERE r.rating = 1
    AND r.product_id = _product_id),
  "2",
    (SELECT COUNT(*)
    FROM reviews r
    WHERE r.rating = 2
    AND r.product_id = _product_id),
  "3",
    (SELECT COUNT(*)
    FROM reviews r
    WHERE r.rating = 3
    AND r.product_id = _product_id),
  "4",
    (SELECT COUNT(*)
    FROM reviews r
    WHERE r.rating = 4
    AND r.product_id = _product_id),
  "5",
    (SELECT COUNT(*)
    FROM reviews r
    WHERE r.rating = 5
    AND r.product_id = _product_id)
)) AS ratings,
(SELECT JSON_OBJECT(
  "1",
    (SELECT COUNT(*)
    FROM reviews r
    WHERE r.recommend = true
    AND r.product_id = _product_id),
  "0",
    (SELECT COUNT(*)
    FROM reviews r
    WHERE r.recommend = false
    AND r.product_id = _product_id)
)) AS recommend,
(
  SELECT JSON_OBJECTAGG(c.name, JSON_OBJECT('id', c.id, 'value', rc.value))
  FROM characteristics c
  INNER JOIN reviews_characteristics rc
  ON c.product_id = _product_id
  AND rc.characteristic_id = c.id
) AS characteristics;

END //
DELIMITER ;

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
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
   IN _reviewer_email VARCHAR(100),
   OUT _Id INT
)

-- test
-- CALL postReview(
--   999993,
--   4,
--   'test summary',
--   'test body',
--   1,
--   'test name',
--   'test@email.com',
--   @Id
-- );
-- SELECT * FROM reviews WHERE id = @Id;
-- DELETE FROM reviews WHERE id = @Id;
-- SELECT * FROM reviews WHERE id = @Id;

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
  SELECT LAST_INSERT_ID() INTO _Id;

END //
DELIMITER ;

 -- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 -- POST photos
 --
 -- ---

DROP PROCEDURE IF EXISTS postPhoto;
DELIMITER //

CREATE PROCEDURE postPhoto(IN _review_id INT, IN _url VARCHAR(250), OUT _Id INT)

-- test
-- CALL postPhoto(
--   10,
--   'testurl.com/testphoto',
--   @Id
-- );
-- SELECT * FROM photos WHERE id = @Id;
-- DELETE FROM photos WHERE id = @Id;
-- SELECT * FROM photos WHERE id = @Id;

BEGIN
  INSERT INTO photos (
    review_id,
    url
  )

  VALUES (
    _review_id,
    _url
  );
  SELECT LAST_INSERT_ID() INTO _Id;

END //
DELIMITER ;

 -- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 -- POST characteristics
 -- ***non-user procedure***
 -- ---

DROP PROCEDURE IF EXISTS postCharacteristics;
DELIMITER //

CREATE PROCEDURE postCharacteristics(IN _product_id INT, IN _name VARCHAR(50), OUT _Id INT)

-- test
-- CALL postCharacteristics(
--   1,
--   'Size',
--   @Id
-- );
-- SELECT * FROM characteristics WHERE id = @Id;
-- SET FOREIGN_KEY_CHECKS = 0;
-- DELETE FROM characteristics WHERE id = @Id;
-- SET FOREIGN_KEY_CHECKS = 1;
-- SELECT * FROM characteristics WHERE id = @Id;

BEGIN
  INSERT INTO characteristics (
    product_id,
    name
  )

  VALUES (
    _product_id,
    _name
  );
  SELECT LAST_INSERT_ID() INTO _Id;

END //
DELIMITER ;

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 -- Insert into reviews_characteristics
 --
 -- ---
DROP PROCEDURE IF EXISTS insertReviewsCharacteristics;
DELIMITER //

CREATE PROCEDURE insertReviewsCharacteristics(IN _characteristic_id INT, IN _review_id INT, IN _value INT, OUT _Id INT)

-- test
-- CALL insertReviewsCharacteristics(
--   1,
--   1,
--   5,
--   @Id
-- );
-- SELECT * FROM reviews_characteristics WHERE id = @Id;
-- DELETE FROM reviews_characteristics WHERE id = @Id;
-- SELECT * FROM reviews_characteristics WHERE id = @Id;

BEGIN
  INSERT INTO reviews_characteristics (
    characteristic_id,
    review_id,
    value
  )

  VALUES (
    _characteristic_id,
    _review_id,
    _value
  );
  SELECT LAST_INSERT_ID() INTO _Id;

END //
DELIMITER ;

 -- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 -- Put Review Helpful
 --
 -- ---
DROP PROCEDURE IF EXISTS putHelpfulness;
DELIMITER //

CREATE PROCEDURE putHelpfulness(IN _review_id INT)

-- test
-- SELECT helpfulness FROM reviews WHERE id = 1;

-- CALL putHelpfulness(1);

-- SELECT helpfulness FROM reviews WHERE id = 1;

-- UPDATE reviews
-- SET helpfulness = helpfulness - 1
-- WHERE id = 1;

-- SELECT helpfulness FROM reviews WHERE id = 1;

BEGIN

  UPDATE reviews
  SET helpfulness = helpfulness + 1
  WHERE id = _review_id;

END //
DELIMITER ;

 -- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 -- Put Review Reported
 --
 -- ---

DROP PROCEDURE IF EXISTS putReported;
DELIMITER //

CREATE PROCEDURE putReported(IN _review_id INT)

-- test
-- SELECT reported FROM reviews WHERE id = 1;

-- CALL putReported(1);

-- SELECT reported FROM reviews WHERE id = 1;

-- UPDATE reviews
-- SET reported = reported - 1
-- WHERE id = 1;

-- SELECT reported FROM reviews WHERE id = 1;

BEGIN

  UPDATE reviews
  SET reported = reported + 1
  WHERE id = _review_id;

END //
DELIMITER ;
