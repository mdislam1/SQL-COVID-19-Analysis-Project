# SQL-COVID-19-Analysis-Project

This SQL project focuses on analyzing COVID-19 data, specifically exploring infection rates, death rates, and vaccination progress across different countries and continents. The analysis involves the use of various SQL queries, including calculations, joins, and window functions. The goal is to gain insights into the impact of the pandemic on different regions and assess vaccination efforts.

## Analysis Steps:

1. Initial Data Selection:
    1. Selects essential data fields such as location, date, total cases, new cases, total deaths, and population from the CovidDeaths table.

2. Total Cases vs Total Deaths:
    1. Calculates the death percentage based on the total number of cases, providing insights into the likelihood of dying if contracting COVID-19 in a specific country.

3. Total Cases vs Population:
    1. Computes the percentage of the population infected with COVID-19, highlighting the impact of the virus on different regions.

4. Countries with Highest Infection Rate:
    1. Identifies countries with the highest infection rates compared to their population, showcasing the severity of the outbreak in specific regions.

5. Countries with Highest Death Count per Population:
    1. Lists countries with the highest death count per population, offering insights into the impact of the virus on mortality rates.

6. Continents with the Highest Death Count per Population:
    1. Analyzes continents to determine which ones have the highest death count per population, providing a broader perspective on the global impact.

7. Total Population vs Vaccinations:
    1. Combines data from the CovidDeaths and CovidVaccinations tables to analyze the percentage of the population that has received at least one COVID-19 vaccine dose.

8. Using CTE for Vaccination Analysis:
    1. Utilizes a Common Table Expression (CTE) to perform calculations on the partitioned data, offering a structured and readable way to analyze vaccination progress.

9. Using Temp Table for Vaccination Analysis:
    1. Demonstrates an alternative approach using a temporary table to perform calculations on vaccination data.

10. Creating a View for Visualization:
    1. Establishes a view, named PercentPopulationVaccinated, to store relevant data for later visualization and reporting.

11. Viewing the Stored Data:
    1. Retrieves data from the created view for further exploration or visualization.

## Note:

  * The analysis covers a range of factors, from infection and death rates to vaccination progress.
  * The SQL project is designed to facilitate data-driven decision-making and gain insights into the global impact of the COVID-19 pandemic.
