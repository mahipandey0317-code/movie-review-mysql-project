USE movie_review_system;
SELECT find_average_rating(12) ;
SELECT title , find_average_rating(movie_id) AS average_rating FROM movies;
SELECT find_average_rating(1) AS average_rating;
SELECT get_review_count(3) AS review_count;