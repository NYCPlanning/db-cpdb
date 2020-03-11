-- Summary of $s commitments by budgetline by fiscal year for data extracted from CCP
SELECT total.budgetline,
	SUM(total.citycost+total.noncitycost) AS total, 
	fy2017.fy2017, 
	fy2018.fy2018, 
	fy2019.fy2019, 
	fy2020.fy2020, 
	fy2021.fy2021
FROM commitments2017aprtestdoyle AS total

LEFT JOIN 
(SELECT budgetline, SUM(citycost+noncitycost) AS fy2017 
FROM commitments2017aprtestdoyle
	WHERE ((RIGHT(plancommdate,2) = '16' 
		AND LEFT(plancommdate,2)::double precision > '6') 
		OR (RIGHT(plancommdate,2) = '17' 
		AND LEFT(plancommdate,2)::double precision < '7'))
GROUP BY budgetline
 ) AS fy2017
 ON total.budgetline=fy2017.budgetline

LEFT JOIN 
(SELECT budgetline, SUM(citycost+noncitycost) AS fy2018 
FROM commitments2017aprtestdoyle
	WHERE ((RIGHT(plancommdate,2) = '17' 
		AND LEFT(plancommdate,2)::double precision > '6') 
		OR (RIGHT(plancommdate,2) = '18' 
		AND LEFT(plancommdate,2)::double precision < '7'))
GROUP BY budgetline
 ) AS fy2018
 ON total.budgetline=fy2018.budgetline

LEFT JOIN 
(SELECT budgetline, SUM(citycost+noncitycost) AS fy2019 
FROM commitments2017aprtestdoyle
	WHERE ((RIGHT(plancommdate,2) = '18' 
		AND LEFT(plancommdate,2)::double precision > '6') 
		OR (RIGHT(plancommdate,2) = '19' 
		AND LEFT(plancommdate,2)::double precision < '7'))
GROUP BY budgetline
 ) AS fy2019
 ON total.budgetline=fy2019.budgetline

 LEFT JOIN 
(SELECT budgetline, SUM(citycost+noncitycost) AS fy2020 
FROM commitments2017aprtestdoyle
	WHERE ((RIGHT(plancommdate,2) = '19' 
		AND LEFT(plancommdate,2)::double precision > '6')
		OR (RIGHT(plancommdate,2) = '20' 
		AND LEFT(plancommdate,2)::double precision < '7'))
GROUP BY budgetline
 ) AS fy2020
 ON total.budgetline=fy2020.budgetline

  LEFT JOIN 
(SELECT budgetline, SUM(citycost+noncitycost) AS fy2021 
FROM commitments2017aprtestdoyle
	WHERE ((RIGHT(plancommdate,2) = '20' 
		AND LEFT(plancommdate,2)::double precision > '6') 
		OR (RIGHT(plancommdate,2) = '21' 
		AND LEFT(plancommdate,2)::double precision < '7'))
GROUP BY budgetline
 ) AS fy2021
 ON total.budgetline=fy2021.budgetline

GROUP BY total.budgetline, fy2017.fy2017, fy2018.fy2018, fy2019.fy2019, fy2020.fy2020, fy2021.fy2021
ORDER BY total.budgetline