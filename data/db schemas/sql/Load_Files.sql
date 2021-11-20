 -- ---
 -- ETL
 --
 -- ---
SET GLOBAL local_infile=1;
  -- ---
 -- Load characteristics
 --
 -- ---
LOAD DATA LOCAL INFILE '/Users/zacharia/Documents/code/HackReactor/atelier-reviews/data/flat_files/characteristics.csv' INTO TABLE characteristics
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

 -- ---
 -- Load reviews
 --
 -- ---
LOAD DATA LOCAL INFILE '/Users/zacharia/Documents/code/HackReactor/atelier-reviews/data/flat_files/reviews.csv' INTO TABLE reviews
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

 -- ---
 -- Load reviews_caharcteristics
 --
 -- ---
LOAD DATA LOCAL INFILE '/Users/zacharia/Documents/code/HackReactor/atelier_reviews/data/flat_files/reviews_characteristics.csv' INTO TABLE reviews_characteristics
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

 -- ---
 -- Load photos
 --
 -- ---
LOAD DATA LOCAL INFILE '/Users/zacharia/Documents/code/HackReactor/atelier-reviews/data/flat_files/photos.csv' INTO TABLE photos
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

SET GLOBAL local_infile=0;



