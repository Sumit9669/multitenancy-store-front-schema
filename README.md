# multitenancy-store-front-schema

It is basic schema setup to overview multitenancy arch for storefront using SQL and NOSQL.

# Requirement

Setup a storefront db-schema which uses both sql and NoSQL
# DB USED
SQL: POSTGRES
NOSQL: CASANDRA

# Setup process
1. clone repo in local system
2. do npm i 
3. setup .env files using example env
4. run npm run db:migrate to run all
5. or for single db npm run db:(here folder name like for user-service ):- npm run db:migrate:user-service.

# Prerequiste:
Create  following db in your postgres db
1. product
2. cusomter-support
3. user
4. notifications
5. audit-log

# Why above DB required
1. Product:
This db will store all information reagarding product, product bought by customer or payment  and billing details as per business need . For now only basic detail have been added , other info can be added based on business need.


2.Customer-support
For every product bought by cusomter(electronic, hardware,software), tracking of support provided to cusotmer can be handled through this and can be verifed weather issue resolved or not and will be used to anaylse , understand and build trust in our cusomter.


3.User
This DB will contain all the users info(cusomer, employee, admin). Through this db various application access, user detail, or store confirgration will be handled


4. Notification:
This db will be primerly used for every user to provide various services through email,sms, or notification depending upon business need


5.Audit-log: 
It is for our intenral use to track logs for very produc and user .
# Other solution for dynamic setup of every store onboarding.
1. We can create a api that will take store info  and store into no-sql db
2. fetch record saved in no-sql db
3. use id as tenant id 
4. request to initiate migration run for postgres to setup all dbs
and set tenant id fetched for that db as default tenant id
