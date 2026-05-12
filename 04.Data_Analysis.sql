-- count the total amount of each member type and their average bike usage time
select member_casual,
count(member_casual) as total_member_casual,
sum(Duration_second) as total_trip_second,
avg(Duration_second) as average_second_per_trip,
avg(Duration_minute) as average_minute_per_trip
from `Cyclicist.Cleaned_data`
group by member_casual;

-- count which bike type each member type use
select 
  member_casual,
  rideable_type,
  count(*) as ride_total
from `Cyclicist.Cleaned_data`
group by member_casual, rideable_type
order by member_casual, rideable_type;

-- count how many minutes on average each member type use every month
select member_casual,
EXTRACT(MONTH FROM started_at) as month,
round(avg(Duration_minute),2) as average_minute_per_trip,
from `Cyclicist.Cleaned_data`
group by member_casual, month
order by member_casual, month;

-- count how many minutes on average each member type use every day
select member_casual,
EXTRACT(DAYOFWEEK FROM started_at) as weekday,
round(avg(Duration_minute),2) as average_minute_per_trip,
from `Cyclicist.Cleaned_data`
group by member_casual, weekday
order by member_casual, weekday;

-- find what time each member type use the bike sharing service
select ride_id, member_casual, started_at,
CASE 
    WHEN EXTRACT(HOUR FROM started_at) = 0 THEN '12 AM (Midnight)'
    WHEN EXTRACT(HOUR FROM started_at) < 12 THEN CAST(EXTRACT(HOUR FROM started_at) AS STRING) || ' AM'
    WHEN EXTRACT(HOUR FROM started_at) = 12 THEN '12 PM (Noon)'
    ELSE CAST(EXTRACT(HOUR FROM started_at) - 12 AS STRING) || ' PM'
  END AS am_pm
from `Cyclicist.Cleaned_data`