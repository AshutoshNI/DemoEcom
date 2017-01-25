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
-- From version 8.0.0.0 to version 8.1.0.0
-- -----------------------------------------------------------
-- In order to upgrade from versions prior to 8.0.0.0, the upgrade
-- scripts must be run sequentially.
-- 

-- Set database version information
INSERT INTO kk_config (kk_config_key, kk_config_value, date_added) VALUES ('HISTORY', '8.1.0.0 U', now());
UPDATE kk_config SET kk_config_value='8.1.0.0 PostgreSQL', date_added=now() WHERE kk_config_key='VERSION';

-- Add codes to product options and product option values for image names
ALTER TABLE products_options ADD COLUMN code varchar(32);
ALTER TABLE products_options_values ADD COLUMN code varchar(32);

-- Add role for custom panel G
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, now(), store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_customers' and p2.code='kk_panel_customG';

-- lock table
DROP TABLE IF EXISTS kk_lock;
CREATE TABLE kk_lock (
  lock_name VARCHAR(32) NOT NULL,
  lock_timestamp TIMESTAMP NOT NULL,
  PRIMARY KEY (lock_name)
);

-- Reserved stock table
DROP TABLE IF EXISTS kk_reserved_stock;
CREATE TABLE kk_reserved_stock (
  kk_reserved_stock_id SERIAL,
  store_id VARCHAR(64),
  customers_id INTEGER DEFAULT '0' NOT NULL,
  catalog_id VARCHAR(32),
  products_id INTEGER NOT NULL,
  products_options VARCHAR(128) NOT NULL,
  quantity INTEGER DEFAULT '0' NOT NULL,
  reserve_start_time TIMESTAMP NOT NULL,
  reserve_end_time TIMESTAMP NOT NULL,
  PRIMARY KEY (kk_reserved_stock_id)
);

-- Stock reservation attributes for basket and order product
ALTER TABLE customers_basket ADD COLUMN reservation_id int NOT NULL default '-1';
ALTER TABLE orders_products ADD COLUMN reservation_id int NOT NULL default '-1';
ALTER TABLE orders_products ADD COLUMN qty_reserved_for_id int NOT NULL default '0';

-- Enables / Disables stock reservation
DELETE FROM configuration WHERE configuration_key = 'STOCK_RESERVATION_ENABLE';
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api, store_id) SELECT 'Enable stock reservation','STOCK_RESERVATION_ENABLE','false','Set to true if you want to reserve stock during checkout','9', '40', 'choice(''true'', ''false'')', now(), '1', store_id FROM configuration WHERE configuration_key = 'STORE_COUNTRY';

-- Defines global stock reservation time
DELETE FROM configuration WHERE configuration_key = 'STOCK_RESERVATION_TIME_SECS';
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api, store_id) SELECT 'Stock Reservation time in secs','STOCK_RESERVATION_TIME_SECS','0','Number of seconds stock will be reserved for','9', '45', 'integer(0,null)', now(), '1', store_id FROM configuration WHERE configuration_key = 'STORE_COUNTRY';

-- Add custom privileges for the Products panel - default to allow access to Remove From Cat button
UPDATE kk_role_to_panel SET custom3=0, custom3_desc='If set remove from cat button not shown' WHERE panel_id IN (SELECT panel_id FROM kk_panel where code='kk_panel_products');

-- New API call
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (DEFAULT,'addRelatedProductsWithOptions', '', now());

-- Modify config variable text
UPDATE configuration SET configuration_title = 'Show Stock Levels', configuration_description='Displays the product stock levels in the storefront application. Set to false if products are virtual.' WHERE configuration_key = 'STOCK_CHECK';
UPDATE configuration SET configuration_title = 'Do Not Automatically Disable Product', configuration_description='If false, a product is automatically disabled when it goes out of stock.' WHERE configuration_key = 'STOCK_ALLOW_CHECKOUT';
UPDATE configuration SET sort_order = '3' WHERE configuration_key = 'STOCK_ENABLE_PRODUCT';

-- Used in storefront to allow checkout when stock is not available
DELETE FROM configuration WHERE configuration_key = 'STORE_FRONT_STOCK_ALLOW_CHECKOUT';
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api, store_id) SELECT 'Allow Checkout When Stock Not Available','STORE_FRONT_STOCK_ALLOW_CHECKOUT','true','When true, the storefront allows checkout even when stock is not available','9', '2', 'choice(''true'', ''false'')', now(), '1', store_id FROM configuration WHERE configuration_key = 'STORE_COUNTRY';




































































-- New Order Total Custom fields:
ALTER TABLE orders_total ADD COLUMN custom4 varchar(128);
ALTER TABLE orders_total ADD COLUMN custom5 varchar(128);

-- Change currency value to decimal
ALTER TABLE currencies ALTER COLUMN value TYPE DECIMAL(15,6);
