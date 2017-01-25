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
-- KonaKart upgrade database script for Oracle
-- From version 7.1.1.0 to version 7.2.0.0
-- -----------------------------------------------------------
-- In order to upgrade from versions prior to 7.1.1.0, the upgrade
-- scripts must be run sequentially.
-- 
set escape \
-- Comment out the next 'Alter session' line if using 11gR1 or earlier
Alter session set deferred_segment_creation=false;


-- Set database version information
set echo on
INSERT INTO kk_config (kk_config_id, kk_config_key, kk_config_value, date_added) VALUES (kk_config_seq.nextval, 'HISTORY', '7.2.0.0 U', sysdate);
UPDATE kk_config SET kk_config_value='7.2.0.0 Oracle', date_added=sysdate WHERE kk_config_key='VERSION';

-- Database Table/Column Modifications

BEGIN EXECUTE IMMEDIATE 'DROP TABLE prod_opt_vals_to_prod_opt'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
ALTER TABLE products_options_values_to RENAME TO prod_opt_vals_to_prod_opt;

BEGIN EXECUTE IMMEDIATE 'DROP TABLE products_attrs_download'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
ALTER TABLE products_attributes_downlo RENAME TO products_attrs_download;

BEGIN EXECUTE IMMEDIATE 'DROP TABLE customers_basket_attrs'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
ALTER TABLE customers_basket_attribute RENAME TO customers_basket_attrs;

ALTER TABLE configuration_group RENAME COLUMN configuration_group_descriptio TO configuration_group_desc;

ALTER TABLE customers_info RENAME COLUMN customers_info_date_of_last_lo TO customers_info_date_last_logon;
ALTER TABLE customers_info RENAME COLUMN customers_info_date_account_cr TO customers_info_date_created;
ALTER TABLE customers_info RENAME COLUMN customers_info_date_account_la TO customers_info_date_modified;

ALTER TABLE prod_opt_vals_to_prod_opt RENAME COLUMN products_options_values_to_pro TO prod_opt_vals_to_prod_opt_id;


-- For Oracle Only - Change sequence names
BEGIN EXECUTE IMMEDIATE 'DROP SEQUENCE prod_opt_vals_to_prod_opt_seq'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
RENAME products_options_values_to_seq TO prod_opt_vals_to_prod_opt_seq;
BEGIN EXECUTE IMMEDIATE 'DROP SEQUENCE customers_basket_attrs_seq'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
RENAME customers_basket_attribute_seq TO customers_basket_attrs_seq;


-- Add some extra fields to the ipn_history table
ALTER TABLE ipn_history ADD gateway_capture_id varchar(64);
ALTER TABLE ipn_history ADD gateway_credit_id varchar(64);
ALTER TABLE ipn_history ADD admin_payment_class varchar(128);

-- Table for refunds
BEGIN EXECUTE IMMEDIATE 'DROP TABLE kk_order_refunds'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE kk_order_refunds (
  order_refunds_id NUMBER(10,0) NOT NULL,
  orders_id NUMBER(10,0) NOT NULL,
  ipn_history_id int,
  orders_number VARCHAR2(128),
  refund_note VARCHAR2(4000),
  refund_amount NUMBER(15,4),
  gateway_credit_id VARCHAR2(64),
  notify_customer NUMBER(10,0) DEFAULT 0,
  refund_status NUMBER(10,0) DEFAULT 0,
  date_added TIMESTAMP,
  last_modified TIMESTAMP,
  store_id VARCHAR2(64),
  custom1 VARCHAR2(128),
  custom2 VARCHAR2(128),
  custom3 VARCHAR2(128),
  custom1Dec NUMBER(15,4),
  custom2Dec NUMBER(15,4),
  PRIMARY KEY(order_refunds_id)
);
BEGIN EXECUTE IMMEDIATE 'DROP SEQUENCE kk_order_refunds_SEQ'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE SEQUENCE kk_order_refunds_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

-- Panel for Refunds
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval, 'kk_panel_refunds','Order Refunds', sysdate);
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval, 'kk_panel_refundsFromOrders','Order Refunds For Order', sysdate);

-- Add Refunds Panels access to all roles that can access the Order panel
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, sysdate, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_orders' and p2.code='kk_panel_refunds';
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, sysdate, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_orders' and p2.code='kk_panel_refundsFromOrders';

-- API calls for Refunds
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'editOrderRefund','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'insertOrderRefund','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'deleteOrderRefund','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'getOrderRefund','', sysdate);

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
BEGIN EXECUTE IMMEDIATE 'DROP TABLE kk_event'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE kk_event (
  kk_event_id NUMBER(10,0) NOT NULL,
  kk_event_code NUMBER(10,0) NOT NULL,
  kk_event_subcode INT,
  kk_event_value VARCHAR2(64),
  store_id VARCHAR2(64),
  custom1 VARCHAR2(64),
  date_added TIMESTAMP,
  PRIMARY KEY(kk_event_id)
);
CREATE INDEX idx_kk_event_date_added ON kk_event (date_added);
BEGIN EXECUTE IMMEDIATE 'DROP SEQUENCE kk_event_SEQ'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE SEQUENCE kk_event_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

-- API calls for KonaKart Events
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'insertKKEvent','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'getKKEvents','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'deleteKKEvents','', sysdate);

-- Configuration variable to enable/disable Product Caching
DELETE FROM configuration WHERE configuration_key = 'CACHE_PRODUCTS';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api, store_id) SELECT configuration_seq.nextval, 'Cache Products','CACHE_PRODUCTS','true','Set to true to Cache Products in memory.','11', '15', 'choice(''true'', ''false'')', sysdate, '1', store_id FROM configuration WHERE configuration_key = 'STORE_COUNTRY';

-- Configuration variable to enable/disable Product Image Name Caching
DELETE FROM configuration WHERE configuration_key = 'CACHE_PRODUCT_IMAGES';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api, store_id) SELECT configuration_seq.nextval, 'Cache Product Images','CACHE_PRODUCT_IMAGES','true','Set to true to Cache Product Image Names in memory.','11', '20', 'choice(''true'', ''false'')', sysdate, '1', store_id FROM configuration WHERE configuration_key = 'STORE_COUNTRY';

-- New Custom Panels
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval, 'kk_panel_customA','Custom Panel A', sysdate);
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval, 'kk_panel_customB','Custom Panel B', sysdate);
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval, 'kk_panel_customC','Custom Panel C', sysdate);
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval, 'kk_panel_customD','Custom Panel D', sysdate);
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval, 'kk_panel_customE','Custom Panel E', sysdate);
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval, 'kk_panel_customF','Custom Panel F', sysdate);
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval, 'kk_panel_customG','Custom Panel G', sysdate);
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval, 'kk_panel_customH','Custom Panel H', sysdate);
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval, 'kk_panel_customI','Custom Panel I', sysdate);
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval, 'kk_panel_customJ','Custom Panel J', sysdate);

-- Set up Custom Panels A-D as examples
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, sysdate, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_products' and p2.code='kk_panel_customA';
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, sysdate, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_products' and p2.code='kk_panel_customB';
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, sysdate, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_orders' and p2.code='kk_panel_customC';
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, sysdate, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_promotions' and p2.code='kk_panel_customD';
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, sysdate, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_refreshCache' and p2.code='kk_panel_customE';

-- Table for Shippers
BEGIN EXECUTE IMMEDIATE 'DROP TABLE kk_shipper'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE kk_shipper (
  shipper_id NUMBER(10,0) NOT NULL,
  name VARCHAR2(64) NOT NULL,
  tracking_url VARCHAR2(255),
  date_added TIMESTAMP,
  store_id VARCHAR2(64),
  custom1 VARCHAR2(128),
  custom2 VARCHAR2(128),
  custom3 VARCHAR2(128),
  PRIMARY KEY(shipper_id)
);
BEGIN EXECUTE IMMEDIATE 'DROP SEQUENCE kk_shipper_SEQ'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE SEQUENCE kk_shipper_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

-- Panel for Shippers
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval, 'kk_panel_shippers','Shippers', sysdate);

-- Add Shippers Panel access to all roles that can access the Order status panel
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, sysdate, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_orderStatuses' and p2.code='kk_panel_shippers';

-- API calls for Shippers
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'updateShipper','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'insertShipper','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'getShippers','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'getShipper','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'deleteShipper','', sysdate);

-- Virtual kk_panel_customerForReview_2 Panel
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval, 'kk_panel_customerForReview_2', 'Customer From Reviews 2', sysdate);

-- Add Panel access to all roles that can access the kk_panel_customerForReview panel
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, sysdate, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_customerForReview' and p2.code='kk_panel_customerForReview_2';

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
BEGIN EXECUTE IMMEDIATE 'DROP TABLE kk_order_shipments'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE kk_order_shipments (
  order_shipment_id NUMBER(10,0) NOT NULL,
  order_id NUMBER(10,0) NOT NULL,
  store_id VARCHAR2(64),
  order_number VARCHAR2(128),
  shipper_name VARCHAR2(64),
  shipper_id int,
  tracking_number VARCHAR2(64),
  tracking_url VARCHAR2(255),
  custom1 VARCHAR2(128),
  custom2 VARCHAR2(128),
  custom3 VARCHAR2(128),
  shipment_notes VARCHAR2(4000),
  date_added TIMESTAMP,
  last_modified TIMESTAMP,
  PRIMARY KEY(order_shipment_id)
);
BEGIN EXECUTE IMMEDIATE 'DROP SEQUENCE kk_order_shipments_SEQ'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE SEQUENCE kk_order_shipments_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

BEGIN EXECUTE IMMEDIATE 'DROP TABLE kk_shipments_to_ord_prods'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE kk_shipments_to_ord_prods (
  order_shipment_id NUMBER(10,0) NOT NULL,
  order_product_id NUMBER(10,0) NOT NULL,
  store_id VARCHAR2(64),
  quantity NUMBER(10,0) NOT NULL,
  date_added TIMESTAMP,
  PRIMARY KEY(order_shipment_id, order_product_id)
);

-- Panel for Shipments
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval, 'kk_panel_shipments','Order Shipments', sysdate);
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval, 'kk_panel_shipmentsFromOrders','Shipments from Orders Panel', sysdate);

-- Add Shipments Panel access to all roles that can access the Order returns panel
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, sysdate, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_returns' and p2.code='kk_panel_shipments';
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, sysdate, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_returnsFromOrders' and p2.code='kk_panel_shipmentsFromOrders';

-- API calls for Shipments
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'getOrderShipments','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'insertOrderShipment','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'editOrderShipment','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'deleteOrderShipment','', sysdate);

-- New table for allowing miscellaneous prices to be associated to a product
BEGIN EXECUTE IMMEDIATE 'DROP TABLE kk_misc_price'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE kk_misc_price (
  kk_misc_price_id NUMBER(10,0) NOT NULL,
  store_id VARCHAR2(64),
  product_id NUMBER(10,0) NOT NULL,
  price_id VARCHAR2(128) NOT NULL,
  price_0 NUMBER(15,4),
  price_1 NUMBER(15,4),
  price_2 NUMBER(15,4),
  price_3 NUMBER(15,4),
  quantity int,
  custom1 VARCHAR2(256),
  custom2 VARCHAR2(128),
  custom3 VARCHAR2(128),
  custom4 VARCHAR2(128),
  custom5 VARCHAR2(128),
  date_added TIMESTAMP,
  last_updated TIMESTAMP,
  PRIMARY KEY(kk_misc_price_id)
);
BEGIN EXECUTE IMMEDIATE 'DROP SEQUENCE kk_misc_price_SEQ'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE SEQUENCE kk_misc_price_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

CREATE INDEX i_product_id_kk_misc_price ON kk_misc_price (product_id);
CREATE INDEX i_store_id_kk_misc_price ON kk_misc_price (store_id);

-- New MiscPrices APIs
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'insertMiscPrices', '', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'deleteMiscPrices', '', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'getMiscPrices', '', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'updateMiscPrices', '', sysdate);

-- Order Status Name Table change
-- First we'll create a temporary table to store the current data

BEGIN EXECUTE IMMEDIATE 'DROP TABLE orders_status_temp'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE orders_status_temp (
  orders_status_id NUMBER(10,0) DEFAULT 0 NOT NULL,
  language_id NUMBER(10,0) DEFAULT 1 NOT NULL,
  orders_status_name VARCHAR2(32) NOT NULL,
  store_id VARCHAR2(64),
  notify_customer NUMBER(10,0) DEFAULT 0,
  PRIMARY KEY(orders_status_id, language_id)
);

-- Copy current data to the temporary table

INSERT INTO orders_status_temp (orders_status_id, language_id, orders_status_name, store_id, notify_customer) SELECT orders_status_id, language_id, orders_status_name, store_id, notify_customer FROM orders_status;

-- Now we can drop the old order_status table

BEGIN EXECUTE IMMEDIATE 'DROP TABLE orders_status'; EXCEPTION WHEN OTHERS THEN NULL; END;
/

-- Next re-create the order_status table to introduce non semantic key
CREATE TABLE orders_status (
  orders_status_pk NUMBER(10,0) NOT NULL,
  store_id VARCHAR2(64),
  orders_status_id NUMBER(10,0) DEFAULT 0 NOT NULL,
  language_id NUMBER(10,0) DEFAULT 1 NOT NULL,
  orders_status_name VARCHAR2(32) NOT NULL,
  notify_customer NUMBER(10,0) DEFAULT 0,
  PRIMARY KEY(orders_status_pk)
);
CREATE INDEX idx_orders_status_name ON orders_status (orders_status_name);
BEGIN EXECUTE IMMEDIATE 'DROP SEQUENCE orders_status_SEQ'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE SEQUENCE orders_status_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

-- Populate the new orders_status table with the data we saved in the orders_status_temp table

INSERT INTO orders_status (orders_status_pk, orders_status_id, language_id, orders_status_name, store_id, notify_customer) SELECT orders_status_seq.nextval, orders_status_id, language_id, orders_status_name, store_id, notify_customer FROM orders_status_temp;

-- Finally remove the orders_status_temp table

BEGIN EXECUTE IMMEDIATE 'DROP TABLE orders_status_temp'; EXCEPTION WHEN OTHERS THEN NULL; END;
/

-- Control for SOLR suggested search and spelling
DELETE FROM configuration WHERE configuration_key = 'SOLR_ADD_TERM_IF_INVISIBLE';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api, store_id) SELECT configuration_seq.nextval, 'Add suggested search for invisible prods.','SOLR_ADD_TERM_IF_INVISIBLE','true','Adds a suggested search entry even when products are invisible','24', '5', 'choice(''true'', ''false'')', sysdate, '0', store_id FROM configuration WHERE configuration_key = 'STORE_COUNTRY';
DELETE FROM configuration WHERE configuration_key = 'SOLR_ADD_TERM_IF_DISABLED';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api, store_id) SELECT configuration_seq.nextval, 'Add suggested search for disabled prods.','SOLR_ADD_TERM_IF_DISABLED','true','Adds a suggested search entry even when products are disabled','24', '5', 'choice(''true'', ''false'')', sysdate, '0', store_id FROM configuration WHERE configuration_key = 'STORE_COUNTRY';

DELETE FROM configuration WHERE configuration_key = 'SOLR_ENABLE_SPELLING_SUGGESTION';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api, store_id) SELECT configuration_seq.nextval, 'Enable spelling suggestions','SOLR_ENABLE_SPELLING_SUGGESTION','true','Enables spelling suggestion functionality','24', '20', 'choice(''true'', ''false'')', sysdate, '1', store_id FROM configuration WHERE configuration_key = 'STORE_COUNTRY';
DELETE FROM configuration WHERE configuration_key = 'SOLR_ADD_SPELLING_IF_INVISIBLE';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api, store_id) SELECT configuration_seq.nextval, 'Add spelling data for invisible prods.','SOLR_ADD_SPELLING_IF_INVISIBLE','true','Adds data used for spelling suggestions even when products are invisible','24', '21', 'choice(''true'', ''false'')', sysdate, '0', store_id FROM configuration WHERE configuration_key = 'STORE_COUNTRY';
DELETE FROM configuration WHERE configuration_key = 'SOLR_ADD_SPELLING_IF_DISABLED';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api, store_id) SELECT configuration_seq.nextval, 'Add spelling data for disabled prods.','SOLR_ADD_SPELLING_IF_DISABLED','true','Adds data used for spelling suggestions even when products are disabled','24', '22', 'choice(''true'', ''false'')', sysdate, '0', store_id FROM configuration WHERE configuration_key = 'STORE_COUNTRY';

-- Add sort order to product attributes
ALTER TABLE products_attributes ADD sort_order int DEFAULT '0';

-- Set a description on the EditProduct Panel custom1 field for assigning products to stores
UPDATE kk_role_to_panel SET custom1=0, custom1_desc='Set to allow assignment of products to stores' WHERE panel_id IN (SELECT panel_id FROM kk_panel where code='kk_panel_editProduct');

-- Allow super-users to assign products to stores
UPDATE kk_role_to_panel SET custom1=1 WHERE panel_id IN (SELECT panel_id FROM kk_panel where code='kk_panel_editProduct') AND role_id IN (SELECT role_id FROM kk_role where super_user=1);




exit;
