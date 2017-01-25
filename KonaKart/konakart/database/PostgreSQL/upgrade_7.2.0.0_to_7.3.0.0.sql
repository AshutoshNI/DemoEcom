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
-- KonaKart upgrade database script for PostgreSQL
-- From version 7.2.0.0 to version 7.3.0.0
-- -----------------------------------------------------------
-- In order to upgrade from versions prior to 7.2.0.0, the upgrade
-- scripts must be run sequentially.
-- 

-- Set database version information
INSERT INTO kk_config (kk_config_key, kk_config_value, date_added) VALUES ('HISTORY', '7.3.0.0 U', now());
UPDATE kk_config SET kk_config_value='7.3.0.0 PostgreSQL', date_added=now() WHERE kk_config_key='VERSION';

DROP TABLE IF EXISTS kk_cust_pwd_hist;
CREATE TABLE kk_cust_pwd_hist (
   id SERIAL,
   cust_id INTEGER NOT NULL,
   password VARCHAR(40),
   date_created TIMESTAMP,
   custom1 VARCHAR(128),
   PRIMARY KEY (id)
);
CREATE INDEX idx_kk_cust_pwd_hist_cust_id ON kk_cust_pwd_hist (cust_id);

INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (DEFAULT,'changeUserPassword', '', now());
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (DEFAULT,'checkPasswordValidity', '', now());

-- For Enabling "Other" Gender
DELETE FROM configuration WHERE configuration_key = 'ENABLE_OTHER_GENDER';
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api, store_id) SELECT 'Enable "Other" Gender', 'ENABLE_OTHER_GENDER', 'false', 'Enable "Other" gender in addition to Male and Female', '5', '1', 'choice(''true'', ''false'')', now(), '1', store_id FROM configuration WHERE configuration_key = 'STORE_COUNTRY';

-- Removal of Publish Products and Google Base/Shopping
DROP TABLE IF EXISTS kk_product_feed;
DELETE FROM configuration WHERE configuration_key = 'GOOGLE_DATA_ENABLED';
DELETE FROM configuration WHERE configuration_key = 'GOOGLE_API_KEY';
DELETE FROM configuration WHERE configuration_key = 'GOOGLE_DATA_USERNAME';
DELETE FROM configuration WHERE configuration_key = 'GOOGLE_DATA_PASSWORD';
DELETE FROM configuration WHERE configuration_key = 'GOOGLE_DATA_LOCATION';
DELETE FROM configuration WHERE configuration_key = 'GOOGLE_DATA_ACCOUNT_ID';
DELETE FROM configuration WHERE configuration_key = 'GOOGLE_PRODUCT_LINK';
DELETE FROM configuration WHERE configuration_key = 'GOOGLE_DATA_ACCOUNT_ID';

-- Remove Access to Data Feeds for all roles
DELETE FROM kk_role_to_panel WHERE panel_id = (SELECT panel_id FROM kk_panel WHERE code = 'kk_panel_dataFeeds');
DELETE FROM kk_role_to_panel WHERE panel_id = (SELECT panel_id FROM kk_panel WHERE code = 'kk_panel_publishProducts');

-- Remove Data Feeds and Publish Products Panels
DELETE FROM kk_panel WHERE code = 'kk_panel_dataFeeds';
DELETE FROM kk_panel WHERE code = 'kk_panel_publishProducts';

-- Add some extra fields to the customers table
ALTER TABLE customers ADD tax_identifier varchar(64);
ALTER TABLE customers ADD tax_exemption varchar(64);
ALTER TABLE customers ADD tax_entity varchar(64);
ALTER TABLE customers ADD ext_reference_1 varchar(64);
ALTER TABLE customers ADD ext_reference_2 varchar(64);

-- Config variable for displaying tax id
DELETE FROM configuration WHERE configuration_key = 'ACCOUNT_TAX_ID';
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api, store_id) SELECT 'Tax Id','ACCOUNT_TAX_ID','false','Display tax id in the customers account','5', '3', 'choice(''true'', ''false'')', now(), '1', store_id FROM configuration WHERE configuration_key = 'STORE_COUNTRY';

-- Remove configuration of the edit customer panel to allow editing of external customers only
UPDATE kk_role_to_panel SET custom1='0', custom1_desc=null WHERE panel_id in (select panel_id from kk_panel WHERE code='kk_panel_editCustomer');

-- For specifying whether or not to Cache Bundle Products
DELETE FROM configuration WHERE configuration_key = 'CACHE_BUNDLE_PRODUCTS';
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api, store_id) SELECT 'Cache Bundle Products','CACHE_BUNDLE_PRODUCTS','false','If true bundle products are cached; if false they are never cached','11', '25', 'choice(''true'', ''false'')', now(), '1', store_id FROM configuration WHERE configuration_key = 'STORE_COUNTRY';

-- For specifying whether or not to Create Product Viewed Events
DELETE FROM configuration WHERE configuration_key = 'CREATE_PRODUCT_VIEWED_EVENTS';
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api, store_id) SELECT 'Create Product Viewed Events','CREATE_PRODUCT_VIEWED_EVENTS','false','If true product viewed events are created; if false they are not.','11', '27', 'choice(''true'', ''false'')', now(), '1', store_id FROM configuration WHERE configuration_key = 'STORE_COUNTRY';

-- For specifying whether or not to Create Product Quantity Events
DELETE FROM configuration WHERE configuration_key = 'CREATE_PRODUCT_QTY_EVENTS';
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api, store_id) SELECT 'Create Product Quantity Events','CREATE_PRODUCT_QTY_EVENTS','true','If true product quantity change events are created; if false they are not.','11', '29', 'choice(''true'', ''false'')', now(), '1', store_id FROM configuration WHERE configuration_key = 'STORE_COUNTRY';

-- For specifying whether or not to Create Products Orderded Events
DELETE FROM configuration WHERE configuration_key = 'CREATE_PRODUCT_ORDERED_EVENTS';
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api, store_id) SELECT 'Create Products Ordered Events','CREATE_PRODUCT_ORDERED_EVENTS','true','If true products ordered change events are created; if false they are not.','11', '32', 'choice(''true'', ''false'')', now(), '1', store_id FROM configuration WHERE configuration_key = 'STORE_COUNTRY';

-- For specifying whether or not to Create Product Review Events
DELETE FROM configuration WHERE configuration_key = 'CREATE_PRODUCT_REVIEW_EVENTS';
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api, store_id) SELECT 'Create Product Review Events','CREATE_PRODUCT_REVIEW_EVENTS','true','If true product review change events are created; if false they are not.','11', '35', 'choice(''true'', ''false'')', now(), '1', store_id FROM configuration WHERE configuration_key = 'STORE_COUNTRY';

-- For specifying whether or not to Create Product Booking Events
DELETE FROM configuration WHERE configuration_key = 'CREATE_PRODUCT_BOOKING_EVENTS';
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api, store_id) SELECT 'Create Product Booking Events','CREATE_PRODUCT_BOOKING_EVENTS','true','If true product booking change events are created; if false they are not.','11', '38', 'choice(''true'', ''false'')', now(), '1', store_id FROM configuration WHERE configuration_key = 'STORE_COUNTRY';

-- Max size of KonaKart Product cache
DELETE FROM configuration WHERE configuration_key = 'KK_PRODUCT_CACHE_MAX_SIZE';
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api, store_id) SELECT 'KonaKart Product Cache Max Size','KK_PRODUCT_CACHE_MAX_SIZE','1000','Maximum Size (maximum number of Products) in the KonaKart Product Cache','11', '46', 'integer(1,10000)', now(), '1', store_id FROM configuration WHERE configuration_key = 'STORE_COUNTRY';

-- Example config parameter for the User Defined Configuration Panel
DELETE FROM configuration WHERE configuration_key = 'USER_DEFINED_EXAMPLE';
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, return_by_api, store_id) SELECT 'Example Parameter','USER_DEFINED_EXAMPLE','Example Value','Add your own configuration parameters to group 31 to appear in the User Defined Configs Panel','31', '10', now(), '1', store_id FROM configuration WHERE configuration_key = 'STORE_COUNTRY';

INSERT INTO kk_panel (code, description, date_added) VALUES ('kk_panel_userDefinedConfig','User Defined Configurations', now());

-- Add User Defined Configurations Panel access to all roles that can access the 'kk_panel_storeConfiguration' panel
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, now(), store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_storeConfiguration' and p2.code='kk_panel_userDefinedConfig';

-- Change the key for the kk_customers_to_role table

-- Customers_to_role table
DROP TABLE IF EXISTS kk_cust_to_role_temp;
CREATE TABLE kk_cust_to_role_temp (
   ctor_id SERIAL,
   role_id INTEGER DEFAULT '0' NOT NULL,
   customers_id INTEGER DEFAULT '0' NOT NULL,
   store_id VARCHAR(64),
   date_added TIMESTAMP,
   PRIMARY KEY (ctor_id)
);

INSERT INTO kk_cust_to_role_temp (role_id, customers_id, store_id, date_added) SELECT role_id, customers_id, store_id, date_added FROM kk_customers_to_role;

-- Create new kk_customers_to_role table
DROP TABLE IF EXISTS kk_customers_to_role;
CREATE TABLE kk_customers_to_role (
   ctor_id SERIAL,
   role_id INTEGER DEFAULT '0' NOT NULL,
   customers_id INTEGER DEFAULT '0' NOT NULL,
   store_id VARCHAR(64),
   date_added TIMESTAMP,
   PRIMARY KEY (ctor_id)
);

-- Copy the saved values from the temporary table back into the new kk_customers_to_role table
INSERT INTO kk_customers_to_role (role_id, customers_id, store_id, date_added) SELECT role_id, customers_id, store_id, date_added FROM kk_cust_to_role_temp;

-- Remove the temporary table
DROP TABLE IF EXISTS kk_cust_to_role_temp;

-- Set max_ints to 1 for these Customer tags if they are currently set to 0
UPDATE kk_customer_tag set max_ints = 1 WHERE max_ints = 0 AND name IN ('PROD_PAGE_SIZE','ORDER_PAGE_SIZE','REVIEW_PAGE_SIZE');

-- Move the Tax Order Module later in the Order Total processing, followd by the Total Order Total module
UPDATE configuration SET configuration_value = '39' WHERE configuration_key = 'MODULE_ORDER_TOTAL_TAX_SORT_ORDER'   AND configuration_value = '3';
UPDATE configuration SET configuration_value = '40' WHERE configuration_key = 'MODULE_ORDER_TOTAL_TOTAL_SORT_ORDER' AND configuration_value = '4';

-- Add new image API calls
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (DEFAULT,'addImage', '', now());
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (DEFAULT,'removeImage', '', now());

-- Correct image name
UPDATE manufacturers SET manufacturers_image = 'manufacturer/acctim.jpg'        WHERE manufacturers_image = 'manufacturer/actim.jpg';


