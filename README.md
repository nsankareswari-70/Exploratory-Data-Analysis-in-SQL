## Exploratory-Data-Analysis-in-SQL

### Project Description:

This project aims to perform an Exploratory Data Analysis (EDA) on two datasets — CovidDeaths and CovidVaccination — stored in the SqlDataExplore database. The goal is to explore, clean, and analyze global COVID-19 data to uncover patterns, trends, and insights related to the pandemic’s progression and the impact of vaccination efforts.

The CovidDeaths dataset contains information on COVID-19 cases, deaths, population, and related statistics across countries and dates, while the CovidVaccination dataset includes data on vaccination progress, such as total vaccinations, people vaccinated, and vaccination rates.

Skills used: Joins, CTE's, Temp Tables, Windows Functions, Aggregate Functions, Creating Views, Converting Data Types

### Objectives:

Data Understanding and Cleaning:

Load both datasets from SQL Server.

Examine schema, data types, missing values, and inconsistencies.

Handle missing or incorrect data and ensure proper data alignment between both tables.

Descriptive Analysis:

Analyze trends in COVID-19 confirmed cases and deaths over time.

Explore country-wise and continent-wise distributions of cases and mortality rates.

Study the relationship between total cases, total deaths, and population.

Vaccination Insights:

Track vaccination progress globally and per country.

Identify correlations between vaccination rates and reduction in new cases/deaths.

Highlight countries with the fastest and slowest vaccination rollouts.

Expected Outcomes:

A comprehensive understanding of how COVID-19 spread across different regions.

Insights into how vaccination efforts affected the pandemic’s trajectory.

Identification of global and regional disparities in vaccination and mortality rates.

Well-documented findings to support public health analysis and decision-making.

Importing tables to the database
```sql
select * from SqlDataExplore.dbo.CovidDeaths order by 3,4
select * from SqlDataExplore.dbo.CovidVaccination order by 3,4
```

```sql
select location,date,total_cases,new_cases,total_deaths,population from 
SqlDataExplore.dbo.CovidDeaths
order by 1,2

-- Death Percentage
select location,date,total_cases,total_deaths,(total_deaths/total_cases)*100 as Deathpercentage from
SqlDataExplore.dbo.CovidDeaths
order by 1,2
-- Death Percentage in US
select location,date,total_cases,total_deaths,(total_deaths/total_cases)*100 as Deathpercentage from
SqlDataExplore.dbo.CovidDeaths where location like '%states%'
order by 1,2


-- Total cases Vs Population (What percentage of population got Covid)
select location, date, population, total_cases, (total_cases/population)*100 as covidpop
from SqlDataExplore.dbo.CovidDeaths where location like '%states%'
order by 1,2
```
```sql
--  Countries with Highest Infection Rate compared to population
SELECT 
    location,
    population,
    MAX(total_cases) AS highest_total_cases,
    MAX((total_cases / population) * 100) AS infection_rate_percent
FROM 
    SqlDataExplore.dbo.CovidDeaths
WHERE 
    continent IS NOT NULL  -- optional: exclude continents/aggregates
GROUP BY 
    location, population
ORDER BY 
    infection_rate_percent DESC;

-- Countries with Highest Death count per population
select location,max(cast(total_deaths as int)) as maxdeathct
from SqlDataExplore.dbo.CovidDeaths 
where continent is not null
group by location
order by maxdeathct desc

-- Total Death count per continent

select continent,max(cast(total_deaths as int)) as TotalDeathcount
from SqlDataExplore.dbo.CovidDeaths 
where continent is not null
group by continent
order by TotalDeathcount desc

-- Total Death count by location
select location, max(cast(total_deaths as int)) as TotalDeathcount
from SqlDataExplore.dbo.CovidDeaths
where continent is null
group by location
order by TotalDeathcount desc
```
```sql
-- Total new cases by date
select date,sum(new_cases) as Totnewcases
from SqlDataExplore.dbo.CovidDeaths
where continent is not null
group by date order by date desc


-- New case and New Deaths percentage
select date, sum(new_cases) as Totnewcases,
sum(cast(new_deaths as int)) as Totnewdeaths, 
sum(cast(new_deaths as int)) /sum(new_cases )*100 as Newdeathpercentage
from SqlDataExplore.dbo.CovidDeaths
where continent is not null
group by date order by date desc


-- Join two tables
select * from SqlDataExplore.dbo.CovidDeaths dea
join SqlDataExplore.dbo.Covidvaccination vac on
dea.location = vac.location
and dea.date = vac.date


-- Total population vs vaccinations
select dea.continent, dea.location,dea.date,dea.population,vac.new_vaccinations,
sum(convert(int,vac.new_vaccinations)) over (partition by dea.location order by dea.location,dea.date)
as Rollingtotvaccinated
from SqlDataExplore.dbo.Covidvaccination vac join SqlDataExplore.dbo.CovidDeaths dea on
dea.location = vac.location
and dea.date=vac.date
where dea.continent is not null
order by 2,3


--Rolling population vs vaccinated percentage
with popvsvac(continent,location,date,population,new_vaccinations,Rollingtotvaccinated)as
(select dea.continent, dea.location,dea.date,dea.population,vac.new_vaccinations,
sum(convert(int,vac.new_vaccinations)) over (partition by dea.location order by dea.location,dea.date)
as Rollingtotvaccinated
from SqlDataExplore.dbo.Covidvaccination vac join SqlDataExplore.dbo.CovidDeaths dea on
dea.location = vac.location
and dea.date=vac.date
where dea.continent is not null
--order by 2,3
)
select *
from popvsvac;


create view asiacon1 as 
select continent,population from SqlDataExplore.dbo.CovidDeaths where continent='Asia';
```


