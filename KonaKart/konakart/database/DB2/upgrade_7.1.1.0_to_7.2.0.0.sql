-- (c) 2006 DS Data Systems UK Ltd, All rights reserved.
-- 
-- DS Data Systems and KonaKart and their respective logos, are
-- trademarks of DS Data Systems UK Ltd. All rights reserved.
-- 
-- The information in this document below this text is free software; you can redistribute
-- it and/or modify it under the terms of the GNU Lesser General Public
-- License as published by the Free Software Foundation; either
-- version 2.1 of the License, or (at your option) any later version.
-- 
-- This software is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-- Lesser General Public License for more details.
-- 
-- -----------------------------------------------------------
-- KonaKart upgrade database script for DB2
-- From version 7.1.1.0 to version 7.2.0.0
-- -----------------------------------------------------------
-- In order to upgrade from versions prior to 7.1.1.0, the upgrade
-- scripts must be run sequentially.
-- 


-- Set database version information
set echo on
INSERT INTO kk_config (kk_config_id, kk_config_key, kk_config_value, date_added) VALUES (NEXTVAL FOR kk_config_seq, 'HISTORY', '7.2.0.0 U', current timestamp);
UPDATE kk_config SET kk_config_value='7.2.0.0 DB2', date_added=current timestamp WHERE kk_config_key='VERSION';

-- Database Table/Column Modifications

DROP TABLE prod_opt_vals_to_prod_opt;

DROP TABLE products_attrs_download;
RENAME TABLE products_attributes_downlo TO products_attrs_download;

DROP TABLE customers_basket_attrs;
RENAME TABLE customers_basket_attribute TO customers_basket_attrs;

ALTER TABLE configuration_group RENAME COLUMN configuration_group_descriptio TO configuration_group_desc;

ALTER TABLE customers_info RENAME COLUMN customers_info_date_of_last_lo TO customers_info_date_last_logon;
ALTER TABLE customers_info RENAME COLUMN customers_info_date_account_cr TO customers_info_date_created;
ALTER TABLE customers_info RENAME COLUMN customers_info_date_account_la TO customers_info_date_modified;


-- For DB2 only
CREATE TABLE prod_opt_vals_to_prod_opt (
  prod_opt_vals_to_prod_opt_id INTEGER NOT NULL,
  products_options_id INTEGER NOT NULL,
  products_options_values_id INTEGER NOT NULL,
  store_id VARCHAR(64),
  PRIMARY KEY(prod_opt_vals_to_prod_opt_id)
);
DROP SEQUENCE prod_opt_vals_to_prod_opt_SEQ;
CREATE SEQUENCE prod_opt_vals_to_prod_opt_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;
INSERT INTO prod_opt_vals_to_prod_opt (prod_opt_vals_to_prod_opt_id, products_options_id, products_options_values_id, store_id) SELECT nextval for prod_opt_vals_to_prod_opt_SEQ, products_options_id, products_options_values_id, store_id FROM products_options_values_to;
DROP TABLE products_options_values_to;



-- Add some extra fields to the ipn_history table
ALTER TABLE ipn_history ADD gateway_capture_id varchar(64);
ALTER TABLE ipn_history ADD gateway_credit_id varchar(64);
ALTER TABLE ipn_history ADD admin_payment_class varchar(128);

-- Table for refunds
DROP TABLE kk_order_refunds;
CREATE TABLE kk_order_refunds (
  order_refunds_id INTEGER NOT NULL,
  orders_id INTEGER NOT NULL,
  ipn_history_id int,
  orders_number VARCHAR(128),
  refund_note VARCHAR(4000),
  refund_amount decimal(15,4),
  gateway_credit_id VARCHAR(64),
  notify_customer INTEGER DEFAULT 0,
  refund_status INTEGER DEFAULT 0,
  date_added TIMESTAMP,
  last_modified TIMESTAMP,
  store_id VARCHAR(64),
  custom1 VARCHAR(128),
  custom2 VARCHAR(128),
  custom3 VARCHAR(128),
  custom1Dec decimal(15,4),
  custom2Dec decimal(15,4),
  PRIMARY KEY(order_refunds_id)
);
DROP SEQUENCE kk_order_refunds_SEQ;
CREATE SEQUENCE kk_order_refunds_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

-- Panel for Refunds
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq, 'kk_panel_refunds','Order Refunds', current timestamp);
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq, 'kk_panel_refundsFromOrders','Order Refunds For Order', current timestamp);

-- Add Refunds Panels access to all roles that can access the Order panel
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, current timestamp, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_orders' and p2.code='kk_panel_refunds';
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, current timestamp, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_orders' and p2.code='kk_panel_refundsFromOrders';

-- API calls for Refunds
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'editOrderRefund','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'insertOrderRefund','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'deleteOrderRefund','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getOrderRefund','', current timestamp);

-- Add a new order status. Needs to have id = 9. Languages may not be applicable for your current setup.
--DELETE FROM orders_status WHERE orders_status_id = 9;
--INSERT INTO orders_status(orders_status_id, language_id, orders_status_name) VALUES (9,(SELECT languages_id FROM languages WHERE code = 'en'),'Refund Approved');
--INSERT INTO orders_status(orders_status_id, language_id, orders_status_name) VALUES (9,(SELECT languages_id FROM languages WHERE code = 'de'),'R�ckerstattung Genehmigt');
--INSERT INTO orders_status(orders_status_id, language_id, orders_status_name) VALUES (9,(SELECT languages_id FROM languages WHERE code = 'es'),'Reembolso Aprobado');
--INSERT INTO orders_status(orders_status_id, language_id, orders_status_name) VALUES (9,(SELECT languages_id FROM languages WHERE code = 'pt'),'Reembolso Aprovado');

-- Add a new order status. Needs to have id = 10. Languages may not be applicable for your current setup.
--DELETE FROM orders_status WHERE orders_status_id = 10;
--INSERT INTO orders_status(orders_status_id, language_id, orders_status_name) VALUES (10,(SELECT languages_id FROM languages WHERE code = 'en'),'Refund Declined');
--INSERT INTO orders_status(orders_status_id, language_id, orders_status_name) VALUES (10,(SELECT languages_id FROM languages WHERE code = 'de'),'R�ckerstattung Abgelehnt');
--INSERT INTO orders_status(orders_status_id, language_id, orders_status_name) VALUES (10,(SELECT languages_id FROM languages WHERE code = 'es'),'Reembolso Rehus�');
--INSERT INTO orders_status(orders_status_id, language_id, orders_status_name) VALUES (10,(SELECT languages_id FROM languages WHERE code = 'pt'),'Reembolso Recusado');

-- Add new product option types
ALTER TABLE customers_basket_attrs ADD customer_price DECIMAL(15,2);
ALTER TABLE customers_basket_attrs ADD customer_string VARCHAR(512);
ALTER TABLE orders_products_attributes ADD customer_price DECIMAL(15,2);
ALTER TABLE orders_products_attributes ADD customer_string VARCHAR(512);

-- Table for KonaKart Events
DROP TABLE kk_event;
CREATE TABLE kk_event (
  kk_event_id INTEGER NOT NULL,
  kk_event_code INTEGER NOT NULL,
  kk_event_subcode INT,
  kk_event_value VARCHAR(64),
  store_id VARCHAR(64),
  custom1 VARCHAR(64),
  date_added TIMESTAMP,
  PRIMARY KEY(kk_event_id)
);
DROP SEQUENCE kk_event_SEQ;
CREATE SEQUENCE kk_event_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

-- API calls for KonaKart Events
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'insertKKEvent','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getKKEvents','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'deleteKKEvents','', current timestamp);

-- Configuration variable to enable/disable Product Caching
DELETE FROM configuration WHERE configuration_key = 'CACHE_PRODUCTS';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api, store_id) SELECT nextval for configuration_seq, 'Cache Products','CACHE_PRODUCTS','true','Set to true to Cache Products in memory.',11, 15, 'choice(''true'', ''false'')', current timestamp, 1, store_id FROM configuration WHERE configuration_key = 'STORE_COUNTRY';

-- Configuration variable to enable/disable Product Image Name Caching
DELETE FROM configuration WHERE configuration_key = 'CACHE_PRODUCT_IMAGES';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api, store_id) SELECT nextval for configuration_seq, 'Cache Product Images','CACHE_PRODUCT_IMAGES','true','Set to true to Cache Product Image Names in memory.',11, 20, 'choice(''true'', ''false'')', current timestamp, 1, store_id FROM configuration WHERE configuration_key = 'STORE_COUNTRY';

-- New Custom Panels
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq, 'kk_panel_customA','Custom Panel A', current timestamp);
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq, 'kk_panel_customB','Custom Panel B', current timestamp);
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq, 'kk_panel_customC','Custom Panel C', current timestamp);
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq, 'kk_panel_customD','Custom Panel D', current timestamp);
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq, 'kk_panel_customE','Custom Panel E', current timestamp);
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq, 'kk_panel_customF','Custom Panel F', current timestamp);
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq, 'kk_panel_customG','Custom Panel G', current timestamp);
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq, 'kk_panel_customH','Custom Panel H', current timestamp);
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq, 'kk_panel_customI','Custom Panel I', current timestamp);
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq, 'kk_panel_customJ','Custom Panel J', current timestamp);

-- Set up Custom Panels A-D as examples
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, current timestamp, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_products' and p2.code='kk_panel_customA';
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, current timestamp, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_products' and p2.code='kk_panel_customB';
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, current timestamp, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_orders' and p2.code='kk_panel_customC';
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, current timestamp, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_promotions' and p2.code='kk_panel_customD';
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, current timestamp, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_refreshCache' and p2.code='kk_panel_customE';

-- Table for Shippers
DROP TABLE kk_shipper;
CREATE TABLE kk_shipper (
  shipper_id INTEGER NOT NULL,
  name VARCHAR(64) NOT NULL,
  tracking_url VARCHAR(255),
  date_added TIMESTAMP,
  store_id VARCHAR(64),
  custom1 VARCHAR(128),
  custom2 VARCHAR(128),
  custom3 VARCHAR(128),
  PRIMARY KEY(shipper_id)
);
DROP SEQUENCE kk_shipper_SEQ;
CREATE SEQUENCE kk_shipper_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

-- Panel for Shippers
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq, 'kk_panel_shippers','Shippers', current timestamp);

-- Add Shippers Panel access to all roles that can access the Order status panel
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, current timestamp, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_orderStatuses' and p2.code='kk_panel_shippers';

-- API calls for Shippers
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'updateShipper','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'insertShipper','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getShippers','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getShipper','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'deleteShipper','', current timestamp);

-- Virtual kk_panel_customerForReview_2 Panel
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq, 'kk_panel_customerForReview_2', 'Customer From Reviews 2', current timestamp);

-- Add Panel access to all roles that can access the kk_panel_customerForReview panel
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, current timestamp, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_customerForReview' and p2.code='kk_panel_customerForReview_2';

-- Add custom privileges for kk_panel_customerForReview_2 panel
UPDATE kk_role_to_panel SET custom1=0, custom1_desc='Set to Access Invisible Customers' WHERE panel_id IN (SELECT panel_id FROM kk_panel where code='kk_panel_customerForReview_2');
UPDATE kk_role_to_panel SET custom2=0, custom2_desc='If set reviews button is hidden' WHERE panel_id IN (SELECT panel_id FROM kk_panel where code='kk_panel_customerForReview_2');
UPDATE kk_role_to_panel SET custom3=0, custom3_desc='If set custom button is hidden' WHERE panel_id IN (SELECT panel_id FROM kk_panel where code='kk_panel_customerForReview_2');

-- Add custom privileges for the kk_panel_customerForReview panel
UPDATE kk_role_to_panel SET custom1=0, custom1_desc='If set email is disabled' WHERE panel_id IN (SELECT panel_id FROM kk_panel where code='kk_panel_customerForReview');
UPDATE kk_role_to_panel SET custom2=0, custom2_desc='If set cannot reset password' WHERE panel_id IN (SELECT panel_id FROM kk_panel where code='kk_panel_customerForReview');
UPDATE kk_role_to_panel SET custom3=0, custom3_desc='If set customer search droplists are disabled' WHERE panel_id IN (SELECT panel_id FROM kk_panel where code='kk_panel_customerForReview');
UPDATE kk_role_to_panel SET custom4=0, custom4_desc='If set login button is hidden' WHERE panel_id IN (SELECT panel_id FROM kk_panel where code='kk_panel_customerForReview');
UPDATE kk_role_to_panel SET custom5=0, custom5_desc='If set addresses button is hidden' WHERE panel_id IN (SELECT panel_id FROM kk_panel where code='kk_panel_customerForReview');

-- Tables for order shipments
DROP TABLE kk_order_shipments;
CREATE TABLE kk_order_shipments (
  order_shipment_id INTEGER NOT NULL,
  order_id INTEGER NOT NULL,
  store_id VARCHAR(64),
  order_number VARCHAR(128),
  shipper_name VARCHAR(64),
  shipper_id int,
  tracking_number VARCHAR(64),
  tracking_url VARCHAR(255),
  custom1 VARCHAR(128),
  custom2 VARCHAR(128),
  custom3 VARCHAR(128),
  shipment_notes VARCHAR(4000),
  date_added TIMESTAMP,
  last_modified TIMESTAMP,
  PRIMARY KEY(order_shipment_id)
);
DROP SEQUENCE kk_order_shipments_SEQ;
CREATE SEQUENCE kk_order_shipments_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

DROP TABLE kk_shipments_to_ord_prods;
CREATE TABLE kk_shipments_to_ord_prods (
  order_shipment_id INTEGER NOT NULL,
  order_product_id INTEGER NOT NULL,
  store_id VARCHAR(64),
  quantity INTEGER NOT NULL,
  date_added TIMESTAMP,
  PRIMARY KEY(order_shipment_id, order_product_id)
);

-- Panel for Shipments
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq, 'kk_panel_shipments','Order Shipments', current timestamp);
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq, 'kk_panel_shipmentsFromOrders','Shipments from Orders Panel', current timestamp);

-- Add Shipments Panel access to all roles that can access the Order returns panel
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, current timestamp, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_returns' and p2.code='kk_panel_shipments';
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, current timestamp, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_returnsFromOrders' and p2.code='kk_panel_shipmentsFromOrders';

-- API calls for Shipments
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getOrderShipments','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'insertOrderShipment','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'editOrderShipment','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'deleteOrderShipment','', current timestamp);

-- New table for allowing miscellaneous prices to be associated to a product
DROP TABLE kk_misc_price;
CREATE TABLE kk_misc_price (
  kk_misc_price_id INTEGER NOT NULL,
  store_id VARCHAR(64),
  product_id INTEGER NOT NULL,
  price_id VARCHAR(128) NOT NULL,
  price_0 decimal(15,4),
  price_1 decimal(15,4),
  price_2 decimal(15,4),
  price_3 decimal(15,4),
  quantity int,
  custom1 VARCHAR(256),
  custom2 VARCHAR(128),
  custom3 VARCHAR(128),
  custom4 VARCHAR(128),
  custom5 VARCHAR(128),
  date_added TIMESTAMP,
  last_updated TIMESTAMP,
  PRIMARY KEY(kk_misc_price_id)
);
DROP SEQUENCE kk_misc_price_SEQ;
CREATE SEQUENCE kk_misc_price_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

CREATE INDEX i_pr_8002e79fd87af ON kk_misc_price (product_id);
CREATE INDEX i_st_8002e79fd87af ON kk_misc_price (store_id);

-- New MiscPrices APIs
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'insertMiscPrices', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'deleteMiscPrices', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getMiscPrices', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'updateMiscPrices', '', current timestamp);

-- Order Status Name Table change
-- First we'll create a temporary table to store the current data

DROP TABLE orders_status_temp;
CREATE TABLE orders_status_temp (
  orders_status_id INTEGER DEFAULT 0 NOT NULL,
  language_id INTEGER DEFAULT 1 NOT NULL,
  orders_status_name VARCHAR(32) NOT NULL,
  store_id VARCHAR(64),
  notify_customer INTEGER DEFAULT 0,
  PRIMARY KEY(orders_status_id, language_id)
);

-- Copy current data to the temporary table

INSERT INTO orders_status_temp (orders_status_id, language_id, orders_status_name, store_id, notify_customer) SELECT orders_status_id, language_id, orders_status_name, store_id, notify_customer FROM orders_status;

-- Now we can drop the old order_status table

DROP TABLE orders_status;

-- Next re-create the order_status table to introduce non semantic key
CREATE TABLE orders_status (
  orders_status_pk INTEGER NOT NULL,
  store_id VARCHAR(64),
  orders_status_id INTEGER DEFAULT 0 NOT NULL,
  language_id INTEGER DEFAULT 1 NOT NULL,
  orders_status_name VARCHAR(32) NOT NULL,
  notify_customer INTEGER DEFAULT 0,
  PRIMARY KEY(orders_status_pk)
);
DROP SEQUENCE orders_status_SEQ;
CREATE SEQUENCE orders_status_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

-- Populate the new orders_status table with the data we saved in the orders_status_temp table

INSERT INTO orders_status (orders_status_pk, orders_status_id, language_id, orders_status_name, store_id, notify_customer) SELECT nextval for orders_status_seq, orders_status_id, language_id, orders_status_name, store_id, notify_customer FROM orders_status_temp;

-- Finally remove the orders_status_temp table

DROP TABLE orders_status_temp;

-- Control for SOLR suggested search and spelling
DELETE FROM configuration WHERE configuration_key = 'SOLR_ADD_TERM_IF_INVISIBLE';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api, store_id) SELECT nextval for configuration_seq, 'Add suggested search for invisible prods.','SOLR_ADD_TERM_IF_INVISIBLE','true','Adds a suggested search entry even when products are invisible',24, 5, 'choice(''true'', ''false'')', current timestamp, 0, store_id FROM configuration WHERE configuration_key = 'STORE_COUNTRY';
DELETE FROM configuration WHERE configuration_key = 'SOLR_ADD_TERM_IF_DISABLED';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api, store_id) SELECT nextval for configuration_seq, 'Add suggested search for disabled prods.','SOLR_ADD_TERM_IF_DISABLED','true','Adds a suggested search entry even when products are disabled',24, 5, 'choice(''true'', ''false'')', current timestamp, 0, store_id FROM configuration WHERE configuration_key = 'STORE_COUNTRY';

DELETE FROM configuration WHERE configuration_key = 'SOLR_ENABLE_SPELLING_SUGGESTION';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api, store_id) SELECT nextval for configuration_seq, 'Enable spelling suggestions','SOLR_ENABLE_SPELLING_SUGGESTION','true','Enables spelling suggestion functionality',24, 20, 'choice(''true'', ''false'')', current timestamp, 1, store_id FROM configuration WHERE configuration_key = 'STORE_COUNTRY';
DELETE FROM configuration WHERE configuration_key = 'SOLR_ADD_SPELLING_IF_INVISIBLE';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api, store_id) SELECT nextval for configuration_seq, 'Add spelling data for invisible prods.','SOLR_ADD_SPELLING_IF_INVISIBLE','true','Adds data used for spelling suggestions even when products are invisible',24, 21, 'choice(''true'', ''false'')', current timestamp, 0, store_id FROM configuration WHERE configuration_key = 'STORE_COUNTRY';
DELETE FROM configuration WHERE configuration_key = 'SOLR_ADD_SPELLING_IF_DISABLED';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api, store_id) SELECT nextval for configuration_seq, 'Add spelling data for disabled prods.','SOLR_ADD_SPELLING_IF_DISABLED','true','Adds data used for spelling suggestions even when products are disabled',24, 22, 'choice(''true'', ''false'')', current timestamp, 0, store_id FROM configuration WHERE configuration_key = 'STORE_COUNTRY';

-- Add sort order to product attributes
ALTER TABLE products_attributes ADD sort_order int DEFAULT 0;

-- Set a description on the EditProduct Panel custom1 field for assigning products to stores
UPDATE kk_role_to_panel SET custom1=0, custom1_desc='Set to allow assignment of products to stores' WHERE panel_id IN (SELECT panel_id FROM kk_panel where code='kk_panel_editProduct');

-- Allow super-users to assign products to stores
UPDATE kk_role_to_panel SET custom1=1 WHERE panel_id IN (SELECT panel_id FROM kk_panel where code='kk_panel_editProduct') AND role_id IN (SELECT role_id FROM kk_role where super_user=1);




exit;
