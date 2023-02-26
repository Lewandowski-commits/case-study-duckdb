# Case study using dbt and duckdb
This is a case study solved using a forked dbt project relying on a duckdb database. Original readme of the source repo is available [here](https://github.com/dbt-labs/jaffle_shop_duckdb).

*Note:* original schema names from the case study challenge descriptions are not used - instead schemas from the forked projects are used due to time constraints on the challenge.

## Challenge A

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

### Task 1
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

# Challenge C
[Solution](https://github.com/Lewandowski-commits/case-study-duckdb/blob/duckdb/challenge_C) per [BigQuery documentation](https://cloud.google.com/bigquery/docs/reference/standard-sql/arrays#scanning_for_values_that_satisfy_a_condition).
*Note:* The solution file is located in the main directory instead of `models` as duckdb does not support the exact array functions as BigQuery (however in general it does support [LIST](https://duckdb.org/docs/sql/data_types/list.html)s).
