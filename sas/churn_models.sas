/*Import the Data*/
proc import datafile="xyz_customer_churn_data.csv"
    out=churn
    dbms=csv
    replace;
    getnames=yes;
run;

/*Data preparation*/
data churn_prep;
    set churn;

    churn_flag = (churn = "Yes");

    if contract_type = "Monthly" then monthly_contract = 1;
    else monthly_contract = 0;

    if subscription_type = "Premium" then premium_plan = 1;
    else premium_plan = 0;
run;

/*Exploratory Statistics*/
proc means data=churn_prep mean min max;
    var age tenure_months monthly_charges support_calls total_charges;
run;

/*Logistic Regression Model*/
proc logistic data=churn_prep descending;
    model churn_flag =
        tenure_months
        monthly_charges
        support_calls
        monthly_contract
        premium_plan;
run;

