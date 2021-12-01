SET FOREIGN_KEY_CHECKS = 0;
DROP DATABASE IF EXISTS reviews;
DROP DATABASE IF EXISTS reviews_api;

CREATE DATABASE reviews_api;
use reviews_api;

 -- ---
 -- Table 'Reviews'
 --
 -- ---

SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS reviews;

CREATE TABLE reviews (
  id INTEGER NOT NULL AUTO_INCREMENT,
  product_id INTEGER NOT NULL,
  rating SMALLINT NOT NULL,
  date TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  summary VARCHAR(150) NULL DEFAULT NULL,
  body VARCHAR(500) NULL DEFAULT NULL,
  recommend TINYINT NOT NULL CHECK (recommend IN (0, 1)) DEFAULT 0,
  reported TINYINT NOT NULL CHECK (reported IN (0, 1)) DEFAULT 0,
  reviewer_name VARCHAR(50) NOT NULL,
  reviewer_email VARCHAR(100) NULL DEFAULT NULL,
  response VARCHAR(140) NULL DEFAULT NULL,
  helpfulness MEDIUMINT NULL DEFAULT 0,
  INDEX (product_id, rating, recommend, date, helpfulness),
  PRIMARY KEY (id)
);

SET FOREIGN_KEY_CHECKS = 1;

 -- ---
 -- Table 'Characteristics'
 --
 -- ---

SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS characteristics;

CREATE TABLE characteristics (
  id INTEGER NOT NULL AUTO_INCREMENT,
  product_id INTEGER NOT NULL,
  name VARCHAR(20) NOT NULL,
  INDEX (product_id),
  PRIMARY KEY (id)
);

SET FOREIGN_KEY_CHECKS = 1;

 -- ---
 -- Table 'reviews_characteristics'
 --
 -- ---

SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS reviews_characteristics;

CREATE TABLE reviews_characteristics (
  id INTEGER NOT NULL AUTO_INCREMENT,
  characteristic_id INTEGER NOT NULL,
  review_id INTEGER NOT NULL,
  value INTEGER NOT NULL,
  INDEX (characteristic_id),
  PRIMARY KEY (id),
  FOREIGN KEY (review_id) REFERENCES reviews(id),
  FOREIGN KEY (characteristic_id) REFERENCES characteristics(id)
);

SET FOREIGN_KEY_CHECKS = 1;

 -- ---
 -- Table 'photos'
 --
 -- ---

SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS photos;

CREATE TABLE photos (
  id INTEGER NOT NULL AUTO_INCREMENT,
  review_id INTEGER,
  url VARCHAR(250) NOT NULL,
  INDEX(review_id),
  PRIMARY KEY (id),
  FOREIGN KEY (review_id) REFERENCES reviews(id)
);

SET FOREIGN_KEY_CHECKS = 1;

 -- ---
 -- Table 'ReviewsMeta'
 --
 -- ---

SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS ReviewsMeta;

CREATE TABLE ReviewsMeta (
  id INTEGER NOT NULL AUTO_INCREMENT,
  product_id INTEGER NOT NULL,
  recommend_true INTEGER NULL DEFAULT NULL,
  recommend_false INTEGER NULL DEFAULT NULL,
  1_star_count INTEGER NULL DEFAULT NULL,
  2_star_count INTEGER NULL DEFAULT NULL,
  3_star_count INTEGER NULL DEFAULT NULL,
  4_star_count INTEGER NULL DEFAULT NULL,
  5_star_count INTEGER NULL DEFAULT NULL,
  PRIMARY KEY (id)
);

SET FOREIGN_KEY_CHECKS = 1;