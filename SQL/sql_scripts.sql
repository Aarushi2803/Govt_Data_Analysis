-- Q1. Top 10 states by total deaths
SELECT
     "State_UT",
     "Total_Died",
    RANK() OVER(ORDER BY "Total_Died" DESC) AS death_rank
FROM my_cleaned_data
ORDER BY death_rank
LIMIT 10;

-- Q2. Fatality rate per state (deaths per 100 cases)
--  + rank by fatality rate
Select 
   "State_UT",
   "Total_Cases",
   "Total_Died",
   ROUND("Total_Died"*100.00/NULLIF( "Total_Cases",0),2) AS fatality_rate,
   RANK() OVER (
        ORDER BY ROUND("Total_Died" * 100.0 / NULLIF("Total_Cases", 0), 2) DESC
    ) AS fatality_rank
FROM my_cleaned_data
ORDER BY fatality_rank
LIMIT 10;

-- Q3. States ABOVE national average fatality rate
--     (uses subquery — common interview pattern)
SELECT
    "State_UT",
    ROUND("Total_Died" * 100.0 / NULLIF("Total_Cases", 0), 2) AS fatality_rate
FROM my_cleaned_data
WHERE
    ROUND("Total_Died" * 100.0 / NULLIF("Total_Cases", 0), 2) >
    (
        SELECT AVG("Total_Died" * 100.0 / NULLIF("Total_Cases", 0))
        FROM my_cleaned_data
    )
ORDER BY fatality_rate DESC;

-- Q4. Road vs Railway vs Crossing — death breakdown
--   (pivot-style using conditional aggregation)
SELECT
    "State_UT",
    "Road_Died",
    "Rail_Died",
    "Crossing_Died",
    "Total_Died",
    ROUND("Road_Died"     * 100.0 / NULLIF("Total_Died", 0), 1) AS road_pct,
    ROUND("Rail_Died"     * 100.0 / NULLIF("Total_Died", 0), 1) AS rail_pct,
    ROUND("Crossing_Died" * 100.0 / NULLIF("Total_Died", 0), 1) AS crossing_pct
FROM my_cleaned_data
ORDER BY "Total_Died" DESC
LIMIT 15;

-- Q5. Risk quartile using NTILE(4)   highest risk, Q1 = lowest
SELECT
    "State_UT",
    "Total_Died",
    ROUND("Total_Died" * 100.0 / NULLIF("Total_Cases", 0), 2) AS fatality_rate,
    NTILE(4) OVER (
        ORDER BY ("Total_Died" * 100.0 / NULLIF("Total_Cases", 0))
    ) AS risk_quartile
FROM my_cleaned_data
ORDER BY risk_quartile DESC, fatality_rate DESC;


-- Q6. Top 5 most DANGEROUS crossing states
--     (crossing fatality rate)
SELECT
    "State_UT",
    "Crossing_Cases",
    "Crossing_Died",
    ROUND("Crossing_Died" * 100.0 / NULLIF("Crossing_Cases", 0), 2) AS crossing_fatality_rate
FROM my_cleaned_data
WHERE "Crossing_Cases" > 0
ORDER BY crossing_fatality_rate DESC
LIMIT 5;

-- Q7. National summary — total across all states
SELECT
    SUM("Total_Cases")                                              AS national_total_cases,
    SUM("Total_Injured")                                            AS national_total_injured,
    SUM("Total_Died")                                               AS national_total_deaths,
    ROUND(SUM("Total_Died") * 100.0 / NULLIF(SUM("Total_Cases"), 0), 2) AS national_fatality_rate,
    ROUND(SUM("Road_Died")     * 100.0 / NULLIF(SUM("Total_Died"), 0), 1) AS road_death_share_pct,
    ROUND(SUM("Rail_Died")     * 100.0 / NULLIF(SUM("Total_Died"), 0), 1) AS rail_death_share_pct,
    ROUND(SUM("Crossing_Died") * 100.0 / NULLIF(SUM("Total_Died"), 0), 1) AS crossing_death_share_pct
FROM my_cleaned_data;

