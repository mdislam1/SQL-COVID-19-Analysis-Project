-- Select Data that we are going to be starting with

SELECT 
	location, 
	date,
	total_cases,
	new_cases,
	total_deaths,
	population
FROM CovidDeaths
ORDER BY 1,2


-- Total Cases vs Total Deaths
-- Shows likelihood of dying if you contract covid in your country

SELECT 
	location, 
	date,
	total_cases,
	total_deaths,
	(total_deaths / total_cases) * 100 AS DeathPercentage
FROM CovidDeaths
ORDER BY 1,2


-- Total Cases vs Population
-- Shows what percentage of population infected with Covid

SELECT 
	location, 
	date,
	population,
	total_cases,
	(total_cases / population) * 100 AS	PercentPopulationInfected
FROM CovidDeaths
ORDER BY 1,2


-- Countries with Highest Infection Rate compared to Population

SELECT 
	location, 
	population,
	MAX(total_cases) AS HighestInfectionCount,
	MAX((total_cases / population)) * 100 AS PercentPopulationInfected
FROM CovidDeaths
GROUP BY location, population
ORDER BY PercentPopulationInfected DESC


-- Countries with Highest Death Count per Population

SELECT 
	location, 
	MAX(total_deaths) AS TotalDeathCount
FROM CovidDeaths
WHERE continent IS NOT NULL
GROUP BY location
ORDER BY TotalDeathCount DESC


-- Showing contintents with the highest death count per population

SELECT 
	continent, 
	MAX(total_deaths) AS TotalDeathCount
FROM CovidDeaths
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY TotalDeathCount DESC


-- Total Population vs Vaccinations
-- Shows Percentage of Population that has recieved at least one Covid Vaccine

SELECT 
	D.continent,
	D.location,
	D.date,
	D.population,
	V.new_vaccinations,
	SUM(V.new_vaccinations) OVER(PARTITION BY D.location ORDER BY D.location, D.date) as RollingPeopleVaccinated
FROM CovidDeaths D
INNER JOIN CovidVaccinations V 
ON D.location = V.location 
and D.date = V.date
WHERE D.continent IS NOT NULL
ORDER BY 2,3


-- Using CTE to perform Calculation on Partition By in previous query

WITH PopVsVac (Continent, Location, Date, Population, New_Vaccinations, RollingPeopleVaccinated)
AS 
(
	SELECT 
		D.continent,
		D.location,
		D.date,
		D.population,
		V.new_vaccinations,
		SUM(V.new_vaccinations) OVER(PARTITION BY D.location ORDER BY D.location, D.date) as RollingPeopleVaccinated
	FROM CovidDeaths D
	INNER JOIN CovidVaccinations V 
	ON D.location = V.location 
	and D.date = V.date
	WHERE D.continent IS NOT NULL
)

SELECT 
	*, (RollingPeopleVaccinated / Population) * 100
FROM PopVsVac


-- Using Temp Table to perform Calculation on Partition By in previous query

DROP TABLE IF EXISTS #PercentPopulationVaccinated
CREATE TABLE #PercentPopulationVaccinated
(
	Continent nvarchar(255),
	Location nvarchar(255),
	Date datetime,
	Population numeric,
	New_vaccinations numeric,
	RollingPeopleVaccinated numeric
)

Insert into #PercentPopulationVaccinated
SELECT 
		D.continent,
		D.location,
		D.date,
		D.population,
		V.new_vaccinations,
		SUM(V.new_vaccinations) OVER(PARTITION BY D.location ORDER BY D.location, D.date) as RollingPeopleVaccinated
	FROM CovidDeaths D
	INNER JOIN CovidVaccinations V 
	ON D.location = V.location 

Select *, (RollingPeopleVaccinated/Population)*100
From #PercentPopulationVaccinated




-- Creating View to store data for later visualizations

CREATE VIEW PercentPopulationVaccinated AS
SELECT 
		D.continent,
		D.location,
		D.date,
		D.population,
		V.new_vaccinations,
		SUM(V.new_vaccinations) OVER(PARTITION BY D.location ORDER BY D.location, D.date) as RollingPeopleVaccinated
	FROM CovidDeaths D
	INNER JOIN CovidVaccinations V 
	ON D.location = V.location 


SELECT * FROM PercentPopulationVaccinated






























