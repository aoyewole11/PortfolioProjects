--Select * from CovidDeaths
--Select * from CovidVaccination

--Select Data that we are going to use

--Select Location, date, total_cases, new_cases, total_deaths, population
--From CovidDeaths
--order by 1,2

--Looking at Total Cases vs Total Deaths
--Shows the perecentage of dying if you get covid in the US
Select Location, date, total_cases, total_deaths, (total_deaths/total_cases)* 100 as DeathPercentage
From CovidDeaths
where location like '%states%'
order by 1,2

--Looking at the total cases vs population
--Shows what percentage of population got covid

Select Location, date,  population,total_cases, (total_cases/population)* 100 as PercentagePopulationInfected
From CovidDeaths
where location like '%states%'
order by 1,2

-- Looking at Countries witht he HIghest infection rate

Select Location,  population, MAX(total_cases) as HighestInfectionCount, MAx((total_cases/population))* 100 as PercentagePopulationInfected
From CovidDeaths
Group by Location,  population
order by PercentagePopulationInfected desc

-- Showing countries witht he highest death count per population

Select Location, MAX(cast(total_deaths as int)) as TotalDeathCount
From CovidDeaths
Where continent is not null
Group by Location
order by TotalDeathCount desc

--LETS DO CONTINTENT

Select continent, MAX(cast(total_deaths as int)) as TotalDeathCount
From CovidDeaths
Where continent is not null
Group by continent
order by TotalDeathCount desc

Select Location, MAX(cast(total_deaths as int)) as TotalDeathCount
From CovidDeaths
Where continent is  null
Group by Location
order by TotalDeathCount desc



--showing the continents witht the highest death count

Select continent, MAX(cast(total_deaths as int)) as TotalDeathCount
From CovidDeaths
Where continent is not null
Group by continent
order by TotalDeathCount desc

--Global Numbers

Select   Sum(new_cases) as total_cases,sum(cast(new_deaths as int)) as total_deaths, Sum(cast(new_deaths as int))/sum(new_cases)*100 as DeathPercentage
FROM CovidDeaths
--where location like '%states%'
where  continent is not null
--Group by date
order by 1,2


-- looking at total population vs vaccination
Select d.continent, d.location, d.date, d.population, v.new_vaccinations
, SUM(CONVERT(bigint,v.new_vaccinations)) OVER (Partition by d.Location order by d.location,d.date) as RollingPeopleVaccinated
from CovidDeaths as d
join CovidVaccination as v
on d.location =v.location
and d.date = v.date
where d.continent is not  null
order by 2,3
go

--USE CTE

With PopvsVac (continent, Location, date, population, new_vaccinations, RollingPeopleVaccinated )
as
(

Select d.continent, d.location, d.date, d.population, v.new_vaccinations
, SUM(CONVERT(bigint,v.new_vaccinations)) OVER (Partition by d.Location order by d.location,d.date) as RollingPeopleVaccinated
from CovidDeaths as d
join CovidVaccination as v
on d.location =v.location
and d.date = v.date
where d.continent is not  null
--order by 2,3
) 

Select *, (RollingPeopleVaccinated/population)* 100
from PopvsVac


------creating view

Create view PercentPopulationVaccinated as

Select d.continent, d.location, d.date, d.population, v.new_vaccinations
, SUM(CONVERT(bigint,v.new_vaccinations)) OVER (Partition by d.Location order by d.location,d.date) as RollingPeopleVaccinated
from CovidDeaths as d
join CovidVaccination as v
on d.location =v.location
and d.date = v.date
where d.continent is not  null
--order by 2,3

Select *
from PercentPopulationVaccinated
