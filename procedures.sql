
USE movie_review_system;
-- function 
DELIMITER // 
CREATE FUNCTION find_average_rating( m_id INT) 
RETURNS FLOAT 
DETERMINISTIC 
BEGIN 
DECLARE avg_rating FLOAT ;
SELECT avg(rating) 
INTO avg_rating FROM 
watchlist w 
INNER JOIN 
reviews r
ON w.watchlist_id = r.watchlist_id
WHERE w.movie_id = m_id ;
RETURN avg_rating ;
END //
DELIMITER ; 

DELIMITER //

CREATE FUNCTION find_average_rating(
    p_movie_id INT
)
RETURNS DECIMAL(5,2)
READS SQL DATA
BEGIN
    DECLARE v_avg DECIMAL(5,2);

    SELECT AVG(rating)
    INTO v_avg
    FROM reviews
    WHERE movie_id = p_movie_id;

    RETURN v_avg;
END //

DELIMITER ;

DELIMITER //

CREATE FUNCTION get_review_count(
    p_movie_id INT
)
RETURNS INT
READS SQL DATA
BEGIN
    DECLARE v_count INT;

    SELECT COUNT(*)
    INTO v_count
    FROM reviews
    WHERE movie_id = p_movie_id;

    RETURN v_count;
END //

DELIMITER ;












-- stored procedure 

DELIMITER //

CREATE PROCEDURE get_all_movies()
BEGIN
    SELECT * FROM movies;
END //

DELIMITER ; 

DELIMITER $$

CREATE PROCEDURE get_movies_by_genre(
    IN p_genre VARCHAR(100)
)
BEGIN
    SELECT *
    FROM movies
    WHERE genre = p_genre;
END $$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE count_movies_by_genre(
    IN p_genre VARCHAR(100),
    OUT p_count INT
)
BEGIN
    SELECT COUNT(*)
    INTO p_count
    FROM movies
    WHERE genre = p_genre;
END $$

DELIMITER ;

DELIMITER //

CREATE PROCEDURE get_user_watchlist(
    IN p_user_id INT
)
BEGIN
    SELECT
        m.title,
        m.genre,
        w.status,
        w.added_date,
        w.watched_date
    FROM watchlist AS w
    JOIN movies AS m
        ON w.movie_id = m.movie_id
    WHERE w.user_id = p_user_id;
END //

DELIMITER ;  

DELIMITER $$

CREATE PROCEDURE get_watchlist_summary(
    IN p_user_id INT,
    OUT p_watched INT,
    OUT p_pending INT
)
BEGIN
    SELECT
        COALESCE(SUM(status = 'Watched'), 0),
        COALESCE(SUM(status = 'Pending'), 0)
    INTO p_watched, p_pending
    FROM watchlist
    WHERE user_id = p_user_id;
END $$

DELIMITER ;












-- trigger 

DELIMITER //
CREATE TRIGGER update_status 
BEFORE INSERT ON reviews
FOR EACH ROW
BEGIN
  UPDATE watchlist SET status = "watched",watched_date = new.review_date WHERE
   watchlist_id = new.watchlist_id ;
       
END
//
DELIMITER ;
