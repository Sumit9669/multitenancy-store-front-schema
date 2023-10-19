/* Replace with your SQL commands */
CREATE SCHEMA main;

SET search_path TO main,public;
GRANT ALL ON SCHEMA main TO public;

CREATE TABLE main.products (
	id                   uuid DEFAULT md5(random()::text || clock_timestamp()::text)::uuid NOT NULL ,
	p_name               varchar(50)  NOT NULL ,
	p_description        varchar(50)  NOT NULL ,
	p_link               varchar(200)   ,
	p_image_url          varchar(255) ,
	price                integer NOT NULL ,
	qr_code              uuid NOT NULL ,
	secret               varchar(50)  NOT NULL ,
	created_on           timestamptz DEFAULT CURRENT_TIMESTAMP NOT NULL ,
	modified_on          timestamptz DEFAULT CURRENT_TIMESTAMP NOT NULL ,
	deleted              bool DEFAULT false NOT NULL ,
	deleted_on           timestamptz   ,
	deleted_by           uuid   ,
	CONSTRAINT pk_products_id PRIMARY KEY ( id )
 );

 CREATE TABLE main.user_product_detail (
	id                   uuid DEFAULT md5(random()::text || clock_timestamp()::text)::uuid NOT NULL ,
	user_id              uuid  NOT NULL ,
	created_on           timestamptz DEFAULT CURRENT_TIMESTAMP NOT NULL ,
	modified_on          timestamptz DEFAULT CURRENT_TIMESTAMP NOT NULL ,
	created_by           uuid   ,
	modified_by          uuid   ,
	deleted              bool DEFAULT false NOT NULL ,
	product_id          uuid NOT Null   ,
	discount            boolean DEFAULT false,
    total_item_price    integer Not Null,
    paid_amount         integer NOT NULL,
    dicount_amount      integer NOT NUll DEFAULT 0,
	deleted_by           uuid   ,
    billing_address      text[],
    shipping_Address     text[],
    warraanty_status     boolean DEFAULT false,
 	deleted_on           timestamptz   ,
	CONSTRAINT pk_user_product_detail_id PRIMARY KEY ( id )
 );

ALTER TABLE main.user_product_detail
    ADD CONSTRAINT fk_product_id FOREIGN KEY (product_id) REFERENCES main.products (id);



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

CREATE TRIGGER mdt_products BEFORE UPDATE ON main.products FOR EACH ROW EXECUTE PROCEDURE main.moddatetime('modified_on');

CREATE TRIGGER mdt_user_product_detail BEFORE UPDATE ON main.user_product_detail FOR EACH ROW EXECUTE PROCEDURE main.moddatetime('modified_on');

