-- Q3:

-- Join Query
SELECT
  sd.version_code,
  s.id AS survivor_id,
  s.first_name,
  s.last_name,
  MAX(a.days_lasted) AS max_days
FROM appearance_data AS a
JOIN season_data  AS sd ON sd.id = a.season_data_id
JOIN survivalist_data AS s ON s.id = a.survivalist_id
GROUP BY
  sd.version_code,
  s.id, s.first_name, s.last_name
ORDER BY
  sd.version_code,
  max_days DESC;

 
 -- Subquery Query (Where Subquery)
SELECT
  s.id AS survivor_id,
  s.first_name,
  s.last_name,
  a.days_lasted, (SELECT AVG(days_lasted) FROM appearance_data) AS mean_days_lasted,
  (SELECT COUNT(survivor_id) FROM appearance_data) AS total_number_of_survivors
FROM appearance_data AS a
JOIN survivalist_data AS s ON s.id = a.survivalist_id
WHERE a.days_lasted > (
  SELECT AVG(days_lasted)
  FROM appearance_data
)
ORDER BY a.days_lasted DESC;


 -- CTE  Query 
WITH avg_days AS (
  SELECT
    sd.id AS season_id,
    sd.version_code,
    sd.season_number,
    AVG(a.days_lasted) AS avg_lasted
  FROM appearance_data AS a
  JOIN season_data AS sd ON sd.id = a.season_data_id
  GROUP BY sd.id, sd.version_code, sd.season_number
)
SELECT
  version_code,
  season_number,
  ROUND(avg_lasted, 1) AS avg_days_lasted
FROM avg_days
WHERE avg_lasted < (
  SELECT AVG(days_lasted)
  FROM appearance_data
)
ORDER BY avg_lasted;


-- Window Function Query
SELECT
  version_code, season_number, first_name, last_name, gap_days
FROM (
  SELECT
    sd.version_code,
    sd.season_number,
    s.first_name,
    s.last_name,
    ROW_NUMBER() OVER (
      PARTITION BY sd.id
      ORDER BY a.days_lasted DESC
    ) AS rn,
    a.days_lasted
      - LEAD(a.days_lasted) OVER (
          PARTITION BY sd.id
          ORDER BY a.days_lasted DESC
        ) AS gap_days
  FROM appearance_data AS a
  JOIN season_data     AS sd ON a.season_data_id = sd.id
  JOIN survivalist_data AS s ON a.survivalist_id = s.id
) AS ranked
WHERE rn = 1
ORDER BY version_code, season_number;


-- Union Query
(SELECT
  s.id AS survivor_id,
  s.first_name,
  s.last_name,
  'Winner' AS status,
  a.days_lasted
FROM appearance_data AS a
JOIN survivalist_data AS s ON s.id = a.survivalist_id
WHERE a.result = 1)
UNION ALL
(SELECT
  s.id  AS survivor_id,
  s.first_name,
  s.last_name,
  'Medically Evacuated' AS status,
  a.days_lasted
FROM appearance_data AS a
JOIN survivalist_data AS s ON s.id = a.survivalist_id
WHERE a.medically_evacuated = 1)
ORDER BY status, days_lasted DESC;


-- Q4:
-- View
CREATE VIEW season_metrics AS
SELECT
  sd.version_code,
  sd.season_number,
  COUNT(*) AS total_contestants, ROUND(AVG(a.days_lasted),2) AS avg_days_lasted,
  MAX(a.days_lasted) AS max_days_lasted,
  ROUND(
    SUM(CASE WHEN a.medically_evacuated=1 THEN 1 ELSE 0 END)
    / COUNT(*) * 100, 2
  ) AS pct_medical_evacuations,
  ROUND(
    SUM(CASE WHEN a.reason_category='Health' 
             AND a.medically_evacuated=0 THEN 1 ELSE 0 END)
    / COUNT(*) * 100, 2
  ) AS pct_health_tapouts,
  ROUND(
    SUM(CASE WHEN a.reason_category='Personal' 
             AND a.medically_evacuated=0 THEN 1 ELSE 0 END)
    / COUNT(*) * 100, 2
  ) AS pct_personal_tapouts
FROM appearance_data AS a
JOIN season_data AS sd ON a.season_data_id = sd.id
GROUP BY
  sd.version_code, sd.season_number;
  
-- Operate View
SELECT * 
FROM season_metrics


-- Q5:
-- Stored Procedure
DELIMITER //
CREATE PROCEDURE AnalyzeProfessionPerformanceByProfession(
  IN p_profession VARCHAR(100)
)
BEGIN
  SELECT
    ssd.profession AS Profession,
    COUNT(*) AS TotalAppearances,
    ROUND(AVG(a.days_lasted), 2) AS AvgDaysLasted,
    MAX(a.days_lasted) AS MaxDaysLasted,
    MIN(a.days_lasted) AS MinDaysLasted,
    ROUND(
      SUM(CASE WHEN a.result = 1 THEN 1 ELSE 0 END)
      / COUNT(*) * 100, 2
    ) AS PctWinners,
    ROUND(
      SUM(CASE WHEN a.medically_evacuated = 1 THEN 1 ELSE 0 END)
      / COUNT(*) * 100, 2
    ) AS PctMedEvacs
  FROM survivor_season_data AS ssd
  JOIN appearance_data AS a ON  ssd.survivalist_id = a.survivalist_id AND ssd.season_data_id = a.season_data_id
  WHERE ssd.profession = p_profession
  GROUP BY ssd.profession;
END;
//
DELIMITER ;

-- Call the Procedure
CALL AnalyzeProfessionPerformanceByProfession('US Veteran');




