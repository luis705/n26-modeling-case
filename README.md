# Problem description

- Model visualy using a MER diagram the desired database adressing all the performance and consistency issues;
- Control the code versioning to keep track of changes;
- Implement the model and construct the data warehouse using SQL.

# Modeling design choices

Before modeling the database some decisions regarding its architecture must be made. The first is the schema used, the schema defines how the tables are related to each other.

In our case, as the most complex problem to be solved is consistency, I chose to use the snowflake schema. When modeling using the snowflake schema, the dimension tables are normalized in such a way that there is no redundant data that causes this consistency problem.

In addition, even if the snowflake schema ends up needing more complex queries and, consequently, with a longer execution time, the fact that the large table is reduced to small tables will make the execution of the queries faster.

Finally, the other reason I chose this schema over the star schema is that databases using the snowflake schema tend to take up less space, which is critical given the current size of the aforementioned table.

# Modeling the database

To model the database I will follow 5 basic steps described bellow:

- [Identify entities and attributes](#entities-and-attributes): the first thing to do is to know your data. In this step I will study the column names, try to aggregate them as attributes of various entities.
- Create the fact tables: after knowing the data, decide which metrics are important to the business, thus creating the columns of the fact table.
- Create the dimension tables: the dimension tables are auxiliray tables that contains descriptive attributes of the data, create those tables is the next step.
- Normalize dimension tables: in the snowflake schema the dimension tables are normalized to avoid redundancy and improve performance
- Create the relation between tables: relate the fact and dimension tables, also create the relationship between the dimension tables and its helper tables. This process is made by adding primary and foreign keys.


## Entities and attributes
The first thing to do is divide the data into categories. The division is arbitrary, in this case I created four categories:

- Account: account attributes for example client type, number of spaces, password, status, etc.
- Card: every card related attribute such as number of virtual cards, cards last digits, card 
color, etc.
- Person: attributes related to a person like cellphone characteristics, location, contact info, etc.
- Transaction: dates of any type of transaction - debit or credit card, pix, digital wallets.


# References

[Tutorialspoint: Data Warehousing - Schemas](https://www.tutorialspoint.com/dwh/dwh_schemas.htm)

[Vertabelo: Star Schema vs. Snowflake Schema](https://vertabelo.com/blog/data-warehouse-modeling-star-schema-vs-snowflake-schema/)

[Software Tersting Help: Schema Types In Data Warehouse Modeling – Star & SnowFlake Schema](https://www.softwaretestinghelp.com/data-warehouse-modeling-star-schema-snowflake-schema/#Which_Is_Better_Snowflake_Schema_Or_Star_Schema)
