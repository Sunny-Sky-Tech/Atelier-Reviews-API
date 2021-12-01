 -- ---
 -- ETL
 --
 -- ---
  -- ---
 -- Load characteristics
 --
 -- ---
SET GLOBAL local_infile=1;
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE characteristics;
LOAD DATA LOCAL INFILE '/Users/zacharia/Documents/code/HackReactor/atelier_reviews/data/flat_files/characteristics.csv' INTO TABLE characteristics
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;
SET FOREIGN_KEY_CHECKS = 1;
SET GLOBAL local_infile=0;

 -- ---
 -- Load reviews
 --
 -- ---
SET GLOBAL local_infile=1;
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE reviews;
LOAD DATA LOCAL INFILE '/Users/zacharia/Documents/code/HackReactor/atelier_reviews/data/flat_files/reviews.csv' INTO TABLE reviews
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(id, product_id, rating, @date, summary, body, @recommend, @reported, reviewer_name, reviewer_email, response, helpfulness)
SET date = FROM_UNIXTIME( @date / 1000 ),
recommend := @recommend = 'true',
reported := @reported = 'true';
SET FOREIGN_KEY_CHECKS = 1;
SET GLOBAL local_infile=0;

 -- ---
 -- Load reviews_caharcteristics
 --
 -- ---
SET GLOBAL local_infile=1;
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE reviews_characteristics;
LOAD DATA LOCAL INFILE '/Users/zacharia/Documents/code/HackReactor/atelier_reviews/data/flat_files/reviews_characteristics.csv' INTO TABLE reviews_characteristics
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;
SET FOREIGN_KEY_CHECKS = 1;
SET GLOBAL local_infile=0;

 -- ---
 -- Load photos
 --
 -- ---
SET GLOBAL local_infile=1;
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE photos;
LOAD DATA LOCAL INFILE '/Users/zacharia/Documents/code/HackReactor/atelier_reviews/data/flat_files/photos.csv' INTO TABLE photos
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;
SET FOREIGN_KEY_CHECKS = 1;
SET GLOBAL local_infile=0;




