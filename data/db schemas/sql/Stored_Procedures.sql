 -- ---
 -- Stored Procedures
 --
 -- ---

-
-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Get Reviews
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
      WHERE review_id IN (r.id)
    ) AS photos
  FROM reviews r
  WHERE r.product_id IN (_product_id)
  AND r.reported NOT IN (1)
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
    WHERE r.rating IN (1)
    AND r.product_id IN (_product_id)),
  "2",
    (SELECT COUNT(*)
    FROM reviews r
    WHERE r.rating IN (2)
    AND r.product_id IN (_product_id)),
  "3",
    (SELECT COUNT(*)
    FROM reviews r
    WHERE r.rating IN (3)
    AND r.product_id IN (_product_id)),
  "4",
    (SELECT COUNT(*)
    FROM reviews r
    WHERE r.rating IN (4)
    AND r.product_id IN (_product_id)),
  "5",
    (SELECT COUNT(*)
    FROM reviews r
    WHERE r.rating IN (5)
    AND r.product_id IN (_product_id))
)) AS ratings,
(SELECT JSON_OBJECT(
  "1",
    (SELECT COUNT(*)
    FROM reviews r
    WHERE r.recommend IN (1)
    AND r.product_id IN (_product_id)),
  "0",
    (SELECT COUNT(*)
    FROM reviews r
    WHERE r.recommend IN (false)
    AND r.product_id IN (_product_id))
)) AS recommend,
(
  SELECT JSON_OBJECTAGG(c.name, JSON_OBJECT('id', c.id, 'value', rc.value))
  FROM characteristics c
  INNER JOIN reviews_characteristics rc
  ON c.product_id IN (_product_id)
  AND rc.characteristic_id IN (c.id)
) AS characteristics;

END //
DELIMITER ;

 --
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
  WHERE id IN (_review_id);

END //
DELIMITER ;

 --
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
  SET reported = 1
  WHERE id IN (_review_id);

END //
DELIMITER ;


 -- ---
 -- Post Review
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
   IN _photos JSON,
   IN _characteristics JSON
)

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
  CALL postPhotos(LAST_INSERT_ID(), _photos);
  CALL insertManyReviewsCharacteristics(LAST_INSERT_ID(), _characteristics);

END //
DELIMITER ;

 -- ---
 -- Post Photo
 --
 -- ---
DROP PROCEDURE IF EXISTS postPhotos;
DELIMITER //

CREATE PROCEDURE postPhotos(IN _review_id INT, IN _urls JSON)

BEGIN
  INSERT INTO photos (
    review_id,
    url
  )
  SELECT _review_id, url FROM
    JSON_TABLE(
      _urls,
      "$[*]"
      COLUMNS(
        url VARCHAR(250) PATH "$"
      )
    ) data;

END //
DELIMITER ;

 -- ---
 -- Insert Many Into reviews_characteristics Table
 --
 -- ---
DROP PROCEDURE IF EXISTS insertManyReviewsCharacteristics;
DELIMITER //

CREATE PROCEDURE insertManyReviewsCharacteristics(IN _review_id INT, IN _characteristics JSON)

BEGIN
  INSERT INTO reviews_characteristics (
    characteristic_id,
    value,
    review_id
  )

  SELECT characteristic_id, value, _review_id FROM
    (WITH j AS (
      SELECT CAST(_characteristics AS JSON) chars
    )
    SELECT characteristic_id, JSON_EXTRACT(j.chars, CONCAT('$."', jt.characteristic_id, '"')) value
      FROM j,
        JSON_TABLE(JSON_KEYS(chars), '$[*]' COLUMNS (characteristic_id INT PATH '$')) jt) data;

END //
DELIMITER ;
