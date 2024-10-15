# EDA on Layoffs Dataset

## Overview
This project focuses on exploratory data analysis (EDA) of layoffs data cleaned from the original dataset sourced from [Kaggle](https://www.kaggle.com/datasets/swaptr/layoffs-2022). The aim is to explore trends, patterns, and insights regarding layoffs across various companies, industries, and countries during the observed period.

## Dataset
The cleaned dataset used for this analysis is stored in a MySQL table named `layoffs_staging2`. The dataset includes the following columns:

- `company`: Name of the company.
- `location`: Location of the company.
- `industry`: Industry category of the company.
- `total_laid_off`: Total number of employees laid off.
- `percentage_laid_off`: Percentage of the workforce laid off.
- `date`: Date of the layoff event.
- `stage`: Funding stage of the company.
- `country`: Country where the company is located.
- `funds_raised_millions`: Total funds raised by the company (in millions).

## Analysis Goals
The analysis aims to:
1. Identify maximum and minimum layoffs and their trends over time.
2. Explore layoffs by company, industry, and funding stage.
3. Examine the relationship between funding raised and layoffs.
4. Investigate patterns and outliers in layoff events.

## Key Findings
- The maximum number of employees laid off in a single event is 12,000, indicating significant layoff events.
- The Consumer and Retail industries experienced the highest total layoffs.
- The United States had the highest number of layoffs, followed by India.
- There were notable spikes in layoffs during the pandemic and its aftermath, especially in early 2020 and late 2022.
- Early-stage companies (Seed, Series A, B) show a higher average layoff percentage, indicating challenges in maintaining workforce stability.

## SQL Queries
The analysis is conducted using SQL queries that explore various aspects of the dataset, including:

- Maximum and minimum layoffs.
- Total layoffs by industry and country.
- Monthly and yearly trends in layoffs.
- Rolling totals of layoffs over time.
- Identification of top companies with the most layoffs each year.

## Conclusion
This EDA provides valuable insights into the layoffs landscape, particularly during the COVID-19 pandemic, and highlights the challenges faced by different industries and companies. The findings may inform future research and decisions regarding workforce management and industry stability.

## Installation
To replicate the analysis, clone this repository and ensure you have a MySQL database with the cleaned dataset loaded as `layoffs_staging2`. Execute the SQL queries in your MySQL environment to explore the insights.
