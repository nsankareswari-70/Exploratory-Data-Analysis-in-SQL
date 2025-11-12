## Exploratory-Data-Analysis-in-SQL

### Project Description:

This project aims to perform an Exploratory Data Analysis (EDA) on two datasets — CovidDeaths and CovidVaccination — stored in the SqlDataExplore database. The goal is to explore, clean, and analyze global COVID-19 data to uncover patterns, trends, and insights related to the pandemic’s progression and the impact of vaccination efforts.

The CovidDeaths dataset contains information on COVID-19 cases, deaths, population, and related statistics across countries and dates, while the CovidVaccination dataset includes data on vaccination progress, such as total vaccinations, people vaccinated, and vaccination rates.

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
`<sql>
select * from SqlDataExplore.dbo.CovidDeaths order by 3,4
select * from SqlDataExplore.dbo.CovidVaccination order by 3,4
`<sql>
