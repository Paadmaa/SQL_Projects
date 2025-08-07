--Portfolio Project Queries
--a.Datewise Likelihood of dying due to covid-Totalcases vs TotalDeath- in India
select date,total_cases,total_deaths,(cast (total_deaths as double precision)/cast(total_cases as double precision)*100) as death_percentage from "CovidDeaths" where location like '%India%';
--b.Total % of deaths out of entire population- in India
select (cast(max(total_deaths) as double precision)/avg(cast(population as double precision))*100) as percentage from "CovidDeaths" where location like '%India%';
--c.Verify b by getting info separately
select max(total_deaths) as total_deaths,avg(cast(population as double precision)) as population from "CovidDeaths" where location like '%India%';
SELECT * FROM public."CovidDeaths" where location like '%India%';
--d.Country with highest death as a % of population
select location,(cast(max(total_deaths) as double precision)/avg(cast(population as double precision))*100) as percentage from "CovidDeaths" group by location order by percentage desc;
--e.Total % of covid +ve cases- in India
select (cast(max(total_cases) as double precision)/avg(cast(population as double precision))*100) as percentage from "CovidDeaths" where location like '%India%';
--f.Total % of covid +ve cases- in world
select location,(cast(max(total_cases) as double precision)/avg(cast(population as double precision))*100) as percentage from "CovidDeaths" group by location order by percentage desc;
--g.Continentwise +ve cases
select location,max(total_cases) as total_cases from "CovidDeaths" where continent is null group by location order by total_cases desc;
--h.Continentwise deaths
select location,max(total_deaths) as total_deaths from "CovidDeaths" where continent is null group by location order by total_deaths desc;
--i.Daily newcases vs hospitalizations vs icu_patients- India
--select date,new_cases,hosp_patients,icu_patients from "CovidDeaths" where location="India";
--j.countrywise age>65
select "CovidDeaths".location,"CovidVaccinations".aged_65_older from "CovidDeaths" join "CovidVaccinations" on "CovidDeaths".iso_code="CovidVaccinations".iso_code and "CovidDeaths".date="CovidVaccinations".date;
select avg("CovidDeaths".population),max("CovidVaccinations".people_fully_vaccinated),"CovidVaccinations".total_boosters from "CovidDeaths" inner join "CovidVaccinations" on "CovidDeaths".iso_code="CovidVaccinations".iso_code and "CovidDeaths".date="CovidVaccinations".date  group by "CovidVaccinatios".location;
--k. Countrywise total vaccinated persons
select "CovidDeaths".location as country,max("CovidVaccinations".people_fully_vaccinated) as Fully_vaccinated from "CovidDeaths" join "CovidVaccinations" on "CovidDeaths".iso_code="CovidVaccinations".iso_code and "CovidDeaths".date="CovidVaccinations".date where "CovidDeaths".continent is not null group by country order by Fully_vaccinated desc;