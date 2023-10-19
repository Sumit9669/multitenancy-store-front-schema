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

Prerequiste:
Create  following db in your postgres db
1. product
2. cusomter-support
3. user
4. notifications
5. audit-log

# Other solution for dynamic setup of every store onboarding.
1. We can create a api that will take store info  and store into no-sql db
2. fetch record saved in no-sql db
3. use id as tenant id 
4. request to initiate migration run for postgres to setup all dbs
and set tenant id fetched for that db as default tenant id
