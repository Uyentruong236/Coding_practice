
-- Find the 5 oldest users:

SELECT
	username,
	created_at
FROM users
ORDER BY created_at LIMIT 5;

-- What day of the week do most users register on?

SELECT 
	username,
	DAYNAME(created_at) as day,
	COUNT(*) as total
FROM users 
GROUP BY day 
ORDER BY total;

-- Find the users who have never posted a photo
SELECT username FROM users
LEFT JOIN photos 
ON users.id = photos.user_id
	WHERE image_url is NULL;

-- What is the photo with the most likes:
SELECT 
	username,
	photos.id,
	photos.image_url,
	COUNT(*) as total
FROM photos 
INNER JOIN likes
	ON photos.id = likes.photo_id
INNER JOIN users
	ON photos.user_id = users.id
	GROUP BY photos.id
	ORDER BY total DESC
	LIMIT 1;

-- How many times does the average user post?
SELECT 
	(SELECT COUNT(*) FROM photos)/
	(SELECT COUNT(*) FROM users) as avg;

-- What are the top 5 most commonly used hastags

SELECT 
	tag_name,
	tag_id,
	COUNT(*) as total
FROM tags
INNER JOIN photo_tags
	ON tags.id = photo_tags.tag_id
GROUP BY tag_name
ORDER BY total DESC
LIMIT 5;

-- Find users who have liked every single photo on instagram (finding bots)

SELECT 
	username,
	COUNT(*) as total
FROM users
INNER JOIN likes
	ON users.id = likes.user_id
GROUP BY users.id
HAVING total = (SELECT COUNT(*) FROM photos);




