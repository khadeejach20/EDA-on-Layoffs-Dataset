-- EDA

-- Here we are jsut going to explore the data and find trends or patterns or anything interesting like outliers
-- normally when starting the EDA process you have some idea of what you're looking for
-- with this info we are just going to look around and see what we find!

-- Let's begin by taking a look at the full dataset.
SELECT *
FROM layoffs_staging2;

-- Max Total Layoffs
-- We want to find the maximum number of employees laid off and the maximum percentage of the workforce laid off.
SELECT MAX(total_laid_off), MAX(percentage_laid_off)
FROM layoffs_staging2;
-- The maximum number of employees laid off in a single event is 12,000. 
-- This indicates a significant layoff event from one of the companies in the dataset.
-- The maximum percentage of workforce laid off in a single event is 100% (represented as 1), indicating at least one company had to lay off its entire workforce.


-- Largest Complete Layoff
SELECT *
FROM layoffs_staging2
WHERE percentage_laid_off = 1
ORDER BY total_laid_off DESC;
-- Katerra (Construction) in the SF Bay Area had the largest number of employees laid off entirely in a single event totaling 2,434 employees 
-- The company raised funds, but their downfall came despite significant efforts

-- Complete Layoffs by Funds Raised
SELECT *
FROM layoffs_staging2
WHERE percentage_laid_off = 1
ORDER BY funds_raised_millions DESC;
-- 1. Britishvolt (London) had the highest funding at $2.4 billion before complete layoffs.
-- 2. Quibi (Los Angeles) fully laid off staff after raising $1.8 billion in 2020.
-- 3. Other notable cases include Deliveroo Australia and Katerra, 
-- This highlights that substantial funding does not ensure business viability.

-- Total Employees Laid Off by Company
SELECT company, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;
-- Amazon leads with 18,150 layoffs, followed by Google (12,000) and Meta (11,000).
-- Notable companies include Salesforce (10,090) and Microsoft (10,000)
-- This shows significant job reductions in the tech sector.

-- Minimum and Maximum Layoff Dates
SELECT MIN(`date`), max(`date`)
FROM layoffs_staging2;
-- The earliest recorded layoff date is March 11, 2020.
-- The latest recorded layoff date is March 6, 2023.
-- This indicates the timeframe of layoffs spans nearly three years.

-- Total Layoffs by Industry
SELECT industry, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY industry
ORDER BY 2 DESC;
-- The industry with the highest total layoffs is Consumer, with 45,182 employees laid off.
-- Retail follows closely with 43,613 layoffs.
-- Other significant sectors include Transportation (33,748), Finance (28,344), and Healthcare (25,953).
-- The data highlights that Consumer and Retail industries have experienced the most layoffs during the observed period.
-- These layoffs may be attributed to the effects of COVID-19 and subsequent lockdowns, 
-- which forced many companies to downsize as consumer behavior shifted and operational challenges arose.

-- Total Layoffs by Country
SELECT country, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY country
ORDER BY 2 DESC;
-- The United States leads with a staggering total of 256,559 layoffs, accounting for a significant portion of the global layoffs.
-- India follows with 35,993 layoffs, and other notable countries include the Netherlands (17,220), Sweden (11,264), and Brazil (10,391).
-- This trend can be linked to various factors, including the economic impact of COVID-19, changes in consumer behavior, and shifts in operational capabilities during lockdowns. 
-- The data highlights the widespread effects of the pandemic across different regions and industries.

-- Total Layoffs by date
SELECT `date`, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY `date`
ORDER BY 1 DESC;

-- Total Layoffs by Year
SELECT YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY YEAR(`date`)
ORDER BY 1 DESC;
-- In 2023, there were 125,677 layoffs, a notable increase compared to 2022 (160,661) and 2021 (15,823).
-- The year 2020 saw 80,998 layoffs, primarily driven by the pandemic and its economic repercussions.
-- The spikes in layoffs in 2022 and 2023 may reflect ongoing adjustments within industries 
-- as companies respond to changing market demands and economic uncertainties, 
-- possibly influenced by the lingering effects of COVID-19 and related lockdowns.

SELECT *
FROM layoffs_staging2;

-- Total Layoffs by Funding Stage
SELECT stage, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY stage
ORDER BY 2 DESC;
-- The most significant layoffs occurred in Post-IPO companies, totaling 204,132 employees.
-- This suggests that even established firms face challenges in the current economic climate.
-- Companies with Unknown funding stages accounted for 40,716 layoffs, indicating a lack of transparency.
-- Acquired companies followed with 27,576 layoffs, suggesting consolidation impacts.
-- Layoffs across various funding stages, including Series A through Series E, also highlight the broader market struggles.

-- Average Layoff Percentage by Funding Stage
SELECT stage, ROUND(AVG(percentage_laid_off), 2)
FROM layoffs_staging2
GROUP BY stage
ORDER BY 2 DESC;
-- The Seed stage shows the highest average layoff proportion at 0.70, indicating that startups are experiencing significant layoffs relative to their size.
-- Series A and Series B follow with average layoff proportions of 0.38 and 0.32, respectively, highlighting the challenges faced by early-stage companies.
-- Even established companies in the Unknown and Acquired stages report notable layoff proportions of around 0.31, suggesting widespread difficulties across various stages of funding.
-- In contrast, larger companies in stages like Post-IPO and Private Equity show lower average layoff percentages (0.16), 
-- implying that while they may have more employees laid off in absolute terms, 
-- the relative impact on their workforce is less severe compared to smaller firms.
-- This analysis emphasizes that the past three years have particularly affected small companies, as indicated by their higher layoff proportions.

-- Monthly Layoff Totals Over Time
SELECT SUBSTRING(`date`,1,7) `MONTH`, SUM(total_laid_off)
FROM layoffs_staging2
WHERE SUBSTRING(`date`,1,7) IS NOT NULL
GROUP BY `MONTH`
ORDER BY 1 ASC;
-- The layoffs spiked in early 2020, likely due to the onset of the COVID-19 pandemic
-- with April 2020 showing the highest number of layoffs at 26,710
-- this reflects the immediate impact of global lockdowns and economic disruptions
-- layoff numbers declined through the second half of 2020, dropping sharply by September
-- however layoffs surged again toward the end of 2022, with a notable peak in November 2022 with 53,451 layoffs
-- the peak in January 2023 showing 84,714 layoffs also suggests that the economic strain persisted into 2023

-- Rolling Total of Layoffs by Month
WITH Rolling_Total AS
(
	SELECT SUBSTRING(`date`,1,7) `MONTH`, SUM(total_laid_off) AS total_off
	FROM layoffs_staging2
	WHERE SUBSTRING(`date`,1,7) IS NOT NULL
	GROUP BY `MONTH`
	ORDER BY 1 ASC
)
SELECT `MONTH`, 
		total_off,
		SUM(total_off) OVER(ORDER BY `MONTH`) rolling_total
FROM Rolling_Total;
-- This query calculates the rolling total of layoffs month by month.
-- The initial surge of layoffs due to the COVID-19 pandemic is reflected in early 2020
-- where the rolling total rapidly climbs from 9,628 in March 2020 to over 36,000 by April 2020
-- By December 2022 layoffs hit a major peak with a rolling total of 247,153
-- The layoffs continue into early 2023, with the rolling total jumping to 342,196 by January 2023
-- showing the persistent impact of economic adjustments across industries
-- This rolling total gives a clearer picture of the cumulative effect of layoffs over time

SELECT company, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;

-- Top 5 Companies with the Most Layoffs per Year
WITH Company_Year (company, years, total_laid_off) AS
(
	SELECT company, YEAR(`date`), SUM(total_laid_off)
	FROM layoffs_staging2
	GROUP BY company, YEAR(`date`)
), Company_Year_Rank AS
(
	SELECT *,
		DENSE_RANK() OVER(PARTITION BY years ORDER BY total_laid_off DESC) Ranking
	FROM Company_Year
	WHERE years IS NOT NULL
)
SELECT *
FROM Company_Year_Rank
WHERE Ranking <= 5;
-- This query identifies the top 5 companies with the most layoffs in each year
-- In 2020 Uber led with 7,525 layoffs followed by Booking.com with 4,375
-- The pattern shifts in 2021, with Bytedance laying off the most employees (3,600), followed by Katerra (2,434)
-- The situation escalated in 2022, with Meta laying off 11,000 workers, and Amazon laying off 10,150
-- The trend continues into 2023, with Google leading the layoffs at 12,000, followed by Microsoft with 10,000
-- This analysis highlights how the layoff landscape evolved year by year, dominated by tech giants in recent years
