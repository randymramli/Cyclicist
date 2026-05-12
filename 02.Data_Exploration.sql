-- Count how many rows of data there are
SELECT count(*)
FROM `Cyclicist.Merged_data`

-- Count how many null values exist in the table
SELECT count(*)
FROM `Cyclicist.Merged_data`
WHERE start_station_name IS NULL

-- Check data types of all column
SELECT column_name, data_type
FROM `Cyclicist.INFORMATION_SCHEMA.COLUMNS`
WHERE table_name = 'Merged_data';

-- Count how many null values in each column
DECLARE query STRING;

SET query = (
  SELECT STRING_AGG(
    FORMAT("COUNTIF(`%s` IS NULL) AS `%s`", column_name, column_name),
    ",\n"
  )
  FROM `Cyclicist.INFORMATION_SCHEMA.COLUMNS`
  WHERE table_name = 'Merged_data'
);

EXECUTE IMMEDIATE FORMAT("""
  SELECT
    %s
  FROM `Cyclicist.Merged_data`
""", query);

-- count how many ride_id have duplicates
SELECT COUNT(*) - COUNT(DISTINCT ride_id) AS duplicate_count
FROM `Cyclicist.Merged_data`;

-- count how many duplicates each duplicate ride_id have
SELECT ride_id, COUNT(*) AS freq
FROM `Cyclicist.Merged_data`
GROUP BY ride_id
HAVING COUNT(*)>1

-- Count how many types there are for each bike type
SELECT DISTINCT rideable_type,count(rideable_type) as bike_types
FROM `Cyclicist.Merged_data`
GROUP BY rideable_type

-- count how many types there are for each membership type
SELECT DISTINCT member_casual,COUNT(member_casual) AS member_types
FROM `Cyclicist.Merged_data`
GROUP BY member_casual


