#----------------------------------------------------------------
# KonaKart upgrade script from version 7.1.1.0 to version 7.2.0.0
#----------------------------------------------------------------
#
# In order to upgrade from earlier versions the upgrade scripts
# must be run sequentially
#

#MySQL -- For MySQL Only - Diaable Safe Updates Mode
SET SQL_SAFE_UPDATES=0;

# Set database version information
INSERT INTO kk_config (kk_config_key, kk_config_value, date_added) VALUES ('HISTORY', '7.2.0.0 U', now());
UPDATE kk_config SET kk_config_value='7.2.0.0 MySQL', date_added=now() WHERE kk_config_key='VERSION';

# Database Table/Column Modifications

DROP TABLE IF EXISTS prod_opt_vals_to_prod_opt;
ALTER TABLE products_options_values_to_products_options RENAME prod_opt_vals_to_prod_opt;

DROP TABLE IF EXISTS products_attrs_download;
ALTER TABLE products_attributes_download RENAME products_attrs_download;

DROP TABLE IF EXISTS customers_basket_attrs;
ALTER TABLE customers_basket_attributes RENAME customers_basket_attrs;

ALTER TABLE configuration_group CHANGE configuration_group_description configuration_group_desc VARCHAR(255) NOT NULL;

ALTER TABLE customers_info CHANGE customers_info_date_of_last_logon customers_info_date_last_logon DATETIME;
ALTER TABLE customers_info CHANGE customers_info_number_of_logons customers_info_number_of_logon INT(5);
ALTER TABLE customers_info CHANGE customers_info_date_account_created customers_info_date_created DATETIME;
ALTER TABLE customers_info CHANGE customers_info_date_account_last_modified customers_info_date_modified DATETIME;

ALTER TABLE prod_opt_vals_to_prod_opt CHANGE products_options_values_to_products_options_id prod_opt_vals_to_prod_opt_id int NOT NULL auto_increment;

#DB2 -- For DB2 only
#DB2 CREATE TABLE prod_opt_vals_to_prod_opt (
#DB2   prod_opt_vals_to_prod_opt_id INTEGER NOT NULL,
#DB2   products_options_id INTEGER NOT NULL,
#DB2   products_options_values_id INTEGER NOT NULL,
#DB2   store_id VARCHAR(64),
#DB2   PRIMARY KEY(prod_opt_vals_to_prod_opt_id)
#DB2 );
#DB2 DROP SEQUENCE prod_opt_vals_to_prod_opt_SEQ;
#DB2 CREATE SEQUENCE prod_opt_vals_to_prod_opt_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;
#DB2 INSERT INTO prod_opt_vals_to_prod_opt (prod_opt_vals_to_prod_opt_id, products_options_id, products_options_values_id, store_id) SELECT nextval for prod_opt_vals_to_prod_opt_SEQ, products_options_id, products_options_values_id, store_id FROM products_options_values_to;
#DB2 DROP TABLE products_options_values_to;

#Oracle -- For Oracle Only - Change sequence names
#Oracle BEGIN EXECUTE IMMEDIATE 'DROP SEQUENCE prod_opt_vals_to_prod_opt_seq'; EXCEPTION WHEN OTHERS THEN NULL; END;
#Oracle /
#Oracle RENAME products_options_values_to_seq TO prod_opt_vals_to_prod_opt_seq;
#Oracle BEGIN EXECUTE IMMEDIATE 'DROP SEQUENCE customers_basket_attrs_seq'; EXCEPTION WHEN OTHERS THEN NULL; END;
#Oracle /
#Oracle RENAME customers_basket_attribute_seq TO customers_basket_attrs_seq;

#PostgreSQL -- For PostgreSQL Only - Change sequence names
#PostgreSQL DROP SEQUENCE IF EXISTS customers_basket_attrs_customers_basket_attributes_id_seq;
#PostgreSQL ALTER SEQUENCE customers_basket_attributes_customers_basket_attributes_id_seq RENAME TO customers_basket_attrs_customers_basket_attributes_id_seq;
#PostgreSQL DROP SEQUENCE IF EXISTS prod_opt_vals_to_prod_opt_prod_opt_vals_to_prod_opt_id_seq;
#PostgreSQL ALTER SEQUENCE products_options_values_to_pr_products_options_values_to_pr_seq RENAME TO prod_opt_vals_to_prod_opt_prod_opt_vals_to_prod_opt_id_seq;

# Add some extra fields to the ipn_history table
ALTER TABLE ipn_history ADD gateway_capture_id varchar(64);
ALTER TABLE ipn_history ADD gateway_credit_id varchar(64);
ALTER TABLE ipn_history ADD admin_payment_class varchar(128);

# Table for refunds
DROP TABLE IF EXISTS kk_order_refunds;
CREATE TABLE kk_order_refunds (
   order_refunds_id int NOT NULL auto_increment,
   orders_id int NOT NULL,
   ipn_history_id int,
   orders_number varchar(128),
   refund_note text,
   refund_amount decimal(15,4),
   gateway_credit_id varchar(64),
   notify_customer int DEFAULT 0,
   refund_status int DEFAULT 0,
   date_added datetime,
   last_modified datetime,
   store_id varchar(64),
   custom1 varchar(128),
   custom2 varchar(128),
   custom3 varchar(128),
   custom1Dec decimal(15,4),
   custom2Dec decimal(15,4),
   PRIMARY KEY (order_refunds_id)
);

# Panel for Refunds
INSERT INTO kk_panel (code, description, date_added) VALUES ('kk_panel_refunds','Order Refunds', now());
INSERT INTO kk_panel (code, description, date_added) VALUES ('kk_panel_refundsFromOrders','Order Refunds For Order', now());

# Add Refunds Panels access to all roles that can access the Order panel
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, now(), store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_orders' and p2.code='kk_panel_refunds';
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, now(), store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_orders' and p2.code='kk_panel_refundsFromOrders';

# API calls for Refunds
INSERT INTO kk_api_call (name, description, date_added) VALUES ('editOrderRefund','', now());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('insertOrderRefund','', now());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('deleteOrderRefund','', now());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getOrderRefund','', now());

# Add a new order status. Needs to have id = 9. Languages may not be applicable for your current setup.
#DELETE FROM orders_status WHERE orders_status_id = 9;
#INSERT INTO orders_status(orders_status_id, language_id, orders_status_name) VALUES (9,(SELECT languages_id FROM languages WHERE code = 'en'),'Refund Approved');
#INSERT INTO orders_status(orders_status_id, language_id, orders_status_name) VALUES (9,(SELECT languages_id FROM languages WHERE code = 'de'),'R�ckerstattung Genehmigt');
#INSERT INTO orders_status(orders_status_id, language_id, orders_status_name) VALUES (9,(SELECT languages_id FROM languages WHERE code = 'es'),'Reembolso Aprobado');
#INSERT INTO orders_status(orders_status_id, language_id, orders_status_name) VALUES (9,(SELECT languages_id FROM languages WHERE code = 'pt'),'Reembolso Aprovado');

# Add a new order status. Needs to have id = 10. Languages may not be applicable for your current setup.
#DELETE FROM orders_status WHERE orders_status_id = 10;
#INSERT INTO orders_status(orders_status_id, language_id, orders_status_name) VALUES (10,(SELECT languages_id FROM languages WHERE code = 'en'),'Refund Declined');
#INSERT INTO orders_status(orders_status_id, language_id, orders_status_name) VALUES (10,(SELECT languages_id FROM languages WHERE code = 'de'),'R�ckerstattung Abgelehnt');
#INSERT INTO orders_status(orders_status_id, language_id, orders_status_name) VALUES (10,(SELECT languages_id FROM languages WHERE code = 'es'),'Reembolso Rehus�');
#INSERT INTO orders_status(orders_status_id, language_id, orders_status_name) VALUES (10,(SELECT languages_id FROM languages WHERE code = 'pt'),'Reembolso Recusado');

# Add new product option types
ALTER TABLE customers_basket_attrs ADD COLUMN customer_price DECIMAL(15,2);
ALTER TABLE customers_basket_attrs ADD COLUMN customer_string VARCHAR(512);
ALTER TABLE orders_products_attributes ADD COLUMN customer_price DECIMAL(15,2);
ALTER TABLE orders_products_attributes ADD COLUMN customer_string VARCHAR(512);

# Table for KonaKart Events
DROP TABLE IF EXISTS kk_event;
CREATE TABLE kk_event (
   kk_event_id INT NOT NULL auto_increment,
   kk_event_code INT NOT NULL,
   kk_event_subcode INT,
   kk_event_value VARCHAR(64),
   store_id VARCHAR(64),
   custom1 VARCHAR(64),
   date_added DATETIME,
   PRIMARY KEY (kk_event_id),
   KEY idx_kk_event_date_added (date_added)
);

# API calls for KonaKart Events
INSERT INTO kk_api_call (name, description, date_added) VALUES ('insertKKEvent','', now());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getKKEvents','', now());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('deleteKKEvents','', now());

# Configuration variable to enable/disable Product Caching
DELETE FROM configuration WHERE configuration_key = 'CACHE_PRODUCTS';
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api, store_id) SELECT 'Cache Products','CACHE_PRODUCTS','true','Set to true to Cache Products in memory.','11', '15', 'choice(\'true\', \'false\')', now(), '1', store_id FROM configuration WHERE configuration_key = 'STORE_COUNTRY';

# Configuration variable to enable/disable Product Image Name Caching
DELETE FROM configuration WHERE configuration_key = 'CACHE_PRODUCT_IMAGES';
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api, store_id) SELECT 'Cache Product Images','CACHE_PRODUCT_IMAGES','true','Set to true to Cache Product Image Names in memory.','11', '20', 'choice(\'true\', \'false\')', now(), '1', store_id FROM configuration WHERE configuration_key = 'STORE_COUNTRY';

# New Custom Panels
INSERT INTO kk_panel (code, description, date_added) VALUES ('kk_panel_customA','Custom Panel A', now());
INSERT INTO kk_panel (code, description, date_added) VALUES ('kk_panel_customB','Custom Panel B', now());
INSERT INTO kk_panel (code, description, date_added) VALUES ('kk_panel_customC','Custom Panel C', now());
INSERT INTO kk_panel (code, description, date_added) VALUES ('kk_panel_customD','Custom Panel D', now());
INSERT INTO kk_panel (code, description, date_added) VALUES ('kk_panel_customE','Custom Panel E', now());
INSERT INTO kk_panel (code, description, date_added) VALUES ('kk_panel_customF','Custom Panel F', now());
INSERT INTO kk_panel (code, description, date_added) VALUES ('kk_panel_customG','Custom Panel G', now());
INSERT INTO kk_panel (code, description, date_added) VALUES ('kk_panel_customH','Custom Panel H', now());
INSERT INTO kk_panel (code, description, date_added) VALUES ('kk_panel_customI','Custom Panel I', now());
INSERT INTO kk_panel (code, description, date_added) VALUES ('kk_panel_customJ','Custom Panel J', now());

# Set up Custom Panels A-D as examples
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, now(), store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_products' and p2.code='kk_panel_customA';
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, now(), store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_products' and p2.code='kk_panel_customB';
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, now(), store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_orders' and p2.code='kk_panel_customC';
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, now(), store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_promotions' and p2.code='kk_panel_customD';
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, now(), store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_refreshCache' and p2.code='kk_panel_customE';

# Table for Shippers
DROP TABLE IF EXISTS kk_shipper;
CREATE TABLE kk_shipper (
   shipper_id INT NOT NULL auto_increment,
   name VARCHAR(64) NOT NULL,
   tracking_url VARCHAR(255),
   date_added datetime,
   store_id VARCHAR(64),
   custom1 VARCHAR(128),
   custom2 VARCHAR(128),
   custom3 VARCHAR(128),
   PRIMARY KEY (shipper_id)
);

# Panel for Shippers
INSERT INTO kk_panel (code, description, date_added) VALUES ('kk_panel_shippers','Shippers', now());

# Add Shippers Panel access to all roles that can access the Order status panel
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, now(), store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_orderStatuses' and p2.code='kk_panel_shippers';

# API calls for Shippers
INSERT INTO kk_api_call (name, description, date_added) VALUES ('updateShipper','', now());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('insertShipper','', now());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getShippers','', now());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getShipper','', now());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('deleteShipper','', now());

# Virtual kk_panel_customerForReview_2 Panel
INSERT INTO kk_panel (code, description, date_added) VALUES ('kk_panel_customerForReview_2', 'Customer From Reviews 2', now());

# Add Panel access to all roles that can access the kk_panel_customerForReview panel
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, now(), store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_customerForReview' and p2.code='kk_panel_customerForReview_2';

# Add custom privileges for kk_panel_customerForReview_2 panel
UPDATE kk_role_to_panel SET custom1=0, custom1_desc='Set to Access Invisible Customers' WHERE panel_id IN (SELECT panel_id FROM kk_panel where code='kk_panel_customerForReview_2');
UPDATE kk_role_to_panel SET custom2=0, custom2_desc='If set reviews button is hidden' WHERE panel_id IN (SELECT panel_id FROM kk_panel where code='kk_panel_customerForReview_2');
UPDATE kk_role_to_panel SET custom3=0, custom3_desc='If set custom button is hidden' WHERE panel_id IN (SELECT panel_id FROM kk_panel where code='kk_panel_customerForReview_2');

# Add custom privileges for the kk_panel_customerForReview panel 
UPDATE kk_role_to_panel SET custom1=0, custom1_desc='If set email is disabled' WHERE panel_id IN (SELECT panel_id FROM kk_panel where code='kk_panel_customerForReview');
UPDATE kk_role_to_panel SET custom2=0, custom2_desc='If set cannot reset password' WHERE panel_id IN (SELECT panel_id FROM kk_panel where code='kk_panel_customerForReview');
UPDATE kk_role_to_panel SET custom3=0, custom3_desc='If set customer search droplists are disabled' WHERE panel_id IN (SELECT panel_id FROM kk_panel where code='kk_panel_customerForReview');
UPDATE kk_role_to_panel SET custom4=0, custom4_desc='If set login button is hidden' WHERE panel_id IN (SELECT panel_id FROM kk_panel where code='kk_panel_customerForReview');
UPDATE kk_role_to_panel SET custom5=0, custom5_desc='If set addresses button is hidden' WHERE panel_id IN (SELECT panel_id FROM kk_panel where code='kk_panel_customerForReview');

# Tables for order shipments
DROP TABLE IF EXISTS kk_order_shipments;
CREATE TABLE kk_order_shipments (
   order_shipment_id int NOT NULL auto_increment,
   order_id int NOT NULL,
   store_id VARCHAR(64),
   order_number VARCHAR(128),
   shipper_name VARCHAR(64),
   shipper_id int,
   tracking_number VARCHAR(64),
   tracking_url VARCHAR(255),
   custom1 VARCHAR(128),
   custom2 VARCHAR(128),
   custom3 VARCHAR(128),
   shipment_notes text,
   date_added datetime,
   last_modified datetime,
   PRIMARY KEY (order_shipment_id)
);

DROP TABLE IF EXISTS kk_shipments_to_ord_prods;
CREATE TABLE kk_shipments_to_ord_prods (
   order_shipment_id int NOT NULL,
   order_product_id int NOT NULL,
   store_id VARCHAR(64),
   quantity int NOT NULL,
   date_added datetime,
   PRIMARY KEY (order_shipment_id, order_product_id)
);

# Panel for Shipments
INSERT INTO kk_panel (code, description, date_added) VALUES ('kk_panel_shipments','Order Shipments', now());
INSERT INTO kk_panel (code, description, date_added) VALUES ('kk_panel_shipmentsFromOrders','Shipments from Orders Panel', now());

# Add Shipments Panel access to all roles that can access the Order returns panel
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, now(), store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_returns' and p2.code='kk_panel_shipments';
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, now(), store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_returnsFromOrders' and p2.code='kk_panel_shipmentsFromOrders';

# API calls for Shipments
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getOrderShipments','', now());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('insertOrderShipment','', now());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('editOrderShipment','', now());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('deleteOrderShipment','', now());

# New table for allowing miscellaneous prices to be associated to a product 
DROP TABLE IF EXISTS kk_misc_price;
CREATE TABLE kk_misc_price (
  kk_misc_price_id int NOT NULL auto_increment,
  store_id varchar(64),
  product_id int NOT NULL,
  price_id varchar(128) NOT NULL,
  price_0 decimal(15,4),
  price_1 decimal(15,4),
  price_2 decimal(15,4),
  price_3 decimal(15,4),  
  quantity int,
  custom1 varchar(256),
  custom2 varchar(128),
  custom3 varchar(128),
  custom4 varchar(128),
  custom5 varchar(128),
  date_added datetime,
  last_updated datetime,
  PRIMARY KEY (kk_misc_price_id)
);

ALTER TABLE kk_misc_price ADD KEY idx_product_id (product_id);
ALTER TABLE kk_misc_price ADD KEY idx_store_id (store_id);

# New MiscPrices APIs
INSERT INTO kk_api_call (name, description, date_added) VALUES ('insertMiscPrices', '', now());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('deleteMiscPrices', '', now());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getMiscPrices', '', now());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('updateMiscPrices', '', now());

# Order Status Name Table change
# First we'll create a temporary table to store the current data

DROP TABLE IF EXISTS orders_status_temp;
CREATE TABLE orders_status_temp (
   orders_status_id int DEFAULT '0' NOT NULL,
   language_id int DEFAULT '1' NOT NULL,
   orders_status_name varchar(32) NOT NULL,
   store_id varchar(64),
   notify_customer int DEFAULT 0,
   PRIMARY KEY (orders_status_id, language_id)
);

# Copy current data to the temporary table 

INSERT INTO orders_status_temp (orders_status_id, language_id, orders_status_name, store_id, notify_customer) SELECT orders_status_id, language_id, orders_status_name, store_id, notify_customer FROM orders_status;

# Now we can drop the old order_status table

DROP TABLE IF EXISTS orders_status;

# Next re-create the order_status table to introduce non semantic key
CREATE TABLE orders_status (
   orders_status_pk int NOT NULL auto_increment,
   store_id varchar(64),
   orders_status_id int DEFAULT '0' NOT NULL,
   language_id int DEFAULT '1' NOT NULL,
   orders_status_name varchar(32) NOT NULL,
   notify_customer int DEFAULT 0,
   PRIMARY KEY (orders_status_pk),
   KEY idx_orders_status_name (orders_status_name)
);

# Populate the new orders_status table with the data we saved in the orders_status_temp table

INSERT INTO orders_status (orders_status_id, language_id, orders_status_name, store_id, notify_customer) SELECT orders_status_id, language_id, orders_status_name, store_id, notify_customer FROM orders_status_temp;

# Finally remove the orders_status_temp table

DROP TABLE IF EXISTS orders_status_temp;

# Control for SOLR suggested search and spelling
DELETE FROM configuration WHERE configuration_key = 'SOLR_ADD_TERM_IF_INVISIBLE';
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api, store_id) SELECT 'Add suggested search for invisible prods.','SOLR_ADD_TERM_IF_INVISIBLE','true','Adds a suggested search entry even when products are invisible','24', '5', 'choice(\'true\', \'false\')', now(), '0', store_id FROM configuration WHERE configuration_key = 'STORE_COUNTRY';
DELETE FROM configuration WHERE configuration_key = 'SOLR_ADD_TERM_IF_DISABLED';
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api, store_id) SELECT 'Add suggested search for disabled prods.','SOLR_ADD_TERM_IF_DISABLED','true','Adds a suggested search entry even when products are disabled','24', '5', 'choice(\'true\', \'false\')', now(), '0', store_id FROM configuration WHERE configuration_key = 'STORE_COUNTRY';

DELETE FROM configuration WHERE configuration_key = 'SOLR_ENABLE_SPELLING_SUGGESTION';
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api, store_id) SELECT 'Enable spelling suggestions','SOLR_ENABLE_SPELLING_SUGGESTION','true','Enables spelling suggestion functionality','24', '20', 'choice(\'true\', \'false\')', now(), '1', store_id FROM configuration WHERE configuration_key = 'STORE_COUNTRY';
DELETE FROM configuration WHERE configuration_key = 'SOLR_ADD_SPELLING_IF_INVISIBLE';
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api, store_id) SELECT 'Add spelling data for invisible prods.','SOLR_ADD_SPELLING_IF_INVISIBLE','true','Adds data used for spelling suggestions even when products are invisible','24', '21', 'choice(\'true\', \'false\')', now(), '0', store_id FROM configuration WHERE configuration_key = 'STORE_COUNTRY';
DELETE FROM configuration WHERE configuration_key = 'SOLR_ADD_SPELLING_IF_DISABLED';
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api, store_id) SELECT 'Add spelling data for disabled prods.','SOLR_ADD_SPELLING_IF_DISABLED','true','Adds data used for spelling suggestions even when products are disabled','24', '22', 'choice(\'true\', \'false\')', now(), '0', store_id FROM configuration WHERE configuration_key = 'STORE_COUNTRY';

# Add sort order to product attributes
ALTER TABLE products_attributes ADD sort_order int DEFAULT '0';

# Set a description on the EditProduct Panel custom1 field for assigning products to stores
UPDATE kk_role_to_panel SET custom1=0, custom1_desc='Set to allow assignment of products to stores' WHERE panel_id IN (SELECT panel_id FROM kk_panel where code='kk_panel_editProduct');

# Allow super-users to assign products to stores
UPDATE kk_role_to_panel SET custom1=1 WHERE panel_id IN (SELECT panel_id FROM kk_panel where code='kk_panel_editProduct') AND role_id IN (SELECT role_id FROM kk_role where super_user=1);

#MSSQL -- Convert all TEXT fields to NVARCHAR(MAX) columns
#MSSQL ALTER TABLE banners ALTER COLUMN banners_html_text NVARCHAR(MAX);
#MSSQL ALTER TABLE newsletters ALTER COLUMN content NVARCHAR(MAX);
#MSSQL ALTER TABLE orders_status_history ALTER COLUMN comments NVARCHAR(MAX);
#MSSQL ALTER TABLE reviews_description ALTER COLUMN reviews_text NVARCHAR(MAX);
#MSSQL ALTER TABLE sessions ALTER COLUMN value NVARCHAR(MAX);
#MSSQL ALTER TABLE ipn_history ALTER COLUMN gateway_full_response NVARCHAR(MAX);
#MSSQL ALTER TABLE orders_returns ALTER COLUMN return_reason NVARCHAR(MAX);
#MSSQL ALTER TABLE kk_audit ALTER COLUMN object_to_string NVARCHAR(MAX);
#MSSQL ALTER TABLE products_description ALTER COLUMN products_comparison NVARCHAR(MAX);
#MSSQL ALTER TABLE kk_msg ALTER COLUMN msg_value NVARCHAR(MAX);
#MSSQL ALTER TABLE kk_order_refunds ALTER COLUMN refund_note NVARCHAR(MAX);
#MSSQL ALTER TABLE kk_order_shipments ALTER COLUMN shipment_notes NVARCHAR(MAX);



