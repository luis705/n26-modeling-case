-- FACT TABLES

CREATE TABLE IF NOT EXISTS TransactionFact (
    transaction_id INTEGER PRIMARY KEY AUTOINCREMENT,
    date_id INTEGER NOT NULL,
    location_id INTEGER NOT NULL,
    type_id INTEGER NOT NULL,
    value INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS AccountFact (
    account_id INTEGER PRIMARY KEY AUTOINCREMENT,
    account_dates_id INTEGER NOT NULL,
    device_id INTEGER NOT NULL,
    account_status_id INTEGER NOT NULL,
    password BLOB NOT NULL,
    balance INTEGER NOT NULL,
    number_of_spaces INTEGER NOT NULL,
    corp_name VARCHAR(3)
);

CREATE TABLE IF NOT EXISTS CustomerFact (
    customer_id INTEGER PRIMARY KEY AUTOINCREMENT,
    birth_date_id INTEGER NOT NULL,
    location_id INTEGER NOT NULL,
    device_id INTEGER NOT NULL,
    customer_status_id INTEGER NOT NULL,
    age INTEGER NOT NULL,
    monthly_income INTEGER NOT NULL,
    cellphone_number STRING NOT NULL,
    email VARCHAR(30) NOT NULL,
    mothers_name VARCHAR(30) NOT NULL
);

CREATE TABLE IF NOT EXISTS CardFact (
    card_id INTEGER PRIMARY KEY AUTOINCREMENT,
    card_dates_id INTEGER NOT NULL,
    number_of_card INTEGER NOT NULL,
    card_limit INTEGER NOT NULL,
    card_color VARCHAR(10) NOT NULL,
    tracking_status VARCHAR(20) NOT NULL
);

-- DIMENSION TABLES
CREATE TABLE IF NOT EXISTS DimDate (
    date_id INTEGER PRIMARY KEY AUTOINCREMENT,
    day INTEGER NOT NULL,
    month INTEGER NOT NULL,
    year INTEGER NOT NULL,
    date INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS DimAccountDates(
    account_dates_id INTEGER PRIMARY KEY AUTOINCREMENT,
    creation_date_id INTEGER NOT NULL,
    cancelation_date_id INTEGER NOT NULL,
    doc_submition_date_id INTEGER NOT NULL,
    last_login_date_id INTEGER NOT NULL,
    onboarding_end_date_id INTEGER NOT NULL,
    onboarding_start_date_id INTEGER NOT NULL,
    inactivation_date_id INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS DimCardDates(
    request_date_id INTEGER PRIMARY KEY AUTOINCREMENT,
    received_date_id INTEGER NOT NULL,
    bill_expiration_date_id INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS DimLocation(
    location_id INTEGER PRIMARY KEY AUTOINCREMENT,
    location_country VARCHAR(20) NOT NULL,
    location_state VARCHAR(20) NOT NULL,
    location_city VARCHAR(20) NOT NULL,
    location_neighborhood VARCHAR(20) NOT NULL,
    location_street VARCHAR(20) NOT NULL
);

CREATE TABLE IF NOT EXISTS DimDevice(
    device_id INTEGER PRIMARY KEY AUTOINCREMENT,
    device_model VARCHAR(10) NOT NULL,
    device_operator VARCHAR(10) NOT NULL,
    device_os VARCHAR(10) NOT NULL,
    app_version VARCHAR(10) NOT NULL
);

CREATE TABLE IF NOT EXISTS DimTransactionType(
    transaction_type_id INTEGER PRIMARY KEY AUTOINCREMENT,
    transation_type VARCHAR(10) NOT NULL,
    transation_in_out INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS DimAccountStatus(
    account_status_id INTEGER PRIMARY KEY AUTOINCREMENT,
    account_active INTEGER NOT NULL,
    credit_pre_approved INTEGER NOT NULL,
    free INTEGER NOT NULL,
    loan_active INTEGER NOT NULL,
    pix_active INTEGER NOT NULL,
    person_type INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS DimCustomerStatus(
    customer_status_id INTEGER PRIMARY KEY AUTOINCREMENT,
    marital_status INTEGER NOT NULL,
    ppe INTEGER NOT NULL
);