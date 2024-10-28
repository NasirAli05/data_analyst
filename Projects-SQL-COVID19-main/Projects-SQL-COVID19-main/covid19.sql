SELECT * FROM covid.cd
Where continent is not null;
Describe covid.cd; -- CHECKING THE DATA TYPES OF COLUMNS IN covid.cd

/*
    This statement modifies the column data types for the 'covid.cd' table.
    The following changes are made:
    - Adjusting VARCHAR lengths for string fields.
    - Setting appropriate INT and FLOAT types for numerical fields.
    - Ensuring consistency in data representation for analysis.
*/
ALTER TABLE covid.cd
MODIFY ï»¿iso_code varchar(10),
MODIFY continent varchar(50),
MODIFY location varchar(100),
MODIFY date date,
MODIFY population BIGINT,
MODIFY total_cases INT,
MODIFY new_cases INT,
MODIFY new_cases_smoothed FLOAT,
MODIFY total_deaths INT,
MODIFY new_deaths INT,
MODIFY new_deaths_smoothed FLOAT,
MODIFY total_cases_per_million FLOAT,
MODIFY new_cases_per_million FLOAT,
MODIFY new_cases_smoothed_per_million FLOAT,
MODIFY total_deaths_per_million FLOAT,
MODIFY new_deaths_per_million FLOAT,
MODIFY new_deaths_smoothed_per_million FLOAT,
MODIFY reproduction_rate FLOAT,
MODIFY icu_patients INT,
MODIFY icu_patients_per_million FLOAT,
MODIFY hosp_patients INT,
MODIFY hosp_patients_per_million FLOAT,
MODIFY weekly_icu_admissions FLOAT,
MODIFY weekly_icu_admissions_per_million FLOAT,
MODIFY weekly_hosp_admissions FLOAT,
MODIFY weekly_hosp_admissions_per_million FLOAT,
MODIFY new_tests INT,
MODIFY total_tests INT,
MODIFY total_tests_per_thousand FLOAT,
MODIFY new_tests_per_thousand FLOAT,
MODIFY new_tests_smoothed INT,
MODIFY new_tests_smoothed_per_thousand FLOAT,
MODIFY positive_rate FLOAT,
MODIFY tests_per_case FLOAT,
MODIFY tests_units TEXT,
MODIFY total_vaccinations INT,
MODIFY people_vaccinated INT,
MODIFY people_fully_vaccinated INT,
MODIFY new_vaccinations INT,
MODIFY new_vaccinations_smoothed INT,
MODIFY total_vaccinations_per_hundred FLOAT,
MODIFY people_vaccinated_per_hundred FLOAT,
MODIFY people_fully_vaccinated_per_hundred FLOAT,
MODIFY new_vaccinations_smoothed_per_million INT,
MODIFY stringency_index FLOAT,
MODIFY population_density FLOAT,
MODIFY median_age FLOAT,
MODIFY aged_65_older FLOAT,
MODIFY aged_70_older FLOAT,
MODIFY gdp_per_capita FLOAT,
MODIFY extreme_poverty FLOAT,
MODIFY cardiovasc_death_rate FLOAT,
MODIFY diabetes_prevalence FLOAT,
MODIFY female_smokers FLOAT,
MODIFY male_smokers FLOAT,
MODIFY handwashing_facilities FLOAT,
MODIFY hospital_beds_per_thousand FLOAT,
MODIFY life_expectancy FLOAT,
MODIFY human_development_index FLOAT;

-- Rechecking the data types
DESCRIBE covid.cd;
DESCRIBE covid.cv;

-- ORDERING EACH TABLE BY THEIR LOCATION AND DATE
SELECT * FROM covid.cd
Where continent is not null
ORDER BY 3,4;

SELECT * FROM covid.cv
Where continent is not null
ORDER BY 3,4;

-- Fetching the data we need from cd(covid deaths) and sort by their location and date
SELECT location, date, total_cases, new_cases, total_deaths, population
FROM covid.cd 
order by 1,2;

-- Evaluating the total cases vs deaths in Somalia
SELECT location, date, total_cases, total_deaths,(total_deaths/total_cases)*100 as Death_Percentage
FROM covid.cd 
WHERE location like "Somalia"
order by 1,2;

/*
This SQL query retrieves the maximum death percentage for each location 
from the 'covid.cd' table. It calculates the death percentage by dividing 
the total deaths by total cases and multiplying by 100. The results are 
grouped by location, ensuring that we get the highest death percentage 
for each unique location.
*/
SELECT location, MAX((total_deaths/total_cases)*100) AS Max_Dth_Prcnt
FROM covid.cd
GROUP BY location;

/*
This query selects the maximum death percentage for each location 
from the 'covid.cd' table, filtering to show only those with 
a percentage greater than 5%.
*/
SELECT location, MAX((total_deaths/total_cases)*100) AS Max_Dth_Prcnt
FROM covid.cd
GROUP BY location
HAVING Max_Dth_Prcnt>5.00;

-- Evaluating Total Cases vs Population as Percentage of Population affected by Covid
SELECT location, date, total_cases, population, (total_cases/population)*100 as Ttl_afct_Ppl,(total_cases/population)*100 as Ttl_afct_Ppl,
FROM covid.cd 
order by 1,2;

/*
This SQL query retrieves the maximum affected percentage for each location 
from the 'covid.cd' table. It calculates the affcted by dividing 
the total cases by population * 100. The results are 
grouped by location, ensuring that we get the highest death percentage 
for each unique location.
*/
SELECT location, population, max((total_cases / population)) * 100 AS Max_Ttl_afct_Ppl
FROM covid.cd
GROUP BY location,population
order by Max_Ttl_afct_Ppl desc ;

-- Evaluating continents'and their total  death count 
/*
Filtering out rows where the continent column is NULL.
In cases where the continent is NULL, the location column
contains the continent name (e.g., 'Asia').
This ensures the data remains consistent and avoids duplication
of continent information in the location field.
*/

SELECT continent, max(total_deaths) as Ttl_Death_toll 
FROM covid.cd
where continent is not null
group by continent
order by Ttl_Death_toll desc;

SELECT 
    CASE 
        WHEN continent IS NULL THEN location
        ELSE continent
    END AS continent, 
    MAX(total_deaths) AS Ttl_Death_toll 
FROM covid.cd
GROUP BY 
    CASE 
        WHEN continent IS NULL THEN location
        ELSE continent
    END
ORDER BY Ttl_Death_toll DESC;

-- GLOBAL STATISTICS
SELECT date,sum(new_cases) as Total_cases, sum(new_deaths) as Total_dths, (sum(new_deaths)/sum(new_cases)*100) AS Glbl_Dth_Prcnt
FROM covid.cd
where continent is not null
GROUP BY date
Order by 1;

-- Evaluating the global death percentage by Covid cases uptil 2021
SELECT sum(new_cases) as Total_cases, sum(new_deaths) as Total_dths, (sum(new_deaths)/sum(new_cases)*100) AS Glbl_Dth_Prcnt
FROM covid.cd
where continent is not null;


-- Joining Covid Vaccination (covid.cv) data set to Covid death( covid.cd)
Select * 
FROM covid.cd 
JOIN covid.cv on cd.location=cv.location
AND cd.date=cv.date;

-- Evaluating Population vs Vaccination using TEMP (CTEs)

With Pop_Vac(Continent, Location, Date, Population, New_Vaccinations, Pop_Vaccinated) AS
(
Select 
	dea.continent,dea.location, dea.date, dea.population,vac.new_vaccinations,
	SUM(vac.new_vaccinations) OVER (PARTITION BY dea.location order by dea.date) as Ttl_Vac_by_Location
FROM 
	covid.cd dea
JOIN 
	covid.cv vac
ON 
	dea.location=vac.location
AND 
	dea.date=vac.date
where 
	dea.continent is not null
Order by 2,3)

Select *, (Pop_Vaccinated/Population*100) as Prcnt_Vccnated_pr_Population 
FROM Pop_Vac;

-- Creating Views for Future Visualizations

CREATE VIEW Percent_Population_Vaccinated AS
With Pop_Vac(Continent, Location, Date, Population, New_Vaccinations, Pop_Vaccinated) AS
(
Select 
	dea.continent,dea.location, dea.date, dea.population,vac.new_vaccinations,
	SUM(vac.new_vaccinations) OVER (PARTITION BY dea.location order by dea.date) as Ttl_Vac_by_Location
FROM 
	covid.cd dea
JOIN 
	covid.cv vac
ON 
	dea.location=vac.location
AND 
	dea.date=vac.date
where 
	dea.continent is not null
Order by 2,3)

Select *, (Pop_Vaccinated/Population*100) as Prcnt_Vccnated_pr_Population 
FROM Pop_Vac;

CREATE VIEW Maximum_Affected_People_Percent AS
SELECT location, population, total_cases, max((total_cases / population)) * 100 AS Max_Prcnt_afct_Ppl
FROM covid.cd
GROUP BY location,population
order by Max_Prcnt_afct_Ppl desc ;

CREATE VIEW Ttl_Deaths_by_Continent AS
SELECT continent, max(total_deaths) as Ttl_Death_toll 
FROM covid.cd
where continent is not null
group by continent
order by Ttl_Death_toll desc;

CREATE VIEW Global_Cases_Deaths AS
SELECT date,sum(new_cases) as Total_cases, sum(new_deaths) as Total_dths, (sum(new_deaths)/sum(new_cases)*100) AS Glbl_Dth_Prcnt
FROM covid.cd
where continent is not null
GROUP BY date
Order by 1;

