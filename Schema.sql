// -- ---
// -- Table 'Reviews'
// -- 
// -- ---

DROP TABLE IF EXISTS Reviews;
		
CREATE TABLE Reviews (
  id INTEGER NOT NULL AUTO_INCREMENT,
  product_id INTEGER NOT NULL,
  rating SMALLINT NOT NULL,
  summary VARCHAR(100) NULL DEFAULT NULL,
  recommend TINYINT NULL DEFAULT NULL,
  response VARCHAR(140) NULL DEFAULT NULL,
  body VARCHAR(250) NULL DEFAULT NULL,
  date DATE NULL DEFAULT NULL,
  email VARCHAR(150) NULL DEFAULT NULL,
  reviewer_name VARCHAR(50) NOT NULL,
  helpfullness INTEGER NULL DEFAULT NULL,
  PRIMARY KEY (id)
);

// -- ---
// -- Table 'reviews_characteristics'
// -- 
// -- ---

DROP TABLE IF EXISTS reviews_characteristics;
		
CREATE TABLE reviews_characteristics (
  characteristic_id INTEGER NOT NULL,
  review_id INTEGER NOT NULL,
  rating INTEGER NOT NULL,
  PRIMARY KEY (characteristic_id, review_id),
  FOREIGN KEY (review_id) REFERENCES Reviews(id)
  FOREIGN KEY (characteristic_id) REFERENCES Characteristics(id)
);

// -- ---
// -- Table 'Characteristics'
// -- 
// -- ---

DROP TABLE IF EXISTS Characteristics;
		
CREATE TABLE Characteristics (
  id INTEGER NOT NULL AUTO_INCREMENT,
  name VARCHAR(50) NOT NULL,
  PRIMARY KEY (id)
);

// -- ---
// -- Table 'photos'
// -- 
// -- ---

DROP TABLE IF EXISTS photos;
		
CREATE TABLE photos (
  id INTEGER NOT NULL AUTO_INCREMENT,
  url VARCHAR(250) NOT NULL,
  review_id INTEGER,
  PRIMARY KEY (id),
  FOREIGN KEY (review_id) REFERENCES Reviews(id)
);

// -- ---
// -- Table 'ReviewsMeta'
// -- 
// -- ---

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




