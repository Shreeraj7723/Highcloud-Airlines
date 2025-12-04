use airline_maindata;
SELECT * FROM MAINDATA;
ALTER TABLE maindata
    RENAME COLUMN `%Airline ID` TO airline_id,
    RENAME COLUMN `%Carrier Group ID` TO carrier_group_id,
    RENAME COLUMN `%Unique Carrier Code`TO unique_carrier_code,
    RENAME COLUMN `%Unique Carrier Entity Code` TO unique_carrier_entity_code,
    RENAME COLUMN `%Region Code` TO region_code,
    RENAME COLUMN `%Origin Airport ID` TO origin_airport_id,
    RENAME COLUMN `%Origin Airport Sequence ID` TO origin_airport_sequence_id,
    RENAME COLUMN `%Origin Airport Market ID` TO origin_airport_market_id,
    RENAME COLUMN `%Origin World Area Code` TO origin_world_area_code,
    RENAME COLUMN `%Destination Airport ID` TO destination_airport_id,
    RENAME COLUMN `%Destination Airport Sequence ID` TO destination_airport_sequence_id,
    RENAME COLUMN `%Destination Airport Market ID` TO destination_airport_market_id,
    RENAME COLUMN `%Destination World Area Code` TO destination_world_area_code,
    RENAME COLUMN `%Aircraft Group ID` TO aircraft_group_id,
    RENAME COLUMN `%Aircraft Type ID` TO aircraft_type_id,
    RENAME COLUMN `%Aircraft Configuration ID` TO aircraft_configuration_id,
    RENAME COLUMN `%Distance Group ID` TO distance_group_id,
    RENAME COLUMN `%Service Class ID` TO service_class_id,
    RENAME COLUMN `%Datasource ID` TO datasource_id,
    RENAME COLUMN `# Departures Scheduled` TO departures_scheduled,
    RENAME COLUMN `# Departures Performed` TO departures_performed,
    RENAME COLUMN `# Payload` TO payload,
    RENAME COLUMN Distance TO distance,
    RENAME COLUMN `# Available Seats` TO available_seats,
    RENAME COLUMN `# Transported Passengers` TO transported_passengers,
    RENAME COLUMN `# Transported Freight` TO transported_freight,
    RENAME COLUMN `# Transported Mail` TO transported_mail,
    RENAME COLUMN `# Ramp-To-Ramp Time` TO ramp_to_ramp_time,
    RENAME COLUMN `# Air Time` TO air_time,
    RENAME COLUMN `Unique Carrier` TO unique_carrier,
    RENAME COLUMN `Carrier Code` TO carrier_code,
    RENAME COLUMN `Carrier Name` TO carrier_name,
    RENAME COLUMN `Origin Airport Code` TO origin_airport_code,
    RENAME COLUMN `Origin City` TO origin_city,
    RENAME COLUMN `Origin State Code` TO origin_state_code,
    RENAME COLUMN `Origin State FIPS` TO origin_state_fips,
    RENAME COLUMN `Origin State` TO origin_state,
    RENAME COLUMN `Origin Country Code` TO origin_country_code,
    RENAME COLUMN `Origin Country` TO origin_country,
    RENAME COLUMN `Destination Airport Code` TO destination_airport_code,
    RENAME COLUMN `Destination City`TO destination_city,
    RENAME COLUMN `Destination State Code` TO destination_state_code,
    RENAME COLUMN `Destination State FIPS` TO destination_state_fips,
    RENAME COLUMN `Destination State` TO destination_state,
    RENAME COLUMN `Destination Country Code` TO destination_country_code,
    RENAME COLUMN `Destination Country` TO destination_country,
    RENAME COLUMN Year TO year,
    RENAME COLUMN `Month (#)` TO month_num,
    RENAME COLUMN Day TO day,
    RENAME COLUMN `From - To Airport Code` TO from_to_airport_code,
    RENAME COLUMN `From - To Airport ID` TO from_to_airport_id,
    RENAME COLUMN `From - To City` TO from_to_city,
    RENAME COLUMN `From - To State Code` TO from_to_state_code,
    RENAME COLUMN `From - To State` TO from_to_state;


-- 1.Create a full Date field from Year, Month, Day
ALTER TABLE maindata 
ADD full_date DATE;

UPDATE maindata
SET full_date = STR_TO_DATE(CONCAT(Year,'-',month_num,'-',Day), '%Y-%m-%d');

-- 2.Year
SELECT full_date, YEAR(full_date) AS year_extracted
FROM maindata;

-- 3.Month Number
SELECT full_date, MONTH(full_date) AS month_number
FROM maindata;

-- 4.Month Full Name
SELECT full_date, MONTHNAME(full_date) AS month_name
FROM maindata;

-- 5.Quarter (Q1–Q4)
SELECT full_date,
       CONCAT('Q', QUARTER(full_date)) AS quarter
FROM maindata;

-- 6.Create Year-Month (YYYY-MMM)
SELECT DATE_FORMAT(full_date,'%Y-%b') AS yr_month
FROM maindata;

-- 7.Weekday Number
SELECT full_date, DAYOFWEEK(full_date) AS weekday_no
FROM maindata;

-- 8.Weekday Name
SELECT full_date, DAYNAME(full_date) AS weekday_name
FROM maindata;

-- 9.Financial Month (Apr–Mar)
SELECT full_date,
CASE 
    WHEN MONTH(full_date) >= 4 THEN MONTH(full_date)-3
    ELSE MONTH(full_date)+9
END AS financial_month
FROM maindata;

-- 10.Financial Quarter
SELECT full_date,
CASE 
    WHEN MONTH(full_date) BETWEEN 4 AND 6 THEN 'Q1'
    WHEN MONTH(full_date) BETWEEN 7 AND 9 THEN 'Q2'
    WHEN MONTH(full_date) BETWEEN 10 AND 12 THEN 'Q3'
    ELSE 'Q4'
END AS financial_quarter
FROM maindata;

-- 11.Load Factor % by Year
SELECT YEAR(full_date) AS year,
SUM(transported_passengers) / SUM(available_seats) * 100 AS load_factor_percent
FROM maindata
GROUP BY YEAR(full_date);

-- 12.Load Factor % by Quarter
SELECT CONCAT('Q', QUARTER(full_date)) AS quarter,
SUM(transported_passengers) / SUM(available_seats) * 100 AS load_factor
FROM maindata
GROUP BY QUARTER;

-- 13.Load Factor % Monthly
SELECT DATE_FORMAT(full_date,'%Y-%m') AS month,
SUM(transported_passengers) / SUM(available_seats) * 100 AS load_factor
FROM maindata
GROUP BY DATE_FORMAT(full_date,'%Y-%m');

-- 14.Load Factor by Carrier Name
SELECT carrier_name,
SUM(transported_passengers) / SUM(available_seats) * 100 AS load_factor
FROM maindata
GROUP BY carrier_name
ORDER BY load_factor DESC;

-- 15.Top 10 Airlines by Passenger Preference
SELECT carrier_name,
SUM(transported_passengers) AS total_passengers
FROM maindata
GROUP BY carrier_name
ORDER BY total_passengers DESC
LIMIT 10;

-- 16.Top Routes based on Number of Flights
SELECT From_To_City AS route,
COUNT(*) AS total_flights
FROM maindata
GROUP BY route
ORDER BY total_flights DESC
LIMIT 10;

-- 17.Weekend vs Weekday Load Factor
SELECT
CASE WHEN DAYOFWEEK(full_date) IN (1,7) THEN 'Weekend' ELSE 'Weekday' END AS day_type,
SUM(transported_passengers) / SUM(available_seats) * 100 AS load_factor
FROM maindata
GROUP BY day_type;

-- 18.Number of Flights by Distance Group
SELECT distance_group_id, COUNT(*) AS total_flights
FROM maindata
GROUP BY distance_group_id
ORDER BY total_flights DESC;

-- 19.Search Flights (Country/State/City Filters — Dynamic Query)
SELECT *
FROM maindata
WHERE origin_country = 'UNITED STATES'
  AND origin_state = 'ALASKA'
  AND origin_city = 'Red Dog, AK'
  AND destination_country = 'UNITED STATES'
  AND destination_state = 'ALASKA'
  AND destination_city = 'Kotzebue, AK';

-- 20.Average Passengers per Route
WITH route_data AS (
   SELECT From_To_City AS route,
          transported_passengers
   FROM maindata
)
SELECT route,
       AVG(transported_passengers) AS avg_passengers
FROM route_data
GROUP BY route;

-- 21.Load Factor Summary
CREATE VIEW v_loadfactor AS
SELECT carrier_name,
       SUM(transported_passengers) AS total_passengers,
       SUM(available_seats) AS total_seats,
       SUM(transported_passengers)/SUM(available_seats)*100 AS load_factor
FROM maindata
GROUP BY carrier_name;

-- 22.Search Flights by Route
DELIMITER $$

CREATE PROCEDURE search_flights (
    IN src_city VARCHAR(100),
    IN dest_city VARCHAR(100)
)
BEGIN
    SELECT *
    FROM maindata
    WHERE origin_city = src_city
      AND destination_city = dest_city;
END $$

DELIMITER ;


CALL search_flights('Red Dog, AK','Kotzebue, AK');
