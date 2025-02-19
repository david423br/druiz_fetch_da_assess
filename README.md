# Fetch - Data Analyst Assessment

## Analysis of anonymous Fetch data

## TABLE OF CONTENTS
* [Executive Summary](#executive-summary)
* [Exploration, Observation, Validations, and Assumptions](#exploration-observation-validations-and-assumptions)
* [Data Source](#data-source)
* [Analytical Approach](#analytical-approach)
* [Tools Used](#tools-used)

### Executive Summary
Analyze Fetch data from user, products, and transaction CSVs provided in order to answer three of the following six questions.

Closed-ended questions:
- 1a. What are the top 5 brands by receipts scanned among users 21 and over?
- 2a. What are the top 5 brands by sales among users that have had their account for at least six months?
- 3a. What is the percentage of sales in the Health & Wellness category by generation?

Open-ended questions: for these, make assumptions and clearly state them when answering the question.
- 1b. Who are Fetch’s power users?
- 2b. Which is the leading brand in the Dips & Salsa category?
- 3b. At what percent has Fetch grown year over year?

### Exploration, Observation, Validations, and Assumptions
- All data analyzed using Python via Jupyter notebook. Notebook available via Github [HERE](https://github.com/david423br/druiz_fetch_da_assess/tree/main/notebook).

### Data Source
To answer these questions, I used the following data retrieved from [Fetch Data Analyst Takehome Assessment](https://fetch-hiring.s3.amazonaws.com/data-analyst/da_take_home/da_takehome_instructions.html)
- user
- products
- transaction

### Analytical Approach
#### Minimum Viable Product (MVP)
- Exporatory analysis via Python using Jupyter Notebook - [Can be viewed HERE](https://github.com/david423br/druiz_fetch_da_assess/tree/main/notebook)
- Data analysis via PostgreSQL using PGAdmin to answer provided questions - [Can be viewed HERE](https://github.com/david423br/druiz_fetch_da_assess/tree/main/sql_script)

#### Known Issues and Challenges
The data provided was pretty sound, not much cleaning necessary, but there are a few data rows that were excluded based on the following criteria:
- FINAL_SALE column in 'transaction' dataset included empty cells
- FINAL_QUANTITY column in 'transaction' dataset included the non-numeric word 'zero'
- PURCHASE_DATE column in 'transaction' dataset does not include HH:MM:SS timestamp data, setting PURCHASE_DATE to DATE datatype does not conflict with all other date specific data being set to TIMESTAMP with TIME ZONE datatype

These observations, exclusions, and assumptions are explained inline in both my Python exploratory analysis, and my SQL data analysis.

#### Data Visualizations
- All data visualizations created using Python via Jupyter notebook and MATPLOTLIB. Notebook available via Github [HERE](https://github.com/david423br/druiz_fetch_da_assess/tree/main/notebook).

### Tools Used
- `Python/Pandas` - for exploration of the data

- `Python/MATPLOTLIB` - for visualization of the data

- `PostgreSQL` - for analysis of the data necessary to answer provided questions

- `Git` - for version control

### Email Draft
- Downloadable PDF and Word Doc attached under folder 'email draft' in Github
- Public Web Version of Email Draft available [HERE](https://docs.google.com/document/d/e/2PACX-1vRfJVK97-sjAKMZSDctA1lolALhLJUYoHbD5mF5T_hpnC-E2W_tnV8wLv-MnQ-yoaBuCoJgw8oIPlo2/pub)