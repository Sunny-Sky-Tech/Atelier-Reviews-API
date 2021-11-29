SET FOREIGN_KEY_CHECKS = 0;
DROP DATABASE IF EXISTS reviews;
DROP DATABASE IF EXISTS reviews_api;

CREATE DATABASE reviews_api;
use reviews_api;

 -- ---
 -- Table 'Reviews'
 --
 -- ---

DROP TABLE IF EXISTS reviews;

CREATE TABLE reviews (
  id INTEGER NOT NULL AUTO_INCREMENT,
  product_id INTEGER NOT NULL,
  rating SMALLINT NOT NULL,
  date TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  summary VARCHAR(150) NULL DEFAULT NULL,
  body VARCHAR(500) NULL DEFAULT NULL,
  recommend TINYINT NULL DEFAULT NULL,
  reported TINYINT NULL DEFAULT 0,
  reviewer_name VARCHAR(50) NOT NULL,
  reviewer_email VARCHAR(100) NULL DEFAULT NULL,
  response VARCHAR(140) NULL DEFAULT NULL,
  helpfulness INTEGER NULL DEFAULT NULL,
  PRIMARY KEY (id)
);

 -- ---
 -- Table 'Characteristics'
 --
 -- ---

DROP TABLE IF EXISTS characteristics;

CREATE TABLE characteristics (
  id INTEGER NOT NULL AUTO_INCREMENT,
  product_id INTEGER NOT NULL,
  name VARCHAR(20) NOT NULL,
  PRIMARY KEY (id)
);

 -- ---
 -- Table 'reviews_characteristics'
 --
 -- ---

DROP TABLE IF EXISTS reviews_characteristics;

CREATE TABLE reviews_characteristics (
  id INTEGER NOT NULL AUTO_INCREMENT,
  characteristic_id INTEGER NOT NULL,
  review_id INTEGER NOT NULL,
  value INTEGER NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (review_id) REFERENCES reviews(id),
  FOREIGN KEY (characteristic_id) REFERENCES characteristics(id)
);

 -- ---
 -- Table 'photos'
 --
 -- ---

DROP TABLE IF EXISTS photos;

CREATE TABLE photos (
  id INTEGER NOT NULL AUTO_INCREMENT,
  review_id INTEGER,
  url VARCHAR(250) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (review_id) REFERENCES reviews(id)
);

 -- ---
 -- Table 'ReviewsMeta'
 --
 -- ---

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