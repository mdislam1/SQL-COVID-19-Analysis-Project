# COVID-19 Data Analysis and Insights

## Overview

This project focuses on analyzing COVID-19 data across various regions to understand the global impact of the virus, including case numbers, deaths, and vaccination coverage. The analysis utilizes two key datasets, `CovidDeaths` and `CovidVaccinations`, loaded from Excel files into an SQLite database. The project calculates key metrics such as death percentages, the proportion of the population infected, and countries with the highest infection and mortality rates. It also tracks vaccination progress by calculating the percentage of the population vaccinated over time using rolling counts, employing advanced SQL techniques like window functions, CTEs, and temporary tables for efficient data manipulation.

The output of the project provides valuable insights into the global pandemic’s impact and the effectiveness of vaccination campaigns. It includes data on COVID-19 case and death numbers, as well as vaccination coverage by country and continent. Advanced queries and optimizations ensure that the data is processed efficiently, even with large datasets. The final result is a structured and optimized SQL setup that enables easy visualization of COVID-19 trends and supports data-driven decisions in public health responses.

## Table of Contents

- [Installation](#installation)
- [Usage](#usage)
- [Data Analysis](#data-analysis)
- [SQL Scripts](#sql-scripts)
- [Contributing](#contributing)
- [License](#license)

## Installation

1. **Clone the Repository:**
   ```bash
   git clone https://github.com/yourusername/covid-19-data-analysis.git
   cd covid-19-data-analysis
   ```

2. **Set Up SQLite Database:**
   - Ensure you have SQLite installed on your system. You can download it from [here](https://sqlite.org/download.html).
   - Load your COVID-19 datasets (`CovidDeaths.xlsx` and `CovidVaccinations.xlsx`) into an SQLite database. You can use tools like [DB Browser for SQLite](https://sqlitebrowser.org/) to import the data.

3. **Install Required Tools:**
   - Ensure you have a SQL client or command-line tool to run SQL scripts.

## Usage

1. **Run the SQL Scripts:**
   - Open your SQL client or command-line tool.
   - Connect to your SQLite database.
   - Run the provided SQL scripts to perform the analysis.

2. **Execute the Scripts:**
   - You can run the entire script at once or execute individual queries to perform specific analyses.

## Data Analysis

The SQL scripts provided perform the following analyses:

1. **Data Quality Check:**
   - Ensure no NULL values in critical columns.

2. **Index Creation:**
   - Create necessary indices for better performance.

3. **Initial Data Selection:**
   - Select initial data for analysis.

4. **Total Cases vs Total Deaths:**
   - Calculate the likelihood of death from COVID-19.

5. **Total Cases vs Population:**
   - Calculate the percentage of the population infected with COVID-19.

6. **Countries with Highest Infection Rate:**
   - Identify countries with the highest infection rate compared to their population.

7. **Countries with Highest Death Count:**
   - Identify countries with the highest death count per population.

8. **Continents with Highest Death Count:**
   - Identify continents with the highest death count per population.

9. **Total Population vs Vaccinations:**
   - Calculate the percentage of the population vaccinated.

10. **CTE for Vaccination Data:**
    - Use Common Table Expressions (CTEs) for rolling vaccination data.

11. **Temp Table for Rolling Vaccinations:**
    - Use temporary tables to calculate rolling vaccinations and population percentage.

12. **Create View for Vaccination Coverage:**
    - Create a view for vaccination coverage data.

13. **Query from View:**
    - Query from the created view for future visualizations.

14. **Moving Average Calculation:**
    - Calculate the moving average of total cases over the last 7 days.

15. **Refactor and Optimize:**
    - Use DISTINCT for unique values.

16. **Handle Time Zones and Date Format:**
    - Ensure consistency in time zones and date formats.

17. **Data Completeness:**
    - Check for missing values and outliers.

18. **Aggregating Data:**
    - Summarize total cases and deaths by location.

19. **Index Optimization:**
    - Optimize indices for faster access on large datasets.

20. **Performance Testing:**
    - Use EXPLAIN for query optimization.

## SQL Scripts

The SQL scripts are provided in the repository. You can find them in the `scripts` directory. Each script is commented to explain its purpose and functionality.

## Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository.
2. Create a new branch (`git checkout -b feature-branch`).
3. Commit your changes (`git commit -am 'Add some feature'`).
4. Push to the branch (`git push origin feature-branch`).
5. Open a pull request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## Author
Md Islam  
GitHub: https://github.com/mdislam1

---

By following this README, you should be able to set up and run the COVID-19 data analysis project successfully. If you encounter any issues, please feel free to open an issue on the GitHub repository.
