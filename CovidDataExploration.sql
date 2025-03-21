/*
Covid-19 Data Analysis and Insights

This project focuses on analyzing Covid-19 data across various regions 
to understand the global impact of the virus, including case numbers, 
deaths, and vaccination coverage. The analysis utilizes two key datasets, 
CovidDeaths and CovidVaccinations, loaded from Excel files into an SQLite 
database. The project calculates key metrics such as death percentages, 
the proportion of the population infected, and countries with the highest 
infection and mortality rates. It also tracks vaccination progress by 
calculating the percentage of the population vaccinated over time using
rolling counts, employing advanced SQL techniques like window functions, 
CTEs, and temporary tables for efficient data manipulation.

The output of the project provides valuable insights into the global 
pandemic’s impact and the effectiveness of vaccination campaigns. 
It includes data on Covid-19 case and death numbers, as well as 
vaccination coverage by country and continent. Advanced queries and 
optimizations ensure that the data is processed efficiently, even with
large datasets. The final result is a structured and optimized SQL setup 
that enables easy visualization of Covid-19 trends and supports 
data-driven decisions in public health responses.

*/


-- 1. Data Quality Check: Ensure no NULL values in critical columns
SELECT * FROM CovidDeaths WHERE total_cases IS NULL OR total_deaths IS NULL;
SELECT * FROM CovidVaccinations WHERE new_vaccinations IS NULL;

-- 2. Create necessary indices for better performance
CREATE INDEX IF NOT EXISTS idx_location_date ON CovidDeaths(location, date);
CREATE INDEX IF NOT EXISTS idx_vaccination_location_date ON CovidVaccinations(location, date);

-- 3. Selecting the initial data
SELECT 
    location, 
    date,
    total_cases,
    new_cases,
    total_deaths,
    population
FROM CovidDeaths
ORDER BY location, date;

-- 4. Total Cases vs Total Deaths: Likelihood of death from COVID-19
SELECT 
    location, 
    date,
    total_cases,
    total_deaths,
    ROUND((COALESCE(total_deaths, 0) / COALESCE(total_cases, 1)) * 100, 2) AS DeathPercentage
FROM CovidDeaths
ORDER BY location, date;

-- 5. Total Cases vs Population: Percentage of population infected with Covid
SELECT 
    location, 
    date,
    population,
    total_cases,
    ROUND((COALESCE(total_cases, 0) / COALESCE(population, 1)) * 100, 2) AS PercentPopulationInfected
FROM CovidDeaths
ORDER BY location, date;

-- 6. Countries with Highest Infection Rate compared to Population
SELECT 
    location, 
    population,
    MAX(total_cases) AS HighestInfectionCount,
    MAX((COALESCE(total_cases, 0) / COALESCE(population, 1))) * 100 AS PercentPopulationInfected
FROM CovidDeaths
GROUP BY location, population
ORDER BY PercentPopulationInfected DESC;

-- 7. Countries with Highest Death Count per Population
SELECT 
    location, 
    MAX(total_deaths) AS TotalDeathCount
FROM CovidDeaths
WHERE continent IS NOT NULL
GROUP BY location
ORDER BY TotalDeathCount DESC;

-- 8. Continents with the Highest Death Count per Population
SELECT 
    continent, 
    MAX(total_deaths) AS TotalDeathCount
FROM CovidDeaths
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY TotalDeathCount DESC;

-- 9. Total Population vs Vaccinations: Percentage of population vaccinated
SELECT 
    D.continent,
    D.location,
    D.date,
    D.population,
    V.new_vaccinations,
    SUM(V.new_vaccinations) OVER(PARTITION BY D.location ORDER BY D.location, D.date) AS RollingPeopleVaccinated
FROM CovidDeaths D
INNER JOIN CovidVaccinations V ON D.location = V.location AND D.date = V.date
WHERE D.continent IS NOT NULL
ORDER BY D.location, D.date;

-- 10. CTE for Vaccination Data and Rolling Vaccinations
WITH RollingVaccinationData AS (
    SELECT
        D.continent,
        D.location,
        D.date,
        D.population,
        V.new_vaccinations,
        SUM(V.new_vaccinations) OVER(PARTITION BY D.location ORDER BY D.date) AS RollingPeopleVaccinated
    FROM CovidDeaths D
    INNER JOIN CovidVaccinations V ON D.location = V.location AND D.date = V.date
)
SELECT *, ROUND((RollingPeopleVaccinated / Population) * 100, 2) AS VaccinationCoveragePercentage
FROM RollingVaccinationData;

-- 11. Temp Table to Calculate Rolling Vaccinations and Population Percentage
DROP TABLE IF EXISTS #TempCovidAnalysis;
CREATE TABLE #TempCovidAnalysis (
    Continent NVARCHAR(255),
    Location NVARCHAR(255),
    Date DATETIME,
    Population INT,
    TotalCases INT,
    TotalDeaths INT,
    Vaccinations INT
);

INSERT INTO #TempCovidAnalysis
SELECT
    D.continent,
    D.location,
    D.date,
    D.population,
    V.new_vaccinations,
    SUM(V.new_vaccinations) OVER(PARTITION BY D.location ORDER BY D.date) AS RollingPeopleVaccinated
FROM CovidDeaths D
INNER JOIN CovidVaccinations V ON D.location = V.location AND D.date = V.date;

SELECT 
    *, ROUND((RollingPeopleVaccinated / Population) * 100, 2) AS PercentPopulationVaccinated
FROM #TempCovidAnalysis;

-- 12. Create View for Vaccination Coverage Data
CREATE VIEW PercentPopulationVaccinated AS
SELECT 
    D.continent,
    D.location,
    D.date,
    D.population,
    V.new_vaccinations,
    SUM(V.new_vaccinations) OVER(PARTITION BY D.location ORDER BY D.date) AS RollingPeopleVaccinated
FROM CovidDeaths D
INNER JOIN CovidVaccinations V ON D.location = V.location AND D.date = V.date;

-- 13. Query from View for future visualizations
SELECT * FROM PercentPopulationVaccinated;

-- 14. Perform a Moving Average Calculation for Total Cases over the last 7 days
SELECT 
    location,
    date,
    total_cases,
    total_deaths,
    AVG(total_cases) OVER (PARTITION BY location ORDER BY date ROWS BETWEEN 7 PRECEDING AND CURRENT ROW) AS MovingAvgTotalCases
FROM CovidDeaths;

-- 15. Refactor and Optimize: Using DISTINCT for unique values
SELECT DISTINCT location FROM CovidDeaths;

-- 16. Handle Time Zones and Date Format for Consistency
SELECT
    location,
    DATE(date, 'UTC') AS date_utc,
    total_cases
FROM CovidDeaths;

-- 17. Data Completeness: Check for missing values and outliers
SELECT 
    location, 
    COUNT(*) AS total_records,
    SUM(CASE WHEN total_cases IS NULL THEN 1 ELSE 0 END) AS missing_total_cases
FROM CovidDeaths
GROUP BY location;

-- 18. Aggregating Data for Summarized View: Total Cases and Deaths by Location
SELECT
    location,
    SUM(total_cases) AS total_cases_sum,
    SUM(total_deaths) AS total_deaths_sum
FROM CovidDeaths
GROUP BY location;

-- 19. Index Optimization for Faster Access on Large Datasets
CREATE INDEX IF NOT EXISTS idx_location_population ON CovidDeaths(location, population);
CREATE INDEX IF NOT EXISTS idx_vaccination_date ON CovidVaccinations(date);

-- 20. Performance Testing: Use EXPLAIN for Query Optimization
EXPLAIN SELECT * FROM CovidDeaths WHERE total_cases > 10000;

-- END OF SQL SCRIPT
