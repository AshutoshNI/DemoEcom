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
-- KonaKart upgrade database script for MS Sql Server
-- From version 8.0.0.0 to version 8.1.0.0
-- -----------------------------------------------------------
-- In order to upgrade from versions prior to 8.0.0.0, the upgrade
-- scripts must be run sequentially.
-- 


-- Set database version information
INSERT INTO kk_config (kk_config_key, kk_config_value, date_added) VALUES ('HISTORY', '8.1.0.0 U', getdate());
UPDATE kk_config SET kk_config_value='8.1.0.0 SQLServer', date_added=getdate() WHERE kk_config_key='VERSION';

-- Add codes to product options and product option values for image names
ALTER TABLE products_options ADD code varchar(32);
ALTER TABLE products_options_values ADD code varchar(32);

-- Add role for custom panel G
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, getdate(), store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_customers' and p2.code='kk_panel_customG';

-- lock table
DROP TABLE kk_lock;
CREATE TABLE kk_lock (
  lock_name varchar(32) NOT NULL,
  lock_timestamp datetime NOT NULL,
  PRIMARY KEY(lock_name)
);

-- Reserved stock table
DROP TABLE kk_reserved_stock;
CREATE TABLE kk_reserved_stock (
  kk_reserved_stock_id int NOT NULL identity(1,1),
  store_id varchar(64),
  customers_id int DEFAULT 0 NOT NULL,
  catalog_id varchar(32),
  products_id int NOT NULL,
  products_options varchar(128) NOT NULL,
  quantity int DEFAULT 0 NOT NULL,
  reserve_start_time datetime NOT NULL,
  reserve_end_time datetime NOT NULL,
  PRIMARY KEY(kk_reserved_stock_id)
);

-- Stock reservation attributes for basket and order product
ALTER TABLE customers_basket ADD reservation_id int NOT NULL default '-1';
ALTER TABLE orders_products ADD reservation_id int NOT NULL default '-1';
ALTER TABLE orders_products ADD qty_reserved_for_id int NOT NULL default '0';

-- Enables / Disables stock reservation
DELETE FROM configuration WHERE configuration_key = 'STOCK_RESERVATION_ENABLE';
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api, store_id) SELECT 'Enable stock reservation','STOCK_RESERVATION_ENABLE','false','Set to true if you want to reserve stock during checkout','9', '40', 'choice(''true'', ''false'')', getdate(), '1', store_id FROM configuration WHERE configuration_key = 'STORE_COUNTRY';

-- Defines global stock reservation time
DELETE FROM configuration WHERE configuration_key = 'STOCK_RESERVATION_TIME_SECS';
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api, store_id) SELECT 'Stock Reservation time in secs','STOCK_RESERVATION_TIME_SECS','0','Number of seconds stock will be reserved for','9', '45', 'integer(0,null)', getdate(), '1', store_id FROM configuration WHERE configuration_key = 'STORE_COUNTRY';

-- Add custom privileges for the Products panel - default to allow access to Remove From Cat button
UPDATE kk_role_to_panel SET custom3=0, custom3_desc='If set remove from cat button not shown' WHERE panel_id IN (SELECT panel_id FROM kk_panel where code='kk_panel_products');

-- New API call
INSERT INTO kk_api_call (name, description, date_added) VALUES ('addRelatedProductsWithOptions', '', getdate());

-- Modify config variable text
UPDATE configuration SET configuration_title = 'Show Stock Levels', configuration_description='Displays the product stock levels in the storefront application. Set to false if products are virtual.' WHERE configuration_key = 'STOCK_CHECK';
UPDATE configuration SET configuration_title = 'Do Not Automatically Disable Product', configuration_description='If false, a product is automatically disabled when it goes out of stock.' WHERE configuration_key = 'STOCK_ALLOW_CHECKOUT';
UPDATE configuration SET sort_order = '3' WHERE configuration_key = 'STOCK_ENABLE_PRODUCT';

-- Used in storefront to allow checkout when stock is not available
DELETE FROM configuration WHERE configuration_key = 'STORE_FRONT_STOCK_ALLOW_CHECKOUT';
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api, store_id) SELECT 'Allow Checkout When Stock Not Available','STORE_FRONT_STOCK_ALLOW_CHECKOUT','true','When true, the storefront allows checkout even when stock is not available','9', '2', 'choice(''true'', ''false'')', getdate(), '1', store_id FROM configuration WHERE configuration_key = 'STORE_COUNTRY';

-- NOTE CAREFULLY
-- ==============
-- For MSSQL Only - These updates convert many varchar colums to nvarchar columns
-- You may need to adjust the lengths of some of these columns if you have modified them from the default KonaKart lengths
-- It is important that you test the execution of this upgrade on a copy of your production data before executing it in production

ALTER TABLE address_book ALTER COLUMN entry_company NVARCHAR(32);
ALTER TABLE address_book ALTER COLUMN entry_firstname NVARCHAR(32);
ALTER TABLE address_book ALTER COLUMN entry_lastname NVARCHAR(32);
ALTER TABLE address_book ALTER COLUMN entry_street_address NVARCHAR(64) NOT NULL;
ALTER TABLE address_book ALTER COLUMN entry_suburb NVARCHAR(32);
ALTER TABLE address_book ALTER COLUMN entry_postcode NVARCHAR(10) NOT NULL;
ALTER TABLE address_book ALTER COLUMN entry_city NVARCHAR(64) NOT NULL;
ALTER TABLE address_book ALTER COLUMN entry_state NVARCHAR(32);
ALTER TABLE address_book ALTER COLUMN custom1 NVARCHAR(128);
ALTER TABLE address_book ALTER COLUMN custom2 NVARCHAR(128);
ALTER TABLE address_book ALTER COLUMN custom3 NVARCHAR(128);
ALTER TABLE address_book ALTER COLUMN custom4 NVARCHAR(128);
ALTER TABLE address_book ALTER COLUMN custom5 NVARCHAR(128);
ALTER TABLE address_book ALTER COLUMN entry_telephone NVARCHAR(32);
ALTER TABLE address_book ALTER COLUMN entry_telephone_1 NVARCHAR(32);
ALTER TABLE address_book ALTER COLUMN entry_email_address NVARCHAR(96);
ALTER TABLE address_book ALTER COLUMN entry_street_address_1 NVARCHAR(64);
ALTER TABLE address_book ALTER COLUMN addr_store_id NVARCHAR(64);

ALTER TABLE categories ALTER COLUMN categories_image NVARCHAR(64);
ALTER TABLE categories ALTER COLUMN custom1 NVARCHAR(128);
ALTER TABLE categories ALTER COLUMN custom2 NVARCHAR(128);
ALTER TABLE categories ALTER COLUMN custom3 NVARCHAR(128);

ALTER TABLE configuration ALTER COLUMN configuration_title NVARCHAR(64) NOT NULL;
ALTER TABLE configuration ALTER COLUMN configuration_value NVARCHAR(255);
ALTER TABLE configuration ALTER COLUMN configuration_description NVARCHAR(255) NOT NULL;

DROP INDEX IDX_COUNTRIES_NAME ON countries;
ALTER TABLE countries ALTER COLUMN countries_name NVARCHAR(64) NOT NULL;
CREATE INDEX IDX_COUNTRIES_NAME ON countries (countries_name);

ALTER TABLE countries ALTER COLUMN custom1 NVARCHAR(10);

DROP INDEX i_coupon_code_coupon ON coupon;
DROP INDEX i_cocoupon ON coupon;
ALTER TABLE coupon ALTER COLUMN coupon_code NVARCHAR(64);
CREATE INDEX i_coupon_code_coupon ON coupon (coupon_code);

ALTER TABLE coupon ALTER COLUMN name NVARCHAR(64);
ALTER TABLE coupon ALTER COLUMN description NVARCHAR(128);
ALTER TABLE coupon ALTER COLUMN custom1 NVARCHAR(128);
ALTER TABLE coupon ALTER COLUMN custom2 NVARCHAR(128);
ALTER TABLE coupon ALTER COLUMN custom3 NVARCHAR(128);
ALTER TABLE coupon ALTER COLUMN custom4 NVARCHAR(128);
ALTER TABLE coupon ALTER COLUMN custom5 NVARCHAR(128);

ALTER TABLE currencies ALTER COLUMN title NVARCHAR(32) NOT NULL;
ALTER TABLE currencies ALTER COLUMN symbol_left NVARCHAR(12);
ALTER TABLE currencies ALTER COLUMN symbol_right NVARCHAR(12);

ALTER TABLE customers ALTER COLUMN customers_firstname NVARCHAR(32) NOT NULL;
ALTER TABLE customers ALTER COLUMN customers_lastname NVARCHAR(32) NOT NULL;

DROP INDEX i_customers_email_address_customers ON customers;
DROP INDEX i_cucustomers ON customers;
ALTER TABLE customers ALTER COLUMN customers_email_address NVARCHAR(96) NOT NULL;
CREATE INDEX i_customers_email_address_customers ON customers (customers_email_address);

ALTER TABLE customers ALTER COLUMN customers_telephone NVARCHAR(32) NOT NULL;
ALTER TABLE customers ALTER COLUMN customers_fax NVARCHAR(32);
ALTER TABLE customers ALTER COLUMN customers_password NVARCHAR(40) NOT NULL;
ALTER TABLE customers ALTER COLUMN custom1 NVARCHAR(128);
ALTER TABLE customers ALTER COLUMN custom2 NVARCHAR(128);
ALTER TABLE customers ALTER COLUMN custom3 NVARCHAR(128);
ALTER TABLE customers ALTER COLUMN custom4 NVARCHAR(128);
ALTER TABLE customers ALTER COLUMN custom5 NVARCHAR(128);
ALTER TABLE customers ALTER COLUMN customers_locale NVARCHAR(16);
ALTER TABLE customers ALTER COLUMN customers_telephone_1 NVARCHAR(32);
ALTER TABLE customers ALTER COLUMN tax_identifier NVARCHAR(64);
ALTER TABLE customers ALTER COLUMN tax_exemption NVARCHAR(64);
ALTER TABLE customers ALTER COLUMN tax_entity NVARCHAR(64);
ALTER TABLE customers ALTER COLUMN ext_reference_1 NVARCHAR(64);
ALTER TABLE customers ALTER COLUMN ext_reference_2 NVARCHAR(64);

ALTER TABLE customers_basket ALTER COLUMN custom1 NVARCHAR(128);
ALTER TABLE customers_basket ALTER COLUMN custom2 NVARCHAR(128);
ALTER TABLE customers_basket ALTER COLUMN custom3 NVARCHAR(128);
ALTER TABLE customers_basket ALTER COLUMN custom4 NVARCHAR(128);
ALTER TABLE customers_basket ALTER COLUMN custom5 NVARCHAR(128);
ALTER TABLE customers_basket ALTER COLUMN products_sku NVARCHAR(255);
ALTER TABLE customers_basket ALTER COLUMN custom6 NVARCHAR(16);
ALTER TABLE customers_basket ALTER COLUMN custom7 NVARCHAR(16);
ALTER TABLE customers_basket ALTER COLUMN custom8 NVARCHAR(16);
ALTER TABLE customers_basket ALTER COLUMN custom9 NVARCHAR(16);
ALTER TABLE customers_basket ALTER COLUMN custom10 NVARCHAR(16);

ALTER TABLE customers_basket_attrs ALTER COLUMN customer_string NVARCHAR(512);

ALTER TABLE geo_zones ALTER COLUMN geo_zone_name NVARCHAR(32);
ALTER TABLE geo_zones ALTER COLUMN geo_zone_description NVARCHAR(255);

ALTER TABLE ipn_history ALTER COLUMN custom1 NVARCHAR(128);
ALTER TABLE ipn_history ALTER COLUMN custom2 NVARCHAR(128);
ALTER TABLE ipn_history ALTER COLUMN custom3 NVARCHAR(128);
ALTER TABLE ipn_history ALTER COLUMN custom4 NVARCHAR(128);

ALTER TABLE kk_booking ALTER COLUMN firstname NVARCHAR(32);
ALTER TABLE kk_booking ALTER COLUMN lastname NVARCHAR(32);
ALTER TABLE kk_booking ALTER COLUMN custom1 NVARCHAR(128);
ALTER TABLE kk_booking ALTER COLUMN custom2 NVARCHAR(128);
ALTER TABLE kk_booking ALTER COLUMN custom3 NVARCHAR(128);

ALTER TABLE kk_catalog ALTER COLUMN cat_name NVARCHAR(32);
ALTER TABLE kk_catalog ALTER COLUMN description NVARCHAR(255);

ALTER TABLE kk_config ALTER COLUMN kk_config_key NVARCHAR(16);
ALTER TABLE kk_config ALTER COLUMN kk_config_value NVARCHAR(256);

ALTER TABLE kk_content ALTER COLUMN click_url NVARCHAR(256);
ALTER TABLE kk_content ALTER COLUMN custom1 NVARCHAR(32);
ALTER TABLE kk_content ALTER COLUMN custom2 NVARCHAR(32);
ALTER TABLE kk_content ALTER COLUMN custom3 NVARCHAR(32);
ALTER TABLE kk_content ALTER COLUMN custom4 NVARCHAR(32);

ALTER TABLE kk_content_desc ALTER COLUMN name1 NVARCHAR(256);
ALTER TABLE kk_content_desc ALTER COLUMN name2 NVARCHAR(256);
ALTER TABLE kk_content_desc ALTER COLUMN name3 NVARCHAR(256);
ALTER TABLE kk_content_desc ALTER COLUMN name4 NVARCHAR(256);
ALTER TABLE kk_content_desc ALTER COLUMN title NVARCHAR(256);
ALTER TABLE kk_content_desc ALTER COLUMN custom1 NVARCHAR(32);
ALTER TABLE kk_content_desc ALTER COLUMN custom2 NVARCHAR(32);
ALTER TABLE kk_content_desc ALTER COLUMN custom3 NVARCHAR(32);
ALTER TABLE kk_content_desc ALTER COLUMN custom4 NVARCHAR(32);

ALTER TABLE kk_content_type ALTER COLUMN custom1 NVARCHAR(32);
ALTER TABLE kk_content_type ALTER COLUMN custom2 NVARCHAR(32);

ALTER TABLE kk_content_type_desc ALTER COLUMN content_type_name NVARCHAR(32);
ALTER TABLE kk_content_type_desc ALTER COLUMN description NVARCHAR(256);
ALTER TABLE kk_content_type_desc ALTER COLUMN custom1 NVARCHAR(32);
ALTER TABLE kk_content_type_desc ALTER COLUMN custom2 NVARCHAR(32);

ALTER TABLE kk_cookie ALTER COLUMN attribute_value NVARCHAR(256);

ALTER TABLE kk_cust_pwd_hist ALTER COLUMN password NVARCHAR(40);
ALTER TABLE kk_cust_pwd_hist ALTER COLUMN custom1 NVARCHAR(128);

ALTER TABLE kk_customer_group ALTER COLUMN name NVARCHAR(64);
ALTER TABLE kk_customer_group ALTER COLUMN description NVARCHAR(128);
ALTER TABLE kk_customer_group ALTER COLUMN custom1 NVARCHAR(128);
ALTER TABLE kk_customer_group ALTER COLUMN custom2 NVARCHAR(128);
ALTER TABLE kk_customer_group ALTER COLUMN custom3 NVARCHAR(128);
ALTER TABLE kk_customer_group ALTER COLUMN custom4 NVARCHAR(128);
ALTER TABLE kk_customer_group ALTER COLUMN custom5 NVARCHAR(128);

ALTER TABLE kk_customers_to_tag ALTER COLUMN tag_value NVARCHAR(255);

ALTER TABLE kk_expression_variable ALTER COLUMN tag_value NVARCHAR(255);

ALTER TABLE kk_misc_item ALTER COLUMN item_value NVARCHAR(512);
ALTER TABLE kk_misc_item ALTER COLUMN custom1 NVARCHAR(128);
ALTER TABLE kk_misc_item ALTER COLUMN custom2 NVARCHAR(128);
ALTER TABLE kk_misc_item ALTER COLUMN custom3 NVARCHAR(128);

ALTER TABLE kk_msg ALTER COLUMN msg_value NVARCHAR(MAX);

ALTER TABLE kk_order_shipments ALTER COLUMN shipper_name NVARCHAR(64);
ALTER TABLE kk_order_shipments ALTER COLUMN tracking_number NVARCHAR(64);
ALTER TABLE kk_order_shipments ALTER COLUMN tracking_url NVARCHAR(255);
ALTER TABLE kk_order_shipments ALTER COLUMN custom1 NVARCHAR(128);
ALTER TABLE kk_order_shipments ALTER COLUMN custom2 NVARCHAR(128);
ALTER TABLE kk_order_shipments ALTER COLUMN custom3 NVARCHAR(128);

ALTER TABLE kk_payment_schedule ALTER COLUMN name NVARCHAR(64);
ALTER TABLE kk_payment_schedule ALTER COLUMN description NVARCHAR(256);
ALTER TABLE kk_payment_schedule ALTER COLUMN custom1 NVARCHAR(128);
ALTER TABLE kk_payment_schedule ALTER COLUMN custom2 NVARCHAR(128);
ALTER TABLE kk_payment_schedule ALTER COLUMN custom3 NVARCHAR(128);
ALTER TABLE kk_payment_schedule ALTER COLUMN custom4 NVARCHAR(128);
ALTER TABLE kk_payment_schedule ALTER COLUMN custom5 NVARCHAR(128);

ALTER TABLE kk_product_to_stores ALTER COLUMN custom1 NVARCHAR(128);
ALTER TABLE kk_product_to_stores ALTER COLUMN custom2 NVARCHAR(128);
ALTER TABLE kk_product_to_stores ALTER COLUMN custom3 NVARCHAR(128);

ALTER TABLE kk_reward_points ALTER COLUMN code NVARCHAR(64);
ALTER TABLE kk_reward_points ALTER COLUMN description NVARCHAR(256);

ALTER TABLE kk_shipper ALTER COLUMN name NVARCHAR(64);
ALTER TABLE kk_shipper ALTER COLUMN tracking_url NVARCHAR(255);
ALTER TABLE kk_shipper ALTER COLUMN custom1 NVARCHAR(128);
ALTER TABLE kk_shipper ALTER COLUMN custom2 NVARCHAR(128);
ALTER TABLE kk_shipper ALTER COLUMN custom3 NVARCHAR(128);

ALTER TABLE kk_store ALTER COLUMN store_desc NVARCHAR(128);
ALTER TABLE kk_store ALTER COLUMN store_admin_email NVARCHAR(96);
ALTER TABLE kk_store ALTER COLUMN store_css_filename NVARCHAR(128);
ALTER TABLE kk_store ALTER COLUMN store_logo_filename NVARCHAR(128);
ALTER TABLE kk_store ALTER COLUMN store_url NVARCHAR(128);
ALTER TABLE kk_store ALTER COLUMN store_home NVARCHAR(64);
ALTER TABLE kk_store ALTER COLUMN custom1 NVARCHAR(128);
ALTER TABLE kk_store ALTER COLUMN custom2 NVARCHAR(128);
ALTER TABLE kk_store ALTER COLUMN custom3 NVARCHAR(128);
ALTER TABLE kk_store ALTER COLUMN custom4 NVARCHAR(128);
ALTER TABLE kk_store ALTER COLUMN custom5 NVARCHAR(128);

ALTER TABLE kk_subscription ALTER COLUMN products_sku NVARCHAR(255);
ALTER TABLE kk_subscription ALTER COLUMN problem_description NVARCHAR(255);
ALTER TABLE kk_subscription ALTER COLUMN custom1 NVARCHAR(128);
ALTER TABLE kk_subscription ALTER COLUMN custom2 NVARCHAR(128);
ALTER TABLE kk_subscription ALTER COLUMN custom3 NVARCHAR(128);
ALTER TABLE kk_subscription ALTER COLUMN custom4 NVARCHAR(128);
ALTER TABLE kk_subscription ALTER COLUMN custom5 NVARCHAR(128);

ALTER TABLE kk_tag ALTER COLUMN name NVARCHAR(128);

ALTER TABLE kk_tag_group ALTER COLUMN name NVARCHAR(128);
ALTER TABLE kk_tag_group ALTER COLUMN description NVARCHAR(255);

ALTER TABLE kk_tier_price ALTER COLUMN custom1 NVARCHAR(128);

ALTER TABLE kk_wishlist ALTER COLUMN name NVARCHAR(128);
ALTER TABLE kk_wishlist ALTER COLUMN description NVARCHAR(255);
ALTER TABLE kk_wishlist ALTER COLUMN customers_firstname NVARCHAR(32);
ALTER TABLE kk_wishlist ALTER COLUMN customers_lastname NVARCHAR(32);
ALTER TABLE kk_wishlist ALTER COLUMN customers_city NVARCHAR(64);
ALTER TABLE kk_wishlist ALTER COLUMN customers_state NVARCHAR(32);
ALTER TABLE kk_wishlist ALTER COLUMN custom1 NVARCHAR(128);
ALTER TABLE kk_wishlist ALTER COLUMN custom2 NVARCHAR(128);
ALTER TABLE kk_wishlist ALTER COLUMN custom3 NVARCHAR(128);
ALTER TABLE kk_wishlist ALTER COLUMN custom4 NVARCHAR(128);
ALTER TABLE kk_wishlist ALTER COLUMN custom5 NVARCHAR(128);
ALTER TABLE kk_wishlist ALTER COLUMN customers1_firstname NVARCHAR(32);
ALTER TABLE kk_wishlist ALTER COLUMN customers1_lastname NVARCHAR(32);
ALTER TABLE kk_wishlist ALTER COLUMN link_url NVARCHAR(255);

ALTER TABLE kk_wishlist_item ALTER COLUMN products_id NVARCHAR(255);
ALTER TABLE kk_wishlist_item ALTER COLUMN custom1 NVARCHAR(128);
ALTER TABLE kk_wishlist_item ALTER COLUMN custom2 NVARCHAR(128);
ALTER TABLE kk_wishlist_item ALTER COLUMN custom3 NVARCHAR(128);
ALTER TABLE kk_wishlist_item ALTER COLUMN custom4 NVARCHAR(128);
ALTER TABLE kk_wishlist_item ALTER COLUMN custom5 NVARCHAR(128);
ALTER TABLE kk_wishlist_item ALTER COLUMN comments NVARCHAR(255);

DROP INDEX IDX_LANGUAGES_NAME ON languages;
ALTER TABLE languages ALTER COLUMN name NVARCHAR(32);
CREATE INDEX IDX_LANGUAGES_NAME ON languages (name);

ALTER TABLE languages ALTER COLUMN image NVARCHAR(64);
ALTER TABLE languages ALTER COLUMN directory NVARCHAR(32);
ALTER TABLE languages ALTER COLUMN locale NVARCHAR(10);

DROP INDEX IDX_MANUFACTURERS_NAME ON manufacturers;
ALTER TABLE manufacturers ALTER COLUMN manufacturers_name NVARCHAR(32);
CREATE INDEX IDX_MANUFACTURERS_NAME ON manufacturers (manufacturers_name);

ALTER TABLE manufacturers ALTER COLUMN manufacturers_image NVARCHAR(64);
ALTER TABLE manufacturers ALTER COLUMN custom1 NVARCHAR(128);
ALTER TABLE manufacturers ALTER COLUMN custom2 NVARCHAR(128);
ALTER TABLE manufacturers ALTER COLUMN custom3 NVARCHAR(128);
ALTER TABLE manufacturers ALTER COLUMN custom4 NVARCHAR(128);
ALTER TABLE manufacturers ALTER COLUMN custom5 NVARCHAR(128);

ALTER TABLE manufacturers_info ALTER COLUMN manufacturers_url NVARCHAR(255);

ALTER TABLE newsletters ALTER COLUMN title NVARCHAR(255) NOT NULL;
ALTER TABLE newsletters ALTER COLUMN module NVARCHAR(255) NOT NULL;

ALTER TABLE orders ALTER COLUMN customers_name NVARCHAR(66) NOT NULL;
ALTER TABLE orders ALTER COLUMN customers_company NVARCHAR(32);
ALTER TABLE orders ALTER COLUMN customers_street_address NVARCHAR(64) NOT NULL;
ALTER TABLE orders ALTER COLUMN customers_suburb NVARCHAR(32);
ALTER TABLE orders ALTER COLUMN customers_city NVARCHAR(64) NOT NULL;
ALTER TABLE orders ALTER COLUMN customers_postcode NVARCHAR(10) NOT NULL;
ALTER TABLE orders ALTER COLUMN customers_state NVARCHAR(32);
ALTER TABLE orders ALTER COLUMN customers_country NVARCHAR(64) NOT NULL;
ALTER TABLE orders ALTER COLUMN customers_telephone NVARCHAR(32) NOT NULL;
ALTER TABLE orders ALTER COLUMN customers_email_address NVARCHAR(96) NOT NULL;
ALTER TABLE orders ALTER COLUMN delivery_name NVARCHAR(66) NOT NULL;
ALTER TABLE orders ALTER COLUMN delivery_company NVARCHAR(32);
ALTER TABLE orders ALTER COLUMN delivery_street_address NVARCHAR(64) NOT NULL;
ALTER TABLE orders ALTER COLUMN delivery_suburb NVARCHAR(32);
ALTER TABLE orders ALTER COLUMN delivery_city NVARCHAR(64) NOT NULL;
ALTER TABLE orders ALTER COLUMN delivery_postcode NVARCHAR(10) NOT NULL;
ALTER TABLE orders ALTER COLUMN delivery_state NVARCHAR(32);
ALTER TABLE orders ALTER COLUMN delivery_country NVARCHAR(64) NOT NULL;
ALTER TABLE orders ALTER COLUMN billing_name NVARCHAR(66) NOT NULL;
ALTER TABLE orders ALTER COLUMN billing_company NVARCHAR(32);
ALTER TABLE orders ALTER COLUMN billing_street_address NVARCHAR(64) NOT NULL;
ALTER TABLE orders ALTER COLUMN billing_suburb NVARCHAR(32);
ALTER TABLE orders ALTER COLUMN billing_city NVARCHAR(64) NOT NULL;
ALTER TABLE orders ALTER COLUMN billing_postcode NVARCHAR(10) NOT NULL;
ALTER TABLE orders ALTER COLUMN billing_state NVARCHAR(32);
ALTER TABLE orders ALTER COLUMN billing_country NVARCHAR(64) NOT NULL;
ALTER TABLE orders ALTER COLUMN payment_method NVARCHAR(32) NOT NULL;
ALTER TABLE orders ALTER COLUMN cc_type NVARCHAR(20);
ALTER TABLE orders ALTER COLUMN cc_owner NVARCHAR(64);
ALTER TABLE orders ALTER COLUMN cc_number NVARCHAR(32);
ALTER TABLE orders ALTER COLUMN cc_expires NVARCHAR(4);
ALTER TABLE orders ALTER COLUMN custom1 NVARCHAR(128);
ALTER TABLE orders ALTER COLUMN custom2 NVARCHAR(128);
ALTER TABLE orders ALTER COLUMN custom3 NVARCHAR(128);
ALTER TABLE orders ALTER COLUMN custom4 NVARCHAR(128);
ALTER TABLE orders ALTER COLUMN custom5 NVARCHAR(128);
ALTER TABLE orders ALTER COLUMN orders_number NVARCHAR(128);
ALTER TABLE orders ALTER COLUMN tracking_number NVARCHAR(128);
ALTER TABLE orders ALTER COLUMN customers_locale NVARCHAR(16);
ALTER TABLE orders ALTER COLUMN invoice_filename NVARCHAR(255);
ALTER TABLE orders ALTER COLUMN customers_telephone_1 NVARCHAR(32);
ALTER TABLE orders ALTER COLUMN delivery_telephone NVARCHAR(32);
ALTER TABLE orders ALTER COLUMN delivery_telephone_1 NVARCHAR(32);
ALTER TABLE orders ALTER COLUMN delivery_email_address NVARCHAR(96);
ALTER TABLE orders ALTER COLUMN billing_telephone NVARCHAR(32);
ALTER TABLE orders ALTER COLUMN billing_telephone_1 NVARCHAR(32);
ALTER TABLE orders ALTER COLUMN billing_email_address NVARCHAR(96);
ALTER TABLE orders ALTER COLUMN customers_street_address_1 NVARCHAR(64);
ALTER TABLE orders ALTER COLUMN delivery_street_address_1 NVARCHAR(64);
ALTER TABLE orders ALTER COLUMN billing_street_address_1 NVARCHAR(64);
ALTER TABLE orders ALTER COLUMN shipping_service_code NVARCHAR(128);
ALTER TABLE orders ALTER COLUMN order_creator NVARCHAR(128);
ALTER TABLE orders ALTER COLUMN affiliate_id NVARCHAR(128);
ALTER TABLE orders ALTER COLUMN payment_module_subcode NVARCHAR(64);
ALTER TABLE orders ALTER COLUMN store_name NVARCHAR(64);
ALTER TABLE orders ALTER COLUMN custom6 NVARCHAR(16);
ALTER TABLE orders ALTER COLUMN custom7 NVARCHAR(16);
ALTER TABLE orders ALTER COLUMN custom8 NVARCHAR(16);
ALTER TABLE orders ALTER COLUMN custom9 NVARCHAR(16);
ALTER TABLE orders ALTER COLUMN custom10 NVARCHAR(16);
ALTER TABLE orders ALTER COLUMN filter1 NVARCHAR(32);
ALTER TABLE orders ALTER COLUMN filter2 NVARCHAR(32);

ALTER TABLE orders_products ALTER COLUMN products_model NVARCHAR(64);
ALTER TABLE orders_products ALTER COLUMN products_name NVARCHAR(255) NOT NULL;
ALTER TABLE orders_products ALTER COLUMN custom1 NVARCHAR(128);
ALTER TABLE orders_products ALTER COLUMN custom2 NVARCHAR(128);
ALTER TABLE orders_products ALTER COLUMN custom3 NVARCHAR(128);
ALTER TABLE orders_products ALTER COLUMN custom4 NVARCHAR(128);
ALTER TABLE orders_products ALTER COLUMN custom5 NVARCHAR(128);
ALTER TABLE orders_products ALTER COLUMN products_sku NVARCHAR(255);
ALTER TABLE orders_products ALTER COLUMN tax_code NVARCHAR(64);
ALTER TABLE orders_products ALTER COLUMN custom6 NVARCHAR(16);
ALTER TABLE orders_products ALTER COLUMN custom7 NVARCHAR(16);
ALTER TABLE orders_products ALTER COLUMN custom8 NVARCHAR(16);
ALTER TABLE orders_products ALTER COLUMN custom9 NVARCHAR(16);
ALTER TABLE orders_products ALTER COLUMN custom10 NVARCHAR(16);

ALTER TABLE orders_products_attributes ALTER COLUMN products_options_values NVARCHAR(64) NOT NULL;
ALTER TABLE orders_products_attributes ALTER COLUMN customer_string NVARCHAR(512);

ALTER TABLE orders_products_download ALTER COLUMN orders_products_filename NVARCHAR(255) NOT NULL;

ALTER TABLE orders_returns ALTER COLUMN rma_code NVARCHAR(128);
ALTER TABLE orders_returns ALTER COLUMN orders_number NVARCHAR(128);

ALTER TABLE orders_total ALTER COLUMN title NVARCHAR(255) NOT NULL;
ALTER TABLE orders_total ALTER COLUMN text NVARCHAR(255) NOT NULL;
ALTER TABLE orders_total ALTER COLUMN class NVARCHAR(32) NOT NULL;
ALTER TABLE orders_total ALTER COLUMN custom1 NVARCHAR(128);
ALTER TABLE orders_total ALTER COLUMN custom2 NVARCHAR(128);
ALTER TABLE orders_total ALTER COLUMN custom3 NVARCHAR(128);

ALTER TABLE products ALTER COLUMN products_model NVARCHAR(64);
ALTER TABLE products ALTER COLUMN products_image NVARCHAR(255);
ALTER TABLE products ALTER COLUMN custom1 NVARCHAR(128);
ALTER TABLE products ALTER COLUMN custom2 NVARCHAR(128);
ALTER TABLE products ALTER COLUMN custom3 NVARCHAR(128);
ALTER TABLE products ALTER COLUMN custom4 NVARCHAR(128);
ALTER TABLE products ALTER COLUMN custom5 NVARCHAR(128);
ALTER TABLE products ALTER COLUMN products_sku NVARCHAR(255);
ALTER TABLE products ALTER COLUMN products_file_path NVARCHAR(255);
ALTER TABLE products ALTER COLUMN products_content_type NVARCHAR(128);
ALTER TABLE products ALTER COLUMN products_image2 NVARCHAR(255);
ALTER TABLE products ALTER COLUMN products_image3 NVARCHAR(255);
ALTER TABLE products ALTER COLUMN products_image4 NVARCHAR(255);
ALTER TABLE products ALTER COLUMN custom6 NVARCHAR(128);
ALTER TABLE products ALTER COLUMN custom7 NVARCHAR(128);
ALTER TABLE products ALTER COLUMN custom8 NVARCHAR(128);
ALTER TABLE products ALTER COLUMN custom9 NVARCHAR(128);
ALTER TABLE products ALTER COLUMN custom10 NVARCHAR(128);
ALTER TABLE products ALTER COLUMN product_image_dir NVARCHAR(64);

ALTER TABLE products_attributes ALTER COLUMN custom1 NVARCHAR(128);
ALTER TABLE products_attributes ALTER COLUMN custom2 NVARCHAR(128);

ALTER TABLE products_attrs_download ALTER COLUMN products_attributes_filename NVARCHAR(255) NOT NULL;

DROP INDEX products_name ON products_description;
ALTER TABLE products_description ALTER COLUMN products_name NVARCHAR(255) NOT NULL;
CREATE INDEX products_name ON products_description (products_name);

ALTER TABLE products_description ALTER COLUMN customd1 NVARCHAR(256);
ALTER TABLE products_description ALTER COLUMN customd2 NVARCHAR(256);
ALTER TABLE products_description ALTER COLUMN customd3 NVARCHAR(256);
ALTER TABLE products_description ALTER COLUMN customd4 NVARCHAR(256);
ALTER TABLE products_description ALTER COLUMN customd5 NVARCHAR(256);
ALTER TABLE products_description ALTER COLUMN customd6 NVARCHAR(256);

ALTER TABLE products_to_products ALTER COLUMN custom1 NVARCHAR(128);
ALTER TABLE products_to_products ALTER COLUMN custom2 NVARCHAR(128);

ALTER TABLE promotion ALTER COLUMN description NVARCHAR(128);
ALTER TABLE promotion ALTER COLUMN name NVARCHAR(64);
ALTER TABLE promotion ALTER COLUMN custom1 NVARCHAR(128);
ALTER TABLE promotion ALTER COLUMN custom2 NVARCHAR(128);
ALTER TABLE promotion ALTER COLUMN custom3 NVARCHAR(128);
ALTER TABLE promotion ALTER COLUMN custom4 NVARCHAR(128);
ALTER TABLE promotion ALTER COLUMN custom5 NVARCHAR(128);
ALTER TABLE promotion ALTER COLUMN custom6 NVARCHAR(128);
ALTER TABLE promotion ALTER COLUMN custom7 NVARCHAR(128);
ALTER TABLE promotion ALTER COLUMN custom8 NVARCHAR(128);
ALTER TABLE promotion ALTER COLUMN custom9 NVARCHAR(128);
ALTER TABLE promotion ALTER COLUMN custom10 NVARCHAR(128);

ALTER TABLE promotion_to_customer ALTER COLUMN custom1 NVARCHAR(128);
ALTER TABLE promotion_to_customer ALTER COLUMN custom2 NVARCHAR(128);

ALTER TABLE reviews ALTER COLUMN customers_name NVARCHAR(64) NOT NULL;
ALTER TABLE reviews ALTER COLUMN custom1 NVARCHAR(128);
ALTER TABLE reviews ALTER COLUMN custom2 NVARCHAR(128);
ALTER TABLE reviews ALTER COLUMN custom3 NVARCHAR(128);

ALTER TABLE tax_class ALTER COLUMN tax_class_title NVARCHAR(32) NOT NULL;
ALTER TABLE tax_class ALTER COLUMN tax_class_description NVARCHAR(255) NOT NULL;

ALTER TABLE tax_rates ALTER COLUMN tax_description NVARCHAR(255) NOT NULL;

ALTER TABLE zones ALTER COLUMN zone_code NVARCHAR(32) NOT NULL;
ALTER TABLE zones ALTER COLUMN zone_name NVARCHAR(32) NOT NULL;

ALTER TABLE zones ALTER COLUMN custom1 NVARCHAR(128);
ALTER TABLE zones ALTER COLUMN custom2 NVARCHAR(128);
ALTER TABLE zones ALTER COLUMN custom3 NVARCHAR(128);

-- New Order Total Custom fields:
ALTER TABLE orders_total ADD custom4 varchar(128);
ALTER TABLE orders_total ADD custom5 varchar(128);

-- Change currency value to decimal
ALTER TABLE currencies ALTER COLUMN value DECIMAL(15,6);
exit;
