CREATE DATABASE olympics;
USE olympics;
CREATE TABLE olympics_history (id INT,
			name VARCHAR(20),
            sex VARCHAR(20),
            age VARCHAR(20),
            height VARCHAR(20),
            weight VARCHAR(20),
            team VARCHAR(20),
            noc VARCHAR(20),
            games VARCHAR(20),
            year INT,
            season VARCHAR(20),
            city VARCHAR(20),
            sport VARCHAR(20),
            event VARCHAR(20),
            medal VARCHAR(20));
SELECT*FROM olympics_history;

SELECT COUNT(DISTINCT name) as total_number_players
FROM olympics_history;

CREATE TABLE olympics_history_noc_region (noc VARCHAR(20),
										region VARCHAR(20),
                                        notes VARCHAR(20));
SELECT*FROM olympics_history_noc_region;
ALTER TABLE olympics_history
MODIFY COLUMN age INT;
ALTER TABLE olympics_history
MODIFY COLUMN age VARCHAR(20);
USE olympics;
SELECT*FROM olympics_history_noc_region;
select*from olympics_history;
/*find no. of summer olympic sports*/
SELECT COUNT(DISTINCT games) as total_number_games
FROM olympics_history
WHERE season = 'summer';

Select distinct sport, games
from olympics_history
WHERE season = 'summer' order by games;
 
 SELECT COUNT(sport), sport
 FROM olympics_history
 WHERE season = 'summer'
 group by sport;

USE olympics;
SELECT*FROM olympics_history;

#Rank of athletes who won gold medals

with t1 as
	(SELECT name, count(1) as medal
	FROM olympics_history
	WHERE medal = 'gold'
	GROUP BY name
	ORDER BY Count(1) desc),
t2 as
	(SELECT*, dense_rank() over (order by medal desc) as rnk
    from t1)
SELECT*FROM t2;

#Total gold, silver, and bronze medals won by each country

SELECT nr.region as country, medal, count(1) as total_medals
FROM olympics_history oh
JOIN olympics_history_noc_region nr on nr.noc=oh.noc
WHERE medal <> 'NA'
group by nr.region, medal
order by nr.region, medal;
