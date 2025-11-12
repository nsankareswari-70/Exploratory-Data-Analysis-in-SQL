select * from SqlDataExplore.dbo.CovidDeaths order by 3,4
select * from SqlDataExplore.dbo.CovidVaccination order by 3,4



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
from popvsvac




