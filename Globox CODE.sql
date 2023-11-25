-- What are the start and end dates of the experiment? This question is required.?
SELECT max(join_dt),MIN (join_dt)
FROM groups;
--How many total users were in the experiment? 
SELECT COUNT(id)
FROM users;
--How many total users were in the experiment?
SELECT SUM(id)
FROM users;
--How many users were in the control and treatment groups?
SELECT COUNT(*), groups.group
FROM groups
GROUP by 2;
--What was the conversion rate of all users?
WITH t1 AS 
	(SELECT COUNT(DISTINCT(uid)):: NUMERIC as c1
   FROM activity),
 t2 AS 
 	(SELECT COUNT(id):: NUMERIC as c2
   FROM users)
SELECT c1/c2
FROM t1,t2;
--What is the user conversion rate for the control and treatment groups?
SELECT COUNT(DISTINCT(a.uid))/COUNT(DISTINCT(u.id)):: NUMERIC*100 as c1
FROM users u
INNER JOIN groups g
ON u.id = g.uid
LEFT JOIN activity a
ON a.uid = u.id
GROUP BY g.group;
--What is the average amount spent per user for the control and treatment groups, including users who did not convert?
SELECT g.group,SUM(a.spent)/COUNT(DISTINCT(u.id)):: NUMERIC as c1
FROM users u
INNER JOIN groups g
ON u.id = g.uid
LEFT JOIN activity a
ON a.uid = u.id
GROUP BY g.group;
--