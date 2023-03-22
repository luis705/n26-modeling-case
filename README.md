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
- [Create the fact tables](#fact-table-creation): after knowing the data, decide which metrics are important to the business, thus creating the columns of the fact table.
- [Create the dimension tables](#dimension-tables-creation): the dimension tables are auxiliray tables that contains descriptive attributes of the data, create those tables is the next step.
- Normalize dimension tables: in the snowflake schema the dimension tables are normalized to avoid redundancy and improve performance
- Create the relation between tables: relate the fact and dimension tables, also create the relationship between the dimension tables and its helper tables. This process is made by adding primary and foreign keys.


## Entities and attributes
The first thing to do is divide the data into categories. The division is arbitrary, in this case I created four categories:

- Account: account attributes for example client type, number of spaces, password, status, etc.
- Card: every card related attribute such as number of virtual cards, cards last digits, card 
color, etc.
- Person: attributes related to a person like cellphone characteristics, location, contact info, etc.
- Transaction: dates of any type of transaction - debit or credit card, pix, digital wallets.


## Fact table creation:
Observing the given column names, it is possible to verify that there is not a column that reports a fact in itself. This way I had two options: create new columns for facts, or build a fact table based on events.

Initially I decided to go with the second approach, but it may be that in the next development stages I will add more columns with facts containing real measurements.

Because of this the fact table must only count foreign keys to the dimension tables. Thus, in this table there will be, in addition to the primary key column, the keys for the dimension account, card, person and transaction.  The definition of this table can be seen below.

<div align="center">

```mermaid
---
title: Fact table
---
erDiagram
    EventFact {
        int fact_id PK
        int account_id FK
        int card_id FK
        int person_id FK
        int transaction_id FK
    }
```
</div>

## Dimension tables creation:
As mentioned earlier we have a dimension for each entity we want to model. So there are 4 dimension tables, each one with its attributes.

<div align="center">

```mermaid
---
title: Dimension tables
---
erDiagram
    DimAccount {
        int    account_id PK

        binary account_password
        
        bool   account_active
        bool   account_free
        bool   account_type
        bool   active_loan
        bool   active_pix
        
        bool   credit_pre_aproved
        
        date   date_cancelation
        date   date_doc_submition
        date   date_last_login
        date   date_onboarding_end
        date   date_onboarding_start
        date   date_register
        
        int    number_spaces
        int    account_balance
        
        string account_corp_name
    }

    DimCard {
        int    card_id PK
        
        date   card_bill_expiration_date
        date   card_received_date
        date   card_request_date
        
        int    card_last_digits
        int    card_limit
        int    card_quantity
        
        string card_color
        string card_tracking_status 
    }

    DimPerson {
        int    person_id PK
        
        bool   ppe

        date   birth_date

        int    age
        int    monthly_income

        string app_version
        string cell_phone_model
        string cell_phone_number
        string cell_phone_operator
        string cell_phone_os
        string city
        string district
        string doc_number
        string email
        string latitude
        string longitude
        string marital_status
        string mother_name
        string name
        string state
    }

    DimTransaction {
        int transaction_id PK
        
        date date_first_cashin
        date date_first_cashout
        date date_first_credit_card
        date date_first_debit_card
        date date_first_digital_wallet
        date date_first_pix_cashin
        date date_first_pix_cashout

        date date_last_cashin
        date date_last_cashout
        date date_last_credit_card
        date date_last_debit_card
        date date_last_digital_wallet
        date date_last_pix_cashin
        date date_last_pix_cashout
        date date_last_transaction

    }

```
</div>

# References

[Tutorialspoint: Data Warehousing - Schemas](https://www.tutorialspoint.com/dwh/dwh_schemas.htm)

[Vertabelo: Star Schema vs. Snowflake Schema](https://vertabelo.com/blog/data-warehouse-modeling-star-schema-vs-snowflake-schema/)

[Software Tersting Help: Schema Types In Data Warehouse Modeling – Star & SnowFlake Schema](https://www.softwaretestinghelp.com/data-warehouse-modeling-star-schema-snowflake-schema/#Which_Is_Better_Snowflake_Schema_Or_Star_Schema)

[Bigbear.AI: Factless Fact Tables](https://bigbear.ai/blog/factless-fact-tables/)