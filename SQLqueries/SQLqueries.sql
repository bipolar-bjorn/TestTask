# НАПИСАТЬ SQL ЗАПРОС, С ПОМОЩЬЮ КОТОРОГО МОЖНО ПОСМОТРЕТЬ ТОП-10 АТЛЕТОВ С НАИБОЛЬШИМ КОЛИЧЕСТВОМ
# ПОДИУМОВ (ЗОЛОТО, СЕРЕБРО, БРОНЗА)

WITH
    t1 AS (SELECT Name, COUNT(1) as total_medals
            FROM athlete_events
            WHERE Medal <> '0'
            GROUP BY Name
            ORDER BY COUNT(1) DESC),
    t2 AS (SELECT *, DENSE_RANK() OVER(ORDER BY t1.total_medals DESC) AS rnk FROM t1)
SELECT * FROM t2 WHERE rnk < 11;

# ДЛЯ КАЖДОГО АТЛЕТА ВЫВЕСТИ КОЛИЧЕСТВО МЕДАЛЕЙ (ЗОЛОТО, СЕРЕБРО, БРОНЗА В ОТДЕЛЬНЫХ СТРОКАХ)
SELECT
    DISTINCT Name,
             COUNT(CASE WHEN Medal = 'Gold' THEN 'Medal' END) as Gold_Medals,
             COUNT(CASE WHEN Medal = 'Silver' THEN 'Medal' END) as Silver_Medals,
             COUNT(CASE WHEN Medal = 'Bronze' THEN 'Medal' END) as Bronze_Medals
FROM athlete_events
GROUP BY Name
ORDER BY Gold_Medals DESC;

# ВЫВЕСТИ СТРАНУ С САМЫМ МАЛЕНЬКИМ КОЛИЧЕСТВОМ НАГРАД

SELECT DISTINCT NOC, COUNT(1) as Medals
FROM athlete_events
WHERE Medal <> '0'
GROUP BY NOC HAVING Medals < 2
ORDER BY COUNT(1) ASC;


# ВЫВЕСТИ КОЛИЧЕСТВО УЧАСТНИКОВ ПО ГОДАМ ПРОВЕДЕНИЯ

SELECT Games, COUNT(DISTINCT Name) as Number_of_participants
FROM athlete_events
GROUP BY Games
ORDER BY Games DESC;

# ВЫВЕСТИ МАКСИМАЛЬНЫЙ И МИНИМАЛЬНЫЙ ВОЗРАСТ УЧАСТНИКОВ ДЛЯ КАЖДЫХ ОЛИМПИЙСКИХ ИГР

SELECT DISTINCT Games, MIN(Age) as min_age, MAX(Age) as Max_age
FROM athlete_events
WHERE Age <> 0
GROUP BY Games
ORDER BY Games;

