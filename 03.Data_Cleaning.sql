DROP TABLE IF EXISTS `Cyclicist.Cleaned_data`;

-- creating new table with clean data

CREATE TABLE IF NOT EXISTS `Cyclicist.Cleaned_data` AS 

-- Make sure all the rides have been used over 0 seconds
WITH base AS (
  SELECT
      *,
      TIMESTAMP_DIFF(ended_at, started_at, SECOND) AS Duration_second,
      TIMESTAMP_DIFF(ended_at, started_at, MINUTE) AS Duration_minute
    FROM `Cyclicist.Merged_data`
    WHERE TIMESTAMP_DIFF(ended_at, started_at, SECOND) > 0
  ),

-- Remove outlier by removing 1% outlier
threshold AS (
  SELECT
    APPROX_QUANTILES(duration_second, 100)[OFFSET(99)] AS p99
  FROM base
),

filtered AS (
  SELECT *
  FROM base, threshold
  WHERE duration_second <= p99
)

(
  SELECT 
    ride_id,
    rideable_type,
    started_at,
    EXTRACT(YEAR FROM started_at) as start_year,
    CASE EXTRACT(MONTH FROM started_at)
      WHEN 1 THEN 'JAN'
      WHEN 2 THEN 'FEB'
      WHEN 3 THEN 'MAR'
      WHEN 4 THEN 'APR'
      WHEN 5 THEN 'MAY'
      WHEN 6 THEN 'JUN'
      WHEN 7 THEN 'JUL'
      WHEN 8 THEN 'AUG'
      WHEN 9 THEN 'SEP'
      WHEN 10 THEN 'OCT'
      WHEN 11 THEN 'NOV'
      WHEN 12 THEN 'DEC'
    END AS start_month,
    EXTRACT(DAY FROM started_at) as start_day,
    CASE EXTRACT(DAYOFWEEK FROM started_at)
      WHEN 1 THEN 'SUN'
      WHEN 2 THEN 'MON'
      WHEN 3 THEN 'TUES'
      WHEN 4 THEN 'WED'
      WHEN 5 THEN 'THURS'
      WHEN 6 THEN 'FRI'
      WHEN 7 THEN 'SAT'    
    END AS day_of_week,
    ended_at,
    Duration_second,

    -- Grouping the duration of bike renters
    Duration_minute,
    CASE
      WHEN Duration_minute <= 5 THEN '0-5 min'
      WHEN Duration_minute <= 10 THEN '5-10 min'
      WHEN Duration_minute <= 20 THEN '10-20 min'
      WHEN Duration_minute <= 30 THEN '20-30 min'
      WHEN Duration_minute <= 60 THEN '30-60 min'
      WHEN Duration_minute <= 120 THEN '60-120 min'
      WHEN Duration_minute <= 1440 THEN '120 min - 1 day'
      ELSE 'Over 1 day'
    END as Duration_group,
    member_casual
    FROM filtered
);