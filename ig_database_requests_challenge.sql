USE instagram;

SELECT COUNT(*) AS 'Number of photos'
	FROM photos;
SELECT COUNT(*) AS 'Number of users'
	FROM users;
SELECT COUNT(*) AS 'Number of likes'
	FROM likes;
SELECT COUNT(*) AS 'Number of comments'
	FROM comments;

-- 1. Finding the five oldest users --
SELECT *
FROM
    users
ORDER BY created_at ASC
	LIMIT 5;
    
-- 2. What day of the week do most users register on? --
SELECT DAYNAME(created_at) AS day,
		COUNT(*) AS total
	FROM users
GROUP BY day
ORDER BY total DESC
LIMIT 3;

-- 3. Find the users who have never posted a photo --
SELECT username
FROM users
LEFT JOIN photos
	ON users.id = photos.user_id
WHERE photos.id IS NULL;

-- 4. Identify who got the most lines on a single photo --
SELECT username, image_url, COUNT(photo_id) AS Count
FROM users
LEFT JOIN photos
	ON users.id = photos.user_id
LEFT JOIN likes
	ON photos.id = likes.photo_id
GROUP BY photo_id
ORDER BY Count DESC LIMIT 5;

-- 5.How many times does the average user post --
SELECT
	(SELECT COUNT(*) FROM photos) / (SELECT COUNT(*) FROM users)
		AS 'Average post per user';
        
-- 6. What are the 5 most commonly used hashtags --
SELECT tag_name, COUNT(tag_id) AS count
FROM tags
JOIN photo_tags
	ON tags.id = photo_tags.tag_id
GROUP BY photo_tags.tag_id
ORDER BY count DESC
	LIMIT 5;
    
-- 7. Find users who have liked every single photo on the site --
SELECT username, COUNT(*) Total
FROM users
JOIN likes
	ON users.id = likes.user_id
GROUP BY likes.user_id
HAVING Total = (SELECT COUNT(*) FROM photos);

