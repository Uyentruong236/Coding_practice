
CREATE DATABASE ig_clone;
USE ig_clone; 

CREATE TABLE users (
    id INTEGER AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE photos (
    id INTEGER AUTO_INCREMENT PRIMARY KEY,
    image_url VARCHAR(255) NOT NULL,
    user_id INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY(user_id) REFERENCES users(id)
);

CREATE TABLE comments (
    id INTEGER AUTO_INCREMENT PRIMARY KEY,
    comment_text VARCHAR(255) NOT NULL,
    photo_id INTEGER NOT NULL,
    user_id INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY(photo_id) REFERENCES photos(id),
    FOREIGN KEY(user_id) REFERENCES users(id)
);

CREATE TABLE likes (
    user_id INTEGER NOT NULL,
    photo_id INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY(user_id) REFERENCES users(id),
    FOREIGN KEY(photo_id) REFERENCES photos(id),
    PRIMARY KEY(user_id, photo_id)
);

CREATE TABLE follows (
    follower_id INTEGER NOT NULL,
    followee_id INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY(follower_id) REFERENCES users(id),
    FOREIGN KEY(followee_id) REFERENCES users(id),
    PRIMARY KEY(follower_id, followee_id)
);

CREATE TABLE tags (
  id INTEGER AUTO_INCREMENT PRIMARY KEY,
  tag_name VARCHAR(255) UNIQUE,
  created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE photo_tags (
    photo_id INTEGER NOT NULL,
    tag_id INTEGER NOT NULL,
    FOREIGN KEY(photo_id) REFERENCES photos(id),
    FOREIGN KEY(tag_id) REFERENCES tags(id),
    PRIMARY KEY(photo_id, tag_id)
);

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






