--Question 1a
SELECT *
FROM survey
LIMIT 10
;


--Question 1b
SELECT DISTINCT question
FROM survey
ORDER BY question ASC
LIMIT 10;


--Question 2
SELECT question AS 'QUESTION',
       COUNT(question) AS 'COUNT'
FROM survey
GROUP BY question
;


--Question 3
--NO QUERY NEEDED


--Question 4
SELECT *
FROM quiz
LIMIT 5
;


SELECT *
FROM home_try_on
LIMIT 5
;


SELECT *
FROM purchase
LIMIT 5
;


--Question 5a
SELECT DISTINCT q.user_id, 
      CASE
        WHEN (h.user_id IS NOT NULL) THEN 'True' 
        ELSE 'False'
        END AS 'is_home_try_on',
      h.number_of_pairs,
      CASE
        WHEN (p.user_id IS NOT NULL) THEN 'True'
        ELSE 'False'
        END AS 'is_purchase'
FROM quiz as 'q'
LEFT JOIN home_try_on as 'h'
     ON q.user_id = h.user_id
LEFT JOIN purchase as 'p'
     ON q.user_id = p.user_id
LIMIT 10;


--Question 5b
WITH newtable AS (
  SELECT DISTINCT q.user_id, 
    h.user_id IS NOT NULL AS 'is_home_try_on',
    h.number_of_pairs,
    p.user_id IS NOT NULL AS 'is_purchase'
FROM quiz as 'q'
LEFT JOIN home_try_on as 'h'
     ON q.user_id = h.user_id
LEFT JOIN purchase as 'p'
     ON q.user_id = p.user_id)
SELECT COUNT(*),
  SUM(is_home_try_on) AS 'Number Home Try-Ons',
  SUM(is_purchase) AS 'Number Purchases',
  1.0*SUM(is_home_try_on) / COUNT(user_id) AS 'Home Try-On %',
  1.0*SUM(is_purchase) / SUM(is_home_try_on) AS 'Purchase %'
FROM newtable;


--Question 6
WITH newtable AS (
  SELECT DISTINCT q.user_id, 
    h.user_id IS NOT NULL AS 'is_home_try_on',
    h.number_of_pairs,
    p.user_id IS NOT NULL AS 'is_purchase'
FROM quiz as 'q'
LEFT JOIN home_try_on as 'h'
     ON q.user_id = h.user_id
LEFT JOIN purchase as 'p'
     ON q.user_id = p.user_id)
SELECT number_of_pairs AS 'Num_Pairs',
       SUM(is_home_try_on) AS 'Number Home Try-Ons',
       SUM(is_purchase) AS 'Number Purchases',
       1.0*SUM(is_purchase) / SUM(is_home_try_on) AS 'Purchase %'
FROM newtable
GROUP BY number_of_pairs
ORDER BY number_of_pairs ASC
;