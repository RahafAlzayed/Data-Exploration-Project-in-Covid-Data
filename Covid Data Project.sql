Select * 
From Project1..CovidDeaths$
Order by 3,4

--Select * 
--From Project1..CovidVaccinations$
--Order by 3,4

Select location, date, total_cases, new_cases, total_deaths, population
From Project1..CovidDeaths$
Order by 1,2

-- Looking at total cases vs total deaths: showing likelihood of dying if you contract covid in Saudi Arabia 
Select location, date, total_cases, total_deaths, (Cast(total_deaths as decimal(12,2)) / Cast(total_cases as decimal(12,2)))*100 as DeathPercentage
From Project1..CovidDeaths$
where location = 'Saudi Arabia'
Order by 1,2

-- Looking at the total cases vs population: showing what percentage of population (only in Saudi Arabia)
Select location, date, population, total_cases, (Cast(total_cases as decimal(12,2)) / Cast(population as decimal(12,2)))*100 as PercentPopulationInfected 
From Project1..CovidDeaths$
where location = 'Saudi Arabia'
Order by 1,2


-- Looking at countries with the highest infection rate compared to population
Select location, population, Max(total_cases) as HighestInfectionCount, Max(total_cases/population)*100 as PercentPopulationInfected 
From Project1..CovidDeaths$
group by location, population
Order by PercentPopulationInfected desc


-- Showing countries with highest death count per population
Select location, Max(cast(total_deaths as int)) as TotalDeathCount
From Project1..CovidDeaths$
where continent is not null
group by location
Order by TotalDeathCount desc


-- Getting the same result but this time by grouping it with Continent
Select location, Max(cast(total_deaths as int)) as TotalDeathCount
From Project1..CovidDeaths$
where continent is null
group by location
Order by TotalDeathCount desc


-- Global numbers 
Select sum(New_Cases) as total_cases, sum(New_Deaths) as total_deaths, sum(New_Deaths)/sum(New_Cases)*100 as DeathPercentage
From Project1..CovidDeaths$
Where continent is null
Order by 1,2


-- Joining the two tables together 
Select *
From Project1..CovidDeaths$ dea
Join Project1..CovidVaccinations$ vac
on dea.location = vac.location
and dea.date = vac.date

-- Looking at total population vs vaccination 
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
From Project1..CovidDeaths$ dea
Join Project1..CovidVaccinations$ vac
on dea.location = vac.location
and dea.date = vac.date
order by 1,2,3


