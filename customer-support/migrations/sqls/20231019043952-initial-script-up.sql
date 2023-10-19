/* Replace with your SQL commands */
/* Replace with your SQL commands */
CREATE SCHEMA main;

SET search_path TO main,public;
GRANT ALL ON SCHEMA main TO public;

CREATE TABLE main.support_plans (
	id                   uuid DEFAULT md5(random()::text || clock_timestamp()::text)::uuid NOT NULL ,
	plan_type               varchar(50)  NOT NULL ,
	plan_description        varchar(50)  NOT NULL ,
	p_image_url          varchar(255) ,
	price                integer NOT NULL ,
	qr_code              uuid NOT NULL ,
	created_on           timestamptz DEFAULT CURRENT_TIMESTAMP NOT NULL ,
	modified_on          timestamptz DEFAULT CURRENT_TIMESTAMP NOT NULL ,
	deleted              bool DEFAULT false NOT NULL ,
	deleted_on           timestamptz   ,
	deleted_by           uuid   ,
	CONSTRAINT pk_support_plans_id PRIMARY KEY ( id )
 );

 CREATE TABLE main.user_support_plans (
	id                   uuid DEFAULT md5(random()::text || clock_timestamp()::text)::uuid NOT NULL ,
	user_id              uuid  NOT NULL ,
	created_on           timestamptz DEFAULT CURRENT_TIMESTAMP NOT NULL ,
	modified_on          timestamptz DEFAULT CURRENT_TIMESTAMP NOT NULL ,
	created_by           uuid   ,
	modified_by          uuid   ,
	deleted              bool DEFAULT false NOT NULL ,
	support_plan_id      uuid    ,
	is_supprt_plan_enabled        boolean DEFAULT false,
    support_care_taker_id uuid   ,
    support_care_taker_assigned boolean DEFAULT false,
	deleted_by           uuid   ,
 	deleted_on           timestamptz   ,
	CONSTRAINT pk_user_support_plans PRIMARY KEY ( id )
 );

 CREATE TABLE main.user_product_complains_status (
	id                   uuid DEFAULT md5(random()::text || clock_timestamp()::text)::uuid NOT NULL ,
	user_product_id              uuid  NOT NULL ,
	complaint_type       varchar(50),
	created_by           uuid   ,
	modified_by          uuid   ,
	deleted              bool DEFAULT false NOT NULL ,
	is_resolved               boolean DEFAULT false,
    user_support_plan_id uuid Not Null,
	deleted_by           uuid   ,
    warraanty_status     boolean DEFAULT false,
 	deleted_on           timestamptz   ,
	CONSTRAINT pk_user_product_complains_status PRIMARY KEY ( id )
 );


ALTER TABLE main.user_support_plans
    ADD CONSTRAINT fk_support_plans_id FOREIGN KEY (support_plan_id) REFERENCES main.support_plans (id);


ALTER TABLE main.user_product_detail
    ADD CONSTRAINT fk_user_support_plans_id FOREIGN KEY (user_support_plan_id) REFERENCES main.user_support_plans (id);


CREATE OR REPLACE FUNCTION main.moddatetime()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
BEGIN
    NEW.modified_on = now();
    RETURN NEW;
END;
$function$
;

CREATE TRIGGER mdt_support_plans BEFORE UPDATE ON main.support_plans FOR EACH ROW EXECUTE PROCEDURE main.moddatetime('modified_on');

CREATE TRIGGER mdt_user_support_plans BEFORE UPDATE ON main.user_support_plans FOR EACH ROW EXECUTE PROCEDURE main.moddatetime('modified_on');

CREATE TRIGGER mdt_user_product_detail BEFORE UPDATE ON main.user_product_detail FOR EACH ROW EXECUTE PROCEDURE main.moddatetime('modified_on');

