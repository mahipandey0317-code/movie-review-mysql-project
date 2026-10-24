USE movie_review_system ;

SET @var1 = 0 ;

CALL get_count_of_genre("SCI-FI" ,@VAR1) ; 

SELECT "sci-fi" AS Genre , @VAR1 AS movie_genre_count ;

SELECT "Comedy" AS Genre , @VAR1 AS movie_genre_count ;