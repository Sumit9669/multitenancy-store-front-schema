/* Replace with your SQL commands */

CREATE KEYSPACE  stores
WITH replication = {'class': 'SimpleStrategy', 'replication_factor' : 3};


CREATE TABLE STORE_FRONT_DETAIL(
   id name uuid PRIMARYKEY,
   store_name varchar,
   address text,
   registration_address text,
   fyscal_start_year timestamp,
   service_type varchar,
   service_detail text,
   genric_config_detail blob, 

   )