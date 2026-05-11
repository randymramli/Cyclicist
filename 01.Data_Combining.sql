-- Combine data from 2025 data into one table

DROP TABLE IF EXISTS `Cyclicist.all_data`;

CREATE TABLE IF NOT EXISTS `Cyclicist.Merged_data` AS (

  SELECT * FROM `Cyclicist.202501-divvy-tripdata`
  UNION ALL
  SELECT * FROM `Cyclicist.202502-divvy-tripdata`
  UNION ALL
  SELECT * FROM `Cyclicist.202503-divvy-tripdata`
  UNION ALL
  SELECT * FROM `Cyclicist.202504-divvy-tripdata`
  UNION ALL
  SELECT * FROM `Cyclicist.202505-divvy-tripdata`
  UNION ALL
  SELECT * FROM `Cyclicist.202506-divvy-tripdata`
  UNION ALL
  SELECT * FROM `Cyclicist.202503-divvy-tripdata`
  UNION ALL
  SELECT * FROM `Cyclicist.202507-divvy-tripdata`
  UNION ALL
  SELECT * FROM `Cyclicist.202508-divvy-tripdata`
  UNION ALL
  SELECT * FROM `Cyclicist.202509-divvy-tripdata`
  UNION ALL
  SELECT * FROM `Cyclicist.202510-divvy-tripdata`
  UNION ALL
  SELECT * FROM `Cyclicist.202511-divvy-tripdata`
  UNION ALL
  SELECT * FROM `Cyclicist.202512-divvy-tripdata`
);