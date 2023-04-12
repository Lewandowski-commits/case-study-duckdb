# Case study using dbt and duckdb
This is a case study solved using a forked dbt project relying on a duckdb database. Original readme of the source repo is available [here](https://github.com/dbt-labs/jaffle_shop_duckdb).

I admit it took me slightly longer than I imagined, however I have never worked or set up **dbt** (or **BigQuery** as a matter of fact). I realise it was not a requirement to set it up, but I thought that would be the only proper way to do this, as I wanted to verify the correctness of my queries in real time. I also meant to pick up **dbt** sometime this year, so I can cross this out of my bucket list!
**Michał's bucket list for 2023:**
- [x] Start learning **dbt**
- [ ] Learn **dbt** in-depth

*Note:* original schema names from the case study challenge descriptions are not used (except for [Challenge C](#challenge-c) - instead schemas from the forked projects are used due to time constraints on the challenge. Also, the original seeds/tables from the source repo have not been removed - again, due to time constraints. Please refer to the readme below for exact links to each solution.

## Challenge A

<details>
    <summary> See the task descriptions, scenarios, and provided supporting resources. </summary>
  
- Scenario 1: As a business intelligence developer, I would like to "look back in time" at previous data states of the ‘general_marketplaces.cln_listings’ table. While some source data systems are built in a way that makes accessing historical data possible, this is not the case here: this table has only current data state. In order to record changes to this mutable table over time, it is necessary to use a mechanism to do so.
    
- Task 1 (1.5 Points): Create or describe a mechanism/script to register each data change (snapshot of end of day) from the clean table ‘general_marketplaces.cln_listings’ into the fact table ‘general_marketplaces.fct_listings’ for each day of the interval considering validity of the records (SCD type 2).
    
- Supporting Resources 1: Kimball documentation and dbt documentation (not mandatory to use dbt, a simple sql script can have the job done*).
Kimball SCD type 2 https://www.kimballgroup.com/data-warehouse-business-intelligence-resources/kimball-techniques/dimensional-modeling-techniques/type-2/#:~:text=Slowly%20changing%20dimension%20type%202,multiple%20rows%20describing%20each%20member.
dbt incremental model https://docs.getdbt.com/docs/build/incremental-models#about-incremental_strategy
dbt snapshot https://docs.getdbt.com/docs/build/snapshots

- Scenario 2: As a business intelligence developer, I would like to see all the listings (classifieds) changes on a daily basis for each platform in order to track its evolution and answer business questions.
    
- Task 2 (1.5 Points): Create a report for the period from Dec. 2021 to Jan. 2022 (2 months). Also consider clean-up/mapping data changes that occurred during this period, for example related to platform re-naming recorded in the dimensional table ‘general_marketplaces.dim_platform’.
    
- Supporting Resources 2: Spreadsheet with flat dataset to be used for the report OR CSV files with star schema dataset to check for modifications on the tables and data analysis.
</details>
    
### Task 1

1. [Source table](https://github.com/Lewandowski-commits/case-study-duckdb/blob/duckdb/models/staging/stg_cln_listings.sql) which also contains a case statement populating the nulls in *last_update_date* column in order to create complete *valid_from* column.
2. [Snapshot](https://github.com/Lewandowski-commits/case-study-duckdb/blob/duckdb/snapshots/snapshot_fct_listings.sql) 
3. Final table [fct_listings](https://github.com/Lewandowski-commits/case-study-duckdb/blob/duckdb/models/fct_listings.sql)

### Task 2
#### Updated solution description
*Note:* I initially misunderstood the task, thinking that the report should be a visual one - my solution from that time is described in the **Old description** section below. At least the report is now also visuallised, even if that was not the point.

*Note:* The `dim_platform` table suggests that the platforms were renamed from Anibis to Anibis.ch, and Tutti.ch to Tutti instead of the both having .ch removed from them as described in the readme. I assume the tables are correct.

The report itself can be found [here](https://github.com/Lewandowski-commits/case-study-duckdb/blob/duckdb/models/challenge_a2.sql). It is built using staging dimension tables which pick only the current values for the dimensions (based on the assumption that a `valid_to is null` means it is current).

<details>
    <summary>See the old description</summary>
    
Given the time restrictions, I chose to create the report in PowerBI, which I am familiar with, instead of Looker. After many unsuccessful tries to connect the duckdb to PowerBI, I decided to ingest the data directly from the files, and not using duckdb.


The report [file](https://github.com/Lewandowski-commits/case-study-duckdb/blob/duckdb/Challenge%20A2%2BB2.pbix) can be downloaded from the repo and viewed in PowerBI desktop, or you can check out a screenshot of it below.

![report screenshot](https://github.com/Lewandowski-commits/case-study-duckdb/blob/duckdb/images/Challenge_A2_Screenshot.png)
</details>

## Challenge B

<details>
    
<summary> See the task descriptions, scenarios, and provided supporting resources. </summary>
- Scenario: Swiss Marketplace Group (SMG) wants to analyse its general listings (classifieds) data to determine which product types are the most popular and which ones are idle. The company wants to use this information to make decisions about which product types they should invest in different ways of promoting (idle listings).
    
- Task 1 (2.5 Points): Write a script/query that shows the following information:
a) The top 3 selling product types by platform.
b) The bottom 3 selling product types by platform.
c) The top 3 idle product types (amount of days).
d) The total amount sold by product type (monetary value rounded to two decimals).
e) Any other insights you could learn from the data that would be useful for the company to know.
    
- Supporting Resources 1: Given that you completed the Challenge A Task 2, you can use the created report output as a start.
    
- Task 2 (2.5 Points): Create data visualizations (charts or/and dashboards) that can be used to explain the results of task 1 (a,b,c,d,e).
a) The top 3 selling product types by platform.
b) The bottom 3 selling product types by platform.
c) The top 3 idle product types (amount of days).
d) The total amount sold by product type (monetary value rounded to two decimals).
e) Any other insights you could learn from the data that would be useful for the company to know.
    
- Supporting Resources 2: Given that you completed the Challenge B Task 1, you can use the results (a,b,c,d,e) as an input data for the visualizations OR you can use the CSV file (challenge_B_task_02_flat_dataset) as a fall-back mechanism to create your data visualizations in case you could not complete Task 1 in time.

</details>

By most/least selling product types, I assumed count of listings is the defining factor.

a. [Solution](https://github.com/Lewandowski-commits/case-study-duckdb/blob/duckdb/models/challenge_b1a.sql)

b. [Solution](https://github.com/Lewandowski-commits/case-study-duckdb/blob/duckdb/models/challenge_b1b.sql) - here more than 3 results are obtained per each platform, solely because there are multiple product categories with only 1 listing. Without further criteria that would help narrow down the bottom 3, it is impossible to have just 3 `product_type`s returned by the query.

c. [Solution](https://github.com/Lewandowski-commits/case-study-duckdb/blob/duckdb/models/challenge_b1c.sql) - given the following assumptions:
1. `idle` means the difference between when a listing was published/status is `active`, and when it changed to anything else than `active`
2. a listing always starts as `active` and only changes status once
3. if status never changed from `active`, then fill in `valid_to` with the current date

d. [Solution](https://github.com/Lewandowski-commits/case-study-duckdb/blob/duckdb/models/challenge_b1d.sql)

e. My suggestion would be to monitor the count of updates over time for each platform. For the time range given in challenge A2, no changes are seen in any listings for Tutti, a low but consistent over time amount of updates for Tutti, and sudden and big update spikes for Ricardo. This could indicate the usage patterns for each platform. I ran out of time before I could implement this in SQL - done in PowerBI and can be seen in challenge A task 2 section **Old description**

### Task 2

See chart titles for references to specific sub-tasks. Please note that the visualisation is sub-task E can be seen in challenge A task 2 section **Old description**. The empty white space at the top could host some slicers and/or dashboard title.

![report screenshot](https://github.com/Lewandowski-commits/case-study-duckdb/blob/duckdb/images/Challenge_B2_Screenshot.png)

## Challenge C
<details>
    
<summary> See the task descriptions, scenarios, and provided supporting resources. </summary>   
- Scenario 1: The fact table ‘general_marketplaces.fct_listings’ is the central part of a star schema and contains periodic snapshots of listings (classifieds). This table is partitioned on the listing_date_key column and is clustered on the platform_id, product_type_id, status_id and user_id columns. The dimensional table ‘general_marketplaces.dim_user’ contains granular information about user location. The dimensional table ‘general_marketplaces.dim_product_type’ contains granular information about product type tags.
    
- Task 1 (2 Points): Please write a SQL script using BigQuery syntax that shows the top 3 countries by number of listings with the product type having the black color for product type tag.
    
- Supporting Resources 1: Entity Relationship Diagram (ERD - entity_relationship_diagram.jpg) and BigQuery Syntax documentation.
    
- Pre-requisites 1: If you have never used BigQuery, please check how to manipulate the RECORD and REPEATED columns:
For the RECORD column, a.k.a. STRUCT fields: you can query the ‘location.city’ column as follow:
SELECT location.city FROM ‘general_marketplaces.dim_user`
For REPEATED columns, a.k.a. ARRAY columns:
https://cloud.google.com/bigquery/docs/reference/standard-sql/arrays
[OPTIONAL] For an overall documentation about the BigQuery queries syntax:
https://cloud.google.com/bigquery/docs/reference/standard-sql/query-syntax
    
</details>

[Solution](https://github.com/Lewandowski-commits/case-study-duckdb/blob/duckdb/challenge_C.sql per [BigQuery documentation](https://cloud.google.com/bigquery/docs/reference/standard-sql/arrays#scanning_for_values_that_satisfy_a_condition).
*Note:* The solution file is located in the main directory instead of `models` as duckdb does not support the exact array functions as BigQuery (however in general it does support [LIST](https://duckdb.org/docs/sql/data_types/list.html)s).
