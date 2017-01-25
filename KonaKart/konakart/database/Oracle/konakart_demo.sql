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
-- KonaKart v8.5.0.0 demo database script for Oracle
-- Created: Wed Jan 18 04:55:08 GMT 2017
-- -----------------------------------------------------------
-- 
set escape \
-- You can comment out the next 'Alter session' line if using 11gR1 or earlier
Alter session set deferred_segment_creation=false;


BEGIN EXECUTE IMMEDIATE 'DROP TABLE address_book'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE address_book (
  address_book_id NUMBER(10,0) NOT NULL,
  customers_id NUMBER(10,0) NOT NULL,
  entry_gender char(1) NOT NULL,
  entry_company VARCHAR2(32),
  entry_firstname VARCHAR2(32) NOT NULL,
  entry_lastname VARCHAR2(32) NOT NULL,
  entry_street_address VARCHAR2(64) NOT NULL,
  entry_suburb VARCHAR2(32),
  entry_postcode VARCHAR2(10) NOT NULL,
  entry_city VARCHAR2(32) NOT NULL,
  entry_state VARCHAR2(32),
  entry_country_id NUMBER(10,0) DEFAULT 0 NOT NULL,
  entry_zone_id NUMBER(10,0) DEFAULT 0 NOT NULL,
  PRIMARY KEY(address_book_id)
);
CREATE INDEX idx_address_book_customers_id ON address_book (customers_id);
BEGIN EXECUTE IMMEDIATE 'DROP SEQUENCE address_book_SEQ'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE SEQUENCE address_book_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

BEGIN EXECUTE IMMEDIATE 'DROP TABLE address_format'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE address_format (
  address_format_id NUMBER(10,0) NOT NULL,
  address_format VARCHAR2(128) NOT NULL,
  address_summary VARCHAR2(48) NOT NULL,
  PRIMARY KEY(address_format_id)
);
BEGIN EXECUTE IMMEDIATE 'DROP SEQUENCE address_format_SEQ'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE SEQUENCE address_format_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

BEGIN EXECUTE IMMEDIATE 'DROP TABLE banners'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE banners (
  banners_id NUMBER(10,0) NOT NULL,
  banners_title VARCHAR2(64) NOT NULL,
  banners_url VARCHAR2(255) NOT NULL,
  banners_image VARCHAR2(64) NOT NULL,
  banners_group VARCHAR2(10) NOT NULL,
  banners_html_text VARCHAR2(4000),
  expires_impressions NUMBER(10,0) DEFAULT 0,
  expires_date TIMESTAMP DEFAULT NULL,
  date_scheduled TIMESTAMP DEFAULT NULL,
  date_added TIMESTAMP NOT NULL,
  date_status_change TIMESTAMP DEFAULT NULL,
  status NUMBER(10,0) DEFAULT 1 NOT NULL,
  PRIMARY KEY(banners_id)
);
BEGIN EXECUTE IMMEDIATE 'DROP SEQUENCE banners_SEQ'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE SEQUENCE banners_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

BEGIN EXECUTE IMMEDIATE 'DROP TABLE banners_history'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE banners_history (
  banners_history_id NUMBER(10,0) NOT NULL,
  banners_id NUMBER(10,0) NOT NULL,
  banners_shown NUMBER(10,0) DEFAULT 0 NOT NULL,
  banners_clicked NUMBER(10,0) DEFAULT 0 NOT NULL,
  banners_history_date TIMESTAMP NOT NULL,
  PRIMARY KEY(banners_history_id)
);
BEGIN EXECUTE IMMEDIATE 'DROP SEQUENCE banners_history_SEQ'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE SEQUENCE banners_history_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

BEGIN EXECUTE IMMEDIATE 'DROP TABLE categories'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE categories (
  categories_id NUMBER(10,0) NOT NULL,
  categories_image VARCHAR2(64),
  parent_id NUMBER(10,0) DEFAULT 0 NOT NULL,
  sort_order NUMBER(10,0),
  date_added TIMESTAMP,
  last_modified TIMESTAMP,
  PRIMARY KEY(categories_id)
);
CREATE INDEX idx_categories_parent_id ON categories (parent_id);
BEGIN EXECUTE IMMEDIATE 'DROP SEQUENCE categories_SEQ'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE SEQUENCE categories_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

BEGIN EXECUTE IMMEDIATE 'DROP TABLE categories_description'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE categories_description (
  categories_id NUMBER(10,0) DEFAULT 0 NOT NULL,
  language_id NUMBER(10,0) DEFAULT 1 NOT NULL,
  categories_name VARCHAR2(32) NOT NULL,
  PRIMARY KEY(categories_id, language_id)
);
CREATE INDEX idx_categories_name ON categories_description (categories_name);

BEGIN EXECUTE IMMEDIATE 'DROP TABLE configuration'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE configuration (
  configuration_id NUMBER(10,0) NOT NULL,
  configuration_title VARCHAR2(64) NOT NULL,
  configuration_key VARCHAR2(64) NOT NULL,
  configuration_value VARCHAR2(255) NULL,
  configuration_description VARCHAR2(255) NOT NULL,
  configuration_group_id NUMBER(10,0) NOT NULL,
  sort_order NUMBER(10,0) NULL,
  last_modified TIMESTAMP NULL,
  date_added TIMESTAMP NOT NULL,
  use_function VARCHAR2(255) NULL,
  set_function VARCHAR2(255) NULL,
  PRIMARY KEY(configuration_id)
);
BEGIN EXECUTE IMMEDIATE 'DROP SEQUENCE configuration_SEQ'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE SEQUENCE configuration_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

BEGIN EXECUTE IMMEDIATE 'DROP TABLE configuration_group'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE configuration_group (
  configuration_group_id NUMBER(10,0) NOT NULL,
  configuration_group_title VARCHAR2(64) NOT NULL,
  configuration_group_desc VARCHAR2(255) NOT NULL,
  sort_order NUMBER(10,0) NULL,
  visible NUMBER(10,0) DEFAULT 1 NULL,
  PRIMARY KEY(configuration_group_id)
);
BEGIN EXECUTE IMMEDIATE 'DROP SEQUENCE configuration_group_SEQ'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE SEQUENCE configuration_group_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

BEGIN EXECUTE IMMEDIATE 'DROP TABLE counter'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE counter (
  startdate char(8),
  counter NUMBER(10,0)
);

BEGIN EXECUTE IMMEDIATE 'DROP TABLE counter_history'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE counter_history (
  month char(8),
  counter NUMBER(10,0)
);

BEGIN EXECUTE IMMEDIATE 'DROP TABLE countries'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE countries (
  countries_id NUMBER(10,0) NOT NULL,
  countries_name VARCHAR2(64) NOT NULL,
  countries_iso_code_2 char(2) NOT NULL,
  countries_iso_code_3 char(3) NOT NULL,
  address_format_id NUMBER(10,0) NOT NULL,
  PRIMARY KEY(countries_id)
);
CREATE INDEX IDX_COUNTRIES_NAME ON countries (countries_name);
BEGIN EXECUTE IMMEDIATE 'DROP SEQUENCE countries_SEQ'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE SEQUENCE countries_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

BEGIN EXECUTE IMMEDIATE 'DROP TABLE currencies'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE currencies (
  currencies_id NUMBER(10,0) NOT NULL,
  title VARCHAR2(32) NOT NULL,
  code char(3) NOT NULL,
  symbol_left VARCHAR2(12),
  symbol_right VARCHAR2(12),
  decimal_point char(1),
  thousands_point char(1),
  decimal_places char(1),
  value FLOAT,
  last_updated TIMESTAMP NULL,
  PRIMARY KEY(currencies_id)
);
BEGIN EXECUTE IMMEDIATE 'DROP SEQUENCE currencies_SEQ'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE SEQUENCE currencies_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

BEGIN EXECUTE IMMEDIATE 'DROP TABLE customers'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE customers (
  customers_id NUMBER(10,0) NOT NULL,
  customers_gender char(1) NOT NULL,
  customers_firstname VARCHAR2(32) NOT NULL,
  customers_lastname VARCHAR2(32) NOT NULL,
  customers_dob TIMESTAMP NOT NULL,
  customers_email_address VARCHAR2(96) NOT NULL,
  customers_default_address_id NUMBER(10,0) NOT NULL,
  customers_telephone VARCHAR2(32) NOT NULL,
  customers_fax VARCHAR2(32),
  customers_password VARCHAR2(40) NOT NULL,
  customers_newsletter char(1),
  PRIMARY KEY(customers_id)
);
BEGIN EXECUTE IMMEDIATE 'DROP SEQUENCE customers_SEQ'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE SEQUENCE customers_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

BEGIN EXECUTE IMMEDIATE 'DROP TABLE customers_basket'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE customers_basket (
  customers_basket_id NUMBER(10,0) NOT NULL,
  customers_id NUMBER(10,0) NOT NULL,
  products_id VARCHAR2(255) NOT NULL,
  customers_basket_quantity NUMBER(10,0) NOT NULL,
  final_price NUMBER(15,4) NOT NULL,
  customers_basket_date_added char(8),
  PRIMARY KEY(customers_basket_id)
);
BEGIN EXECUTE IMMEDIATE 'DROP SEQUENCE customers_basket_SEQ'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE SEQUENCE customers_basket_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

BEGIN EXECUTE IMMEDIATE 'DROP TABLE customers_basket_attrs'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE customers_basket_attrs (
  customers_basket_attributes_id NUMBER(10,0) NOT NULL,
  customers_id NUMBER(10,0) NOT NULL,
  products_id VARCHAR2(255) NOT NULL,
  products_options_id NUMBER(10,0) NOT NULL,
  products_options_value_id NUMBER(10,0) NOT NULL,
  PRIMARY KEY(customers_basket_attributes_id)
);
BEGIN EXECUTE IMMEDIATE 'DROP SEQUENCE customers_basket_attrs_SEQ'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE SEQUENCE customers_basket_attrs_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

BEGIN EXECUTE IMMEDIATE 'DROP TABLE customers_info'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE customers_info (
  customers_info_id NUMBER(10,0) NOT NULL,
  customers_info_date_last_logon TIMESTAMP,
  customers_info_number_of_logon NUMBER(10,0),
  customers_info_date_created TIMESTAMP,
  customers_info_date_modified TIMESTAMP,
  global_product_notifications NUMBER(10,0) DEFAULT 0,
  PRIMARY KEY(customers_info_id)
);

BEGIN EXECUTE IMMEDIATE 'DROP TABLE languages'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE languages (
  languages_id NUMBER(10,0) NOT NULL,
  name VARCHAR2(32)  NOT NULL,
  code char(2) NOT NULL,
  image VARCHAR2(64),
  directory VARCHAR2(32),
  sort_order NUMBER(10,0),
  PRIMARY KEY(languages_id)
);
CREATE INDEX IDX_LANGUAGES_NAME ON languages (name);
BEGIN EXECUTE IMMEDIATE 'DROP SEQUENCE languages_SEQ'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE SEQUENCE languages_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;


BEGIN EXECUTE IMMEDIATE 'DROP TABLE manufacturers'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE manufacturers (
  manufacturers_id NUMBER(10,0) NOT NULL,
  manufacturers_name VARCHAR2(32) NOT NULL,
  manufacturers_image VARCHAR2(64),
  date_added TIMESTAMP NULL,
  last_modified TIMESTAMP NULL,
  PRIMARY KEY(manufacturers_id)
);
CREATE INDEX IDX_MANUFACTURERS_NAME ON manufacturers (manufacturers_name);
BEGIN EXECUTE IMMEDIATE 'DROP SEQUENCE manufacturers_SEQ'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE SEQUENCE manufacturers_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

BEGIN EXECUTE IMMEDIATE 'DROP TABLE manufacturers_info'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE manufacturers_info (
  manufacturers_id NUMBER(10,0) NOT NULL,
  languages_id NUMBER(10,0) NOT NULL,
  manufacturers_url VARCHAR2(255) NOT NULL,
  url_clicked NUMBER(10,0) DEFAULT 0 NOT NULL,
  date_last_click TIMESTAMP NULL,
  PRIMARY KEY(manufacturers_id, languages_id)
);

BEGIN EXECUTE IMMEDIATE 'DROP TABLE newsletters'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE newsletters (
  newsletters_id NUMBER(10,0) NOT NULL,
  title VARCHAR2(255) NOT NULL,
  content VARCHAR2(4000) NOT NULL,
  module VARCHAR2(255) NOT NULL,
  date_added TIMESTAMP NOT NULL,
  date_sent TIMESTAMP,
  status NUMBER(10,0),
  locked NUMBER(10,0) DEFAULT 0,
  PRIMARY KEY(newsletters_id)
);
BEGIN EXECUTE IMMEDIATE 'DROP SEQUENCE newsletters_SEQ'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE SEQUENCE newsletters_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

BEGIN EXECUTE IMMEDIATE 'DROP TABLE orders'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE orders (
  orders_id NUMBER(10,0) NOT NULL,
  customers_id NUMBER(10,0) NOT NULL,
  customers_name VARCHAR2(64) NOT NULL,
  customers_company VARCHAR2(32),
  customers_street_address VARCHAR2(64) NOT NULL,
  customers_suburb VARCHAR2(32),
  customers_city VARCHAR2(32) NOT NULL,
  customers_postcode VARCHAR2(10) NOT NULL,
  customers_state VARCHAR2(32),
  customers_country VARCHAR2(32) NOT NULL,
  customers_telephone VARCHAR2(32) NOT NULL,
  customers_email_address VARCHAR2(96) NOT NULL,
  customers_address_format_id NUMBER(10,0) NOT NULL,
  delivery_name VARCHAR2(64) NOT NULL,
  delivery_company VARCHAR2(32),
  delivery_street_address VARCHAR2(64) NOT NULL,
  delivery_suburb VARCHAR2(32),
  delivery_city VARCHAR2(32) NOT NULL,
  delivery_postcode VARCHAR2(10) NOT NULL,
  delivery_state VARCHAR2(32),
  delivery_country VARCHAR2(32) NOT NULL,
  delivery_address_format_id NUMBER(10,0) NOT NULL,
  billing_name VARCHAR2(64) NOT NULL,
  billing_company VARCHAR2(32),
  billing_street_address VARCHAR2(64) NOT NULL,
  billing_suburb VARCHAR2(32),
  billing_city VARCHAR2(32) NOT NULL,
  billing_postcode VARCHAR2(10) NOT NULL,
  billing_state VARCHAR2(32),
  billing_country VARCHAR2(32) NOT NULL,
  billing_address_format_id NUMBER(10,0) NOT NULL,
  payment_method VARCHAR2(32) NOT NULL,
  cc_type VARCHAR2(20),
  cc_owner VARCHAR2(64),
  cc_number VARCHAR2(32),
  cc_expires VARCHAR2(4),
  last_modified TIMESTAMP,
  date_purchased TIMESTAMP,
  orders_status NUMBER(10,0) NOT NULL,
  orders_date_finished TIMESTAMP,
  currency char(3),
  currency_value NUMBER(14,6),
  PRIMARY KEY(orders_id)
);
BEGIN EXECUTE IMMEDIATE 'DROP SEQUENCE orders_SEQ'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE SEQUENCE orders_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

BEGIN EXECUTE IMMEDIATE 'DROP TABLE orders_products'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE orders_products (
  orders_products_id NUMBER(10,0) NOT NULL,
  orders_id NUMBER(10,0) NOT NULL,
  products_id NUMBER(10,0) NOT NULL,
  products_model VARCHAR2(12),
  products_name VARCHAR2(64) NOT NULL,
  products_price NUMBER(15,4) NOT NULL,
  final_price NUMBER(15,4) NOT NULL,
  products_tax NUMBER(7,4) NOT NULL,
  products_quantity NUMBER(10,0) NOT NULL,
  PRIMARY KEY(orders_products_id)
);
BEGIN EXECUTE IMMEDIATE 'DROP SEQUENCE orders_products_SEQ'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE SEQUENCE orders_products_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

BEGIN EXECUTE IMMEDIATE 'DROP TABLE orders_status'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE orders_status (
  orders_status_id NUMBER(10,0) DEFAULT 0 NOT NULL,
  language_id NUMBER(10,0) DEFAULT 1 NOT NULL,
  orders_status_name VARCHAR2(32) NOT NULL,
  PRIMARY KEY(orders_status_id, language_id)
);
CREATE INDEX idx_orders_status_name ON orders_status (orders_status_name);

BEGIN EXECUTE IMMEDIATE 'DROP TABLE orders_status_history'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE orders_status_history (
  orders_status_history_id NUMBER(10,0) NOT NULL,
  orders_id NUMBER(10,0) NOT NULL,
  orders_status_id NUMBER(10,0) NOT NULL,
  date_added TIMESTAMP NOT NULL,
  customer_notified NUMBER(10,0) DEFAULT 0,
  comments VARCHAR2(4000),
  PRIMARY KEY(orders_status_history_id)
);
BEGIN EXECUTE IMMEDIATE 'DROP SEQUENCE orders_status_history_SEQ'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE SEQUENCE orders_status_history_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

BEGIN EXECUTE IMMEDIATE 'DROP TABLE orders_products_attributes'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE orders_products_attributes (
  orders_products_attributes_id NUMBER(10,0) NOT NULL,
  orders_id NUMBER(10,0) NOT NULL,
  orders_products_id NUMBER(10,0) NOT NULL,
  products_options VARCHAR2(32) NOT NULL,
  products_options_values VARCHAR2(32) NOT NULL,
  options_values_price NUMBER(15,4) NOT NULL,
  price_prefix char(1) NOT NULL,
  PRIMARY KEY(orders_products_attributes_id)
);
BEGIN EXECUTE IMMEDIATE 'DROP SEQUENCE orders_products_attributes_SEQ'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE SEQUENCE orders_products_attributes_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

BEGIN EXECUTE IMMEDIATE 'DROP TABLE orders_products_download'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE orders_products_download (
  orders_products_download_id NUMBER(10,0) NOT NULL,
  orders_id NUMBER(10,0) DEFAULT 0 NOT NULL,
  orders_products_id NUMBER(10,0) DEFAULT 0 NOT NULL,
  orders_products_filename VARCHAR2(255) NOT NULL,
  download_maxdays NUMBER(10,0) DEFAULT 0 NOT NULL,
  download_count NUMBER(10,0) DEFAULT 0 NOT NULL,
  PRIMARY KEY(orders_products_download_id)
);
BEGIN EXECUTE IMMEDIATE 'DROP SEQUENCE orders_products_download_SEQ'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE SEQUENCE orders_products_download_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

BEGIN EXECUTE IMMEDIATE 'DROP TABLE orders_total'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE orders_total (
  orders_total_id NUMBER(10,0) NOT NULL,
  orders_id NUMBER(10,0) NOT NULL,
  title VARCHAR2(255) NOT NULL,
  text VARCHAR2(255) NOT NULL,
  value NUMBER(15,4) NOT NULL,
  class VARCHAR2(32) NOT NULL,
  sort_order NUMBER(10,0) NOT NULL,
  PRIMARY KEY(orders_total_id)
);
CREATE INDEX idx_orders_total_orders_id ON orders_total (orders_id);
BEGIN EXECUTE IMMEDIATE 'DROP SEQUENCE orders_total_SEQ'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE SEQUENCE orders_total_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

BEGIN EXECUTE IMMEDIATE 'DROP TABLE products'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE products (
  products_id NUMBER(10,0) NOT NULL,
  products_quantity NUMBER(10,0) NOT NULL,
  products_model VARCHAR2(12),
  products_image VARCHAR2(64),
  products_price NUMBER(15,4) NOT NULL,
  products_date_added TIMESTAMP NOT NULL,
  products_last_modified TIMESTAMP,
  products_date_available TIMESTAMP,
  products_weight NUMBER(5,2) NOT NULL,
  products_status NUMBER(3,0) NOT NULL,
  products_tax_class_id NUMBER(10,0) NOT NULL,
  manufacturers_id NUMBER(10,0) NULL,
  products_ordered NUMBER(10,0) DEFAULT 0 NOT NULL,
  PRIMARY KEY(products_id)
);
CREATE INDEX idx_products_date_added ON products (products_date_added);
BEGIN EXECUTE IMMEDIATE 'DROP SEQUENCE products_SEQ'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE SEQUENCE products_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

BEGIN EXECUTE IMMEDIATE 'DROP TABLE products_attributes'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE products_attributes (
  products_attributes_id NUMBER(10,0) NOT NULL,
  products_id NUMBER(10,0) NOT NULL,
  options_id NUMBER(10,0) NOT NULL,
  options_values_id NUMBER(10,0) NOT NULL,
  options_values_price NUMBER(15,4) NOT NULL,
  price_prefix char(1) NOT NULL,
  PRIMARY KEY(products_attributes_id)
);
BEGIN EXECUTE IMMEDIATE 'DROP SEQUENCE products_attributes_SEQ'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE SEQUENCE products_attributes_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

BEGIN EXECUTE IMMEDIATE 'DROP TABLE products_attrs_download'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE products_attrs_download (
  products_attributes_id NUMBER(10,0) NOT NULL,
  products_attributes_filename VARCHAR2(255) NOT NULL,
  products_attributes_maxdays NUMBER(10,0) DEFAULT 0,
  products_attributes_maxcount NUMBER(10,0) DEFAULT 0,
  PRIMARY KEY(products_attributes_id)
);

BEGIN EXECUTE IMMEDIATE 'DROP TABLE products_description'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE products_description (
  products_id NUMBER(10,0) NOT NULL,
  language_id NUMBER(10,0) DEFAULT 1 NOT NULL,
  products_name VARCHAR2(64) NOT NULL,
  products_description VARCHAR2(4000),
  products_url VARCHAR2(255) default NULL,
  products_viewed NUMBER(10,0) DEFAULT 0,
  PRIMARY KEY(products_id,language_id)
);
CREATE INDEX products_name ON products_description (products_name);
BEGIN EXECUTE IMMEDIATE 'DROP SEQUENCE products_description_SEQ'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE SEQUENCE products_description_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

BEGIN EXECUTE IMMEDIATE 'DROP TABLE products_notifications'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE products_notifications (
  products_id NUMBER(10,0) NOT NULL,
  customers_id NUMBER(10,0) NOT NULL,
  date_added TIMESTAMP NOT NULL,
  PRIMARY KEY(products_id, customers_id)
);

BEGIN EXECUTE IMMEDIATE 'DROP TABLE products_options'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE products_options (
  products_options_id NUMBER(10,0) DEFAULT 0 NOT NULL,
  language_id NUMBER(10,0) DEFAULT 1 NOT NULL,
  products_options_name VARCHAR2(32) NOT NULL,
  PRIMARY KEY(products_options_id,language_id)
);

BEGIN EXECUTE IMMEDIATE 'DROP TABLE products_options_values'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE products_options_values (
  products_options_values_id NUMBER(10,0) DEFAULT 0 NOT NULL,
  language_id NUMBER(10,0) DEFAULT 1 NOT NULL,
  products_options_values_name VARCHAR2(64) NOT NULL,
  PRIMARY KEY(products_options_values_id,language_id)
);

BEGIN EXECUTE IMMEDIATE 'DROP TABLE prod_opt_vals_to_prod_opt'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE prod_opt_vals_to_prod_opt (
  prod_opt_vals_to_prod_opt_id NUMBER(10,0) NOT NULL,
  products_options_id NUMBER(10,0) NOT NULL,
  products_options_values_id NUMBER(10,0) NOT NULL,
  PRIMARY KEY(prod_opt_vals_to_prod_opt_id)
);
BEGIN EXECUTE IMMEDIATE 'DROP SEQUENCE prod_opt_vals_to_prod_opt_SEQ'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE SEQUENCE prod_opt_vals_to_prod_opt_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

BEGIN EXECUTE IMMEDIATE 'DROP TABLE products_to_categories'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE products_to_categories (
  products_id NUMBER(10,0) NOT NULL,
  categories_id NUMBER(10,0) NOT NULL,
  PRIMARY KEY(products_id,categories_id)
);

BEGIN EXECUTE IMMEDIATE 'DROP TABLE reviews'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE reviews (
  reviews_id NUMBER(10,0) NOT NULL,
  products_id NUMBER(10,0) NOT NULL,
  customers_id int,
  customers_name VARCHAR2(64) NOT NULL,
  reviews_rating NUMBER(10,0),
  date_added TIMESTAMP,
  last_modified TIMESTAMP,
  reviews_read NUMBER(10,0) DEFAULT 0 NOT NULL,
  PRIMARY KEY(reviews_id)
);
BEGIN EXECUTE IMMEDIATE 'DROP SEQUENCE reviews_SEQ'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE SEQUENCE reviews_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

BEGIN EXECUTE IMMEDIATE 'DROP TABLE reviews_description'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE reviews_description (
  reviews_id NUMBER(10,0) NOT NULL,
  languages_id NUMBER(10,0) NOT NULL,
  reviews_text VARCHAR2(4000) NOT NULL,
  PRIMARY KEY(reviews_id, languages_id)
);

BEGIN EXECUTE IMMEDIATE 'DROP TABLE sessions'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE sessions (
  sesskey VARCHAR2(32) NOT NULL,
  expiry NUMBER(10,0) NOT NULL,
  value VARCHAR2(4000) NOT NULL,
  PRIMARY KEY(sesskey)
);

BEGIN EXECUTE IMMEDIATE 'DROP TABLE specials'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE specials (
  specials_id NUMBER(10,0) NOT NULL,
  products_id NUMBER(10,0) NOT NULL,
  specials_new_products_price NUMBER(15,4) NOT NULL,
  specials_date_added TIMESTAMP,
  specials_last_modified TIMESTAMP,
  expires_date TIMESTAMP,
  date_status_change TIMESTAMP,
  status NUMBER(10,0) DEFAULT 1 NOT NULL,
  PRIMARY KEY(specials_id)
);
BEGIN EXECUTE IMMEDIATE 'DROP SEQUENCE specials_SEQ'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE SEQUENCE specials_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

BEGIN EXECUTE IMMEDIATE 'DROP TABLE tax_class'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE tax_class (
  tax_class_id NUMBER(10,0) NOT NULL,
  tax_class_title VARCHAR2(32) NOT NULL,
  tax_class_description VARCHAR2(255) NOT NULL,
  last_modified TIMESTAMP NULL,
  date_added TIMESTAMP NOT NULL,
  PRIMARY KEY(tax_class_id)
);
BEGIN EXECUTE IMMEDIATE 'DROP SEQUENCE tax_class_SEQ'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE SEQUENCE tax_class_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

BEGIN EXECUTE IMMEDIATE 'DROP TABLE tax_rates'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE tax_rates (
  tax_rates_id NUMBER(10,0) NOT NULL,
  tax_zone_id NUMBER(10,0) NOT NULL,
  tax_class_id NUMBER(10,0) NOT NULL,
  tax_priority NUMBER(10,0) DEFAULT 1,
  tax_rate NUMBER(7,4) NOT NULL,
  tax_description VARCHAR2(255) NOT NULL,
  last_modified TIMESTAMP NULL,
  date_added TIMESTAMP NOT NULL,
  PRIMARY KEY(tax_rates_id)
);
BEGIN EXECUTE IMMEDIATE 'DROP SEQUENCE tax_rates_SEQ'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE SEQUENCE tax_rates_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

BEGIN EXECUTE IMMEDIATE 'DROP TABLE geo_zones'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE geo_zones (
  geo_zone_id NUMBER(10,0) NOT NULL,
  geo_zone_name VARCHAR2(32) NOT NULL,
  geo_zone_description VARCHAR2(255) NOT NULL,
  last_modified TIMESTAMP NULL,
  date_added TIMESTAMP NOT NULL,
  PRIMARY KEY(geo_zone_id)
);
BEGIN EXECUTE IMMEDIATE 'DROP SEQUENCE geo_zones_SEQ'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE SEQUENCE geo_zones_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

BEGIN EXECUTE IMMEDIATE 'DROP TABLE whos_online'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE whos_online (
  customer_id int,
  full_name VARCHAR2(64) NOT NULL,
  session_id VARCHAR2(128) NOT NULL,
  ip_address VARCHAR2(15) NOT NULL,
  time_entry VARCHAR2(14) NOT NULL,
  time_last_click VARCHAR2(14) NOT NULL,
  last_page_url VARCHAR2(64) NOT NULL
);

BEGIN EXECUTE IMMEDIATE 'DROP TABLE zones'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE zones (
  zone_id NUMBER(10,0) NOT NULL,
  zone_country_id NUMBER(10,0) NOT NULL,
  zone_code VARCHAR2(32) NOT NULL,
  zone_name VARCHAR2(32) NOT NULL,
  PRIMARY KEY(zone_id)
);
BEGIN EXECUTE IMMEDIATE 'DROP SEQUENCE zones_SEQ'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE SEQUENCE zones_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

BEGIN EXECUTE IMMEDIATE 'DROP TABLE zones_to_geo_zones'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE zones_to_geo_zones (
  association_id NUMBER(10,0) NOT NULL,
  zone_country_id NUMBER(10,0) NOT NULL,
  zone_id NUMBER(10,0) NULL,
  geo_zone_id NUMBER(10,0) NULL,
  last_modified TIMESTAMP NULL,
  date_added TIMESTAMP NOT NULL,
  PRIMARY KEY(association_id)
);
BEGIN EXECUTE IMMEDIATE 'DROP SEQUENCE zones_to_geo_zones_SEQ'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE SEQUENCE zones_to_geo_zones_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;


-- data

set echo on
INSERT INTO address_book VALUES (address_book_seq.nextval, 1, 'm', 'ACME Inc.', 'John', 'Doe', '1 Way Street', '', '12345', 'NeverNever', '', 223, 12);

-- 1 - Default, 2 - USA, 3 - Spain, 4 - Singapore, 5 - Germany
INSERT INTO address_format VALUES (address_format_seq.nextval, '$firstname $lastname$cr$streets$cr$city, $postcode$cr$statecomma$country','$city / $country');
INSERT INTO address_format VALUES (address_format_seq.nextval, '$firstname $lastname$cr$streets$cr$city, $state    $postcode$cr$country','$city, $state / $country');
INSERT INTO address_format VALUES (address_format_seq.nextval, '$firstname $lastname$cr$streets$cr$city$cr$postcode - $statecomma$country','$state / $country');
INSERT INTO address_format VALUES (address_format_seq.nextval, '$firstname $lastname$cr$streets$cr$city ($postcode)$cr$country', '$postcode / $country');
INSERT INTO address_format VALUES (address_format_seq.nextval, '$firstname $lastname$cr$streets$cr$postcode $city$cr$country','$city / $country');

INSERT INTO categories VALUES (categories_seq.nextval, 'no-image.png', '0', '1', sysdate, null);
INSERT INTO categories VALUES (categories_seq.nextval, 'no-image.png', '0', '2', sysdate, null);
INSERT INTO categories VALUES (categories_seq.nextval, 'no-image.png', '0', '3', sysdate, null);
INSERT INTO categories VALUES (categories_seq.nextval, 'no-image.png', '1', '0', sysdate, null);
INSERT INTO categories VALUES (categories_seq.nextval, 'no-image.png', '1', '0', sysdate, null);
INSERT INTO categories VALUES (categories_seq.nextval, 'no-image.png', '1', '0', sysdate, null);
INSERT INTO categories VALUES (categories_seq.nextval, 'no-image.png', '1', '0', sysdate, null);
INSERT INTO categories VALUES (categories_seq.nextval, 'no-image.png', '1', '0', sysdate, null);
INSERT INTO categories VALUES (categories_seq.nextval, 'no-image.png', '1', '0', sysdate, null);
INSERT INTO categories VALUES (categories_seq.nextval, 'no-image.png', '3', '0', sysdate, null);
INSERT INTO categories VALUES (categories_seq.nextval, 'no-image.png', '3', '0', sysdate, null);
INSERT INTO categories VALUES (categories_seq.nextval, 'no-image.png', '3', '0', sysdate, null);
INSERT INTO categories VALUES (categories_seq.nextval, 'no-image.png', '3', '0', sysdate, null);
INSERT INTO categories VALUES (categories_seq.nextval, 'no-image.png', '3', '0', sysdate, null);
INSERT INTO categories VALUES (categories_seq.nextval, 'no-image.png', '3', '0', sysdate, null);
INSERT INTO categories VALUES (categories_seq.nextval, 'no-image.png', '1', '0', sysdate, null);
INSERT INTO categories VALUES (categories_seq.nextval, 'no-image.png', '1', '0', sysdate, null);
INSERT INTO categories VALUES (categories_seq.nextval, 'no-image.png', '2', '0', sysdate, null);
INSERT INTO categories VALUES (categories_seq.nextval, 'no-image.png', '2', '0', sysdate, null);
INSERT INTO categories VALUES (categories_seq.nextval, 'no-image.png', '2', '0', sysdate, null);

INSERT INTO categories_description VALUES ( '1', '1', 'Hardware');
INSERT INTO categories_description VALUES ( '2', '1', 'Software');
INSERT INTO categories_description VALUES ( '3', '1', 'DVD Movies');
INSERT INTO categories_description VALUES ( '4', '1', 'Graphics Cards');
INSERT INTO categories_description VALUES ( '5', '1', 'Printers');
INSERT INTO categories_description VALUES ( '6', '1', 'Monitors');
INSERT INTO categories_description VALUES ( '7', '1', 'Speakers');
INSERT INTO categories_description VALUES ( '8', '1', 'Keyboards');
INSERT INTO categories_description VALUES ( '9', '1', 'Mice');
INSERT INTO categories_description VALUES ( '10', '1', 'Action');
INSERT INTO categories_description VALUES ( '11', '1', 'Science Fiction');
INSERT INTO categories_description VALUES ( '12', '1', 'Comedy');
INSERT INTO categories_description VALUES ( '13', '1', 'Cartoons');
INSERT INTO categories_description VALUES ( '14', '1', 'Thriller');
INSERT INTO categories_description VALUES ( '15', '1', 'Drama');
INSERT INTO categories_description VALUES ( '16', '1', 'Memory');
INSERT INTO categories_description VALUES ( '17', '1', 'CDROM Drives');
INSERT INTO categories_description VALUES ( '18', '1', 'Simulation');
INSERT INTO categories_description VALUES ( '19', '1', 'Action');
INSERT INTO categories_description VALUES ( '20', '1', 'Strategy');
INSERT INTO categories_description VALUES ( '1', '2', 'Hardware');
INSERT INTO categories_description VALUES ( '2', '2', 'Software');
INSERT INTO categories_description VALUES ( '3', '2', 'DVD Filme');
INSERT INTO categories_description VALUES ( '4', '2', 'Grafikkarten');
INSERT INTO categories_description VALUES ( '5', '2', 'Drucker');
INSERT INTO categories_description VALUES ( '6', '2', 'Bildschirme');
INSERT INTO categories_description VALUES ( '7', '2', 'Lautsprecher');
INSERT INTO categories_description VALUES ( '8', '2', 'Tastaturen');
INSERT INTO categories_description VALUES ( '9', '2', 'Mäuse');
INSERT INTO categories_description VALUES ( '10', '2', 'Action');
INSERT INTO categories_description VALUES ( '11', '2', 'Science Fiction');
INSERT INTO categories_description VALUES ( '12', '2', 'Komödie');
INSERT INTO categories_description VALUES ( '13', '2', 'Zeichentrick');
INSERT INTO categories_description VALUES ( '14', '2', 'Thriller');
INSERT INTO categories_description VALUES ( '15', '2', 'Drama');
INSERT INTO categories_description VALUES ( '16', '2', 'Speicher');
INSERT INTO categories_description VALUES ( '17', '2', 'CDROM Laufwerke');
INSERT INTO categories_description VALUES ( '18', '2', 'Simulation');
INSERT INTO categories_description VALUES ( '19', '2', 'Action');
INSERT INTO categories_description VALUES ( '20', '2', 'Strategie');
INSERT INTO categories_description VALUES ( '1', '3', 'Hardware');
INSERT INTO categories_description VALUES ( '2', '3', 'Software');
INSERT INTO categories_description VALUES ( '3', '3', 'Peliculas DVD');
INSERT INTO categories_description VALUES ( '4', '3', 'Tarjetas Graficas');
INSERT INTO categories_description VALUES ( '5', '3', 'Impresoras');
INSERT INTO categories_description VALUES ( '6', '3', 'Monitores');
INSERT INTO categories_description VALUES ( '7', '3', 'Altavoces');
INSERT INTO categories_description VALUES ( '8', '3', 'Teclados');
INSERT INTO categories_description VALUES ( '9', '3', 'Ratones');
INSERT INTO categories_description VALUES ( '10', '3', 'Accion');
INSERT INTO categories_description VALUES ( '11', '3', 'Ciencia Ficcion');
INSERT INTO categories_description VALUES ( '12', '3', 'Comedia');
INSERT INTO categories_description VALUES ( '13', '3', 'Dibujos Animados');
INSERT INTO categories_description VALUES ( '14', '3', 'Suspense');
INSERT INTO categories_description VALUES ( '15', '3', 'Drama');
INSERT INTO categories_description VALUES ( '16', '3', 'Memoria');
INSERT INTO categories_description VALUES ( '17', '3', 'Unidades CDROM');
INSERT INTO categories_description VALUES ( '18', '3', 'Simulacion');
INSERT INTO categories_description VALUES ( '19', '3', 'Accion');
INSERT INTO categories_description VALUES ( '20', '3', 'Estrategia');

--
-- Configuration groups
--

-- 1
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (configuration_seq.nextval, 'Store Name', 'STORE_NAME', 'KonaKart', 'The name of my store', '1', '1', sysdate);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (configuration_seq.nextval, 'Store Owner', 'STORE_OWNER', 'Kenny Kart', 'The name of my store owner', '1', '2', sysdate);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (configuration_seq.nextval, 'E-Mail Address', 'STORE_OWNER_EMAIL_ADDRESS', 'root@localhost', 'The e-mail address of my store owner', '1', '3', sysdate);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (configuration_seq.nextval, 'E-Mail From', 'EMAIL_FROM', 'KonaKart <root@localhost>', 'The e-mail address used in (sent) e-mails', '1', '4', sysdate);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, use_function, set_function, date_added) VALUES (configuration_seq.nextval, 'Country', 'STORE_COUNTRY', '223', 'The country my store is located in', '1', '6', 'tep_get_country_name', 'tep_cfg_pull_down_country_list(', sysdate);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, use_function, set_function, date_added) VALUES (configuration_seq.nextval, 'Zone', 'STORE_ZONE', '18', 'The zone my store is located in', '1', '7', 'tep_cfg_get_zone_name', 'tep_cfg_pull_down_zone_list(', sysdate);
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Expected Sort Order', 'EXPECTED_PRODUCTS_SORT', 'desc', 'This is the sort order used in the expected products box.', '1', '8', 'tep_cfg_select_option(array(\'asc\', \'desc\'), ', now());
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Expected Sort Field', 'EXPECTED_PRODUCTS_FIELD', 'date_expected', 'The column to sort by in the expected products box.', '1', '9', 'tep_cfg_select_option(array(\'products_name\', \'date_expected\'), ', now());
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Switch To Default Language Currency', 'USE_DEFAULT_LANGUAGE_CURRENCY', 'false', 'Automatically switch to the language\'s currency when it is changed', '1', '10', 'choice(\'true\'=\'true\',\'false\'=\'false\')', now());
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Use Search-Engine Safe URLs (still in development)', 'SEARCH_ENGINE_FRIENDLY_URLS', 'false', 'Use search-engine safe urls for all site links', '1', '12', 'choice(\'true\'=\'true\',\'false\'=\'false\')', now());
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Display Cart After Adding Product', 'DISPLAY_CART', 'true', 'Display the shopping cart after adding a product (or return back to their origin)', '1', '14', 'choice(\'true\'=\'true\',\'false\'=\'false\')', now());
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Allow Guest To Tell A Friend', 'ALLOW_GUEST_TO_TELL_A_FRIEND', 'false', 'Allow guests to tell a friend about a product', '1', '15', 'choice(\'true\'=\'true\',\'false\'=\'false\')', now());
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Default Search Operator', 'ADVANCED_SEARCH_DEFAULT_OPERATOR', 'and', 'Default search operators', '1', '17', 'tep_cfg_select_option(array(\'and\', \'or\'), ', now());
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Store Address and Phone', 'STORE_NAME_ADDRESS', 'Store Name\nAddress\nCountry\nPhone', 'This is the Store Name, Address and Phone used on printable documents and displayed online', '1', '18', 'tep_cfg_textarea(', now());
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (configuration_seq.nextval, 'Show Category Counts', 'SHOW_COUNTS', 'true', 'Count recursively how many products are in each category', '1', '19', 'choice(''true''=''true'',''false''=''false'')', sysdate);
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Tax Decimal Places', 'TAX_DECIMAL_PLACES', '0', 'Pad the tax value this amount of decimal places', '1', '20', now());
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (configuration_seq.nextval, 'Display Prices with Tax', 'DISPLAY_PRICE_WITH_TAX', 'false', 'Display prices with tax included (true) or add the tax at the end (false)', '1', '21', 'choice(''true''=''true'',''false''=''false'')', sysdate);

-- 2
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (configuration_seq.nextval, 'First Name', 'ENTRY_FIRST_NAME_MIN_LENGTH', '2', 'Minimum length of first name', '2', '1','integer(0,null)', sysdate);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (configuration_seq.nextval, 'Last Name', 'ENTRY_LAST_NAME_MIN_LENGTH', '2', 'Minimum length of last name', '2', '2', 'integer(0,null)', sysdate);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (configuration_seq.nextval, 'Date of Birth', 'ENTRY_DOB_MIN_LENGTH', '10', 'Minimum length of date of birth', '2', '3', 'integer(0,null)', sysdate);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (configuration_seq.nextval, 'E-Mail Address', 'ENTRY_EMAIL_ADDRESS_MIN_LENGTH', '6', 'Minimum length of e-mail address', '2', '4', 'integer(0,null)', sysdate);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (configuration_seq.nextval, 'Street Address', 'ENTRY_STREET_ADDRESS_MIN_LENGTH', '5', 'Minimum length of street address', '2', '5', 'integer(0,null)', sysdate);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (configuration_seq.nextval, 'Company', 'ENTRY_COMPANY_MIN_LENGTH', '2', 'Minimum length of company name', '2', '6', 'integer(0,null)', sysdate);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (configuration_seq.nextval, 'Post Code', 'ENTRY_POSTCODE_MIN_LENGTH', '4', 'Minimum length of post code', '2', '7', 'integer(0,null)', sysdate);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (configuration_seq.nextval, 'City', 'ENTRY_CITY_MIN_LENGTH', '3', 'Minimum length of city', '2', '8', 'integer(0,null)', sysdate);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (configuration_seq.nextval, 'State', 'ENTRY_STATE_MIN_LENGTH', '2', 'Minimum length of state', '2', '9', 'integer(0,null)', sysdate);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (configuration_seq.nextval, 'Telephone Number', 'ENTRY_TELEPHONE_MIN_LENGTH', '3', 'Minimum length of telephone number', '2', '10', 'integer(0,null)', sysdate);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (configuration_seq.nextval, 'Password', 'ENTRY_PASSWORD_MIN_LENGTH', '5', 'Minimum length of password', '2', '11', 'integer(0,null)', sysdate);
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Credit Card Owner Name', 'CC_OWNER_MIN_LENGTH', '3', 'Minimum length of credit card owner name', '2', '12', now());
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Credit Card Number', 'CC_NUMBER_MIN_LENGTH', '10', 'Minimum length of credit card number', '2', '13', now());
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Review Text', 'REVIEW_TEXT_MIN_LENGTH', '50', 'Minimum length of review text', '2', '14', now());
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Best Sellers', 'MIN_DISPLAY_BESTSELLERS', '1', 'Minimum number of best sellers to display', '2', '15', now());
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Also Purchased', 'MIN_DISPLAY_ALSO_PURCHASED', '1', 'Minimum number of products to display in the \'This Customer Also Purchased\' box', '2', '16', now());

-- 3
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (configuration_seq.nextval, 'Address Book Entries', 'MAX_ADDRESS_BOOK_ENTRIES', '5', 'Maximum address book entries a customer is allowed to have', '3', '1', 'integer(0,null)', sysdate);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (configuration_seq.nextval, 'Search Results', 'MAX_DISPLAY_SEARCH_RESULTS', '20', 'Number of products to list', '3', '2', 'integer(0,null)', sysdate);
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Page Links', 'MAX_DISPLAY_PAGE_LINKS', '5', 'Number of \'number\' links use for page-sets', '3', '3', now());
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Special Products', 'MAX_DISPLAY_SPECIAL_PRODUCTS', '9', 'Maximum number of products on special to display', '3', '4', now());
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (configuration_seq.nextval, 'New Products Module', 'MAX_DISPLAY_NEW_PRODUCTS', '9', 'Maximum number of new products to display in a category', '3', '5', 'integer(0,null)', sysdate);
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Products Expected', 'MAX_DISPLAY_UPCOMING_PRODUCTS', '10', 'Maximum number of products expected to display', '3', '6', now());
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (configuration_seq.nextval, 'Manufacturers List', 'MAX_DISPLAY_MANUFACTURERS_IN_A_LIST', '0', 'Used in manufacturers box; when the number of manufacturers exceeds this number, a drop-down list will be displayed instead of the default list', '3', '7', 'integer(0,null)', sysdate);
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Manufacturers Select Size', 'MAX_MANUFACTURERS_LIST', '1', 'Used in manufacturers box; when this value is \'1\' the classic drop-down list will be used for the manufacturers box. Otherwise, a list-box with the specified number of rows will be displayed.', '3', '7', now());
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (configuration_seq.nextval, 'Length of Manufacturers Name', 'MAX_DISPLAY_MANUFACTURER_NAME_LEN', '15', 'Used in manufacturers box; maximum length of manufacturers name to display', '3', '8', 'integer(0,null)', sysdate);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (configuration_seq.nextval, 'New Reviews', 'MAX_DISPLAY_NEW_REVIEWS', '5', 'Maximum number of new reviews to display', '3', '9', 'integer(0,null)', sysdate);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (configuration_seq.nextval, 'Selection of Random Reviews', 'MAX_RANDOM_SELECT_REVIEWS', '10', 'How many records to select from to choose one random product review', '3', '10', 'integer(0,null)', sysdate);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (configuration_seq.nextval, 'Selection of Random New Products', 'MAX_RANDOM_SELECT_NEW', '10', 'How many records to select from to choose one random new product to display', '3', '11', 'integer(0,null)', sysdate);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (configuration_seq.nextval, 'Selection of Products on Special', 'MAX_RANDOM_SELECT_SPECIALS', '10', 'How many records to select from to choose one random product special to display', '3', '12', 'integer(0,null)', sysdate);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (configuration_seq.nextval, 'Categories To List Per Row', 'MAX_DISPLAY_CATEGORIES_PER_ROW', '3', 'How many categories to list per row', '3', '13', 'integer(0,null)', sysdate);
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('New Products Listing', 'MAX_DISPLAY_PRODUCTS_NEW', '10', 'Maximum number of new products to display in new products page', '3', '14', now());
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (configuration_seq.nextval, 'Best Sellers', 'MAX_DISPLAY_BESTSELLERS', '10', 'Maximum number of best sellers to display', '3', '15', 'integer(0,null)', sysdate);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (configuration_seq.nextval, 'Also Purchased', 'MAX_DISPLAY_ALSO_PURCHASED', '6', 'Maximum number of products to display in the ''This Customer Also Purchased'' box', '3', '16', 'integer(0,null)', sysdate);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (configuration_seq.nextval, 'Customer Order History Box', 'MAX_DISPLAY_PRODUCTS_IN_ORDER_HISTORY_BOX', '6', 'Maximum number of products to display in the customer order history box', '3', '17', 'integer(0,null)', sysdate);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (configuration_seq.nextval, 'Order History', 'MAX_DISPLAY_ORDER_HISTORY', '10', 'Maximum number of orders to display in the order history page', '3', '18', 'integer(0,null)', sysdate);

-- 4
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (configuration_seq.nextval, 'Small Image Width', 'SMALL_IMAGE_WIDTH', '100', 'The pixel width of small images', '4', '1', 'integer(0,null)', sysdate);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (configuration_seq.nextval, 'Small Image Height', 'SMALL_IMAGE_HEIGHT', '80', 'The pixel height of small images', '4', '2', 'integer(0,null)', sysdate);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (configuration_seq.nextval, 'Heading Image Width', 'HEADING_IMAGE_WIDTH', '57', 'The pixel width of heading images', '4', '3', 'integer(0,null)', sysdate);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (configuration_seq.nextval, 'Heading Image Height', 'HEADING_IMAGE_HEIGHT', '40', 'The pixel height of heading images', '4', '4', 'integer(0,null)', sysdate);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (configuration_seq.nextval, 'Subcategory Image Width', 'SUBCATEGORY_IMAGE_WIDTH', '100', 'The pixel width of subcategory images', '4', '5', 'integer(0,null)', sysdate);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (configuration_seq.nextval, 'Subcategory Image Height', 'SUBCATEGORY_IMAGE_HEIGHT', '57', 'The pixel height of subcategory images', '4', '6', 'integer(0,null)', sysdate);
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Calculate Image Size', 'CONFIG_CALCULATE_IMAGE_SIZE', 'true', 'Calculate the size of images?', '4', '7', 'choice(\'true\'=\'true\',\'false\'=\'false\')', now());
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Image Required', 'IMAGE_REQUIRED', 'true', 'Enable to display broken images. Good for development.', '4', '8', 'choice(\'true\'=\'true\',\'false\'=\'false\')', now());

-- 5
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (configuration_seq.nextval, 'Gender', 'ACCOUNT_GENDER', 'true', 'Display gender in the customers account', '5', '1', 'choice(''true''=''true'',''false''=''false'')', sysdate);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (configuration_seq.nextval, 'Date of Birth', 'ACCOUNT_DOB', 'true', 'Display date of birth in the customers account', '5', '2', 'choice(''true''=''true'',''false''=''false'')', sysdate);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (configuration_seq.nextval, 'Company', 'ACCOUNT_COMPANY', 'true', 'Display company in the customers account', '5', '3', 'choice(''true''=''true'',''false''=''false'')', sysdate);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (configuration_seq.nextval, 'Suburb', 'ACCOUNT_SUBURB', 'true', 'Display suburb in the customers account', '5', '4', 'choice(''true''=''true'',''false''=''false'')', sysdate);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (configuration_seq.nextval, 'State', 'ACCOUNT_STATE', 'true', 'Display state in the customers account', '5', '5', 'choice(''true''=''true'',''false''=''false'')', sysdate);

-- 6 - Modules installed
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (configuration_seq.nextval, 'Installed Modules', 'MODULE_PAYMENT_INSTALLED', 'cod.php', 'List of payment module filenames separated by a semi-colon. This is automatically updated. No need to edit. (Example: cc.php;cod.php;paypal.php)', '6', '0', sysdate);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (configuration_seq.nextval, 'Installed Modules', 'MODULE_ORDER_TOTAL_INSTALLED', 'ot_subtotal.php;ot_tax.php;ot_shipping.php;ot_total.php', 'List of order_total module filenames separated by a semi-colon. This is automatically updated. No need to edit. (Example: ot_subtotal.php;ot_tax.php;ot_shipping.php;ot_total.php)', '6', '0', sysdate);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (configuration_seq.nextval, 'Installed Modules', 'MODULE_SHIPPING_INSTALLED', 'flat.php', 'List of shipping module filenames separated by a semi-colon. This is automatically updated. No need to edit. (Example: ups.php;flat.php;item.php)', '6', '0', sysdate);

-- 6 - COD module
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (configuration_seq.nextval, 'Enable Cash On Delivery Module', 'MODULE_PAYMENT_COD_STATUS', 'True', 'Do you want to accept Cash On Delevery payments?', '6', '1', 'choice(''true''=''true'',''false''=''false'')', sysdate);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, use_function, set_function, date_added) VALUES (configuration_seq.nextval, 'Payment Zone', 'MODULE_PAYMENT_COD_ZONE', '0', 'If a zone is selected, only enable this payment method for that zone.', '6', '2', 'tep_get_zone_class_title', 'tep_cfg_pull_down_zone_classes(', sysdate);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (configuration_seq.nextval, 'Sort order of display.', 'MODULE_PAYMENT_COD_SORT_ORDER', '0', 'Sort order of display. Lowest is displayed first.', '6', '0', sysdate);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, use_function, date_added) VALUES (configuration_seq.nextval, 'Set Order Status', 'MODULE_PAYMENT_COD_ORDER_STATUS_ID', '0', 'Set the status of orders made with this payment module to this value', '6', '0', 'tep_cfg_pull_down_order_statuses(', 'tep_get_order_status_name', sysdate);

--6 - Shipping Flat
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (configuration_seq.nextval, 'Enable Flat Shipping', 'MODULE_SHIPPING_FLAT_STATUS', 'True', 'Do you want to offer flat rate shipping?', '6', '0', 'choice(''true''=''true'',''false''=''false'')', sysdate);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (configuration_seq.nextval, 'Shipping Cost', 'MODULE_SHIPPING_FLAT_COST', '5.00', 'The shipping cost for all orders using this shipping method.', '6', '0', sysdate);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, use_function, set_function, date_added) VALUES (configuration_seq.nextval, 'Tax Class', 'MODULE_SHIPPING_FLAT_TAX_CLASS', '0', 'Use the following tax class on the shipping fee.', '6', '0', 'tep_get_tax_class_title', 'tep_cfg_pull_down_tax_classes(', sysdate);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, use_function, set_function, date_added) VALUES (configuration_seq.nextval, 'Shipping Zone', 'MODULE_SHIPPING_FLAT_ZONE', '0', 'If a zone is selected, only enable this shipping method for that zone.', '6', '0', 'tep_get_zone_class_title', 'tep_cfg_pull_down_zone_classes(', sysdate);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (configuration_seq.nextval, 'Sort Order', 'MODULE_SHIPPING_FLAT_SORT_ORDER', '0', 'Sort order of display.', '6', '0', sysdate);

--6 - Order Totals
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (configuration_seq.nextval, 'Display Shipping', 'MODULE_ORDER_TOTAL_SHIPPING_STATUS', 'true', 'Do you want to display the order shipping cost?', '6', '1','choice(''true''=''true'',''false''=''false'')', sysdate);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (configuration_seq.nextval, 'Sort Order', 'MODULE_ORDER_TOTAL_SHIPPING_SORT_ORDER', '2', 'Sort order of display.', '6', '2', sysdate);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (configuration_seq.nextval, 'Display Sub-Total', 'MODULE_ORDER_TOTAL_SUBTOTAL_STATUS', 'true', 'Do you want to display the order sub-total cost?', '6', '1','choice(''true''=''true'',''false''=''false'')', sysdate);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (configuration_seq.nextval, 'Sort Order', 'MODULE_ORDER_TOTAL_SUBTOTAL_SORT_ORDER', '1', 'Sort order of display.', '6', '2', sysdate);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (configuration_seq.nextval, 'Display Tax', 'MODULE_ORDER_TOTAL_TAX_STATUS', 'true', 'Do you want to display the order tax value?', '6', '1','choice(''true''=''true'',''false''=''false'')', sysdate);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (configuration_seq.nextval, 'Sort Order', 'MODULE_ORDER_TOTAL_TAX_SORT_ORDER', '39', 'Sort order of display.', '6', '2', sysdate);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (configuration_seq.nextval, 'Display Total', 'MODULE_ORDER_TOTAL_TOTAL_STATUS', 'true', 'Do you want to display the total order value?', '6', '1','choice(''true''=''true'',''false''=''false'')', sysdate);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (configuration_seq.nextval, 'Sort Order', 'MODULE_ORDER_TOTAL_TOTAL_SORT_ORDER', '40', 'Sort order of display.', '6', '2', sysdate);

-- 6 - Defaults
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (configuration_seq.nextval, 'Default Currency', 'DEFAULT_CURRENCY', 'USD', 'Default Currency', '6', '0', sysdate);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (configuration_seq.nextval, 'Default Language', 'DEFAULT_LANGUAGE', 'en', 'Default Language', '6', '0', sysdate);
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Default Order Status For New Orders', 'DEFAULT_ORDERS_STATUS_ID', '1', 'When a new order is created, this order status will be assigned to it.', '6', '0', now());


-- 7
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, use_function, set_function, date_added) VALUES (configuration_seq.nextval, 'Country of Origin', 'SHIPPING_ORIGIN_COUNTRY', '223', 'Select the country of origin to be used in shipping quotes.', '7', '1', 'tep_get_country_name', 'tep_cfg_pull_down_country_list(', sysdate);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (configuration_seq.nextval, 'Postal Code', 'SHIPPING_ORIGIN_ZIP', 'NONE', 'Enter the Postal Code (ZIP) of the Store to be used in shipping quotes.', '7', '2', sysdate);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (configuration_seq.nextval, 'Enter the Maximum Package Weight you will ship', 'SHIPPING_MAX_WEIGHT', '50', 'Carriers have a max weight limit for a single package. This is a common one for all.', '7', '3', 'double(0,null)', sysdate);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (configuration_seq.nextval, 'Package Tare weight.', 'SHIPPING_BOX_WEIGHT', '3', 'What is the weight of typical packaging of small to medium packages?', '7', '4', 'double(0,null)', sysdate);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (configuration_seq.nextval, 'Larger packages - percentage increase.', 'SHIPPING_BOX_PADDING', '10', 'For 10% enter 10', '7', '5', 'double(0,null)', sysdate);

-- 8
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Display Product Image', 'PRODUCT_LIST_IMAGE', '1', 'Do you want to display the Product Image?', '8', '1', now());
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Display Product Manufaturer Name','PRODUCT_LIST_MANUFACTURER', '0', 'Do you want to display the Product Manufacturer Name?', '8', '2', now());
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Display Product Model', 'PRODUCT_LIST_MODEL', '0', 'Do you want to display the Product Model?', '8', '3', now());
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Display Product Name', 'PRODUCT_LIST_NAME', '2', 'Do you want to display the Product Name?', '8', '4', now());
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Display Product Price', 'PRODUCT_LIST_PRICE', '3', 'Do you want to display the Product Price', '8', '5', now());
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Display Product Quantity', 'PRODUCT_LIST_QUANTITY', '0', 'Do you want to display the Product Quantity?', '8', '6', now());
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Display Product Weight', 'PRODUCT_LIST_WEIGHT', '0', 'Do you want to display the Product Weight?', '8', '7', now());
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Display Buy Now column', 'PRODUCT_LIST_BUY_NOW', '4', 'Do you want to display the Buy Now column?', '8', '8', now());
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Display Category/Manufacturer Filter (0=disable; 1=enable)', 'PRODUCT_LIST_FILTER', '1', 'Do you want to display the Category/Manufacturer Filter?', '8', '9', now());
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Location of Prev/Next Navigation Bar (1-top, 2-bottom, 3-both)', 'PREV_NEXT_BAR_LOCATION', '2', 'Sets the location of the Prev/Next Navigation Bar (1-top, 2-bottom, 3-both)', '8', '10', now());

-- 9
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (configuration_seq.nextval, 'Check stock level', 'STOCK_CHECK', 'true', 'Check to see if sufficent stock is available', '9', '1', 'choice(''true''=''true'',''false''=''false'')', sysdate);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (configuration_seq.nextval, 'Subtract stock', 'STOCK_LIMITED', 'true', 'Subtract product in stock by product orders', '9', '2', 'choice(''true''=''true'',''false''=''false'')', sysdate);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (configuration_seq.nextval, 'Allow Checkout', 'STOCK_ALLOW_CHECKOUT', 'true', 'Allow customer to checkout even if there is insufficient stock', '9', '3', 'choice(''true''=''true'',''false''=''false'')', sysdate);
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Mark product out of stock', 'STOCK_MARK_PRODUCT_OUT_OF_STOCK', '***', 'Display something on screen so customer can see which product has insufficient stock', '9', '4', now());
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (configuration_seq.nextval, 'Stock Re-order level', 'STOCK_REORDER_LEVEL', '5', 'Define when stock needs to be re-ordered', '9', '5', 'integer(null,null)', sysdate);

-- 10
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Store Page Parse Time', 'STORE_PAGE_PARSE_TIME', 'false', 'Store the time it takes to parse a page', '10', '1', 'choice(\'true\'=\'true\',\'false\'=\'false\')', now());
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Log Destination', 'STORE_PAGE_PARSE_TIME_LOG', '/var/log/www/tep/page_parse_time.log', 'Directory and filename of the page parse time log', '10', '2', now());
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Log Date Format', 'STORE_PARSE_DATE_TIME_FORMAT', '%d/%m/%Y %H:%M:%S', 'The date format', '10', '3', now());
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Display The Page Parse Time', 'DISPLAY_PAGE_PARSE_TIME', 'true', 'Display the page parse time (store page parse time must be enabled)', '10', '4', 'choice(\'true\'=\'true\',\'false\'=\'false\')', now());
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Store Database Queries', 'STORE_DB_TRANSACTIONS', 'false', 'Store the database queries in the page parse time log (PHP4 only)', '10', '5', 'choice(\'true\'=\'true\',\'false\'=\'false\')', now());

-- 11
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Use Cache', 'USE_CACHE', 'false', 'Use caching features', '11', '1', 'choice(\'true\'=\'true\',\'false\'=\'false\')', now());
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Cache Directory', 'DIR_FS_CACHE', '/tmp/', 'The directory where the cached files are saved', '11', '2', now());

-- 12
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('E-Mail Transport Method', 'EMAIL_TRANSPORT', 'sendmail', 'Defines if this server uses a local connection to sendmail or uses an SMTP connection via TCP/IP. Servers running on Windows and MacOS should change this setting to SMTP.', '12', '1', 'tep_cfg_select_option(array(\'sendmail\', \'smtp\'),', now());
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('E-Mail Linefeeds', 'EMAIL_LINEFEED', 'LF', 'Defines the character sequence used to separate mail headers.', '12', '2', 'tep_cfg_select_option(array(\'LF\', \'CRLF\'),', now());
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Use MIME HTML When Sending Emails', 'EMAIL_USE_HTML', 'false', 'Send e-mails in HTML format', '12', '3', 'choice(\'true\'=\'true\',\'false\'=\'false\')', now());
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Verify E-Mail Addresses Through DNS', 'ENTRY_EMAIL_ADDRESS_CHECK', 'false', 'Verify e-mail address through a DNS server', '12', '4', 'choice(\'true\'=\'true\',\'false\'=\'false\')', now());
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (configuration_seq.nextval, 'Send E-Mails', 'SEND_EMAILS', 'true', 'Send out e-mails', '12', '1', 'choice(''true''=''true'',''false''=''false'')', sysdate);

-- 13
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Enable download', 'DOWNLOAD_ENABLED', 'false', 'Enable the products download functions.', '13', '1', 'choice(\'true\'=\'true\',\'false\'=\'false\')', now());
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Download by redirect', 'DOWNLOAD_BY_REDIRECT', 'false', 'Use browser redirection for download. Disable on non-Unix systems.', '13', '2', 'choice(\'true\'=\'true\',\'false\'=\'false\')', now());
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Expiry delay (days)' ,'DOWNLOAD_MAX_DAYS', '7', 'Set number of days before the download link expires. 0 means no limit.', '13', '3', '', now());
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Maximum number of downloads' ,'DOWNLOAD_MAX_COUNT', '5', 'Set the maximum number of downloads. 0 means no download authorized.', '13', '4', '', now());

-- 14
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Enable GZip Compression', 'GZIP_COMPRESSION', 'false', 'Enable HTTP GZip compression.', '14', '1', 'choice(\'true\'=\'true\',\'false\'=\'false\')', now());
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Compression Level', 'GZIP_LEVEL', '5', 'Use this compression level 0-9 (0 = minimum, 9 = maximum).', '14', '2', now());

-- 15
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Session Directory', 'SESSION_WRITE_DIRECTORY', '/tmp', 'If sessions are file based, store them in this directory.', '15', '1', now());
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Force Cookie Use', 'SESSION_FORCE_COOKIE_USE', 'False', 'Force the use of sessions when cookies are only enabled.', '15', '2', 'choice(\'true\'=\'true\',\'false\'=\'false\')', now());
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Check SSL Session ID', 'SESSION_CHECK_SSL_SESSION_ID', 'False', 'Validate the SSL_SESSION_ID on every secure HTTPS page request.', '15', '3', 'choice(\'true\'=\'true\',\'false\'=\'false\')', now());
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Check User Agent', 'SESSION_CHECK_USER_AGENT', 'False', 'Validate the clients browser user agent on every page request.', '15', '4', 'choice(\'true\'=\'true\',\'false\'=\'false\')', now());
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Check IP Address', 'SESSION_CHECK_IP_ADDRESS', 'False', 'Validate the clients IP address on every page request.', '15', '5', 'choice(\'true\'=\'true\',\'false\'=\'false\')', now());
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Prevent Spider Sessions', 'SESSION_BLOCK_SPIDERS', 'False', 'Prevent known spiders from starting a session.', '15', '6', 'choice(\'true\'=\'true\',\'false\'=\'false\')', now());
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Recreate Session', 'SESSION_RECREATE', 'False', 'Recreate the session to generate a new session ID when the customer logs on or creates an account (PHP >=4.1 needed).', '15', '7', 'choice(\'true\'=\'true\',\'false\'=\'false\')', now());

INSERT INTO configuration_group VALUES (configuration_group_seq.nextval, 'My Store', 'General information about my store', '1', '1');
INSERT INTO configuration_group VALUES (configuration_group_seq.nextval, 'Minimum Values', 'The minimum values for functions / data', '2', '1');
INSERT INTO configuration_group VALUES (configuration_group_seq.nextval, 'Maximum Values', 'The maximum values for functions / data', '3', '1');
INSERT INTO configuration_group VALUES (configuration_group_seq.nextval, 'Images', 'Image parameters', '4', '1');
INSERT INTO configuration_group VALUES (configuration_group_seq.nextval, 'Customer Details', 'Customer account configuration', '5', '1');
INSERT INTO configuration_group VALUES (configuration_group_seq.nextval, 'Module Options', 'Hidden from configuration', '6', '0');
INSERT INTO configuration_group VALUES (configuration_group_seq.nextval, 'Shipping/Packaging', 'Shipping options available at my store', '7', '1');
--INSERT INTO configuration_group VALUES ('8', 'Product Listing', 'Product Listing    configuration options', '8', '1');
INSERT INTO configuration_group VALUES (configuration_group_seq.nextval, 'Stock', 'Stock configuration options', '9', '1');
--INSERT INTO configuration_group VALUES ('10', 'Logging', 'Logging configuration options', '10', '1');
INSERT INTO configuration_group VALUES (configuration_group_seq.nextval, 'Cache', 'Caching configuration options', '11', '1');
INSERT INTO configuration_group VALUES (configuration_group_seq.nextval, 'E-Mail Options', 'General setting for E-Mail transport and HTML E-Mails', '12', '1');
--INSERT INTO configuration_group VALUES ('13', 'Download', 'Downloadable products options', '13', '1');
--INSERT INTO configuration_group VALUES ('14', 'GZip Compression', 'GZip compression options', '14', '1');
--INSERT INTO configuration_group VALUES ('15', 'Sessions', 'Session options', '15', '1');

INSERT INTO countries VALUES (countries_seq.nextval,'Afghanistan','AF','AFG','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Albania','AL','ALB','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Algeria','DZ','DZA','1');
INSERT INTO countries VALUES (countries_seq.nextval,'American Samoa','AS','ASM','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Andorra','AD','AND','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Angola','AO','AGO','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Anguilla','AI','AIA','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Antarctica','AQ','ATA','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Antigua and Barbuda','AG','ATG','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Argentina','AR','ARG','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Armenia','AM','ARM','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Aruba','AW','ABW','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Australia','AU','AUS','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Austria','AT','AUT','5');
INSERT INTO countries VALUES (countries_seq.nextval,'Azerbaijan','AZ','AZE','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Bahamas','BS','BHS','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Bahrain','BH','BHR','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Bangladesh','BD','BGD','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Barbados','BB','BRB','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Belarus','BY','BLR','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Belgium','BE','BEL','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Belize','BZ','BLZ','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Benin','BJ','BEN','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Bermuda','BM','BMU','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Bhutan','BT','BTN','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Bolivia','BO','BOL','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Bosnia and Herzegowina','BA','BIH','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Botswana','BW','BWA','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Bouvet Island','BV','BVT','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Brazil','BR','BRA','1');
INSERT INTO countries VALUES (countries_seq.nextval,'British Indian Ocean Territory','IO','IOT','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Brunei Darussalam','BN','BRN','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Bulgaria','BG','BGR','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Burkina Faso','BF','BFA','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Burundi','BI','BDI','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Cambodia','KH','KHM','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Cameroon','CM','CMR','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Canada','CA','CAN','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Cape Verde','CV','CPV','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Cayman Islands','KY','CYM','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Central African Republic','CF','CAF','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Chad','TD','TCD','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Chile','CL','CHL','1');
INSERT INTO countries VALUES (countries_seq.nextval,'China','CN','CHN','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Christmas Island','CX','CXR','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Cocos (Keeling) Islands','CC','CCK','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Colombia','CO','COL','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Comoros','KM','COM','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Congo','CG','COG','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Cook Islands','CK','COK','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Costa Rica','CR','CRI','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Cote D''Ivoire','CI','CIV','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Croatia','HR','HRV','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Cuba','CU','CUB','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Cyprus','CY','CYP','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Czech Republic','CZ','CZE','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Denmark','DK','DNK','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Djibouti','DJ','DJI','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Dominica','DM','DMA','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Dominican Republic','DO','DOM','1');
INSERT INTO countries VALUES (countries_seq.nextval,'East Timor','TP','TMP','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Ecuador','EC','ECU','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Egypt','EG','EGY','1');
INSERT INTO countries VALUES (countries_seq.nextval,'El Salvador','SV','SLV','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Equatorial Guinea','GQ','GNQ','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Eritrea','ER','ERI','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Estonia','EE','EST','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Ethiopia','ET','ETH','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Falkland Islands (Malvinas)','FK','FLK','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Faroe Islands','FO','FRO','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Fiji','FJ','FJI','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Finland','FI','FIN','1');
INSERT INTO countries VALUES (countries_seq.nextval,'France','FR','FRA','1');
INSERT INTO countries VALUES (countries_seq.nextval,'France, Metropolitan','FX','FXX','1');
INSERT INTO countries VALUES (countries_seq.nextval,'French Guiana','GF','GUF','1');
INSERT INTO countries VALUES (countries_seq.nextval,'French Polynesia','PF','PYF','1');
INSERT INTO countries VALUES (countries_seq.nextval,'French Southern Territories','TF','ATF','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Gabon','GA','GAB','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Gambia','GM','GMB','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Georgia','GE','GEO','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Germany','DE','DEU','5');
INSERT INTO countries VALUES (countries_seq.nextval,'Ghana','GH','GHA','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Gibraltar','GI','GIB','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Greece','GR','GRC','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Greenland','GL','GRL','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Grenada','GD','GRD','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Guadeloupe','GP','GLP','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Guam','GU','GUM','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Guatemala','GT','GTM','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Guinea','GN','GIN','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Guinea-bissau','GW','GNB','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Guyana','GY','GUY','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Haiti','HT','HTI','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Heard and Mc Donald Islands','HM','HMD','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Honduras','HN','HND','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Hong Kong','HK','HKG','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Hungary','HU','HUN','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Iceland','IS','ISL','1');
INSERT INTO countries VALUES (countries_seq.nextval,'India','IN','IND','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Indonesia','ID','IDN','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Iran (Islamic Republic of)','IR','IRN','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Iraq','IQ','IRQ','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Ireland','IE','IRL','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Israel','IL','ISR','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Italy','IT','ITA','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Jamaica','JM','JAM','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Japan','JP','JPN','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Jordan','JO','JOR','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Kazakhstan','KZ','KAZ','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Kenya','KE','KEN','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Kiribati','KI','KIR','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Korea, Democratic People''s Republic of','KP','PRK','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Korea, Republic of','KR','KOR','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Kuwait','KW','KWT','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Kyrgyzstan','KG','KGZ','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Lao People''s Democratic Republic','LA','LAO','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Latvia','LV','LVA','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Lebanon','LB','LBN','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Lesotho','LS','LSO','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Liberia','LR','LBR','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Libyan Arab Jamahiriya','LY','LBY','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Liechtenstein','LI','LIE','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Lithuania','LT','LTU','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Luxembourg','LU','LUX','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Macau','MO','MAC','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Macedonia, The Former Yugoslav Republic of','MK','MKD','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Madagascar','MG','MDG','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Malawi','MW','MWI','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Malaysia','MY','MYS','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Maldives','MV','MDV','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Mali','ML','MLI','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Malta','MT','MLT','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Marshall Islands','MH','MHL','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Martinique','MQ','MTQ','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Mauritania','MR','MRT','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Mauritius','MU','MUS','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Mayotte','YT','MYT','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Mexico','MX','MEX','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Micronesia, Federated States of','FM','FSM','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Moldova, Republic of','MD','MDA','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Monaco','MC','MCO','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Mongolia','MN','MNG','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Montserrat','MS','MSR','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Morocco','MA','MAR','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Mozambique','MZ','MOZ','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Myanmar','MM','MMR','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Namibia','NA','NAM','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Nauru','NR','NRU','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Nepal','NP','NPL','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Netherlands','NL','NLD','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Netherlands Antilles','AN','ANT','1');
INSERT INTO countries VALUES (countries_seq.nextval,'New Caledonia','NC','NCL','1');
INSERT INTO countries VALUES (countries_seq.nextval,'New Zealand','NZ','NZL','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Nicaragua','NI','NIC','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Niger','NE','NER','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Nigeria','NG','NGA','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Niue','NU','NIU','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Norfolk Island','NF','NFK','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Northern Mariana Islands','MP','MNP','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Norway','NO','NOR','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Oman','OM','OMN','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Pakistan','PK','PAK','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Palau','PW','PLW','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Panama','PA','PAN','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Papua New Guinea','PG','PNG','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Paraguay','PY','PRY','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Peru','PE','PER','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Philippines','PH','PHL','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Pitcairn','PN','PCN','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Poland','PL','POL','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Portugal','PT','PRT','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Puerto Rico','PR','PRI','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Qatar','QA','QAT','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Reunion','RE','REU','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Romania','RO','ROM','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Russian Federation','RU','RUS','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Rwanda','RW','RWA','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Saint Kitts and Nevis','KN','KNA','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Saint Lucia','LC','LCA','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Saint Vincent and the Grenadines','VC','VCT','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Samoa','WS','WSM','1');
INSERT INTO countries VALUES (countries_seq.nextval,'San Marino','SM','SMR','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Sao Tome and Principe','ST','STP','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Saudi Arabia','SA','SAU','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Senegal','SN','SEN','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Seychelles','SC','SYC','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Sierra Leone','SL','SLE','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Singapore','SG','SGP', '4');
INSERT INTO countries VALUES (countries_seq.nextval,'Slovakia (Slovak Republic)','SK','SVK','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Slovenia','SI','SVN','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Solomon Islands','SB','SLB','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Somalia','SO','SOM','1');
INSERT INTO countries VALUES (countries_seq.nextval,'South Africa','ZA','ZAF','1');
INSERT INTO countries VALUES (countries_seq.nextval,'South Georgia and the South Sandwich Islands','GS','SGS','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Spain','ES','ESP','3');
INSERT INTO countries VALUES (countries_seq.nextval,'Sri Lanka','LK','LKA','1');
INSERT INTO countries VALUES (countries_seq.nextval,'St. Helena','SH','SHN','1');
INSERT INTO countries VALUES (countries_seq.nextval,'St. Pierre and Miquelon','PM','SPM','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Sudan','SD','SDN','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Suriname','SR','SUR','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Svalbard and Jan Mayen Islands','SJ','SJM','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Swaziland','SZ','SWZ','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Sweden','SE','SWE','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Switzerland','CH','CHE','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Syrian Arab Republic','SY','SYR','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Taiwan','TW','TWN','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Tajikistan','TJ','TJK','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Tanzania, United Republic of','TZ','TZA','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Thailand','TH','THA','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Togo','TG','TGO','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Tokelau','TK','TKL','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Tonga','TO','TON','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Trinidad and Tobago','TT','TTO','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Tunisia','TN','TUN','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Turkey','TR','TUR','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Turkmenistan','TM','TKM','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Turks and Caicos Islands','TC','TCA','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Tuvalu','TV','TUV','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Uganda','UG','UGA','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Ukraine','UA','UKR','1');
INSERT INTO countries VALUES (countries_seq.nextval,'United Arab Emirates','AE','ARE','1');
INSERT INTO countries VALUES (countries_seq.nextval,'United Kingdom','GB','GBR','1');
INSERT INTO countries VALUES (countries_seq.nextval,'United States','US','USA', '2');
INSERT INTO countries VALUES (countries_seq.nextval,'United States Minor Outlying Islands','UM','UMI','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Uruguay','UY','URY','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Uzbekistan','UZ','UZB','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Vanuatu','VU','VUT','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Vatican City State (Holy See)','VA','VAT','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Venezuela','VE','VEN','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Viet Nam','VN','VNM','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Virgin Islands (British)','VG','VGB','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Virgin Islands (U.S.)','VI','VIR','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Wallis and Futuna Islands','WF','WLF','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Western Sahara','EH','ESH','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Yemen','YE','YEM','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Yugoslavia','YU','YUG','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Zaire','ZR','ZAR','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Zambia','ZM','ZMB','1');
INSERT INTO countries VALUES (countries_seq.nextval,'Zimbabwe','ZW','ZWE','1');

INSERT INTO currencies VALUES (currencies_seq.nextval,'US Dollar','USD','$','','.',',','2',to_number('1.0000', '9D9999', 'NLS_NUMERIC_CHARACTERS = ''.,'''), sysdate);
INSERT INTO currencies VALUES (currencies_seq.nextval,'Euro','EUR','','EUR','.',',','2',to_number('1.4000', '9D9999', 'NLS_NUMERIC_CHARACTERS = ''.,'''), sysdate);

-- John Doe User "root@localhost.com" Password: "password"
INSERT INTO customers VALUES (customers_seq.nextval, 'm', 'John', 'doe', to_date('2001/01/01', 'yyyy/mm/dd'), 'root@localhost', '1', '12345', '', 'd95e8fa7f20a009372eb3477473fcd34:1c', '0');

INSERT INTO customers_info VALUES (1, sysdate, 0, sysdate, sysdate, 0);

INSERT INTO languages VALUES (languages_seq.nextval,'English','en','icon.gif','english',1);
INSERT INTO languages VALUES (languages_seq.nextval,'Deutsch','de','icon.gif','german',2);
INSERT INTO languages VALUES (languages_seq.nextval,'Español','es','icon.gif','espanol',3);

INSERT INTO manufacturers VALUES (manufacturers_seq.nextval,'Matrox','manufacturer_matrox.gif', sysdate, null);
INSERT INTO manufacturers VALUES (manufacturers_seq.nextval,'Microsoft','manufacturer_microsoft.gif', sysdate, null);
INSERT INTO manufacturers VALUES (manufacturers_seq.nextval,'Warner','manufacturer_warner.gif', sysdate, null);
INSERT INTO manufacturers VALUES (manufacturers_seq.nextval,'Fox','manufacturer_fox.gif', sysdate, null);
INSERT INTO manufacturers VALUES (manufacturers_seq.nextval,'Logitech','manufacturer_logitech.gif', sysdate, null);
INSERT INTO manufacturers VALUES (manufacturers_seq.nextval,'Canon','manufacturer_canon.gif', sysdate, null);
INSERT INTO manufacturers VALUES (manufacturers_seq.nextval,'Sierra','manufacturer_sierra.gif', sysdate, null);
INSERT INTO manufacturers VALUES (manufacturers_seq.nextval,'GT Interactive','manufacturer_gt_interactive.gif', sysdate, null);
INSERT INTO manufacturers VALUES (manufacturers_seq.nextval,'Hewlett Packard','manufacturer_hewlett_packard.gif', sysdate, null);

INSERT INTO manufacturers_info VALUES (1, 1, 'http://www.matrox.com', 0, null);
INSERT INTO manufacturers_info VALUES (1, 2, 'http://www.matrox.de', 0, null);
INSERT INTO manufacturers_info VALUES (1, 3, 'http://www.matrox.com', 0, null);
INSERT INTO manufacturers_info VALUES (2, 1, 'http://www.microsoft.com', 0, null);
INSERT INTO manufacturers_info VALUES (2, 2, 'http://www.microsoft.de', 0, null);
INSERT INTO manufacturers_info VALUES (2, 3, 'http://www.microsoft.es', 0, null);
INSERT INTO manufacturers_info VALUES (3, 1, 'http://www.warner.com', 0, null);
INSERT INTO manufacturers_info VALUES (3, 2, 'http://www.warner.de', 0, null);
INSERT INTO manufacturers_info VALUES (3, 3, 'http://www.warner.com', 0, null);
INSERT INTO manufacturers_info VALUES (4, 1, 'http://www.fox.com', 0, null);
INSERT INTO manufacturers_info VALUES (4, 2, 'http://www.fox.de', 0, null);
INSERT INTO manufacturers_info VALUES (4, 3, 'http://www.fox.com', 0, null);
INSERT INTO manufacturers_info VALUES (5, 1, 'http://www.logitech.com', 0, null);
INSERT INTO manufacturers_info VALUES (5, 2, 'http://www.logitech.com', 0, null);
INSERT INTO manufacturers_info VALUES (5, 3, 'http://www.logitech.com', 0, null);
INSERT INTO manufacturers_info VALUES (6, 1, 'http://www.canon.com', 0, null);
INSERT INTO manufacturers_info VALUES (6, 2, 'http://www.canon.de', 0, null);
INSERT INTO manufacturers_info VALUES (6, 3, 'http://www.canon.es', 0, null);
INSERT INTO manufacturers_info VALUES (7, 1, 'http://www.sierra.com', 0, null);
INSERT INTO manufacturers_info VALUES (7, 2, 'http://www.sierra.de', 0, null);
INSERT INTO manufacturers_info VALUES (7, 3, 'http://www.sierra.com', 0, null);
INSERT INTO manufacturers_info VALUES (8, 1, 'http://www.infogrames.com', 0, null);
INSERT INTO manufacturers_info VALUES (8, 2, 'http://www.infogrames.de', 0, null);
INSERT INTO manufacturers_info VALUES (8, 3, 'http://www.infogrames.com', 0, null);
INSERT INTO manufacturers_info VALUES (9, 1, 'http://www.hewlettpackard.com', 0, null);
INSERT INTO manufacturers_info VALUES (9, 2, 'http://www.hewlettpackard.de', 0, null);
INSERT INTO manufacturers_info VALUES (9, 3, 'http://welcome.hp.com/country/es/spa/welcome.htm', 0, null);

INSERT INTO orders_status VALUES ( '1', '1', 'Pending');
INSERT INTO orders_status VALUES ( '1', '2', 'Offen');
INSERT INTO orders_status VALUES ( '1', '3', 'Pendiente');
INSERT INTO orders_status VALUES ( '2', '1', 'Processing');
INSERT INTO orders_status VALUES ( '2', '2', 'In Bearbeitung');
INSERT INTO orders_status VALUES ( '2', '3', 'Proceso');
INSERT INTO orders_status VALUES ( '3', '1', 'Delivered');
INSERT INTO orders_status VALUES ( '3', '2', 'Versendet');
INSERT INTO orders_status VALUES ( '3', '3', 'Entregado');
INSERT INTO orders_status(orders_status_id, language_id, orders_status_name) VALUES (4,1,'Waiting for Payment');
INSERT INTO orders_status(orders_status_id, language_id, orders_status_name) VALUES (4,2,'Wartezahlung');
INSERT INTO orders_status(orders_status_id, language_id, orders_status_name) VALUES (4,3,'Para pago que espera');
INSERT INTO orders_status(orders_status_id, language_id, orders_status_name) VALUES (5,1,'Payment Received');
INSERT INTO orders_status(orders_status_id, language_id, orders_status_name) VALUES (5,2,'Zahlung empfing');
INSERT INTO orders_status(orders_status_id, language_id, orders_status_name) VALUES (5,3,'Pago recibido');
INSERT INTO orders_status(orders_status_id, language_id, orders_status_name) VALUES (6,1,'Payment Declined');
INSERT INTO orders_status(orders_status_id, language_id, orders_status_name) VALUES (6,2,'Zahlung sank');
INSERT INTO orders_status(orders_status_id, language_id, orders_status_name) VALUES (6,3,'Pago declinado');


INSERT INTO products VALUES (products_seq.nextval,32,'MG200MMS','matrox/mg200mms.gif',299.99, sysdate,null,sysdate,23.00,1,1,1,0);
INSERT INTO products VALUES (products_seq.nextval,32,'MG400-32MB','matrox/mg400-32mb.gif',499.99, sysdate,null,sysdate,23.00,1,1,1,0);
INSERT INTO products VALUES (products_seq.nextval,2,'MSIMPRO','microsoft/msimpro.gif',49.99, sysdate,null,sysdate,7.00,1,1,3,0);
INSERT INTO products VALUES (products_seq.nextval,13,'DVD-RPMK','dvd/replacement_killers.gif',42.00, sysdate,null,sysdate,23.00,1,1,2,0);
INSERT INTO products VALUES (products_seq.nextval,17,'DVD-BLDRNDC','dvd/blade_runner.gif',35.99, sysdate,null,sysdate,7.00,1,1,3,0);
INSERT INTO products VALUES (products_seq.nextval,10,'DVD-MATR','dvd/the_matrix.gif',39.99, sysdate,null,sysdate,7.00,1,1,3,0);
INSERT INTO products VALUES (products_seq.nextval,10,'DVD-YGEM','dvd/youve_got_mail.gif',34.99, sysdate,null,sysdate,7.00,1,1,3,0);
INSERT INTO products VALUES (products_seq.nextval,10,'DVD-ABUG','dvd/a_bugs_life.gif',35.99, sysdate,null,sysdate,7.00,1,1,3,0);
INSERT INTO products VALUES (products_seq.nextval,10,'DVD-UNSG','dvd/under_siege.gif',29.99, sysdate,null,sysdate,7.00,1,1,3,0);
INSERT INTO products VALUES (products_seq.nextval,10,'DVD-UNSG2','dvd/under_siege2.gif',29.99, sysdate,null,sysdate,7.00,1,1,3,0);
INSERT INTO products VALUES (products_seq.nextval,10,'DVD-FDBL','dvd/fire_down_below.gif',29.99, sysdate,null,sysdate,7.00,1,1,3,0);
INSERT INTO products VALUES (products_seq.nextval,10,'DVD-DHWV','dvd/die_hard_3.gif',39.99, sysdate,null,sysdate,7.00,1,1,4,0);
INSERT INTO products VALUES (products_seq.nextval,10,'DVD-LTWP','dvd/lethal_weapon.gif',34.99, sysdate,null,sysdate,7.00,1,1,3,0);
INSERT INTO products VALUES (products_seq.nextval,10,'DVD-REDC','dvd/red_corner.gif',32.00, sysdate,null,sysdate,7.00,1,1,3,0);
INSERT INTO products VALUES (products_seq.nextval,10,'DVD-FRAN','dvd/frantic.gif',35.00, sysdate,null,sysdate,7.00,1,1,3,0);
INSERT INTO products VALUES (products_seq.nextval,10,'DVD-CUFI','dvd/courage_under_fire.gif',38.99, sysdate,null,sysdate,7.00,1,1,4,0);
INSERT INTO products VALUES (products_seq.nextval,10,'DVD-SPEED','dvd/speed.gif',39.99, sysdate,null,sysdate,7.00,1,1,4,0);
INSERT INTO products VALUES (products_seq.nextval,10,'DVD-SPEED2','dvd/speed_2.gif',42.00, sysdate,null,sysdate,7.00,1,1,4,0);
INSERT INTO products VALUES (products_seq.nextval,10,'DVD-TSAB','dvd/theres_something_about_mary.gif',49.99, sysdate,null,sysdate,7.00,1,1,4,0);
INSERT INTO products VALUES (products_seq.nextval,10,'DVD-BELOVED','dvd/beloved.gif',54.99, sysdate,null,sysdate,7.00,1,1,3,0);
INSERT INTO products VALUES (products_seq.nextval,16,'PC-SWAT3','sierra/swat_3.gif',79.99, sysdate,null,sysdate,7.00,1,1,7,0);
INSERT INTO products VALUES (products_seq.nextval,13,'PC-UNTM','gt_interactive/unreal_tournament.gif',89.99, sysdate,null,sysdate,7.00,1,1,8,0);
INSERT INTO products VALUES (products_seq.nextval,16,'PC-TWOF','gt_interactive/wheel_of_time.gif',99.99, sysdate,null,sysdate,10.00,1,1,8,0);
INSERT INTO products VALUES (products_seq.nextval,17,'PC-DISC','gt_interactive/disciples.gif',90.00, sysdate,null,sysdate,8.00,1,1,8,0);
INSERT INTO products VALUES (products_seq.nextval,16,'MSINTKB','microsoft/intkeyboardps2.gif',69.99, sysdate,null,sysdate,8.00,1,1,2,0);
INSERT INTO products VALUES (products_seq.nextval,10,'MSIMEXP','microsoft/imexplorer.gif',64.95, sysdate,null,sysdate,8.00,1,1,2,0);
INSERT INTO products VALUES (products_seq.nextval,8,'HPLJ1100XI','hewlett_packard/lj1100xi.gif',499.99, sysdate,null,sysdate,45.00,1,1,9,0);

INSERT INTO products_description VALUES (products_description_seq.nextval,1,'Matrox G200 MMS','Reinforcing its position as a multi-monitor trailblazer, Matrox Graphics Inc. has once again developed the most flexible and highly advanced solution in the industry. Introducing the new Matrox G200 Multi-Monitor Series; the first graphics card ever to support up to four DVI digital flat panel displays on a single 8' || chr(34) || ' PCI board.<br><br>With continuing demand for digital flat panels in the financial workplace, the Matrox G200 MMS is the ultimate in flexible solutions. The Matrox G200 MMS also supports the new digital video interface (DVI) created by the Digital Display Working Group (DDWG) designed to ease the adoption of digital flat panels. Other configurations include composite video capture ability and onboard TV tuner, making the Matrox G200 MMS the complete solution for business needs.<br><br>Based on the award-winning MGA-G200 graphics chip, the Matrox G200 Multi-Monitor Series provides superior 2D/3D graphics acceleration to meet the demanding needs of business applications such as real-time stock quotes (Versus), live video feeds (Reuters ' || chr(38) || ' Bloombergs), multiple windows applications, word processing, spreadsheets and CAD.','www.matrox.com/mga/products/g200_mms/home.cfm',0);
INSERT INTO products_description VALUES (products_description_seq.nextval,1,'Matrox G400 32MB','<b>Dramatically Different High Performance Graphics</b><br><br>Introducing the Millennium G400 Series - a dramatically different, high performance graphics experience. Armed with the industry''s fastest graphics chip, the Millennium G400 Series takes explosive acceleration two steps further by adding unprecedented image quality, along with the most versatile display options for all your 3D, 2D and DVD applications. As the most powerful and innovative tools in your PC''s arsenal, the Millennium G400 Series will not only change the way you see graphics, but will revolutionize the way you use your computer.<br><br><b>Key features:</b><ul><li>New Matrox G400 256-bit DualBus graphics chip</li><li>Explosive 3D, 2D and DVD performance</li><li>DualHead Display</li><li>Superior DVD and TV output</li><li>3D Environment-Mapped Bump Mapping</li><li>Vibrant Color Quality rendering </li><li>UltraSharp DAC of up to 360 MHz</li><li>3D Rendering Array Processor</li><li>Support for 16 or 32 MB of memory</li></ul>','www.matrox.com/mga/products/mill_g400/home.htm',0);
INSERT INTO products_description VALUES (products_description_seq.nextval,1,'Microsoft IntelliMouse Pro','Every element of IntelliMouse Pro - from its unique arched shape to the texture of the rubber grip around its base - is the product of extensive customer and ergonomic research. Microsoft''s popular wheel control, which now allows zooming and universal scrolling functions, gives IntelliMouse Pro outstanding comfort and efficiency.','www.microsoft.com/hardware/mouse/intellimouse.asp',0);
INSERT INTO products_description VALUES (products_description_seq.nextval,1,'The Replacement Killers','Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br>Languages: English, Deutsch.<br>Subtitles: English, Deutsch, Spanish.<br>Audio: Dolby Surround 5.1.<br>Picture Format: 16:9 Wide-Screen.<br>Length: (approx) 80 minutes.<br>Other: Interactive Menus, Chapter Selection, Subtitles (more languages).','www.replacement-killers.com',0);
INSERT INTO products_description VALUES (products_description_seq.nextval,1,'Blade Runner - Director''s Cut','Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br>Languages: English, Deutsch.<br>Subtitles: English, Deutsch, Spanish.<br>Audio: Dolby Surround 5.1.<br>Picture Format: 16:9 Wide-Screen.<br>Length: (approx) 112 minutes.<br>Other: Interactive Menus, Chapter Selection, Subtitles (more languages).','www.bladerunner.com',0);
INSERT INTO products_description VALUES (products_description_seq.nextval,1,'The Matrix','Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br><br>Languages: English, Deutsch.<br><br>Subtitles: English, Deutsch.<br><br>Audio: Dolby Surround.<br><br>Picture Format: 16:9 Wide-Screen.<br><br>Length: (approx) 131 minutes.<br><br>Other: Interactive Menus, Chapter Selection, Making Of.','www.thematrix.com',0);
INSERT INTO products_description VALUES (products_description_seq.nextval,1,'You''ve Got Mail','Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br><br>Languages: English, Deutsch, Spanish.<br><br>Subtitles: English, Deutsch, Spanish, French, Nordic, Polish.<br><br>Audio: Dolby Digital 5.1.<br><br>Picture Format: 16:9 Wide-Screen.<br><br>Length: (approx) 115 minutes.<br><br>Other: Interactive Menus, Chapter Selection, Subtitles (more languages).','www.youvegotmail.com',0);
INSERT INTO products_description VALUES (products_description_seq.nextval,1,'A Bug''s Life','Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br><br>Languages: English, Deutsch.<br><br>Subtitles: English, Deutsch, Spanish.<br><br>Audio: Dolby Digital 5.1 / Dobly Surround Stereo.<br><br>Picture Format: 16:9 Wide-Screen.<br><br>Length: (approx) 91 minutes.<br><br>Other: Interactive Menus, Chapter Selection, Subtitles (more languages).','www.abugslife.com',0);
INSERT INTO products_description VALUES (products_description_seq.nextval,1,'Under Siege','Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br><br>Languages: English, Deutsch.<br><br>Subtitles: English, Deutsch, Spanish.<br><br>Audio: Dolby Surround 5.1.<br><br>Picture Format: 16:9 Wide-Screen.<br><br>Length: (approx) 98 minutes.<br><br>Other: Interactive Menus, Chapter Selection, Subtitles (more languages).','',0);
INSERT INTO products_description VALUES (products_description_seq.nextval,1,'Under Siege 2 - Dark Territory','Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br><br>Languages: English, Deutsch.<br><br>Subtitles: English, Deutsch, Spanish.<br><br>Audio: Dolby Surround 5.1.<br><br>Picture Format: 16:9 Wide-Screen.<br><br>Length: (approx) 98 minutes.<br><br>Other: Interactive Menus, Chapter Selection, Subtitles (more languages).','',0);
INSERT INTO products_description VALUES (products_description_seq.nextval,1,'Fire Down Below','Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br><br>Languages: English, Deutsch.<br><br>Subtitles: English, Deutsch, Spanish.<br><br>Audio: Dolby Surround 5.1.<br><br>Picture Format: 16:9 Wide-Screen.<br><br>Length: (approx) 100 minutes.<br><br>Other: Interactive Menus, Chapter Selection, Subtitles (more languages).','',0);
INSERT INTO products_description VALUES (products_description_seq.nextval,1,'Die Hard With A Vengeance','Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br><br>Languages: English, Deutsch.<br><br>Subtitles: English, Deutsch, Spanish.<br><br>Audio: Dolby Surround 5.1.<br><br>Picture Format: 16:9 Wide-Screen.<br><br>Length: (approx) 122 minutes.<br><br>Other: Interactive Menus, Chapter Selection, Subtitles (more languages).','',0);
INSERT INTO products_description VALUES (products_description_seq.nextval,1,'Lethal Weapon','Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br><br>Languages: English, Deutsch.<br><br>Subtitles: English, Deutsch, Spanish.<br><br>Audio: Dolby Surround 5.1.<br><br>Picture Format: 16:9 Wide-Screen.<br><br>Length: (approx) 100 minutes.<br><br>Other: Interactive Menus, Chapter Selection, Subtitles (more languages).','',0);
INSERT INTO products_description VALUES (products_description_seq.nextval,1,'Red Corner','Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br><br>Languages: English, Deutsch.<br><br>Subtitles: English, Deutsch, Spanish.<br><br>Audio: Dolby Surround 5.1.<br><br>Picture Format: 16:9 Wide-Screen.<br><br>Length: (approx) 117 minutes.<br><br>Other: Interactive Menus, Chapter Selection, Subtitles (more languages).','',0);
INSERT INTO products_description VALUES (products_description_seq.nextval,1,'Frantic','Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br><br>Languages: English, Deutsch.<br><br>Subtitles: English, Deutsch, Spanish.<br><br>Audio: Dolby Surround 5.1.<br><br>Picture Format: 16:9 Wide-Screen.<br><br>Length: (approx) 115 minutes.<br><br>Other: Interactive Menus, Chapter Selection, Subtitles (more languages).','',0);
INSERT INTO products_description VALUES (products_description_seq.nextval,1,'Courage Under Fire','Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br><br>Languages: English, Deutsch.<br><br>Subtitles: English, Deutsch, Spanish.<br><br>Audio: Dolby Surround 5.1.<br><br>Picture Format: 16:9 Wide-Screen.<br><br>Length: (approx) 112 minutes.<br><br>Other: Interactive Menus, Chapter Selection, Subtitles (more languages).','',0);
INSERT INTO products_description VALUES (products_description_seq.nextval,1,'Speed','Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br><br>Languages: English, Deutsch.<br><br>Subtitles: English, Deutsch, Spanish.<br><br>Audio: Dolby Surround 5.1.<br><br>Picture Format: 16:9 Wide-Screen.<br><br>Length: (approx) 112 minutes.<br><br>Other: Interactive Menus, Chapter Selection, Subtitles (more languages).','',0);
INSERT INTO products_description VALUES (products_description_seq.nextval,1,'Speed 2: Cruise Control','Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br><br>Languages: English, Deutsch.<br><br>Subtitles: English, Deutsch, Spanish.<br><br>Audio: Dolby Surround 5.1.<br><br>Picture Format: 16:9 Wide-Screen.<br><br>Length: (approx) 120 minutes.<br><br>Other: Interactive Menus, Chapter Selection, Subtitles (more languages).','',0);
INSERT INTO products_description VALUES (products_description_seq.nextval,1,'There''s Something About Mary','Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br><br>Languages: English, Deutsch.<br><br>Subtitles: English, Deutsch, Spanish.<br><br>Audio: Dolby Surround 5.1.<br><br>Picture Format: 16:9 Wide-Screen.<br><br>Length: (approx) 114 minutes.<br><br>Other: Interactive Menus, Chapter Selection, Subtitles (more languages).','',0);
INSERT INTO products_description VALUES (products_description_seq.nextval,1,'Beloved','Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br><br>Languages: English, Deutsch.<br><br>Subtitles: English, Deutsch, Spanish.<br><br>Audio: Dolby Surround 5.1.<br><br>Picture Format: 16:9 Wide-Screen.<br><br>Length: (approx) 164 minutes.<br><br>Other: Interactive Menus, Chapter Selection, Subtitles (more languages).','',0);
INSERT INTO products_description VALUES (products_description_seq.nextval,1,'SWAT 3: Close Quarters Battle','<b>Windows 95/98</b><br><br>211 in progress with shots fired. Officer down. Armed suspects with hostages. Respond Code 3! Los Angles, 2005, In the next seven days, representatives from every nation around the world will converge on Las Angles to witness the signing of the United Nations Nuclear Abolishment Treaty. The protection of these dignitaries falls on the shoulders of one organization, LAPD SWAT. As part of this elite tactical organization, you and your team have the weapons and all the training necessary to protect, to serve, and \"When needed\" to use deadly force to keep the peace. It takes more than weapons to make it through each mission. Your arsenal includes C2 charges, flashbangs, tactical grenades. opti-Wand mini-video cameras, and other devices critical to meeting your objectives and keeping your men free of injury. Uncompromised Duty, Honor and Valor!','www.swat3.com',0);
INSERT INTO products_description VALUES (products_description_seq.nextval,1,'Unreal Tournament','From the creators of the best-selling Unreal, comes Unreal Tournament. A new kind of single player experience. A ruthless multiplayer revolution.<br><br>This stand-alone game showcases completely new team-based gameplay, groundbreaking multi-faceted single player action or dynamic multi-player mayhem. It''s a fight to the finish for the title of Unreal Grand Master in the gladiatorial arena. A single player experience like no other! Guide your team of ''bots'' (virtual teamates) against the hardest criminals in the galaxy for the ultimate title - the Unreal Grand Master.','www.unrealtournament.net',0);
INSERT INTO products_description VALUES (products_description_seq.nextval,1,'The Wheel Of Time','The world in which The Wheel of Time takes place is lifted directly out of Jordan''s pages; it''s huge and consists of many different environments. How you navigate the world will depend largely on which game - single player or multipayer - you''re playing. The single player experience, with a few exceptions, will see Elayna traversing the world mainly by foot (with a couple notable exceptions). In the multiplayer experience, your character will have more access to travel via Ter''angreal, Portal Stones, and the Ways. However you move around, though, you''ll quickly discover that means of locomotion can easily become the least of the your worries...<br><br>During your travels, you quickly discover that four locations are crucial to your success in the game. Not surprisingly, these locations are the homes of The Wheel of Time''s main characters. Some of these places are ripped directly from the pages of Jordan''s books, made flesh with Legend''s unparalleled pixel-pushing ways. Other places are specific to the game, conceived and executed with the intent of expanding this game world even further. Either way, they provide a backdrop for some of the most intense first person action and strategy you''ll have this year.','www.wheeloftime.com',0);
INSERT INTO products_description VALUES (products_description_seq.nextval,1,'Disciples: Sacred Lands','A new age is dawning...<br><br>Enter the realm of the Sacred Lands, where the dawn of a New Age has set in motion the most momentous of wars. As the prophecies long foretold, four races now clash with swords and sorcery in a desperate bid to control the destiny of their gods. Take on the quest as a champion of the Empire, the Mountain Clans, the Legions of the Damned, or the Undead Hordes and test your faith in battles of brute force, spellbinding magic and acts of guile. Slay demons, vanquish giants and combat merciless forces of the dead and undead. But to ensure the salvation of your god, the hero within must evolve.<br><br>The day of reckoning has come... and only the chosen will survive.','',0);
INSERT INTO products_description VALUES (products_description_seq.nextval,1,'Microsoft Internet Keyboard PS/2','The Internet Keyboard has 10 Hot Keys on a comfortable standard keyboard design that also includes a detachable palm rest. The Hot Keys allow you to browse the web, or check e-mail directly from your keyboard. The IntelliType Pro software also allows you to customize your hot keys - make the Internet Keyboard work the way you want it to!','',0);
INSERT INTO products_description VALUES (products_description_seq.nextval,1,'Microsoft IntelliMouse Explorer','Microsoft introduces its most advanced mouse, the IntelliMouse Explorer! IntelliMouse Explorer features a sleek design, an industrial-silver finish, a glowing red underside and taillight, creating a style and look unlike any other mouse. IntelliMouse Explorer combines the accuracy and reliability of Microsoft IntelliEye optical tracking technology, the convenience of two new customizable function buttons, the efficiency of the scrolling wheel and the comfort of expert ergonomic design. All these great features make this the best mouse for the PC!','www.microsoft.com/hardware/mouse/explorer.asp',0);
INSERT INTO products_description VALUES (products_description_seq.nextval,1,'Hewlett Packard LaserJet 1100Xi','HP has always set the pace in laser printing technology. The new generation HP LaserJet 1100 series sets another impressive pace, delivering a stunning 8 pages per minute print speed. The 600 dpi print resolution with HP''s Resolution Enhancement technology (REt) makes every document more professional.<br><br>Enhanced print speed and laser quality results are just the beginning. With 2MB standard memory, HP LaserJet 1100xi users will be able to print increasingly complex pages. Memory can be increased to 18MB to tackle even more complex documents with ease. The HP LaserJet 1100xi supports key operating systems including Windows 3.1, 3.11, 95, 98, NT 4.0, OS/2 and DOS. Network compatibility available via the optional HP JetDirect External Print Servers.<br><br>HP LaserJet 1100xi also features The Document Builder for the Web Era from Trellix Corp. (featuring software to create Web documents).','www.pandi.hp.com/pandi-db/prodinfo.main?product=laserjet1100',0);
INSERT INTO products_description VALUES (1,2,'Matrox G200 MMS','<b>Unterstützung für zwei bzw. vier analoge oder digitale Monitore</b><br><br>Die Matrox G200 Multi-Monitor-Serie führt die bewährte Matrox Tradition im Multi-Monitor- Bereich fort und bietet flexible und fortschrittliche Lösungen.Matrox stellt als erstes Unternehmen einen vierfachen digitalen PanelLink® DVI Flachbildschirm Ausgang zur Verfügung. Mit den optional erhältlichen TV Tuner und Video-Capture Möglichkeiten stellt die Matrox G200 MMS eine alles umfassende Mehrschirm-Lösung dar.<br><br><b>Leistungsmerkmale:</b><br><ul><br><li>Preisgekrönter Matrox G200 128-Bit Grafikchip</li><br><li>Schneller 8 MB SGRAM-Speicher pro Kanal</li><br><li>Integrierter, leistungsstarker 250 MHz RAMDAC</li><br><li>Unterstützung für bis zu 16 Bildschirme über 4 Quad-Karten (unter Win NT,ab Treiber 4.40)</li><br><li>Unterstützung von 9 Monitoren unter Win 98</li><br><li>2 bzw. 4 analoge oder digitale Ausgabekanäle pro PCI-Karte</li><br><li>Desktop-Darstellung von 1800 x 1440 oder 1920 x 1200 pro Chip</li><br><li>Anschlußmöglichkeit an einen 15-poligen VGA-Monitor oder an einen 30-poligen digitalen DVI-Flachbildschirm plus integriertem Composite-Video-Eingang (bei der TV-Version)</li><br><li>PCI Grafikkarte, kurze Baulänge</li><br><li>Treiberunterstützung: Windows® 2000, Windows NT® und Windows® 98</li><br><li>Anwendungsbereiche: Börsenumgebung mit zeitgleich großem Visualisierungsbedarf, Videoüberwachung, Video-Conferencing</li><br></ul>','www.matrox.com/mga/deutsch/products/g200_mms/home.cfm',0);
INSERT INTO products_description VALUES (2,2,'Matrox G400 32 MB','<b>Neu! Matrox G400 ' || chr(34) || 'all inclusive' || chr(34) || ' und vieles mehr...</b><br><br>Die neue Millennium G400-Serie - Hochleistungsgrafik mit dem sensationellen Unterschied. Ausgestattet mit dem neu eingeführten Matrox G400 Grafikchip, bietet die Millennium G400-Serie eine überragende Beschleunigung inklusive bisher nie dagewesener Bildqualitat und enorm flexibler Darstellungsoptionen bei allen Ihren 3D-, 2D- und DVD-Anwendungen.<br><br><ul><br><li>DualHead Display und TV-Ausgang</li><br><li>Environment Mapped Bump Mapping</li><br><li>Matrox G400 256-Bit DualBus</li><br><li>3D Rendering Array Prozessor</li><br><li>Vibrant Color Quality² (VCQ²)</li><br><li>UltraSharp DAC</li><br></ul><br><i>' || chr(34) || 'Bleibt abschließend festzustellen, daß die Matrox Millennium G400 Max als Allroundkarte für den Highend-PC derzeit unerreicht ist. Das ergibt den Testsieg und unsere wärmste Empfehlung.' || chr(34) || '</i><br><br><b>GameStar 8/99 (S.184)</b>','www.matrox.com/mga/deutsch/products/mill_g400/home.cfm',0);
INSERT INTO products_description VALUES (3,2,'Microsoft IntelliMouse Pro','Die IntelliMouse Pro hat mit der IntelliRad-Technologie einen neuen Standard gesetzt. Anwenderfreundliche Handhabung und produktiveres Arbeiten am PC zeichnen die IntelliMouse aus. Die gewölbte Oberseite paßt sich natürlich in die Handfläche ein, die geschwungene Form erleichtert das Bedienen der Maus. Sie ist sowohl für Rechts- wie auch für Linkshänder geeignet. Mit dem Rad der IntelliMouse kann der Anwender einfach und komfortabel durch Dokumente navigieren.<br><br><b>Eigenschaften:</b><br><ul><br><li><b>ANSCHLUSS:</b> PS/2</li><br><li><b>FARBE:</b> weiß</li><br><li><b>TECHNIK:</b> Mauskugel</li><br><li><b>TASTEN:</b> 3 (incl. Scrollrad)</li><br><li><b>SCROLLRAD:</b> Ja</li><br></ul>','',0);
INSERT INTO products_description VALUES (4,2,'Die Ersatzkiller','Originaltitel: ' || chr(34) || 'The Replacement Killers' || chr(34) || '<br><br>Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br><br>Sprachen: English, Deutsch.<br><br>Untertitel: English, Deutsch, Spanish.<br><br>Audio: Dolby Surround 5.1.<br><br>Bildformat: 16:9 Wide-Screen.<br><br>Dauer: (approx) 80 minutes.<br><br>Außerdem: Interaktive Menus, Kapitelauswahl, Untertitel.<br><br>(USA 1998). Til Schweiger schießt auf Hongkong-Star Chow Yun-Fat (' || chr(34) || 'Anna und der König' || chr(34) || ') ­ ein Fehler ...','www.replacement-killers.com',0);
INSERT INTO products_description VALUES (5,2,'Blade Runner - Director''s Cut','Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br><br>Sprachen: English, Deutsch.<br><br>Untertitel: English, Deutsch, Spanish.<br><br>Audio: Dolby Surround 5.1.<br><br>Bildformat: 16:9 Wide-Screen.<br><br>Dauer: (approx) 112 minutes.<br><br>Außerdem: Interaktive Menus, Kapitelauswahl, Untertitel.<br><br><b>Sci-Fi-Klassiker, USA 1983, 112 Min.</b><br><br>Los Angeles ist im Jahr 2019 ein Hexenkessel. Dauerregen und Smog tauchen den überbevölkerten Moloch in ewige Dämmerung. Polizeigleiter schwirren durch die Luft und überwachen das grelle Ethnogemisch, das sich am Fuße 400stöckiger Stahlbeton-Pyramiden tummelt. Der abgehalfterte Ex-Cop und \"Blade Runner\" Rick Deckard ist Spezialist für die Beseitigung von Replikanten, künstlichen Menschen, geschaffen für harte Arbeit auf fremden Planeten. Nur ihm kann es gelingen, vier flüchtige, hochintelligente \"Nexus 6\"-Spezialmodelle zu stellen. Die sind mit ihrem starken und brandgefährlichen Anführer Batty auf der Suche nach ihrem Schöpfer. Er soll ihnen eine längere Lebenszeit schenken. Das muß Rick Deckard verhindern.  Als sich der eiskalte Jäger in Rachel, die Sekretärin seines Auftraggebers, verliebt, gerät sein Weltbild jedoch ins Wanken. Er entdeckt, daß sie - vielleicht wie er selbst - ein Replikant ist ...<br><br>Die Konfrontation des Menschen mit \"Realität\" und \"Virtualität\" und das verstrickte Spiel mit getürkten Erinnerungen zieht sich als roter Faden durch das Werk von Autor Philip K. Dick (\"Die totale Erinnerung\"). Sein Roman \"Träumen Roboter von elektrischen Schafen?\" liefert die Vorlage für diesen doppelbödigen Thriller, der den Zuschauer mit faszinierenden<br>Zukunftsvisionen und der gigantischen Kulisse des Großstadtmolochs gefangen nimmt.','www.bladerunner.com',0);
INSERT INTO products_description VALUES (6,2,'Matrix','Originaltitel: ' || chr(34) || 'The Matrix' || chr(34) || '<br><br>Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br><br>Sprachen: English, Deutsch.<br><br>Untertitel: English, Deutsch, Spanish.<br><br>Audio: Dolby Surround 5.1.<br><br>Bildformat: 16:9 Wide-Screen.<br><br>Dauer: (approx) 136 minuten.<br><br>Außerdem: Interaktive Menus, Kapitelauswahl, Untertitel.<br><br>(USA 1999) Der Geniestreich der Wachowski-Brüder. In dieser technisch perfekten Utopie kämpft Hacker Keanu Reeves gegen die Diktatur der Maschinen...','www.whatisthematrix.com',0);
INSERT INTO products_description VALUES (7,2,'e-m@il für Dich','Original: ' || chr(34) || 'You''ve got mail' || chr(34) || '<br><br>Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br><br>Sprachen: English, Deutsch.<br><br>Untertitel: English, Deutsch, Spanish.<br><br>Audio: Dolby Surround 5.1.<br><br>Bildformat: 16:9 Wide-Screen.<br><br>Dauer: (approx) 112 minutes.<br><br>Außerdem: Interaktive Menus, Kapitelauswahl, Untertitel.<br><br>(USA 1998) von Nora Ephron (' || chr(34) || 'Schlaflos in Seattle' || chr(34) || '). Meg Ryan und Tom Hanks knüpfen per E-Mail zarte Bande. Dass sie sich schon kennen, ahnen sie nicht ...','www.youvegotmail.com',0);
INSERT INTO products_description VALUES (8,2,'Das Große Krabbeln','Originaltitel: ' || chr(34) || 'A Bug''s Life' || chr(34) || '<br><br>Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br><br>Sprachen: English, Deutsch.<br><br>Untertitel: English, Deutsch, Spanish.<br><br>Audio: Dolby Surround 5.1.<br><br>Bildformat: 16:9 Wide-Screen.<br><br>Dauer: (approx) 96 minuten.<br><br>Außerdem: Interaktive Menus, Kapitelauswahl, Untertitel.<br><br>(USA 1998). Ameise Flik zettelt einen Aufstand gegen gefräßige Grashüpfer an ... Eine fantastische Computeranimation des \"Toy Story\"-Teams. ','www.abugslife.com',0);
INSERT INTO products_description VALUES (9,2,'Alarmstufe: Rot','Originaltitel: ' || chr(34) || 'Under Siege' || chr(34) || '<br><br>Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br><br>Sprachen: English, Deutsch.<br><br>Untertitel: English, Deutsch, Spanish.<br><br>Audio: Dolby Surround 5.1.<br><br>Bildformat: 16:9 Wide-Screen.<br><br>Dauer: (approx) 96 minuten.<br><br>Außerdem: Interaktive Menus, Kapitelauswahl, Untertitel.<br><br><b>Actionthriller. Smutje Steven Seagal versalzt Schurke Tommy Lee Jones die Suppe</b><br><br>Katastrophe ahoi: Kurz vor Ausmusterung der \"U.S.S. Missouri\" kapert die High-tech-Bande von Ex-CIA-Agent Strannix (Tommy Lee Jones) das Schlachtschiff. Strannix will die Nuklearraketen des Kreuzers klauen und verscherbeln. Mit Hilfe des irren Ersten Offiziers Krill (lustig: Gary Busey) killen die Gangster den Käpt’n und sperren seine Crew unter Deck. Blöd, dass sie dabei Schiffskoch Rybak (Steven Seagal) vergessen. Der Ex-Elitekämpfer knipst einen Schurken nach dem anderen aus. Eine Verbündete findet er in Stripperin Jordan (Ex-\"Baywatch\"-Biene Erika Eleniak). Die sollte eigentlich aus Käpt’ns Geburtstagstorte hüpfen ... Klar: Seagal ist kein Edelmime. Dafür ist Regisseur Andrew Davis (\"Auf der Flucht\") ein Könner: Er würzt die Action-Orgie mit Ironie und nutzt die imposante Schiffskulisse voll aus. Für Effekte und Ton gab es 1993 Oscar-Nominierungen. ','',0);
INSERT INTO products_description VALUES (10,2,'Alarmstufe: Rot 2','Originaltitel: ' || chr(34) || 'Under Siege 2: Dark Territory' || chr(34) || '<br><br>Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br><br>Sprachen: English, Deutsch.<br><br>Untertitel: English, Deutsch, Spanish.<br><br>Audio: Dolby Surround 5.1.<br><br>Bildformat: 16:9 Wide-Screen.<br><br>Dauer: (approx) 96 minuten.<br><br>Außerdem: Interaktive Menus, Kapitelauswahl, Untertitel.<br><br>(USA ’95). Von einem gekaperten Zug aus übernimmt Computerspezi Dane die Kontrolle über einen Kampfsatelliten und erpresst das Pentagon. Aber auch Ex-Offizier Ryback (Steven Seagal) ist im Zug ...<br>','',0);
INSERT INTO products_description VALUES (11,2,'Fire Down Below','Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br><br>Sprachen: English, Deutsch.<br><br>Untertitel: English, Deutsch, Spanish.<br><br>Audio: Dolby Surround 5.1.<br><br>Bildformat: 16:9 Wide-Screen.<br><br>Dauer: (approx) 96 minuten.<br><br>Außerdem: Interaktive Menus, Kapitelauswahl, Untertitel.<br><br>Ein mysteriöser Mordfall führt den Bundesmarschall Jack Taggert in eine Kleinstadt im US-Staat Kentucky. Doch bei seinen Ermittlungen stößt er auf eine Mauer des Schweigens. Angst beherrscht die Stadt, und alle Spuren führen zu dem undurchsichtigen Minen-Tycoon Orin Hanner. Offenbar werden in der friedlichen Berglandschaft gigantische Mengen Giftmülls verschoben, mit unkalkulierbaren Risiken. Um eine Katastrophe zu verhindern, räumt Taggert gnadenlos auf ...','',0);
INSERT INTO products_description VALUES (12,2,'Stirb Langsam - Jetzt Erst Recht','Originaltitel: ' || chr(34) || 'Die Hard With A Vengeance' || chr(34) || '<br><br>Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br><br>Sprachen: English, Deutsch.<br><br>Untertitel: English, Deutsch, Spanish.<br><br>Audio: Dolby Surround 5.1.<br><br>Bildformat: 16:9 Wide-Screen.<br><br>Dauer: (approx) 96 minuten.<br><br>Außerdem: Interaktive Menus, Kapitelauswahl, Untertitel.<br><br>So explosiv, so spannend, so rasant wie nie zuvor: Bruce Willis als Detectiv John McClane in einem Action-Thriller der Superlative! Das ist heute nicht McClanes Tag. Seine Frau hat ihn verlassen, sein Boß hat ihn vom Dienst suspendiert und irgendein Verrückter hat ihn gerade zum Gegenspieler in einem teuflischen Spiel erkoren - und der Einsatz ist New York selbst. Ein Kaufhaus ist explodiert, doch das ist nur der Auftakt. Der geniale Superverbrecher Simon droht, die ganze Stadt Stück für Stück in die Luft zu sprengen, wenn McClane und sein Partner wider Willen seine explosiven\" Rätsel nicht lösen. Eine mörderische Hetzjagd quer durch New York beginnt - bis McClane merkt, daß der Bombenterror eigentlich nur ein brillantes Ablenkungsmanöver ist...!<br><i>\"Perfekt gemacht und stark besetzt. Das Action-Highlight des Jahres!\"</i> <b>(Bild)</b>','',0);
INSERT INTO products_description VALUES (13,2,'Zwei stahlharte Profis','Originaltitel: ' || chr(34) || 'Lethal Weapon' || chr(34) || '<br><br>Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br><br>Sprachen: English, Deutsch.<br><br>Untertitel: English, Deutsch, Spanish.<br><br>Audio: Dolby Surround 5.1.<br><br>Bildformat: 16:9 Wide-Screen.<br><br>Dauer: (approx) 96 minuten.<br><br>Außerdem: Interaktive Menus, Kapitelauswahl, Untertitel.<br><br>Sie sind beide Cops in L.A.. Sie haben beide in Vietnam für eine Spezialeinheit gekämpft. Und sie hassen es beide, mit einem Partner arbeiten zu müssen. Aber sie sind Partner: Martin Riggs, der Mann mit dem Todeswunsch, für wen auch immer. Und Roger Murtaugh, der besonnene Polizist. Gemeinsam enttarnen sie einen gigantischen Heroinschmuggel, hinter dem sich eine Gruppe ehemaliger CIA-Söldner verbirgt. Eine Killerbande gegen zwei Profis ...','',0);
INSERT INTO products_description VALUES (14,2,'Labyrinth ohne Ausweg','Originaltitel: ' || chr(34) || 'Red Corner' || chr(34) || '<br><br>Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br><br>Sprachen: English, Deutsch.<br><br>Untertitel: English, Deutsch, Spanish.<br><br>Audio: Dolby Surround 5.1.<br><br>Bildformat: 16:9 Wide-Screen.<br><br>Dauer: (approx) 96 minuten.<br><br>Außerdem: Interaktive Menus, Kapitelauswahl, Untertitel.<br><br>Dem Amerikaner Jack Moore wird in China der bestialische Mord an einem Fotomodel angehängt. Brutale Gefängnisschergen versuchen, ihn durch Folter zu einem Geständnis zu zwingen. Vor Gericht fordert die Anklage die Todesstrafe - Moore''s Schicksal scheint besiegelt. Durch einen Zufall gelingt es ihm, aus der Haft zu fliehen, doch aus der feindseligen chinesischen Hauptstadt gibt es praktisch kein Entkommen ...','',0);
INSERT INTO products_description VALUES (15,2,'Frantic','Originaltitel: ' || chr(34) || 'Frantic' || chr(34) || '<br><br>Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br><br>Sprachen: English, Deutsch.<br><br>Untertitel: English, Deutsch, Spanish.<br><br>Audio: Dolby Surround 5.1.<br><br>Bildformat: 16:9 Wide-Screen.<br><br>Dauer: (approx) 96 minuten.<br><br>Außerdem: Interaktive Menus, Kapitelauswahl, Untertitel.<br><br>Ein romantischer Urlaub in Paris, der sich in einen Alptraum verwandelt. Ein Mann auf der verzweifelten Suche nach seiner entführten Frau. Ein düster-bedrohliches Paris, in dem nur ein Mensch Licht in die tödliche Affäre bringen kann.','',0);
INSERT INTO products_description VALUES (16,2,'Mut Zur Wahrheit','Originaltitel: ' || chr(34) || 'Courage Under Fire' || chr(34) || '<br><br>Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br><br>Sprachen: English, Deutsch.<br><br>Untertitel: English, Deutsch, Spanish.<br><br>Audio: Dolby Surround 5.1.<br><br>Bildformat: 16:9 Wide-Screen.<br><br>Dauer: (approx) 96 minuten.<br><br>Außerdem: Interaktive Menus, Kapitelauswahl, Untertitel.<br><br>Lieutenant Colonel Nathaniel Serling (Denzel Washington) lässt während einer Schlacht im Golfkrieg versehentlich auf einen US-Panzer schießen, dessen Mannschaft dabei ums Leben kommt. Ein Jahr nach diesem Vorfall wird Serling, der mittlerweile nach Washington D.C. versetzt wurde, die Aufgabe übertragen, sich um einen Kandidaten zu kümmern, der während des Krieges starb und dem der höchste militärische Orden zuteil werden soll. Allerdings sind sowohl der Fall und als auch der betreffende Soldat ein politisch heißes Eisen -- Captain Karen Walden (Meg Ryan) ist Amerikas erster weiblicher Soldat, der im Kampf getötet wurde.<br><br>Serling findet schnell heraus, dass es im Fall des im felsigen Gebiet von Kuwait abgestürzten Rettungshubschraubers Diskrepanzen gibt. In Flashbacks werden von unterschiedlichen Personen verschiedene Versionen von Waldens Taktik, die Soldaten zu retten und den Absturz zu überleben, dargestellt (à la Kurosawas Rashomon). Genau wie in Glory erweist sich Regisseur Edward Zwicks Zusammenstellung von bekannten und unbekannten Schauspielern als die richtige Mischung. Waldens Crew ist besonders überzeugend. Matt Damon als der Sanitäter kommt gut als der leichtfertige Typ rüber, als er Washington seine Geschichte erzählt. Im Kampf ist er ein mit Fehlern behafteter, humorvoller Soldat.<br><br>Die erstaunlichste Arbeit in Mut zur Wahrheit leistet Lou Diamond Phillips (als der Schütze der Gruppe), dessen Karriere sich auf dem Weg in die direkt für den Videomarkt produzierten Filme befand. Und dann ist da noch Ryan. Sie hat sich in dramatischen Filmen in der Vergangenheit gut behauptet (Eine fast perfekte Liebe, Ein blutiges Erbe), es aber nie geschafft, ihrem Image zu entfliehen, das sie in die Ecke der romantischen Komödie steckte. Mit gefärbtem Haar, einem leichten Akzent und der von ihr geforderten Darstellungskunst hat sie endlich einen langlebigen dramatischen Film.','',0);
INSERT INTO products_description VALUES (17,2,'Speed','Originaltitel: ' || chr(34) || 'Speed' || chr(34) || '<br><br>Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br><br>Sprachen: English, Deutsch.<br><br>Untertitel: English, Deutsch, Spanish.<br><br>Audio: Dolby Surround 5.1.<br><br>Bildformat: 16:9 Wide-Screen.<br><br>Dauer: (approx) 96 minuten.<br><br>Außerdem: Interaktive Menus, Kapitelauswahl, Untertitel.<br><br>Er ist ein Cop aus der Anti-Terror-Einheit von Los Angeles. Und so ist der Alarm für Jack Traven nichts Ungewöhnliches: Ein Terrorist will drei Millionen Dollar erpressen, oder die zufälligen Geiseln in einem Aufzug fallen 35 Stockwerke in die Tiefe. Doch Jack schafft das Unmögliche - die Geiseln werden gerettet und der Terrorist stirbt an seiner eigenen Bombe. Scheinbar. Denn schon wenig später steht Jack (Keanu Reeves) dem Bombenexperten Payne erneut gegenüber. Diesmal hat sich der Erpresser eine ganz perfide Mordwaffe ausgedacht: Er plaziert eine Bombe in einem öffentlichen Bus. Der Mechanismus der Sprengladung schaltet sich automatisch ein, sobald der Bus schneller als 50 Meilen in der Stunde fährt und detoniert sofort, sobald die Geschwindigkeit sinkt. Plötzlich wird für eine Handvoll ahnungsloser Durchschnittsbürger der Weg zur Arbeit zum Höllentrip - und nur Jack hat ihr Leben in der Hand. Als der Busfahrer verletzt wird, übernimmt Fahrgast Annie (Sandra Bullock) das Steuer. Doch wohin mit einem Bus, der nicht bremsen kann in der Stadt der Staus? Doch es kommt noch schlimmer: Payne (Dennis Hopper) will jetzt nicht nur seine drei Millionen Dollar. Er will Jack. Um jeden Preis.','',0);
INSERT INTO products_description VALUES (18,2,'Speed 2: Cruise Control','Originaltitel: ' || chr(34) || 'Speed 2 - Cruise Control' || chr(34) || '<br><br>Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br><br>Sprachen: English, Deutsch.<br><br>Untertitel: English, Deutsch, Spanish.<br><br>Audio: Dolby Surround 5.1.<br><br>Bildformat: 16:9 Wide-Screen.<br><br>Dauer: (approx) 96 minuten.<br><br>Außerdem: Interaktive Menus, Kapitelauswahl, Untertitel.<br><br>Halten Sie ihre Schwimmwesten bereit, denn die actiongeladene Fortsetzung von Speed begibt sich auf Hochseekurs. Erleben Sie Sandra Bullock erneut in ihrer Star-Rolle als Annie Porter. Die Karibik-Kreuzfahrt mit ihrem Freund Alex entwickelt sich unaufhaltsam zur rasenden Todesfahrt, als ein wahnsinniger Computer-Spezialist den Luxusliner in seine Gewalt bringt und auf einen mörderischen Zerstörungskurs programmiert. Eine hochexplosive Reise, bei der kein geringerer als Action-Spezialist Jan De Bont das Ruder in die Hand nimmt. Speed 2: Cruise Controll läßt ihre Adrenalin-Wellen in rasender Geschwindigkeit ganz nach oben schnellen.','',0);
INSERT INTO products_description VALUES (19,2,'Verrückt nach Mary','Originaltitel: ' || chr(34) || 'There''s Something About Mary' || chr(34) || '<br><br>Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br><br>Sprachen: English, Deutsch.<br><br>Untertitel: English, Deutsch, Spanish.<br><br>Audio: Dolby Surround 5.1.<br><br>Bildformat: 16:9 Wide-Screen.<br><br>Dauer: (approx) 96 minuten.<br><br>Außerdem: Interaktive Menus, Kapitelauswahl, Untertitel.<br><br>13 Jahre nachdem Teds Rendezvous mit seiner angebeteten Mary in einem peinlichen Fiasko endete, träumt er immer noch von ihr und engagiert den windigen Privatdetektiv Healy um sie aufzuspüren. Der findet Mary in Florida und verliebt sich auf den ersten Blick in die atemberaubende Traumfrau. Um Ted als Nebenbuhler auszuschalten, tischt er ihm dicke Lügen über Mary auf. Ted läßt sich jedoch nicht abschrecken, eilt nach Miami und versucht nun alles, um Healy die Balztour zu vermasseln. Doch nicht nur Healy ist verrückt nach Mary und Ted bekommt es mit einer ganzen Legion liebeskranker Konkurrenten zu tun ...','',0);
INSERT INTO products_description VALUES (20,2,'Menschenkind','Originaltitel: ' || chr(34) || 'Beloved' || chr(34) || '<br><br>Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br><br>Sprachen: English, Deutsch.<br><br>Untertitel: English, Deutsch, Spanish.<br><br>Audio: Dolby Surround 5.1.<br><br>Bildformat: 16:9 Wide-Screen.<br><br>Dauer: (approx) 96 minuten.<br><br>Außerdem: Interaktive Menus, Kapitelauswahl, Untertitel.<br><br>Dieser vielschichtige Film ist eine Arbeit, die Regisseur Jonathan Demme und dem amerikanischen Talkshow-Star Oprah Winfrey sehr am Herzen lag. Der Film deckt im Verlauf seiner dreistündigen Spielzeit viele Bereiche ab. Menschenkind ist teils Sklavenepos, teils Mutter-Tochter-Drama und teils Geistergeschichte.<br><br>Der Film fordert vom Publikum höchste Aufmerksamkeit, angefangen bei seiner dramatischen und etwas verwirrenden Eingangssequenz, in der die Bewohner eines Hauses von einem niederträchtigen übersinnlichen Angriff heimgesucht werden. Aber Demme und seine talentierte Besetzung bereiten denen, die dabei bleiben ein unvergessliches Erlebnis. Der Film folgt den Spuren von Sethe (in ihren mittleren Jahren von Oprah Winfrey dargestellt), einer ehemaligen Sklavin, die sich scheinbar ein friedliches und produktives Leben in Ohio aufgebaut hat. Aber durch den erschreckenden und sparsamen Einsatz von Rückblenden deckt Demme, genau wie das literarische Meisterwerk von Toni Morrison, auf dem der Film basiert, langsam die Schrecken von Sethes früherem Leben auf und das schreckliche Ereignis, dass dazu führte, dass Sethes Haus von Geistern heimgesucht wird.<br><br>Während die Gräuel der Sklaverei und das blutige Ereignis in Sethes Familie unleugbar tief beeindrucken, ist die Qualität des Film auch in kleineren, genauso befriedigenden Details sichtbar. Die geistlich beeinflusste Musik von Rachel Portman ist gleichzeitig befreiend und bedrückend, und der Einblick in die afro-amerikanische Gemeinschaft nach der Sklaverei -- am Beispiel eines Familienausflugs zu einem Jahrmarkt, oder dem gospelsingenden Nähkränzchen -- machen diesen Film zu einem speziellen Vergnügen sowohl für den Geist als auch für das Herz. Die Schauspieler, besonders Kimberley Elise als Sethes kämpfende Tochter und Thandie Newton als der mysteriöse Titelcharakter, sind sehr rührend. Achten Sie auch auf Danny Glover (Lethal Weapon) als Paul D.','',0);
INSERT INTO products_description VALUES (21,2,'SWAT 3: Elite Edition','<b>KEINE KOMPROMISSE!</b><br><i>Kämpfen Sie Seite an Seite mit Ihren LAPD SWAT-Kameraden gegen das organisierte Verbrechen!</i><br><br>Eine der realistischsten 3D-Taktiksimulationen der letzten Zeit jetzt mit Multiplayer-Modus, 5 neuen Missionen und jede Menge nützliche Tools!<br><br>Los Angeles, 2005. In wenigen Tagen steht die Unterzeichnung des Abkommens der Vereinten Nationen zur Atom-Ächtung durch Vertreter aller Nationen der Welt an. Radikale terroristische Vereinigungen machen sich in der ganzen Stadt breit. Verantwortlich für die Sicherheit der Delegierten zeichnet sich eine Eliteeinheit der LAPD: das SWAT-Team. Das Schicksal der Stadt liegt in Ihren Händen.<br><br><b>Neue Features:</b><br><ul><br><li>Multiplayer-Modus (Co op-Modus, Deathmatch in den bekannten Variationen)</li><br><li>5 neue Missionen an original Örtlichkeiten Las (U-Bahn, Whitman Airport, etc.)</li><br><li>neue Charakter</li><br><li>neue Skins</li><br><li>neue Waffen</li><br><li>neue Sounds</li><br><li>verbesserte KI</li><br><li>Tools-Package</li><br><li>Scenario-Editor</li><br><li>Level-Editor</li><br></ul><br>Die dritte Folge der Bestseller-Reihe im Bereich der 3D-Echtzeit-Simulationen präsentiert sich mit einer neuen Spielengine mit extrem ausgeprägtem Realismusgrad. Der Spieler übernimmt das Kommando über eine der besten Polizei-Spezialeinheiten oder einer der übelsten Terroristen-Gangs der Welt. Er durchläuft - als \"Guter\" oder \"Böser\" - eine der härtesten und elitärsten Kampfausbildungen, in der er lernt, mit jeder Art von Krisensituationen umzugehen. Bei diesem Action-Abenteuer geht es um das Leben prominenter Vertreter der Vereinten Nationen und bei 16 Missionen an Originalschauplätzen in LA gibt die \"lebensechte\" KI den Protagonisten jeder Seite so einige harte Nüsse zu knacken.','www.swat3.com',0);
INSERT INTO products_description VALUES (22,2,'Unreal Tournament','2341: Die Gewalt ist eine Lebensweise, die sich ihren Weg durch die dunklen Risse der Gesellschaft bahnt. Sie bedroht die Macht und den Einfluss der regierenden Firmen, die schnellstens ein Mittel finden müssen, die tobenden Massen zu besänftigen - ein profitables Mittel ... Gladiatorenkämpfe sind die Lösung. Sie sollen den Durst der Menschen nach Blut stillen und sind die perfekte Gelegenheit, die Aufständischen, Kriminellen und Aliens zu beseitigen, die die Firmenelite bedrohen.<br><br>Das Turnier war geboren - ein Kampf auf Leben und Tod. Galaxisweit live und in Farbe! Kämpfen Sie für Freiheit, Ruhm und Ehre. Sie müssen stark, schnell und geschickt sein ... oder Sie bleiben auf der Strecke.<br><br>Kämpfen Sie allein oder kommandieren Sie ein Team gegen Armeen unbarmherziger Krieger, die alle nur ein Ziel vor Augen haben: Die Arenen lebend zu verlassen und sich dem Grand Champion zu stellen ... um ihn dann zu bezwingen!<br><br><b>Features:</b><br><ul><br><li>Auf dem PC mehrfach als Spiel des Jahres ausgezeichnet!</li><br><li>Mehr als 50 faszinierende Level - verlassene Raumstationen, gotische Kathedralen und graffitibedeckte Großstädte.</li><br><li>Vier actionreiche Spielmodi - Deathmatch, Capture the Flag, Assault und Domination werden Ihren Adrenalinpegel in die Höhe schnellen lassen.</li><br><li>Dramatische Mehrspieler-Kämpfe mit 2, 3 und 4 Spielern, auch über das Netzwerk</li><br><li>Gnadenlos aggressive Computergegner verlangen Ihnen das Äußerste ab.</li><br><li>Neuartiges Benutzerinterface und verbesserte Steuerung - auch mit USB-Maus und -Tastatur spielbar.</li><br></ul><br>Der Nachfolger des Actionhits \"Unreal\" verspricht ein leichtes, intuitives Interface, um auch Einsteigern schnellen Zugang zu den Duellen gegen die Bots zu ermöglichen. Mit diesen KI-Kriegern kann man auch Teams bilden und im umfangreichen Multiplayermodus ohne Onlinekosten in den Kampf ziehen. 35 komplett neue Arenen und das erweiterte Waffenangebot bilden dazu den würdigen Rahmen.','www.unrealtournament.net',0);
INSERT INTO products_description VALUES (23,2,'The Wheel Of Time','<b><i>\"Wheel Of Time\"(Das Rad der Zeit)</i></b> basiert auf den Fantasy-Romanen von Kultautor Robert Jordan und stellt einen einzigartigen Mix aus Strategie-, Action- und Rollenspielelementen dar. Obwohl die Welt von \"Wheel of Time\" eng an die literarische Vorlage der Romane angelehnt ist, erzählt das Spiel keine lineare Geschichte. Die Story entwickelt sich abhängig von den Aktionen der Spieler, die jeweils die Rollen der Hauptcharaktere aus dem Roman übernehmen. Jede Figur hat den Oberbefehl über eine große Gefolgschaft, militärische Einheiten und Ländereien. Die Spieler können ihre eigenen Festungen konstruieren, individuell ausbauen, von dort aus das umliegende Land erforschen, magische Gegenstände sammeln oder die gegnerischen Zitadellen erstürmen. Selbstverständlich kann man sich auch über LAN oder Internet gegenseitig Truppen auf den Hals hetzen und die Festungen seiner Mitspieler in Schutt und Asche legen. Dreh- und Anlegepunkt von \"Wheel of Time\" ist der Kampf um die finstere Macht \"The Dark One\", die vor langer Zeit die Menschheit beinahe ins Verderben stürzte und nur mit Hilfe gewaltiger magischer Energie verbannt werden konnte. \"The Amyrlin Seat\" und \"The Children of the Night\" kämpfen nur gegen \"The Forsaken\" und \"The Hound\" um den Besitz des Schlüssels zu \"Shayol Ghul\" - dem magischen Siegel, mit dessen Hilfe \"The Dark One\" seinerzeit gebannt werden konnte.<br><br><b>Features:</b> <br><ul><br><li>Ego-Shooter mit Strategie-Elementen</li><br><li>Spielumgebung in Echtzeit-3D</li><br><li>Konstruktion aud Ausbau der eigenen Festung</li><br><li>Einsatz von über 100 Artefakten und Zaubersprüchen</li><br><li>Single- und Multiplayermodus</li><br></ul><br>Im Mittelpunkt steht der Kampf gegen eine finstere Macht namens The Dark One. Deren Schergen müssen mit dem Einsatz von über 100 Artefakten und Zaubereien wie Blitzschlag oder Teleportation aus dem Weg geräumt werden. Die opulente 3D-Grafik verbindet Strategie- und Rollenspielelemente. <br><br><b>Voraussetzungen</b><br>mind. P200, 32MB RAM, 4x CD-Rom, Win95/98, DirectX 5.0 komp.Grafikkarte und Soundkarte. ','www.wheeloftime.com',0);
INSERT INTO products_description VALUES (24,2,'Disciples: Sacred Land','Rundenbasierende Fantasy/RTS-Strategie mit gutem Design (vor allem die Levels, 4 versch. Rassen, tolle Einheiten), fantastischer Atmosphäre und exzellentem Soundtrack. Grafisch leider auf das Niveau von 1990.','www.strategyfirst.com/disciples/welcome.html',0);
INSERT INTO products_description VALUES (25,2,'Microsoft Internet Tastatur PS/2','<i>Microsoft Internet Keyboard,Windows-Tastatur mit 10 zusätzl. Tasten,2 selbst programmierbar, abnehmbareHandgelenkauflage. Treiber im Lieferumfang.</i><br><br>Ein-Klick-Zugriff auf das Internet und vieles mehr! Das Internet Keyboard verfügt über 10 zusätzliche Abkürzungstasten auf einer benutzerfreundlichen Standardtastatur, die darüber hinaus eine abnehmbare Handballenauflage aufweist. Über die Abkürzungstasten können Sie durch das Internet surfen oder direkt von der Tastatur aus auf E-Mails zugreifen. Die IntelliType Pro-Software ermöglicht außerdem das individuelle Belegen der Tasten.','',0);
INSERT INTO products_description VALUES (26,2,'Microsof IntelliMouse Explorer','Die IntelliMouse Explorer überzeugt durch ihr modernes Design mit silberfarbenem Gehäuse, sowie rot schimmernder Unter- und Rückseite. Die neuartige IntelliEye-Technologie sorgt für eine noch nie dagewesene Präzision, da statt der beweglichen Teile (zum Abtasten der Bewegungsänderungen an der Unterseite der Maus) ein optischer Sensor die Bewegungen der Maus erfaßt. Das Herzstück der Microsoft IntelliEye-Technologie ist ein kleiner Chip, der einen optischen Sensor und einen digitalen Signalprozessor (DSP) enthält.<br><br>Da auf bewegliche Teile, die Staub, Schmutz und Fett aufnehmen können, verzichtet wurde, muß die IntelliMouse Explorer nicht mehr gereinigt werden. Darüber hinaus arbeitet die IntelliMouse Explorer auf nahezu jeder Arbeitsoberfläche, so daß kein Mauspad mehr erforderlich ist. Mit dem Rad und zwei neuen zusätzlichen Maustasten ermöglicht sie effizientes und komfortables Arbeiten am PC.<br><br><b>Eigenschaften:</b><br><ul><br><li><b>ANSCHLUSS:</b> USB (PS/2-Adapter enthalten)</li><br><li><b>FARBE:</b> metallic-grau</li><br><li><b>TECHNIK:</b> Optisch (Akt.: ca. 1500 Bilder/s)</li><br><li><b>TASTEN:</b> 5 (incl. Scrollrad)</li><br><li><b>SCROLLRAD:</b> Ja</li><br></ul><br><i><b>BEMERKUNG:</b><br>Keine Reinigung bewegter Teile mehr notwendig, da statt der Mauskugel ein Fotoempfänger benutzt wird.</i>','',0);
INSERT INTO products_description VALUES (27,2,'Hewlett-Packard LaserJet 1100Xi','<b>HP LaserJet für mehr Produktivität und Flexibilität am Arbeitsplatz</b><br><br>Der HP LaserJet 1100Xi Drucker verbindet exzellente Laserdruckqualität mit hoher Geschwindigkeit für mehr Effizienz.<br><br><b>Zielkunden</b><br><ul><li>Einzelanwender, die Wert auf professionelle Ausdrucke in Laserqualität legen und schnelle Ergebnisse auch bei komplexen Dokumenten erwarten.</li><br><li>Der HP LaserJet 1100 sorgt mit gestochen scharfen Texten und Grafiken für ein professionelles Erscheinungsbild Ihrer Arbeit und Ihres Unternehmens. Selbst bei komplexen Dokumenten liefert er schnelle Ergebnisse. Andere Medien - wie z.B. Transparentfolien und Briefumschläge, etc. - lassen sich problemlos bedrucken. Somit ist der HP LaserJet 1100 ein Multifunktionstalent im Büroalltag.</li><br></ul><br><b>Eigenschaften</b><br><ul><br><li><b>Druckqualität</b> Schwarzweiß: 600 x 600 dpi</li><br><li><b>Monatliche Druckleistung</b> Bis zu 7000 Seiten</li><br><li><b>Speicher</b> 2 MB Standardspeicher, erweiterbar auf 18 MB</li><br><li><b>Schnittstelle/gemeinsame Nutzung</b> Parallel, IEEE 1284-kompatibel</li><br><li><b>Softwarekompatibilität</b> DOS/Win 3.1x/9x/NT 4.0</li><br><li><b>Papierzuführung</b> 125-Blatt-Papierzuführung</li><br><li><b>Druckmedien</b> Normalpapier, Briefumschläge, Transparentfolien, kartoniertes Papier, Postkarten und Etiketten</li><br><li><b>Netzwerkfähig</b> Über HP JetDirect PrintServer</li><br><li><b>Lieferumfang</b> HP LaserJet 1100Xi Drucker (Lieferumfang: Drucker, Tonerkassette, 2 m Parallelkabel, Netzkabel, Kurzbedienungsanleitung, Benutzerhandbuch, CD-ROM, 3,5\"-Disketten mit Windows® 3.1x, 9x, NT 4.0 Treibern und DOS-Dienstprogrammen)</li><br><li><b>Gewährleistung</b> Ein Jahr</li><br></ul><br>','www.hp.com',0);
INSERT INTO products_description VALUES (1,3,'Matrox G200 MMS','Reinforcing its position as a multi-monitor trailblazer, Matrox Graphics Inc. has once again developed the most flexible and highly advanced solution in the industry. Introducing the new Matrox G200 Multi-Monitor Series; the first graphics card ever to support up to four DVI digital flat panel displays on a single 8' || chr(34) || ' PCI board.<br><br>With continuing demand for digital flat panels in the financial workplace, the Matrox G200 MMS is the ultimate in flexible solutions. The Matrox G200 MMS also supports the new digital video interface (DVI) created by the Digital Display Working Group (DDWG) designed to ease the adoption of digital flat panels. Other configurations include composite video capture ability and onboard TV tuner, making the Matrox G200 MMS the complete solution for business needs.<br><br>Based on the award-winning MGA-G200 graphics chip, the Matrox G200 Multi-Monitor Series provides superior 2D/3D graphics acceleration to meet the demanding needs of business applications such as real-time stock quotes (Versus), live video feeds (Reuters ' || chr(38) || ' Bloombergs), multiple windows applications, word processing, spreadsheets and CAD.','www.matrox.com/mga/products/g200_mms/home.cfm',0);
INSERT INTO products_description VALUES (2,3,'Matrox G400 32MB','<b>Dramatically Different High Performance Graphics</b><br><br>Introducing the Millennium G400 Series - a dramatically different, high performance graphics experience. Armed with the industry''s fastest graphics chip, the Millennium G400 Series takes explosive acceleration two steps further by adding unprecedented image quality, along with the most versatile display options for all your 3D, 2D and DVD applications. As the most powerful and innovative tools in your PC''s arsenal, the Millennium G400 Series will not only change the way you see graphics, but will revolutionize the way you use your computer.<br><br><b>Key features:</b><ul><li>New Matrox G400 256-bit DualBus graphics chip</li><li>Explosive 3D, 2D and DVD performance</li><li>DualHead Display</li><li>Superior DVD and TV output</li><li>3D Environment-Mapped Bump Mapping</li><li>Vibrant Color Quality rendering </li><li>UltraSharp DAC of up to 360 MHz</li><li>3D Rendering Array Processor</li><li>Support for 16 or 32 MB of memory</li></ul>','www.matrox.com/mga/products/mill_g400/home.htm',0);
INSERT INTO products_description VALUES (3,3,'Microsoft IntelliMouse Pro','Every element of IntelliMouse Pro - from its unique arched shape to the texture of the rubber grip around its base - is the product of extensive customer and ergonomic research. Microsoft''s popular wheel control, which now allows zooming and universal scrolling functions, gives IntelliMouse Pro outstanding comfort and efficiency.','www.microsoft.com/hardware/mouse/intellimouse.asp',0);
INSERT INTO products_description VALUES (4,3,'The Replacement Killers','Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br>Languages: English, Deutsch.<br>Subtitles: English, Deutsch, Spanish.<br>Audio: Dolby Surround 5.1.<br>Picture Format: 16:9 Wide-Screen.<br>Length: (approx) 80 minutes.<br>Other: Interactive Menus, Chapter Selection, Subtitles (more languages).','www.replacement-killers.com',0);
INSERT INTO products_description VALUES (5,3,'Blade Runner - Director''s Cut','Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br>Languages: English, Deutsch.<br>Subtitles: English, Deutsch, Spanish.<br>Audio: Dolby Surround 5.1.<br>Picture Format: 16:9 Wide-Screen.<br>Length: (approx) 112 minutes.<br>Other: Interactive Menus, Chapter Selection, Subtitles (more languages).','www.bladerunner.com',0);
INSERT INTO products_description VALUES (6,3,'The Matrix','Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br><br>Languages: English, Deutsch.<br><br>Subtitles: English, Deutsch.<br><br>Audio: Dolby Surround.<br><br>Picture Format: 16:9 Wide-Screen.<br><br>Length: (approx) 131 minutes.<br><br>Other: Interactive Menus, Chapter Selection, Making Of.','www.thematrix.com',0);
INSERT INTO products_description VALUES (7,3,'You''ve Got Mail','Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br><br>Languages: English, Deutsch, Spanish.<br><br>Subtitles: English, Deutsch, Spanish, French, Nordic, Polish.<br><br>Audio: Dolby Digital 5.1.<br><br>Picture Format: 16:9 Wide-Screen.<br><br>Length: (approx) 115 minutes.<br><br>Other: Interactive Menus, Chapter Selection, Subtitles (more languages).','www.youvegotmail.com',0);
INSERT INTO products_description VALUES (8,3,'A Bug''s Life','Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br><br>Languages: English, Deutsch.<br><br>Subtitles: English, Deutsch, Spanish.<br><br>Audio: Dolby Digital 5.1 / Dobly Surround Stereo.<br><br>Picture Format: 16:9 Wide-Screen.<br><br>Length: (approx) 91 minutes.<br><br>Other: Interactive Menus, Chapter Selection, Subtitles (more languages).','www.abugslife.com',0);
INSERT INTO products_description VALUES (9,3,'Under Siege','Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br><br>Languages: English, Deutsch.<br><br>Subtitles: English, Deutsch, Spanish.<br><br>Audio: Dolby Surround 5.1.<br><br>Picture Format: 16:9 Wide-Screen.<br><br>Length: (approx) 98 minutes.<br><br>Other: Interactive Menus, Chapter Selection, Subtitles (more languages).','',0);
INSERT INTO products_description VALUES (10,3,'Under Siege 2 - Dark Territory','Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br><br>Languages: English, Deutsch.<br><br>Subtitles: English, Deutsch, Spanish.<br><br>Audio: Dolby Surround 5.1.<br><br>Picture Format: 16:9 Wide-Screen.<br><br>Length: (approx) 98 minutes.<br><br>Other: Interactive Menus, Chapter Selection, Subtitles (more languages).','',0);
INSERT INTO products_description VALUES (11,3,'Fire Down Below','Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br><br>Languages: English, Deutsch.<br><br>Subtitles: English, Deutsch, Spanish.<br><br>Audio: Dolby Surround 5.1.<br><br>Picture Format: 16:9 Wide-Screen.<br><br>Length: (approx) 100 minutes.<br><br>Other: Interactive Menus, Chapter Selection, Subtitles (more languages).','',0);
INSERT INTO products_description VALUES (12,3,'Die Hard With A Vengeance','Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br><br>Languages: English, Deutsch.<br><br>Subtitles: English, Deutsch, Spanish.<br><br>Audio: Dolby Surround 5.1.<br><br>Picture Format: 16:9 Wide-Screen.<br><br>Length: (approx) 122 minutes.<br><br>Other: Interactive Menus, Chapter Selection, Subtitles (more languages).','',0);
INSERT INTO products_description VALUES (13,3,'Lethal Weapon','Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br><br>Languages: English, Deutsch.<br><br>Subtitles: English, Deutsch, Spanish.<br><br>Audio: Dolby Surround 5.1.<br><br>Picture Format: 16:9 Wide-Screen.<br><br>Length: (approx) 100 minutes.<br><br>Other: Interactive Menus, Chapter Selection, Subtitles (more languages).','',0);
INSERT INTO products_description VALUES (14,3,'Red Corner','Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br><br>Languages: English, Deutsch.<br><br>Subtitles: English, Deutsch, Spanish.<br><br>Audio: Dolby Surround 5.1.<br><br>Picture Format: 16:9 Wide-Screen.<br><br>Length: (approx) 117 minutes.<br><br>Other: Interactive Menus, Chapter Selection, Subtitles (more languages).','',0);
INSERT INTO products_description VALUES (15,3,'Frantic','Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br><br>Languages: English, Deutsch.<br><br>Subtitles: English, Deutsch, Spanish.<br><br>Audio: Dolby Surround 5.1.<br><br>Picture Format: 16:9 Wide-Screen.<br><br>Length: (approx) 115 minutes.<br><br>Other: Interactive Menus, Chapter Selection, Subtitles (more languages).','',0);
INSERT INTO products_description VALUES (16,3,'Courage Under Fire','Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br><br>Languages: English, Deutsch.<br><br>Subtitles: English, Deutsch, Spanish.<br><br>Audio: Dolby Surround 5.1.<br><br>Picture Format: 16:9 Wide-Screen.<br><br>Length: (approx) 112 minutes.<br><br>Other: Interactive Menus, Chapter Selection, Subtitles (more languages).','',0);
INSERT INTO products_description VALUES (17,3,'Speed','Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br><br>Languages: English, Deutsch.<br><br>Subtitles: English, Deutsch, Spanish.<br><br>Audio: Dolby Surround 5.1.<br><br>Picture Format: 16:9 Wide-Screen.<br><br>Length: (approx) 112 minutes.<br><br>Other: Interactive Menus, Chapter Selection, Subtitles (more languages).','',0);
INSERT INTO products_description VALUES (18,3,'Speed 2: Cruise Control','Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br><br>Languages: English, Deutsch.<br><br>Subtitles: English, Deutsch, Spanish.<br><br>Audio: Dolby Surround 5.1.<br><br>Picture Format: 16:9 Wide-Screen.<br><br>Length: (approx) 120 minutes.<br><br>Other: Interactive Menus, Chapter Selection, Subtitles (more languages).','',0);
INSERT INTO products_description VALUES (19,3,'There''s Something About Mary','Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br><br>Languages: English, Deutsch.<br><br>Subtitles: English, Deutsch, Spanish.<br><br>Audio: Dolby Surround 5.1.<br><br>Picture Format: 16:9 Wide-Screen.<br><br>Length: (approx) 114 minutes.<br><br>Other: Interactive Menus, Chapter Selection, Subtitles (more languages).','',0);
INSERT INTO products_description VALUES (20,3,'Beloved','Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br><br>Languages: English, Deutsch.<br><br>Subtitles: English, Deutsch, Spanish.<br><br>Audio: Dolby Surround 5.1.<br><br>Picture Format: 16:9 Wide-Screen.<br><br>Length: (approx) 164 minutes.<br><br>Other: Interactive Menus, Chapter Selection, Subtitles (more languages).','',0);
INSERT INTO products_description VALUES (21,3,'SWAT 3: Close Quarters Battle','<b>Windows 95/98</b><br><br>211 in progress with shots fired. Officer down. Armed suspects with hostages. Respond Code 3! Los Angles, 2005, In the next seven days, representatives from every nation around the world will converge on Las Angles to witness the signing of the United Nations Nuclear Abolishment Treaty. The protection of these dignitaries falls on the shoulders of one organization, LAPD SWAT. As part of this elite tactical organization, you and your team have the weapons and all the training necessary to protect, to serve, and \"When needed\" to use deadly force to keep the peace. It takes more than weapons to make it through each mission. Your arsenal includes C2 charges, flashbangs, tactical grenades. opti-Wand mini-video cameras, and other devices critical to meeting your objectives and keeping your men free of injury. Uncompromised Duty, Honor and Valor!','www.swat3.com',0);
INSERT INTO products_description VALUES (22,3,'Unreal Tournament','From the creators of the best-selling Unreal, comes Unreal Tournament. A new kind of single player experience. A ruthless multiplayer revolution.<br><br>This stand-alone game showcases completely new team-based gameplay, groundbreaking multi-faceted single player action or dynamic multi-player mayhem. It''s a fight to the finish for the title of Unreal Grand Master in the gladiatorial arena. A single player experience like no other! Guide your team of ''bots'' (virtual teamates) against the hardest criminals in the galaxy for the ultimate title - the Unreal Grand Master.','www.unrealtournament.net',0);
INSERT INTO products_description VALUES (23,3,'The Wheel Of Time','The world in which The Wheel of Time takes place is lifted directly out of Jordan''s pages; it''s huge and consists of many different environments. How you navigate the world will depend largely on which game - single player or multipayer - you''re playing. The single player experience, with a few exceptions, will see Elayna traversing the world mainly by foot (with a couple notable exceptions). In the multiplayer experience, your character will have more access to travel via Ter''angreal, Portal Stones, and the Ways. However you move around, though, you''ll quickly discover that means of locomotion can easily become the least of the your worries...<br><br>During your travels, you quickly discover that four locations are crucial to your success in the game. Not surprisingly, these locations are the homes of The Wheel of Time''s main characters. Some of these places are ripped directly from the pages of Jordan''s books, made flesh with Legend''s unparalleled pixel-pushing ways. Other places are specific to the game, conceived and executed with the intent of expanding this game world even further. Either way, they provide a backdrop for some of the most intense first person action and strategy you''ll have this year.','www.wheeloftime.com',0);
INSERT INTO products_description VALUES (24,3,'Disciples: Sacred Lands','A new age is dawning...<br><br>Enter the realm of the Sacred Lands, where the dawn of a New Age has set in motion the most momentous of wars. As the prophecies long foretold, four races now clash with swords and sorcery in a desperate bid to control the destiny of their gods. Take on the quest as a champion of the Empire, the Mountain Clans, the Legions of the Damned, or the Undead Hordes and test your faith in battles of brute force, spellbinding magic and acts of guile. Slay demons, vanquish giants and combat merciless forces of the dead and undead. But to ensure the salvation of your god, the hero within must evolve.<br><br>The day of reckoning has come... and only the chosen will survive.','',0);
INSERT INTO products_description VALUES (25,3,'Microsoft Internet Keyboard PS/2','The Internet Keyboard has 10 Hot Keys on a comfortable standard keyboard design that also includes a detachable palm rest. The Hot Keys allow you to browse the web, or check e-mail directly from your keyboard. The IntelliType Pro software also allows you to customize your hot keys - make the Internet Keyboard work the way you want it to!','',0);
INSERT INTO products_description VALUES (26,3,'Microsoft IntelliMouse Explorer','Microsoft introduces its most advanced mouse, the IntelliMouse Explorer! IntelliMouse Explorer features a sleek design, an industrial-silver finish, a glowing red underside and taillight, creating a style and look unlike any other mouse. IntelliMouse Explorer combines the accuracy and reliability of Microsoft IntelliEye optical tracking technology, the convenience of two new customizable function buttons, the efficiency of the scrolling wheel and the comfort of expert ergonomic design. All these great features make this the best mouse for the PC!','www.microsoft.com/hardware/mouse/explorer.asp',0);
INSERT INTO products_description VALUES (27,3,'Hewlett Packard LaserJet 1100Xi','HP has always set the pace in laser printing technology. The new generation HP LaserJet 1100 series sets another impressive pace, delivering a stunning 8 pages per minute print speed. The 600 dpi print resolution with HP''s Resolution Enhancement technology (REt) makes every document more professional.<br><br>Enhanced print speed and laser quality results are just the beginning. With 2MB standard memory, HP LaserJet 1100xi users will be able to print increasingly complex pages. Memory can be increased to 18MB to tackle even more complex documents with ease. The HP LaserJet 1100xi supports key operating systems including Windows 3.1, 3.11, 95, 98, NT 4.0, OS/2 and DOS. Network compatibility available via the optional HP JetDirect External Print Servers.<br><br>HP LaserJet 1100xi also features The Document Builder for the Web Era from Trellix Corp. (featuring software to create Web documents).','www.pandi.hp.com/pandi-db/prodinfo.main?product=laserjet1100',0);

INSERT INTO products_attributes VALUES (products_attributes_seq.nextval,1,4,1,0.00,'+');
INSERT INTO products_attributes VALUES (products_attributes_seq.nextval,1,4,2,50.00,'+');
INSERT INTO products_attributes VALUES (products_attributes_seq.nextval,1,4,3,70.00,'+');
INSERT INTO products_attributes VALUES (products_attributes_seq.nextval,1,3,5,0.00,'+');
INSERT INTO products_attributes VALUES (products_attributes_seq.nextval,1,3,6,100.00,'+');
INSERT INTO products_attributes VALUES (products_attributes_seq.nextval,2,4,3,10.00,'-');
INSERT INTO products_attributes VALUES (products_attributes_seq.nextval,2,4,4,0.00,'+');
INSERT INTO products_attributes VALUES (products_attributes_seq.nextval,2,3,6,0.00,'+');
INSERT INTO products_attributes VALUES (products_attributes_seq.nextval,2,3,7,120.00,'+');
INSERT INTO products_attributes VALUES (products_attributes_seq.nextval,26,3,8,0.00,'+');
INSERT INTO products_attributes VALUES (products_attributes_seq.nextval,26,3,9,6.00,'+');
--INSERT INTO products_attributes VALUES (26,22,5,10,0.00,'+');
--INSERT INTO products_attributes VALUES (27,22,5,13,0.00,'+');

INSERT INTO products_attrs_download VALUES (26, 'unreal.zip', 7, 3);

INSERT INTO products_options VALUES (1, 1, 'Color');
INSERT INTO products_options VALUES (2, 1, 'Size');
INSERT INTO products_options VALUES (3, 1, 'Model');
INSERT INTO products_options VALUES (4, 1, 'Memory');
INSERT INTO products_options VALUES (1, 2, 'Farbe');
INSERT INTO products_options VALUES (2, 2, 'Größe');
INSERT INTO products_options VALUES (3, 2, 'Modell');
INSERT INTO products_options VALUES (4, 2, 'Speicher');
INSERT INTO products_options VALUES (1, 3, 'Color');
INSERT INTO products_options VALUES (2, 3, 'Talla');
INSERT INTO products_options VALUES (3, 3, 'Modelo');
INSERT INTO products_options VALUES (4, 3, 'Memoria');
--INSERT INTO products_options VALUES (5, 3, 'Version');
--INSERT INTO products_options VALUES (5, 2, 'Version');
--INSERT INTO products_options VALUES (5, 1, 'Version');


INSERT INTO products_options_values VALUES (1,1,'4 mb');
INSERT INTO products_options_values VALUES (2,1,'8 mb');
INSERT INTO products_options_values VALUES (3,1,'16 mb');
INSERT INTO products_options_values VALUES (4,1,'32 mb');
INSERT INTO products_options_values VALUES (5,1,'Value');
INSERT INTO products_options_values VALUES (6,1,'Premium');
INSERT INTO products_options_values VALUES (7,1,'Deluxe');
INSERT INTO products_options_values VALUES (8,1,'PS/2');
INSERT INTO products_options_values VALUES (9,1,'USB');
INSERT INTO products_options_values VALUES (1,2,'4 MB');
INSERT INTO products_options_values VALUES (2,2,'8 MB');
INSERT INTO products_options_values VALUES (3,2,'16 MB');
INSERT INTO products_options_values VALUES (4,2,'32 MB');
INSERT INTO products_options_values VALUES (5,2,'Value Ausgabe');
INSERT INTO products_options_values VALUES (6,2,'Premium Ausgabe');
INSERT INTO products_options_values VALUES (7,2,'Deluxe Ausgabe');
INSERT INTO products_options_values VALUES (8,2,'PS/2 Anschluss');
INSERT INTO products_options_values VALUES (9,2,'USB Anschluss');
INSERT INTO products_options_values VALUES (1,3,'4 mb');
INSERT INTO products_options_values VALUES (2,3,'8 mb');
INSERT INTO products_options_values VALUES (3,3,'16 mb');
INSERT INTO products_options_values VALUES (4,3,'32 mb');
INSERT INTO products_options_values VALUES (5,3,'Value');
INSERT INTO products_options_values VALUES (6,3,'Premium');
INSERT INTO products_options_values VALUES (7,3,'Deluxe');
INSERT INTO products_options_values VALUES (8,3,'PS/2');
INSERT INTO products_options_values VALUES (9,3,'USB');
--INSERT INTO products_options_values VALUES (10, 1, 'Download: Windows - English');
--INSERT INTO products_options_values VALUES (10, 2, 'Download: Windows - Englisch');
--INSERT INTO products_options_values VALUES (10, 3, 'Download: Windows - Inglese');
--INSERT INTO products_options_values VALUES (13, 1, 'Box: Windows - English');
--INSERT INTO products_options_values VALUES (13, 2, 'Box: Windows - Englisch');
--INSERT INTO products_options_values VALUES (13, 3, 'Box: Windows - Inglese');

INSERT INTO prod_opt_vals_to_prod_opt VALUES (prod_opt_vals_to_prod_opt_seq.nextval,4,1);
INSERT INTO prod_opt_vals_to_prod_opt VALUES (prod_opt_vals_to_prod_opt_seq.nextval,4,2);
INSERT INTO prod_opt_vals_to_prod_opt VALUES (prod_opt_vals_to_prod_opt_seq.nextval,4,3);
INSERT INTO prod_opt_vals_to_prod_opt VALUES (prod_opt_vals_to_prod_opt_seq.nextval,4,4);
INSERT INTO prod_opt_vals_to_prod_opt VALUES (prod_opt_vals_to_prod_opt_seq.nextval,3,5);
INSERT INTO prod_opt_vals_to_prod_opt VALUES (prod_opt_vals_to_prod_opt_seq.nextval,3,6);
INSERT INTO prod_opt_vals_to_prod_opt VALUES (prod_opt_vals_to_prod_opt_seq.nextval,3,7);
INSERT INTO prod_opt_vals_to_prod_opt VALUES (prod_opt_vals_to_prod_opt_seq.nextval,3,8);
INSERT INTO prod_opt_vals_to_prod_opt VALUES (prod_opt_vals_to_prod_opt_seq.nextval,3,9);
--INSERT INTO prod_opt_vals_to_prod_opt VALUES (10, 5, 10);
--INSERT INTO prod_opt_vals_to_prod_opt VALUES (13, 5, 13);

INSERT INTO products_to_categories VALUES (1,4);
INSERT INTO products_to_categories VALUES (2,4);
INSERT INTO products_to_categories VALUES (3,9);
INSERT INTO products_to_categories VALUES (4,10);
INSERT INTO products_to_categories VALUES (5,11);
INSERT INTO products_to_categories VALUES (6,10);
INSERT INTO products_to_categories VALUES (7,12);
INSERT INTO products_to_categories VALUES (8,13);
INSERT INTO products_to_categories VALUES (9,10);
INSERT INTO products_to_categories VALUES (10,10);
INSERT INTO products_to_categories VALUES (11,10);
INSERT INTO products_to_categories VALUES (12,10);
INSERT INTO products_to_categories VALUES (13,10);
INSERT INTO products_to_categories VALUES (14,15);
INSERT INTO products_to_categories VALUES (15,14);
INSERT INTO products_to_categories VALUES (16,15);
INSERT INTO products_to_categories VALUES (17,10);
INSERT INTO products_to_categories VALUES (18,10);
INSERT INTO products_to_categories VALUES (19,12);
INSERT INTO products_to_categories VALUES (20,15);
INSERT INTO products_to_categories VALUES (21,18);
INSERT INTO products_to_categories VALUES (22,19);
INSERT INTO products_to_categories VALUES (23,20);
INSERT INTO products_to_categories VALUES (24,20);
INSERT INTO products_to_categories VALUES (25,8);
INSERT INTO products_to_categories VALUES (26,9);
INSERT INTO products_to_categories VALUES (27,5);

INSERT INTO reviews VALUES (reviews_seq.nextval,19,1,'John doe',5, sysdate,sysdate,0);

INSERT INTO reviews_description VALUES (1,1, 'this has to be one of the funniest movies released for 1999!');

INSERT INTO specials VALUES (specials_seq.nextval,3, 39.99, sysdate, sysdate, to_date('2020/01/01', 'yyyy/mm/dd'), sysdate, 1);
INSERT INTO specials VALUES (specials_seq.nextval,5, 30.00, sysdate, sysdate, to_date('2020/01/01', 'yyyy/mm/dd'), sysdate, 1);
INSERT INTO specials VALUES (specials_seq.nextval,6, 30.00, sysdate, sysdate, to_date('2020/01/01', 'yyyy/mm/dd'), sysdate, 1);
INSERT INTO specials VALUES (specials_seq.nextval,16, 29.99, sysdate, sysdate, to_date('2020/01/01', 'yyyy/mm/dd'), sysdate, 1);

INSERT INTO tax_class VALUES (tax_class_seq.nextval, 'Taxable Goods', 'The following types of products are included non-food, services, etc', sysdate, sysdate);

-- USA/Florida
INSERT INTO tax_rates VALUES (tax_rates_seq.nextval, 1, 1, 1, 7.0, 'FL TAX 7.0%', sysdate, sysdate);
INSERT INTO geo_zones VALUES (geo_zones_seq.nextval,'Florida','Florida local sales tax zone',sysdate,sysdate);
INSERT INTO zones_to_geo_zones VALUES (zones_to_geo_zones_seq.nextval,223,18,1,sysdate,sysdate);

-- USA
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 223,'AL','Alabama');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 223,'AK','Alaska');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 223,'AS','American Samoa');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 223,'AZ','Arizona');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 223,'AR','Arkansas');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 223,'AF','Armed Forces Africa');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 223,'AA','Armed Forces Americas');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 223,'AC','Armed Forces Canada');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 223,'AE','Armed Forces Europe');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 223,'AM','Armed Forces Middle East');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 223,'AP','Armed Forces Pacific');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 223,'CA','California');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 223,'CO','Colorado');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 223,'CT','Connecticut');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 223,'DE','Delaware');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 223,'DC','District of Columbia');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 223,'FM','Federated States Of Micronesia');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 223,'FL','Florida');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 223,'GA','Georgia');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 223,'GU','Guam');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 223,'HI','Hawaii');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 223,'ID','Idaho');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 223,'IL','Illinois');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 223,'IN','Indiana');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 223,'IA','Iowa');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 223,'KS','Kansas');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 223,'KY','Kentucky');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 223,'LA','Louisiana');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 223,'ME','Maine');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 223,'MH','Marshall Islands');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 223,'MD','Maryland');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 223,'MA','Massachusetts');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 223,'MI','Michigan');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 223,'MN','Minnesota');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 223,'MS','Mississippi');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 223,'MO','Missouri');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 223,'MT','Montana');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 223,'NE','Nebraska');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 223,'NV','Nevada');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 223,'NH','New Hampshire');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 223,'NJ','New Jersey');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 223,'NM','New Mexico');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 223,'NY','New York');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 223,'NC','North Carolina');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 223,'ND','North Dakota');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 223,'MP','Northern Mariana Islands');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 223,'OH','Ohio');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 223,'OK','Oklahoma');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 223,'OR','Oregon');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 223,'PW','Palau');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 223,'PA','Pennsylvania');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 223,'PR','Puerto Rico');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 223,'RI','Rhode Island');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 223,'SC','South Carolina');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 223,'SD','South Dakota');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 223,'TN','Tennessee');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 223,'TX','Texas');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 223,'UT','Utah');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 223,'VT','Vermont');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 223,'VI','Virgin Islands');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 223,'VA','Virginia');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 223,'WA','Washington');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 223,'WV','West Virginia');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 223,'WI','Wisconsin');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 223,'WY','Wyoming');

--Australia
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 13,'ACT','Australian Capitol Territory');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 13,'NSW','New South Wales');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 13,'NT','Northern Territory');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 13,'QLD','Queensland');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 13,'SA','South Australia');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 13,'TAS','Tasmania');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 13,'VIC','Victoria');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 13,'WA','Western Australia');

-- Austria
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 14,'WI','Wien');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 14,'NO','Niederösterreich');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 14,'OO','Oberösterreich');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 14,'SB','Salzburg');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 14,'KN','Kärnten');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 14,'ST','Steiermark');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 14,'TI','Tirol');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 14,'BL','Burgenland');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 14,'VB','Voralberg');

--China
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 44,'AN','Anhui');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 44,'BE','Beijing');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 44,'CH','Chongqing');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 44,'FU','Fujian');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 44,'GA','Gansu');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 44,'GU','Guangdong');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 44,'GX','Guangxi');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 44,'GZ','Guizhou');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 44,'HA','Hainan');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 44,'HB','Hebei');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 44,'HL','Heilongjiang');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 44,'HE','Henan');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 44,'HK','Hong Kong');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 44,'HU','Hubei');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 44,'HN','Hunan');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 44,'IM','Inner Mongolia');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 44,'JI','Jiangsu');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 44,'JX','Jiangxi');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 44,'JL','Jilin');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 44,'LI','Liaoning');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 44,'MA','Macau');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 44,'NI','Ningxia');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 44,'SH','Shaanxi');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 44,'SA','Shandong');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 44,'SG','Shanghai');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 44,'SX','Shanxi');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 44,'SI','Sichuan');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 44,'TI','Tianjin');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 44,'XI','Xinjiang');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 44,'YU','Yunnan');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 44,'ZH','Zhejiang');

--India
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 99,'AN','Andaman and Nicobar Islands');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 99,'AP','Andhra Pradesh');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 99,'AR','Arunachal Pradesh');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 99,'AS','Assam');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 99,'BI','Bihar');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 99,'CH','Chandigarh');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 99,'DA','Dadra and Nagar Haveli');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 99,'DM','Daman and Diu');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 99,'DE','Delhi');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 99,'GO','Goa');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 99,'GU','Gujarat');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 99,'HA','Haryana');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 99,'HP','Himachal Pradesh');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 99,'JA','Jammu and Kashmir');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 99,'KA','Karnataka');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 99,'KE','Kerala');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 99,'LI','Lakshadweep Islands');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 99,'MP','Madhya Pradesh');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 99,'MA','Maharashtra');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 99,'MN','Manipur');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 99,'ME','Meghalaya');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 99,'MI','Mizoram');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 99,'NA','Nagaland');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 99,'OR','Orissa');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 99,'PO','Pondicherry');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 99,'PU','Punjab');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 99,'RA','Rajasthan');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 99,'SI','Sikkim');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 99,'TN','Tamil Nadu');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 99,'TR','Tripura');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 99,'UP','Uttar Pradesh');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 99,'WB','West Bengal');

--Netherlands
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 150,'DR','Drenthe');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 150,'FL','Flevoland');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 150,'FR','Friesland');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 150,'GE','Gelderland');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 150,'GR','Groningen');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 150,'LI','Limburg');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 150,'NB','Noord Brabant');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 150,'NH','Noord Holland');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 150,'OV','Overijssel');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 150,'UT','Utrecht');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 150,'ZE','Zeeland');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 150,'ZH','Zuid Holland');

-- Canada
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 38,'AB','Alberta');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 38,'BC','British Columbia');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 38,'MB','Manitoba');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 38,'NF','Newfoundland');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 38,'NB','New Brunswick');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 38,'NS','Nova Scotia');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 38,'NT','Northwest Territories');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 38,'NU','Nunavut');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 38,'ON','Ontario');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 38,'PE','Prince Edward Island');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 38,'QC','Quebec');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 38,'SK','Saskatchewan');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 38,'YT','Yukon Territory');

-- Germany
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 81,'NDS','Niedersachsen');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 81,'BAW','Baden-Württemberg');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 81,'BAY','Bayern');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 81,'BER','Berlin');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 81,'BRG','Brandenburg');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 81,'BRE','Bremen');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 81,'HAM','Hamburg');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 81,'HES','Hessen');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 81,'MEC','Mecklenburg-Vorpommern');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 81,'NRW','Nordrhein-Westfalen');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 81,'RHE','Rheinland-Pfalz');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 81,'SAR','Saarland');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 81,'SAS','Sachsen');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 81,'SAC','Sachsen-Anhalt');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 81,'SCN','Schleswig-Holstein');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 81,'THE','Thüringen');

--Greece
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 84,'AT','Attica');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 84,'CN','Central Greece');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 84,'CM','Central Macedonia');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 84,'CR','Crete');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 84,'EM','East Macedonia and Thrace');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 84,'EP','Epirus');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 84,'II','Ionian Islands');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 84,'NA','North Aegean');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 84,'PP','Peloponnesos');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 84,'SA','South Aegean');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 84,'TH','Thessaly');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 84,'WG','West Greece');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 84,'WM','West Macedonia');

-- Swizterland
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 204,'AG','Aargau');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 204,'AI','Appenzell Innerrhoden');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 204,'AR','Appenzell Ausserrhoden');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 204,'BE','Bern');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 204,'BL','Basel-Landschaft');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 204,'BS','Basel-Stadt');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 204,'FR','Freiburg');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 204,'GE','Genf');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 204,'GL','Glarus');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 204,'JU','Graubünden');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 204,'JU','Jura');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 204,'LU','Luzern');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 204,'NE','Neuenburg');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 204,'NW','Nidwalden');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 204,'OW','Obwalden');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 204,'SG','St. Gallen');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 204,'SH','Schaffhausen');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 204,'SO','Solothurn');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 204,'SZ','Schwyz');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 204,'TG','Thurgau');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 204,'TI','Tessin');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 204,'UR','Uri');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 204,'VD','Waadt');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 204,'VS','Wallis');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 204,'ZG','Zug');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 204,'ZH','Zürich');

-- Spain
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 195,'A Coruña','A Coruña');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 195,'Alava','Alava');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 195,'Albacete','Albacete');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 195,'Alicante','Alicante');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 195,'Almeria','Almeria');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 195,'Asturias','Asturias');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 195,'Avila','Avila');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 195,'Badajoz','Badajoz');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 195,'Baleares','Baleares');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 195,'Barcelona','Barcelona');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 195,'Burgos','Burgos');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 195,'Caceres','Caceres');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 195,'Cadiz','Cadiz');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 195,'Cantabria','Cantabria');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 195,'Castellon','Castellon');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 195,'Ceuta','Ceuta');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 195,'Ciudad Real','Ciudad Real');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 195,'Cordoba','Cordoba');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 195,'Cuenca','Cuenca');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 195,'Girona','Girona');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 195,'Granada','Granada');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 195,'Guadalajara','Guadalajara');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 195,'Guipuzcoa','Guipuzcoa');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 195,'Huelva','Huelva');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 195,'Huesca','Huesca');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 195,'Jaen','Jaen');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 195,'La Rioja','La Rioja');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 195,'Las Palmas','Las Palmas');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 195,'Leon','Leon');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 195,'Lleida','Lleida');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 195,'Lugo','Lugo');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 195,'Madrid','Madrid');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 195,'Malaga','Malaga');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 195,'Melilla','Melilla');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 195,'Murcia','Murcia');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 195,'Navarra','Navarra');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 195,'Ourense','Ourense');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 195,'Palencia','Palencia');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 195,'Pontevedra','Pontevedra');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 195,'Salamanca','Salamanca');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 195,'Santa Cruz de Tenerife','Santa Cruz de Tenerife');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 195,'Segovia','Segovia');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 195,'Sevilla','Sevilla');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 195,'Soria','Soria');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 195,'Tarragona','Tarragona');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 195,'Teruel','Teruel');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 195,'Toledo','Toledo');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 195,'Valencia','Valencia');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 195,'Valladolid','Valladolid');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 195,'Vizcaya','Vizcaya');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 195,'Zamora','Zamora');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 195,'Zaragoza','Zaragoza');

--Turkey
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 215,'ADA','Adana');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 215,'ADI','Adiyaman');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 215,'AFY','Afyonkarahisar');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 215,'AGR','Agri');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 215,'AKS','Aksaray');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 215,'AMA','Amasya');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 215,'ANK','Ankara');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 215,'ANT','Antalya');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 215,'ARD','Ardahan');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 215,'ART','Artvin');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 215,'AYI','Aydin');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 215,'BAL','Balikesir');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 215,'BAR','Bartin');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 215,'BAT','Batman');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 215,'BAY','Bayburt');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 215,'BIL','Bilecik');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 215,'BIN','Bingol');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 215,'BIT','Bitlis');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 215,'BOL','Bolu');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 215,'BRD','Burdur');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 215,'BRS','Bursa');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 215,'CKL','Canakkale');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 215,'CKR','Cankiri');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 215,'COR','Corum');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 215,'DEN','Denizli');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 215,'DIY','Diyarbakir');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 215,'DUZ','Duzce');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 215,'EDI','Edirne');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 215,'ELA','Elazig');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 215,'EZC','Erzincan');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 215,'EZR','Erzurum');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 215,'ESK','Eskisehir');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 215,'GAZ','Gaziantep');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 215,'GIR','Giresun');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 215,'GMS','Gumushane');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 215,'HKR','Hakkari');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 215,'HTY','Hatay');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 215,'IGD','Igdir');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 215,'ISP','Isparta');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 215,'IST','Istanbul');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 215,'IZM','Izmir');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 215,'KAH','Kahramanmaras');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 215,'KRB','Karabuk');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 215,'KRM','Karaman');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 215,'KRS','Kars');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 215,'KAS','Kastamonu');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 215,'KAY','Kayseri');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 215,'KLS','Kilis');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 215,'KRK','Kirikkale');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 215,'KLR','Kirklareli');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 215,'KRH','Kirsehir');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 215,'KOC','Kocaeli');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 215,'KON','Konya');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 215,'KUT','Kutahya');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 215,'MAL','Malatya');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 215,'MAN','Manisa');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 215,'MAR','Mardin');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 215,'MER','Mersin');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 215,'MUG','Mugla');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 215,'MUS','Mus');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 215,'NEV','Nevsehir');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 215,'NIG','Nigde');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 215,'ORD','Ordu');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 215,'OSM','Osmaniye');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 215,'RIZ','Rize');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 215,'SAK','Sakarya');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 215,'SAM','Samsun');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 215,'SAN','Sanliurfa');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 215,'SII','Siirt');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 215,'SIN','Sinop');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 215,'SIR','Sirnak');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 215,'SIV','Sivas');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 215,'TEL','Tekirdag');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 215,'TOK','Tokat');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 215,'TRA','Trabzon');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 215,'TUN','Tunceli');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 215,'USK','Usak');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 215,'VAN','Van');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 215,'YAL','Yalova');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 215,'YOZ','Yozgat');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 215,'ZON','Zonguldak');

--United Kingdom
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 222, 'ABN', 'Aberdeen');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 222, 'ABNS', 'Aberdeenshire');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 222, 'ANG', 'Anglesey');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 222, 'AGS', 'Angus');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 222, 'ARY', 'Argyll and Bute');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 222, 'BEDS', 'Bedfordshire');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 222, 'BERKS', 'Berkshire');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 222, 'BLA', 'Blaenau Gwent');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 222, 'BRI', 'Bridgend');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 222, 'BSTL', 'Bristol');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 222, 'BUCKS', 'Buckinghamshire');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 222, 'CAE', 'Caerphilly');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 222, 'CAMBS', 'Cambridgeshire');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 222, 'CDF', 'Cardiff');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 222, 'CARM', 'Carmarthenshire');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 222, 'CDGN', 'Ceredigion');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 222, 'CHES', 'Cheshire');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 222, 'CLACK', 'Clackmannanshire');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 222, 'CON', 'Conwy');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 222, 'CORN', 'Cornwall');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 222, 'DNBG', 'Denbighshire');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 222, 'DERBY', 'Derbyshire');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 222, 'DVN', 'Devon');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 222, 'DOR', 'Dorset');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 222, 'DGL', 'Dumfries and Galloway');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 222, 'DUND', 'Dundee');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 222, 'DHM', 'Durham');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 222, 'ARYE', 'East Ayrshire');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 222, 'DUNBE', 'East Dunbartonshire');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 222, 'LOTE', 'East Lothian');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 222, 'RENE', 'East Renfrewshire');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 222, 'ERYS', 'East Riding of Yorkshire');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 222, 'SXE', 'East Sussex');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 222, 'EDIN', 'Edinburgh');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 222, 'ESX', 'Essex');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 222, 'FALK', 'Falkirk');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 222, 'FFE', 'Fife');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 222, 'FLINT', 'Flintshire');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 222, 'GLAS', 'Glasgow');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 222, 'GLOS', 'Gloucestershire');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 222, 'LDN', 'Greater London');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 222, 'MCH', 'Greater Manchester');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 222, 'GDD', 'Gwynedd');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 222, 'HANTS', 'Hampshire');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 222, 'HWR', 'Herefordshire');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 222, 'HERTS', 'Hertfordshire');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 222, 'HLD', 'Highlands');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 222, 'IVER', 'Inverclyde');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 222, 'IOW', 'Isle of Wight');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 222, 'KNT', 'Kent');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 222, 'LANCS', 'Lancashire');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 222, 'LEICS', 'Leicestershire');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 222, 'LINCS', 'Lincolnshire');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 222, 'MSY', 'Merseyside');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 222, 'MERT', 'Merthyr Tydfil');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 222, 'MLOT', 'Midlothian');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 222, 'MMOUTH', 'Monmouthshire');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 222, 'MORAY', 'Moray');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 222, 'NPRTAL', 'Neath Port Talbot');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 222, 'NEWPT', 'Newport');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 222, 'NOR', 'Norfolk');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 222, 'ARYN', 'North Ayrshire');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 222, 'LANN', 'North Lanarkshire');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 222, 'YSN', 'North Yorkshire');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 222, 'NHM', 'Northamptonshire');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 222, 'NLD', 'Northumberland');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 222, 'NOT', 'Nottinghamshire');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 222, 'ORK', 'Orkney Islands');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 222, 'OFE', 'Oxfordshire');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 222, 'PEM', 'Pembrokeshire');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 222, 'PERTH', 'Perth and Kinross');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 222, 'PWS', 'Powys');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 222, 'REN', 'Renfrewshire');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 222, 'RHON', 'Rhondda Cynon Taff');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 222, 'RUT', 'Rutland');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 222, 'BOR', 'Scottish Borders');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 222, 'SHET', 'Shetland Islands');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 222, 'SPE', 'Shropshire');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 222, 'SOM', 'Somerset');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 222, 'ARYS', 'South Ayrshire');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 222, 'LANS', 'South Lanarkshire');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 222, 'YSS', 'South Yorkshire');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 222, 'SFD', 'Staffordshire');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 222, 'STIR', 'Stirling');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 222, 'SFK', 'Suffolk');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 222, 'SRY', 'Surrey');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 222, 'SWAN', 'Swansea');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 222, 'TORF', 'Torfaen');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 222, 'TWR', 'Tyne and Wear');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 222, 'VGLAM', 'Vale of Glamorgan');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 222, 'WARKS', 'Warwickshire');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 222, 'WDUN', 'West Dunbartonshire');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 222, 'WLOT', 'West Lothian');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 222, 'WMD', 'West Midlands');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 222, 'SXW', 'West Sussex');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 222, 'YSW', 'West Yorkshire');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 222, 'WIL', 'Western Isles');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 222, 'WLT', 'Wiltshire');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 222, 'WORCS', 'Worcestershire');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name) VALUES (zones_seq.nextval, 222, 'WRX', 'Wrexham');



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

-----------------------------------------------------------------
-- KonaKart supplementary v8.5.0.0 demo database script for MySQL database
-----------------------------------------------------------------
--
-- KonaKart data configuration parameters
--
-- TODO:
-- To configure KonaKart to be able to send emails you have to modify the values to be inserted for the
-- Email configuration parameters..  You will need to set parameters for:
--	SMTP Server Name
--	SMTP Secure (whether or not the server requires authentication, true or false)
--	SMTP Username
--	SMTP Password
--	Email Reply To Address

-- TODO - Modify the following values for your own configuration:  (Default values are supplied - but these have to be changed)

-- Email Configuration:

INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (configuration_seq.nextval, 'SMTP Server',          'SMTP_SERVER',          'ENTER_YOUR_SMTP_SERVER_HERE', 'The SMTP server',                                         '12', '2', sysdate);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, set_function) VALUES (configuration_seq.nextval, 'SMTP Secure',          'SMTP_SECURE',          'false',                       'Whether or not the SMTP server needs user authentication', '12', '3', sysdate, 'choice(''true''=''true'',''false''=''false'')');
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (configuration_seq.nextval, 'SMTP User',            'SMTP_USER',            'user@yourdomain.com',         'The SMTP user',                                           '12', '4', sysdate);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, set_function) VALUES (configuration_seq.nextval, 'SMTP Password',        'SMTP_PASSWORD',        '',                            'The SMTP password',                                       '12', '5', sysdate, 'password');
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (configuration_seq.nextval, 'Email Reply To',       'EMAIL_REPLY_TO',       'user@yourdomain.com',         'The Reply To Address',                                    '12', '6', sysdate);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, set_function) VALUES (configuration_seq.nextval, 'Debug Email Sessions', 'DEBUG_EMAIL_SESSIONS', 'false',                       'Debug email sessions',                                    '12', '7', sysdate, 'choice(''true''=''true'',''false''=''false'')');
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (configuration_seq.nextval, 'Send Extra Emails To', 'SEND_EXTRA_EMAILS_TO', '', 'Send extra emails to the following email addresses, separated by semicolons: email@address1; email@address2', '1', '11', sysdate);

-- Stock Reorder implementation:

INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (configuration_seq.nextval, 'Stock Reorder Class','STOCK_REORDER_CLASS','com.konakart.bl.ReorderMgr','The Stock Reorder Implementation Cass','9', '7', sysdate);

-- Refresh interval for client side caches

INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (configuration_seq.nextval, 'Client cache refresh interval','CLIENT_CACHE_UPDATE_SECS','600','Interval in seconds for refreshing client side caches','11', '8', 'integer(60,null)', sysdate);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (configuration_seq.nextval, 'Client config cache refresh check interval','CLIENT_CONFIG_CACHE_CHECK_SECS','30','Interval in seconds for checking to see whether the client side cache of config variables needs updating','11', '9', 'integer(30,null)', sysdate);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (configuration_seq.nextval, 'Client config cache refresh flag','CLIENT_CONFIG_CACHE_CHECK_FLAG','false','Boolean to determine whether to refresh the client config variable cache','100', '1' , sysdate);

-- Table to store IPN notifications from payment gateways
BEGIN EXECUTE IMMEDIATE 'DROP TABLE ipn_history'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE ipn_history (
  ipn_history_id NUMBER(10,0) NOT NULL,
  module_code VARCHAR2(32) NOT NULL,
  gateway_transaction_id VARCHAR2(128),
  gateway_result VARCHAR2(128),
  gateway_full_response VARCHAR2(4000),
  order_id int,
  konakart_result_id int,
  konakart_result_description VARCHAR2(255),
  date_added TIMESTAMP,
  PRIMARY KEY(ipn_history_id)
);
BEGIN EXECUTE IMMEDIATE 'DROP SEQUENCE ipn_history_SEQ'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE SEQUENCE ipn_history_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

-- Base URL and path for images

INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (configuration_seq.nextval, 'Image base URL','IMG_BASE_URL','http://localhost:8780/konakart/images/','The base URL for application images','4', '9', sysdate);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (configuration_seq.nextval, 'Image base path','IMG_BASE_PATH','C:/Program Files/KonaKart/webapps/konakart/images','The base path where application images are saved','4', '10', sysdate);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (configuration_seq.nextval, 'URL for reaching Image servlet','IMG_SERVLET_URL','/konakartadmin/uploadAction','The URL used to reach the servlet used for uploading images','4', '11', sysdate);

-- Addition of custom fields

ALTER TABLE customers ADD custom1 varchar(128);
ALTER TABLE customers ADD custom2 varchar(128);
ALTER TABLE customers ADD custom3 varchar(128);
ALTER TABLE customers ADD custom4 varchar(128);
ALTER TABLE customers ADD custom5 varchar(128);

ALTER TABLE products ADD custom1 varchar(128);
ALTER TABLE products ADD custom2 varchar(128);
ALTER TABLE products ADD custom3 varchar(128);
ALTER TABLE products ADD custom4 varchar(128);
ALTER TABLE products ADD custom5 varchar(128);

ALTER TABLE manufacturers ADD custom1 varchar(128);
ALTER TABLE manufacturers ADD custom2 varchar(128);
ALTER TABLE manufacturers ADD custom3 varchar(128);
ALTER TABLE manufacturers ADD custom4 varchar(128);
ALTER TABLE manufacturers ADD custom5 varchar(128);

ALTER TABLE address_book ADD custom1 varchar(128);
ALTER TABLE address_book ADD custom2 varchar(128);
ALTER TABLE address_book ADD custom3 varchar(128);
ALTER TABLE address_book ADD custom4 varchar(128);
ALTER TABLE address_book ADD custom5 varchar(128);

ALTER TABLE orders ADD custom1 varchar(128);
ALTER TABLE orders ADD custom2 varchar(128);
ALTER TABLE orders ADD custom3 varchar(128);
ALTER TABLE orders ADD custom4 varchar(128);
ALTER TABLE orders ADD custom5 varchar(128);

ALTER TABLE reviews ADD custom1 varchar(128);
ALTER TABLE reviews ADD custom2 varchar(128);
ALTER TABLE reviews ADD custom3 varchar(128);

ALTER TABLE categories ADD custom1 varchar(128);
ALTER TABLE categories ADD custom2 varchar(128);
ALTER TABLE categories ADD custom3 varchar(128);

-- SSL
DELETE FROM configuration WHERE configuration_key = 'ENABLE_SSL';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (configuration_seq.nextval, 'Enables SSL if set to true', 'ENABLE_SSL', 'false', 'Enables SSL if set to true to make the site secure', '16', '10', 'choice(''true''=''true'',''false''=''false'')', sysdate);
DELETE FROM configuration WHERE configuration_key = 'STANDARD_PORT_NUMBER';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (configuration_seq.nextval, 'Port number for standard (non SSL) pages','STANDARD_PORT_NUMBER','8780','Port number used to access standard non SSL pages','16', '20' ,'integer(0,null)', sysdate);
DELETE FROM configuration WHERE configuration_key = 'SSL_PORT_NUMBER';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (configuration_seq.nextval, 'Port number for SSL pages','SSL_PORT_NUMBER','8443','Port number used to access SSL pages','16', '30' ,'integer(0,null)', sysdate);

-- Location for report definitions, and BIRT viewer home
DELETE FROM configuration WHERE configuration_key = 'REPORTS_DEFN_PATH';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (configuration_seq.nextval, 'Report definitions base path','REPORTS_DEFN_PATH','C:/Program Files/KonaKart/webapps/birt-viewer/reports/','The reports definition location','17', '1', sysdate);
DELETE FROM configuration WHERE configuration_key = 'REPORTS_EXTENSION';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (configuration_seq.nextval, 'Report file extension','REPORTS_EXTENSION','.rptdesign','The report file extension - identifies report files','17', '2', sysdate);
DELETE FROM configuration WHERE configuration_key = 'REPORTS_URL';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (configuration_seq.nextval, 'Report viewer URL','REPORTS_URL','http://localhost:8780/birt-viewer/frameset?__report=reports/','The report viewer base URL','17', '3', sysdate);
DELETE FROM configuration WHERE configuration_key = 'REPORTS_STATUS_PAGE_URL';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (configuration_seq.nextval, 'Status Page Report URL','REPORTS_STATUS_PAGE_URL','http://localhost:8780/birt-viewer/run?__report=reports/OrdersInLast30DaysChart.rptdesign','The URL for the report on the status page','17', '4', sysdate);

-- Stock Reorder Email
DELETE FROM configuration WHERE configuration_key = 'STOCK_REORDER_EMAIL';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (configuration_seq.nextval, 'E-Mail address for low stock alert', 'STOCK_REORDER_EMAIL', 'reorder_mgr@konakart.com', 'The e-mail address used to send an alert email when the stock level of a product falls below the reorder level', '9', '6', sysdate);

-- Allow user to insert coupon code
DELETE FROM configuration WHERE configuration_key = 'DISPLAY_COUPON_ENTRY';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (configuration_seq.nextval, 'Display Coupon Entry Field', 'DISPLAY_COUPON_ENTRY', 'true', 'During checkout the customer will be allowed to enter a coupon if set to true', '1', '22', 'choice(''true''=''true'',''false''=''false'')', sysdate);

-- Promotions
BEGIN EXECUTE IMMEDIATE 'DROP TABLE promotion'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE promotion (
  promotion_id NUMBER(10,0) NOT NULL,
  order_total_code VARCHAR2(32) NOT NULL,
  description VARCHAR2(128),
  name VARCHAR2(64),
  active NUMBER(10,0) DEFAULT 0 NOT NULL,
  cumulative NUMBER(10,0) DEFAULT 0 NOT NULL,
  requires_coupon NUMBER(10,0) DEFAULT 0 NOT NULL,
  start_date TIMESTAMP,
  end_date TIMESTAMP,
  manufacturer_rule int,
  product_rule int,
  customer_rule int,
  category_rule int,
  custom1 VARCHAR2(128),
  custom2 VARCHAR2(128),
  custom3 VARCHAR2(128),
  custom4 VARCHAR2(128),
  custom5 VARCHAR2(128),
  custom6 VARCHAR2(128),
  custom7 VARCHAR2(128),
  custom8 VARCHAR2(128),
  custom9 VARCHAR2(128),
  custom10 VARCHAR2(128),
  date_added TIMESTAMP NOT NULL,
  last_modified TIMESTAMP,
  PRIMARY KEY(promotion_id)
);
BEGIN EXECUTE IMMEDIATE 'DROP SEQUENCE promotion_SEQ'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE SEQUENCE promotion_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

BEGIN EXECUTE IMMEDIATE 'DROP TABLE promotion_to_manufacturer'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE promotion_to_manufacturer (
  promotion_id NUMBER(10,0) NOT NULL,
  manufacturers_id NUMBER(10,0) NOT NULL,
  PRIMARY KEY(promotion_id,manufacturers_id)
);

BEGIN EXECUTE IMMEDIATE 'DROP TABLE promotion_to_product'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE promotion_to_product (
  promotion_id NUMBER(10,0) NOT NULL,
  products_id NUMBER(10,0) NOT NULL,
  products_options_id NUMBER(10,0) DEFAULT 0 NOT NULL,
  products_options_values_id NUMBER(10,0) DEFAULT 0 NOT NULL,
  PRIMARY KEY(promotion_id,products_id,products_options_id,products_options_values_id)
);

BEGIN EXECUTE IMMEDIATE 'DROP TABLE promotion_to_category'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE promotion_to_category (
  promotion_id NUMBER(10,0) NOT NULL,
  categories_id NUMBER(10,0) NOT NULL,
  PRIMARY KEY(promotion_id,categories_id)
);

BEGIN EXECUTE IMMEDIATE 'DROP TABLE promotion_to_customer'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE promotion_to_customer (
  promotion_id NUMBER(10,0) NOT NULL,
  customers_id NUMBER(10,0) NOT NULL,
  max_use NUMBER(10,0) DEFAULT -1 NOT NULL,
  times_used NUMBER(10,0) DEFAULT 0 NOT NULL,
  custom1 VARCHAR2(128),
  custom2 VARCHAR2(128),
  PRIMARY KEY(promotion_id,customers_id)
);

BEGIN EXECUTE IMMEDIATE 'DROP TABLE coupon'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE coupon (
  coupon_id NUMBER(10,0) NOT NULL,
  coupon_code VARCHAR2(64) NOT NULL,
  name VARCHAR2(64),
  description VARCHAR2(128),
  max_use NUMBER(10,0) DEFAULT 1 NOT NULL,
  times_used NUMBER(10,0) DEFAULT 0 NOT NULL,
  custom1 VARCHAR2(128),
  custom2 VARCHAR2(128),
  custom3 VARCHAR2(128),
  custom4 VARCHAR2(128),
  custom5 VARCHAR2(128),
  date_added TIMESTAMP NOT NULL,
  last_modified TIMESTAMP,
  PRIMARY KEY(coupon_id)
);
BEGIN EXECUTE IMMEDIATE 'DROP SEQUENCE coupon_SEQ'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE SEQUENCE coupon_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

BEGIN EXECUTE IMMEDIATE 'DROP TABLE promotion_to_coupon'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE promotion_to_coupon (
  promotion_id NUMBER(10,0) NOT NULL,
  coupon_id NUMBER(10,0) NOT NULL,
  PRIMARY KEY(promotion_id,coupon_id)
);

-- Add promotion related fields to orders table
ALTER TABLE orders ADD promotion_ids varchar(64);
ALTER TABLE orders ADD coupon_ids varchar(64);


-- Utility Table
BEGIN EXECUTE IMMEDIATE 'DROP TABLE utility'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE utility (
  id NUMBER(10,0) NOT NULL,
  PRIMARY KEY(id)
);

DELETE FROM utility;
INSERT INTO utility (id) VALUES (1);
INSERT INTO utility (id) VALUES (2);
INSERT INTO utility (id) VALUES (3);
INSERT INTO utility (id) VALUES (4);
INSERT INTO utility (id) VALUES (5);
INSERT INTO utility (id) VALUES (6);
INSERT INTO utility (id) VALUES (7);
INSERT INTO utility (id) VALUES (8);
INSERT INTO utility (id) VALUES (9);
INSERT INTO utility (id) VALUES (10);
INSERT INTO utility (id) VALUES (11);
INSERT INTO utility (id) VALUES (12);
INSERT INTO utility (id) VALUES (13);
INSERT INTO utility (id) VALUES (14);
INSERT INTO utility (id) VALUES (15);
INSERT INTO utility (id) VALUES (16);
INSERT INTO utility (id) VALUES (17);
INSERT INTO utility (id) VALUES (18);
INSERT INTO utility (id) VALUES (19);
INSERT INTO utility (id) VALUES (20);
INSERT INTO utility (id) VALUES (21);
INSERT INTO utility (id) VALUES (22);
INSERT INTO utility (id) VALUES (23);
INSERT INTO utility (id) VALUES (24);
INSERT INTO utility (id) VALUES (25);
INSERT INTO utility (id) VALUES (26);
INSERT INTO utility (id) VALUES (27);
INSERT INTO utility (id) VALUES (28);
INSERT INTO utility (id) VALUES (29);
INSERT INTO utility (id) VALUES (30);
INSERT INTO utility (id) VALUES (31);

-- Product relationships for merchandising
BEGIN EXECUTE IMMEDIATE 'DROP TABLE products_to_products'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE products_to_products (
  products_to_products_id NUMBER(10,0) NOT NULL,
  id_from NUMBER(10,0) NOT NULL,
  id_to NUMBER(10,0) NOT NULL,
  relation_type NUMBER(10,0) DEFAULT 0 NOT NULL,
  custom1 VARCHAR2(128),
  custom2 VARCHAR2(128),
  PRIMARY KEY(products_to_products_id)
);
BEGIN EXECUTE IMMEDIATE 'DROP SEQUENCE products_to_products_SEQ'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE SEQUENCE products_to_products_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

-- Max number of items to display for merchandising
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (configuration_seq.nextval, 'Up Sell Products', 'MAX_DISPLAY_UP_SELL', '6', 'Maximum number of products to display in the ''Top of Range'' box', '3', '20', 'integer(0,null)', sysdate);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (configuration_seq.nextval, 'Cross Sell Products', 'MAX_DISPLAY_CROSS_SELL', '6', 'Maximum number of products to display in the ''Similar Products'' box', '3', '21', 'integer(0,null)', sysdate);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (configuration_seq.nextval, 'Accessories', 'MAX_DISPLAY_ACCESSORIES', '6', 'Maximum number of products to display in the ''Accessories'' box', '3', '22', 'integer(0,null)', sysdate);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (configuration_seq.nextval, 'Dependent Products', 'MAX_DISPLAY_DEPENDENT_PRODUCTS', '6', 'Maximum number of products to display in the ''Warranties'' box', '3', '23', 'integer(0,null)', sysdate);

-- Single page checkout
DELETE FROM configuration WHERE configuration_key = 'ONE_PAGE_CHECKOUT';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (configuration_seq.nextval, 'Enables One Page Checkout', 'ONE_PAGE_CHECKOUT', 'true', 'When set to true, it enables the one page checkout functionality rather than 3 separate pages', '1', '23', 'choice(''true''=''true'',''false''=''false'')', sysdate);
DELETE FROM configuration WHERE configuration_key = 'ALLOW_CHECKOUT_WITHOUT_REGISTRATION';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (configuration_seq.nextval, 'Enables Checkout Without Registration', 'ALLOW_CHECKOUT_WITHOUT_REGISTRATION', 'true', 'When set to true, and one page checkout is enabled, it allows customers to checkout without registering', '1', '24', 'choice(''true''=''true'',''false''=''false'')', sysdate);


-- Order Integration Mgr
DELETE FROM configuration WHERE configuration_key = 'ORDER_INTEGRATION_CLASS';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (configuration_seq.nextval, 'Order Integration Class', 'ORDER_INTEGRATION_CLASS','com.konakart.bl.OrderIntegrationMgr','The Order Integration Implementation Class, to trigger off events when an order is saved or modified', '9', '8', sysdate);
DELETE FROM configuration WHERE configuration_key = 'ADMIN_ORDER_INTEGRATION_CLASS';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (configuration_seq.nextval, 'Admin Order Integration Class', 'ADMIN_ORDER_INTEGRATION_CLASS','com.konakartadmin.bl.AdminOrderIntegrationMgr','The Order Integration Implementation Class, to trigger off events when an order is modified from the Admin App', '9', '9', sysdate);

-- Table to contain quantities for products with different options
BEGIN EXECUTE IMMEDIATE 'DROP TABLE products_quantity'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE products_quantity (
  products_id NUMBER(10,0) NOT NULL,
  products_options VARCHAR2(128) NOT NULL,
  products_quantity NUMBER(10,0) NOT NULL,
  products_sku VARCHAR2(255),
  PRIMARY KEY(products_id, products_options)
);

-- Add extra fields to orders_products_attributes table
ALTER TABLE orders_products_attributes ADD products_options_id int DEFAULT '-1' NOT NULL;
ALTER TABLE orders_products_attributes ADD products_options_values_id int DEFAULT '-1' NOT NULL;

-- Add extra fields to products table
ALTER TABLE products ADD products_invisible NUMBER(10,0) DEFAULT 0 NOT NULL;
ALTER TABLE products ADD products_sku varchar(255);

-- Tables for returns
BEGIN EXECUTE IMMEDIATE 'DROP TABLE orders_returns'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE orders_returns (
  orders_returns_id NUMBER(10,0) NOT NULL,
  orders_id NUMBER(10,0) NOT NULL,
  rma_code VARCHAR2(128),
  return_reason VARCHAR2(4000),
  date_added TIMESTAMP,
  last_modified TIMESTAMP,
  PRIMARY KEY(orders_returns_id)
);
BEGIN EXECUTE IMMEDIATE 'DROP SEQUENCE orders_returns_SEQ'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE SEQUENCE orders_returns_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

BEGIN EXECUTE IMMEDIATE 'DROP TABLE returns_to_ord_prods'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE returns_to_ord_prods (
  orders_returns_id NUMBER(10,0) NOT NULL,
  orders_products_id NUMBER(10,0) NOT NULL,
  quantity NUMBER(10,0) NOT NULL,
  date_added TIMESTAMP,
  PRIMARY KEY(orders_returns_id, orders_products_id)
);

-- Extend the size of the products_model column
ALTER TABLE products MODIFY products_model VARCHAR(64);

-- Add an extra field to the ipn_history table
ALTER TABLE ipn_history ADD customers_id int;

-- For the case where SSL communication requires a different URL
DELETE FROM configuration WHERE configuration_key = 'SSL_BASE_URL';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (configuration_seq.nextval, 'Base URL for SSL pages','SSL_BASE_URL','','Base URL used for SSL pages (i.e. https://myhost:8443). This overrides the SSL port number config.','16', '40', sysdate);

-- Variables for configuring auditing
DELETE FROM configuration WHERE configuration_key = 'READ_AUDIT';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (configuration_seq.nextval, 'Auditing for Reads', 'READ_AUDIT', '0', 'Enable / Disable auditing for reads', '18', '1','tep_cfg_pull_down_audit_list(', sysdate);
DELETE FROM configuration WHERE configuration_key = 'EDIT_AUDIT';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (configuration_seq.nextval, 'Auditing for Edits', 'EDIT_AUDIT', '0', 'Enable / Disable auditing for edits', '18', '2','tep_cfg_pull_down_audit_list(', sysdate);
DELETE FROM configuration WHERE configuration_key = 'INSERT_AUDIT';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (configuration_seq.nextval, 'Auditing for Inserts', 'INSERT_AUDIT', '0', 'Enable / Disable auditing for inserts', '18', '3','tep_cfg_pull_down_audit_list(', sysdate);
DELETE FROM configuration WHERE configuration_key = 'DELETE_AUDIT';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (configuration_seq.nextval, 'Auditing for Deletes', 'DELETE_AUDIT', '0', 'Enable / Disable auditing for deletes', '18', '4','tep_cfg_pull_down_audit_list(', sysdate);

-- Audit table
BEGIN EXECUTE IMMEDIATE 'DROP TABLE kk_audit'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE kk_audit (
  audit_id NUMBER(10,0) NOT NULL,
  customers_id NUMBER(10,0) NOT NULL,
  audit_action NUMBER(10,0) NOT NULL,
  api_method_name VARCHAR2(128) NOT NULL,
  object_id int,
  object_to_string VARCHAR2(4000),
  date_added TIMESTAMP NOT NULL,
  PRIMARY KEY(audit_id)
);
BEGIN EXECUTE IMMEDIATE 'DROP SEQUENCE kk_audit_SEQ'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE SEQUENCE kk_audit_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

-- Add extra fields to the customers table
ALTER TABLE customers ADD customers_type int;
ALTER TABLE customers ADD customers_enabled int DEFAULT 1;

-- Role table
BEGIN EXECUTE IMMEDIATE 'DROP TABLE kk_role'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE kk_role (
  role_id NUMBER(10,0) NOT NULL,
  name VARCHAR2(128) NOT NULL,
  description VARCHAR2(255),
  date_added TIMESTAMP,
  last_modified TIMESTAMP,
  PRIMARY KEY(role_id)
);
BEGIN EXECUTE IMMEDIATE 'DROP SEQUENCE kk_role_SEQ'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE SEQUENCE kk_role_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

-- Customers_to_role table
BEGIN EXECUTE IMMEDIATE 'DROP TABLE kk_customers_to_role'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE kk_customers_to_role (
  ctor_id NUMBER(10,0) NOT NULL,
  role_id NUMBER(10,0) DEFAULT 0 NOT NULL,
  customers_id NUMBER(10,0) DEFAULT 0 NOT NULL,
  store_id VARCHAR2(64),
  date_added TIMESTAMP,
  PRIMARY KEY(ctor_id)
);
BEGIN EXECUTE IMMEDIATE 'DROP SEQUENCE kk_customers_to_role_SEQ'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE SEQUENCE kk_customers_to_role_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

-- Panel table
BEGIN EXECUTE IMMEDIATE 'DROP TABLE kk_panel'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE kk_panel (
  panel_id NUMBER(10,0) NOT NULL,
  code VARCHAR2(128) NOT NULL,
  description VARCHAR2(255),
  date_added TIMESTAMP,
  last_modified TIMESTAMP,
  PRIMARY KEY(panel_id)
);
BEGIN EXECUTE IMMEDIATE 'DROP SEQUENCE kk_panel_SEQ'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE SEQUENCE kk_panel_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

-- Role to Panel table
BEGIN EXECUTE IMMEDIATE 'DROP TABLE kk_role_to_panel'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE kk_role_to_panel (
  role_id NUMBER(10,0) DEFAULT 0 NOT NULL,
  panel_id NUMBER(10,0) DEFAULT 0 NOT NULL,
  can_edit NUMBER(10,0) DEFAULT 0,
  can_insert NUMBER(10,0) DEFAULT 0,
  can_delete NUMBER(10,0) DEFAULT 0,
  custom1 NUMBER(10,0) DEFAULT 0,
  custom1_desc VARCHAR2(128),
  custom2 NUMBER(10,0) DEFAULT 0,
  custom2_desc VARCHAR2(128),
  custom3 NUMBER(10,0) DEFAULT 0,
  custom3_desc VARCHAR2(128),
  custom4 NUMBER(10,0) DEFAULT 0,
  custom4_desc VARCHAR2(128),
  custom5 NUMBER(10,0) DEFAULT 0,
  custom5_desc VARCHAR2(128),
  date_added TIMESTAMP,
  last_modified TIMESTAMP,
  PRIMARY KEY(role_id, panel_id)
);

-- Default super-administrator user = "admin@konakart.com" password = "princess"
DELETE FROM customers WHERE customers_email_address = 'admin@konakart.com' AND customers_telephone='019081';
DELETE FROM address_book WHERE entry_street_address='1 Way Street' AND entry_postcode='PostCode1';
INSERT INTO address_book (address_book_id, customers_id, entry_gender, entry_company, entry_firstname, entry_lastname, entry_street_address, entry_suburb, entry_postcode, entry_city, entry_state, entry_country_id, entry_zone_id) VALUES (address_book_seq.nextval,-1, 'm', 'ACME Inc.', 'Andy', 'Admin', '1 Way Street', '', 'PostCode1', 'NeverNever', '', 223, 12);
INSERT INTO customers (customers_id, customers_gender, customers_firstname, customers_lastname,customers_dob, customers_email_address, customers_default_address_id, customers_telephone, customers_fax, customers_password, customers_newsletter, customers_type) VALUES (customers_seq.nextval, 'm', 'Andy', 'Admin', to_date('1977/01/01', 'yyyy/mm/dd'), 'admin@konakart.com', -1, '019081', '', 'f5147fc3f6eb46e234c01db939bdb581:08', '0', 1);
INSERT INTO customers_info select customers_id , sysdate, 0, sysdate, sysdate, 0 FROM customers WHERE customers_email_address = 'admin@konakart.com' AND customers_telephone='019081';
UPDATE address_book SET customers_id = (select customers_id from customers WHERE customers_email_address = 'admin@konakart.com' AND customers_telephone='019081') WHERE customers_id=-1;
UPDATE customers SET customers_default_address_id = (select address_book_id FROM address_book WHERE entry_street_address='1 Way Street' AND entry_postcode='PostCode1') WHERE customers_default_address_id=-1;

-- Default catalog maintainer user = "cat@konakart.com" password = "princess"
DELETE FROM customers WHERE customers_email_address = 'cat@konakart.com' AND customers_telephone='019082';
DELETE FROM address_book WHERE entry_street_address='2 Way Street' AND entry_postcode='PostCode2';
INSERT INTO address_book (address_book_id, customers_id, entry_gender, entry_company, entry_firstname, entry_lastname, entry_street_address, entry_suburb, entry_postcode, entry_city, entry_state, entry_country_id, entry_zone_id) VALUES (address_book_seq.nextval,-1, 'm', 'ACME Inc.', 'Caty', 'Catalog', '2 Way Street', '', 'PostCode2', 'NeverNever', '', 223, 12);
INSERT INTO customers (customers_id, customers_gender, customers_firstname, customers_lastname,customers_dob, customers_email_address, customers_default_address_id, customers_telephone, customers_fax, customers_password, customers_newsletter, customers_type) VALUES (customers_seq.nextval, 'm', 'Caty', 'Catalog', to_date('1977/01/01', 'yyyy/mm/dd'), 'cat@konakart.com', -1, '019082', '', 'f5147fc3f6eb46e234c01db939bdb581:08', '0', 1);
INSERT INTO customers_info SELECT customers_id , sysdate, 0, sysdate, sysdate, 0 FROM customers WHERE customers_email_address = 'cat@konakart.com' AND customers_telephone='019082';
UPDATE address_book SET customers_id = (SELECT customers_id FROM customers WHERE customers_email_address = 'cat@konakart.com' AND customers_telephone='019082') WHERE customers_id=-1;
UPDATE customers SET customers_default_address_id = (SELECT address_book_id FROM address_book WHERE entry_street_address='2 Way Street' AND entry_postcode='PostCode2') WHERE customers_default_address_id=-1;


-- Default order maintainer user = "order@konakart.com" password = "princess"
DELETE FROM customers WHERE customers_email_address = 'order@konakart.com' and customers_telephone='019083';
DELETE FROM address_book WHERE entry_street_address='3 Way Street' and entry_postcode='PostCode3';
INSERT INTO address_book (address_book_id, customers_id, entry_gender, entry_company, entry_firstname, entry_lastname, entry_street_address, entry_suburb, entry_postcode, entry_city, entry_state, entry_country_id, entry_zone_id) VALUES (address_book_seq.nextval,-1, 'm', 'ACME Inc.', 'Olly', 'Order', '3 Way Street', '', 'PostCode3', 'NeverNever', '', 223, 12);
INSERT INTO customers (customers_id, customers_gender, customers_firstname, customers_lastname,customers_dob, customers_email_address, customers_default_address_id, customers_telephone, customers_fax, customers_password, customers_newsletter, customers_type) VALUES (customers_seq.nextval, 'm', 'Olly', 'Order', to_date('1977/01/01', 'yyyy/mm/dd'), 'order@konakart.com', -1, '019083', '', 'f5147fc3f6eb46e234c01db939bdb581:08', '0', 1);
INSERT INTO customers_info SELECT customers_id , sysdate, 0, sysdate, sysdate, 0 FROM customers WHERE customers_email_address = 'order@konakart.com' AND customers_telephone='019083';
UPDATE address_book SET customers_id = (SELECT customers_id FROM customers WHERE customers_email_address = 'order@konakart.com' AND customers_telephone='019083') WHERE customers_id=-1;
UPDATE customers SET customers_default_address_id = (SELECT address_book_id FROM address_book WHERE entry_street_address='3 Way Street' AND entry_postcode='PostCode3') WHERE customers_default_address_id=-1;

-- Panels
DELETE FROM kk_panel;
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval,  'kk_panel_addressFormats','Address Formats', sysdate);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval,  'kk_panel_audit','Audit', sysdate);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval,  'kk_panel_auditConfig','AuditConfig', sysdate);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval,  'kk_panel_cache','Cache', sysdate);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval,  'kk_panel_categories','Categories', sysdate);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval,  'kk_panel_configFiles','Configuration Files', sysdate);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval,  'kk_panel_digitalDownloadConfig','Digital Downloads', sysdate);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval,  'kk_panel_countries','Countries', sysdate);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval,  'kk_panel_coupons','Coupons', sysdate);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval,  'kk_panel_couponsFromProm','Coupons For Promotions', sysdate);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval,  'kk_panel_currencies','Currencies', sysdate);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval,  'kk_panel_customerDetails','Customer Details', sysdate);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval,  'kk_panel_customerOrders','Customer Orders', sysdate);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval,  'kk_panel_customers','Customers', sysdate);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval,  'kk_panel_deleteSessions','Delete Expired Sessions', sysdate);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval,  'kk_panel_editCustomer','Edit Customer', sysdate);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval,  'kk_panel_editOrderPanel','Edit Order', sysdate);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval,  'kk_panel_editProduct','Edit Product', sysdate);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval,  'kk_panel_emailOptions','Email Options', sysdate);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval,  'kk_panel_geoZones','Geo-Zones', sysdate);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval,  'kk_panel_httpHttps','HTTP / HTTPS', sysdate);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval,  'kk_panel_images','Images', sysdate);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval,  'kk_panel_insertCustomer','Insert Customer', sysdate);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval,  'kk_panel_ipnhistory','Payment Gateway Callbacks', sysdate);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval,  'kk_panel_ipnhistoryFromOrders','Payment Status For Order', sysdate);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval,  'kk_panel_languages','Languages', sysdate);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval,  'kk_panel_logging','Logging', sysdate);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval,  'kk_panel_roleToPanels','Maintain Roles', sysdate);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval,  'kk_panel_manufacturers','Manufacturers', sysdate);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval,  'kk_panel_maximumValues','Maximum Values', sysdate);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval,  'kk_panel_minimumValues','Minimum Values', sysdate);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval,  'kk_panel_userToRoles','Map Users to Roles', sysdate);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval,  'kk_panel_orders','Orders', sysdate);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval,  'kk_panel_orderStatuses','Order Statuses', sysdate);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval,  'kk_panel_orderTotalModules','Order Total', sysdate);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval,  'kk_panel_paymentModules','Payment', sysdate);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval,  'kk_panel_prodsFromCat','Products for Categories', sysdate);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval,  'kk_panel_prodsFromManu','Products for Manufacturer', sysdate);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval,  'kk_panel_productOptions','Product Options', sysdate);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval,  'kk_panel_products','Products', sysdate);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval,  'kk_panel_promotions','Promotions', sysdate);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval,  'kk_panel_promRules','Promotion Rules', sysdate);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval,  'kk_panel_refreshCache','Refresh Config Cache', sysdate);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval,  'kk_panel_reports','Reports', sysdate);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval,  'kk_panel_reportsConfig','Reports Configuration', sysdate);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval,  'kk_panel_returns','Product Returns', sysdate);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval,  'kk_panel_returnsFromOrders','Product Returns For Order', sysdate);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval,  'kk_panel_rss','Latest News', sysdate);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval,  'kk_panel_shippingModules','Shipping', sysdate);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval,  'kk_panel_shippingPacking','Shipping / Packing', sysdate);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval,  'kk_panel_status','Status', sysdate);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval,  'kk_panel_stockAndOrders','Stock and Orders', sysdate);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval,  'kk_panel_storeConfiguration','My Store', sysdate);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval,  'kk_panel_subZones','Sub-Zones', sysdate);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval,  'kk_panel_taxAreaMapping','Tax Area Mapping', sysdate);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval,  'kk_panel_taxAreas','Tax Areas', sysdate);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval,  'kk_panel_taxAreaToZoneMapping','Tax Area to Zone Mapping', sysdate);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval,  'kk_panel_taxClasses','Tax Classes', sysdate);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval,  'kk_panel_taxRates','Tax Rates', sysdate);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval,  'kk_panel_zones','Zones', sysdate);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval,  'kk_panel_changePassword','Change Password', sysdate);

-- Roles
DELETE FROM kk_role;
INSERT INTO kk_role (role_id, name, description, date_added) VALUES (kk_role_seq.nextval,  'Super User','Permission to do everything to all stores', sysdate);
INSERT INTO kk_role (role_id, name, description, date_added) VALUES (kk_role_seq.nextval,  'Catalog Maintenance','Permission to maintain the catalog of products', sysdate);
INSERT INTO kk_role (role_id, name, description, date_added) VALUES (kk_role_seq.nextval,  'Order Maintenance','Permission to maintain the orders', sysdate);
INSERT INTO kk_role (role_id, name, description, date_added) VALUES (kk_role_seq.nextval,  'Customer Maintenance','Permission to maintain the customers', sysdate);
INSERT INTO kk_role (role_id, name, description, date_added) VALUES (kk_role_seq.nextval,  'Store Administrator','Permission to maintain a single store', sysdate);

-- Associate roles to panels
DELETE FROM kk_role_to_panel;

-- Super User Role
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 1, 1,1,1,sysdate);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 2, 1,1,1,sysdate);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 3, 1,1,1,sysdate);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 4, 1,1,1,sysdate);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 5, 1,1,1,sysdate);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 6, 1,1,1,sysdate);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 7, 1,1,1,sysdate);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 8, 1,1,1,sysdate);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 9, 1,1,1,sysdate);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 10, 1,1,1,sysdate);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 11, 1,1,1,sysdate);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 12, 1,1,1,sysdate);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 13, 1,1,1,sysdate);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, custom1, custom1_desc, custom2, custom2_desc) VALUES (1, 14, 1,1,1,sysdate, 0, 'If set email is disabled', 0, 'If set cannot reset password');
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 15, 1,1,1,sysdate);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 16, 1,1,1,sysdate);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 17, 1,1,1,sysdate);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 18, 1,1,1,sysdate);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 19, 1,1,1,sysdate);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 20, 1,1,1,sysdate);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 21, 1,1,1,sysdate);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 22, 1,1,1,sysdate);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 23, 1,1,1,sysdate);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 24, 1,1,1,sysdate);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 25, 1,1,1,sysdate);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 26, 1,1,1,sysdate);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 27, 1,1,1,sysdate);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 28, 1,1,1,sysdate);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 29, 1,1,1,sysdate);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 30, 1,1,1,sysdate);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 31, 1,1,1,sysdate);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 32, 1,1,1,sysdate);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 33, 1,1,1,sysdate);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 34, 1,1,1,sysdate);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 35, 1,1,1,sysdate);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 36, 1,1,1,sysdate);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 37, 1,1,1,sysdate);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 38, 1,1,1,sysdate);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 39, 1,1,1,sysdate);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 40, 1,1,1,sysdate);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 41, 1,1,1,sysdate);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 42, 1,1,1,sysdate);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 43, 1,1,1,sysdate);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, custom1, custom1_desc) VALUES (1, 44, 1,1,1,sysdate, 0, 'If set reports cannot be run');
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 45, 1,1,1,sysdate);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 46, 1,1,1,sysdate);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 47, 1,1,1,sysdate);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 48, 1,1,1,sysdate);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 49, 1,1,1,sysdate);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 50, 1,1,1,sysdate);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 51, 1,1,1,sysdate);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 52, 1,1,1,sysdate);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 53, 1,1,1,sysdate);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 54, 1,1,1,sysdate);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 55, 1,1,1,sysdate);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 56, 1,1,1,sysdate);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 57, 1,1,1,sysdate);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 58, 1,1,1,sysdate);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 59, 1,1,1,sysdate);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 60, 1,1,1,sysdate);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 61, 1,1,1,sysdate);

-- Catalog maintenance Role
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (2, 5, 1,1,1,sysdate);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (2, 9, 1,1,1,sysdate);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (2, 10, 1,1,1,sysdate);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (2, 18, 1,1,1,sysdate);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (2, 29, 1,1,1,sysdate);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (2, 37, 1,1,1,sysdate);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (2, 38, 1,1,1,sysdate);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (2, 39, 1,1,1,sysdate);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (2, 40, 1,1,1,sysdate);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (2, 41, 1,1,1,sysdate);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (2, 42, 1,1,1,sysdate);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (2, 61, 1,1,1,sysdate);

-- Order Maintenance Role
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (3, 17, 1,1,1,sysdate);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (3, 24, 1,1,1,sysdate);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (3, 25, 1,1,1,sysdate);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (3, 33, 1,1,1,sysdate);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (3, 46, 1,1,1,sysdate);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (3, 47, 1,1,1,sysdate);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (3, 61, 1,1,1,sysdate);

-- Customer Maintenance Role
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (4, 13, 1,1,1,sysdate);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, custom1, custom1_desc, custom2, custom2_desc) VALUES (4, 14, 1,1,1,sysdate, 0, 'If set email is disabled', 0, 'If set cannot reset password');
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (4, 16, 1,1,1,sysdate);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (4, 23, 1,1,1,sysdate);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (4, 61, 1,1,1,sysdate);

-- Associate customers to roles
DELETE FROM kk_customers_to_role;

-- Super User
INSERT INTO kk_customers_to_role (ctor_id, role_id, customers_id, date_added) SELECT kk_customers_to_role_seq.nextval, 1, customers_id, sysdate FROM customers WHERE customers_email_address = 'admin@konakart.com' AND customers_telephone='019081';

-- Catalog maintainer
INSERT INTO kk_customers_to_role (ctor_id, role_id, customers_id, date_added) SELECT kk_customers_to_role_seq.nextval, 2, customers_id, sysdate FROM customers WHERE customers_email_address = 'cat@konakart.com' AND customers_telephone='019082';

-- Order & Customer Manager
INSERT INTO kk_customers_to_role (ctor_id, role_id, customers_id, date_added) SELECT kk_customers_to_role_seq.nextval, 3, customers_id, sysdate FROM customers WHERE customers_email_address = 'order@konakart.com' AND customers_telephone='019083';
INSERT INTO kk_customers_to_role (ctor_id, role_id, customers_id, date_added) SELECT kk_customers_to_role_seq.nextval, 4, customers_id, sysdate FROM customers WHERE customers_email_address = 'order@konakart.com' AND customers_telephone='019083';

-- Digital Download table
BEGIN EXECUTE IMMEDIATE 'DROP TABLE kk_digital_download'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE kk_digital_download (
  products_id NUMBER(10,0) DEFAULT 0 NOT NULL,
  customers_id NUMBER(10,0) DEFAULT 0 NOT NULL,
  max_downloads NUMBER(10,0) DEFAULT -1,
  times_downloaded NUMBER(10,0) DEFAULT 0,
  expiration_date TIMESTAMP,
  date_added TIMESTAMP,
  last_modified TIMESTAMP,
  PRIMARY KEY(products_id, customers_id)
);

-- Add extra fields to the products table
ALTER TABLE products ADD products_type int DEFAULT '0';
ALTER TABLE products ADD products_file_path varchar(255);
ALTER TABLE products ADD products_content_type varchar(128);

-- Add extra field to the orders_products
ALTER TABLE orders_products ADD products_type int DEFAULT '0';

-- Configuration variables for digital downloads
DELETE FROM configuration WHERE configuration_key = 'DD_BASE_PATH';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (configuration_seq.nextval, 'Digital Download Base Path', 'DD_BASE_PATH', '', 'Base path for digital download files', 19, 0, sysdate);
DELETE FROM configuration WHERE configuration_key = 'DD_MAX_DOWNLOADS';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (configuration_seq.nextval, 'Max Number of Downloads', 'DD_MAX_DOWNLOADS', '-1', 'Maximum number of downloads allowed from link. -1 for unlimited number.', 19, 1, sysdate);
DELETE FROM configuration WHERE configuration_key = 'DD_MAX_DOWNLOAD_DAYS';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (configuration_seq.nextval, 'Number of days link is valid', 'DD_MAX_DOWNLOAD_DAYS', '-1', 'The download link remains valid for this number of days. -1 for unlimited number of days', 19, 2, sysdate);
DELETE FROM configuration WHERE configuration_key = 'DD_DELETE_ON_EXPIRATION';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (configuration_seq.nextval, 'Delete record on expiration', 'DD_DELETE_ON_EXPIRATION', 'true', 'When the download link expires, delete the database table record', 19, 3, 'choice(''true''=''true'',''false''=''false'')',sysdate);
DELETE FROM configuration WHERE configuration_key = 'DD_DOWNLOAD_AS_ATTACHMENT';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (configuration_seq.nextval, 'Download as an attachment', 'DD_DOWNLOAD_AS_ATTACHMENT', 'true', 'Download the file as an attachment rather than viewing in the browser', 19, 4, 'choice(''true''=''true'',''false''=''false'')',sysdate);

-- Add a new order status
DELETE FROM orders_status WHERE orders_status_id = 7;
INSERT INTO orders_status(orders_status_id, language_id, orders_status_name) VALUES (7,1,'Partially Delivered');
INSERT INTO orders_status(orders_status_id, language_id, orders_status_name) VALUES (7,2,'Teilweise geliefert');
INSERT INTO orders_status(orders_status_id, language_id, orders_status_name) VALUES (7,3,'Entregado parcialmente');

-- Configuration variable for enabling/disabling access to Invisible Products in the Admin App
DELETE FROM configuration WHERE configuration_key = 'SHOW_INVISIBLE_PRODUCTS_IN_ADM';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (configuration_seq.nextval, 'Show Invisible Products', 'SHOW_INVISIBLE_PRODUCTS_IN_ADM', 'true', 'Show invisible products in the Admin App', 9, 4, 'choice(''true''=''true'',''false''=''false'')', sysdate);

-- Add a primary key to the counter table
BEGIN EXECUTE IMMEDIATE 'DROP TABLE counter'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE counter (
  counter_id NUMBER(10,0) NOT NULL,
  startdate char(8),
  counter NUMBER(10,0),
  PRIMARY KEY(counter_id)
);
BEGIN EXECUTE IMMEDIATE 'DROP SEQUENCE counter_SEQ'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE SEQUENCE counter_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;


-- Logging configuration
INSERT INTO configuration_group VALUES (configuration_group_seq.nextval, 'Logging', 'Logging configuration options', '20', '1');
DELETE FROM configuration WHERE configuration_key = 'ADMIN_APP_LOGGING_LEVEL';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (configuration_seq.nextval, 'Admin App logging level', 'ADMIN_APP_LOGGING_LEVEL', '4', 'Set the logging level for the KonaKart Admin App', '20', '1', 'option(0=OFF,1=SEVERE,2=ERROR,4=WARNING,6=INFO,8=DEBUG)', sysdate);

-- Detailed eMail configurations
DELETE FROM configuration WHERE configuration_key = 'SEND_ORDER_CONF_EMAIL';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (configuration_seq.nextval, 'Send Order Confirmation E-Mails', 'SEND_ORDER_CONF_EMAIL', 'true', 'Send out an e-mail when an order is saved or state changes', '12', '8', 'choice(''true''=''true'',''false''=''false'')', sysdate);
DELETE FROM configuration WHERE configuration_key = 'SEND_STOCK_REORDER_EMAIL';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (configuration_seq.nextval, 'Send Stock Reorder E-Mails', 'SEND_STOCK_REORDER_EMAIL', 'true', 'Send out an e-mail when the stock level of a product falls below a certain value', '12', '9', 'choice(''true''=''true'',''false''=''false'')', sysdate);
DELETE FROM configuration WHERE configuration_key = 'SEND_WELCOME_EMAIL';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (configuration_seq.nextval, 'Send Welcome E-Mails', 'SEND_WELCOME_EMAIL', 'true', 'Send out a welcome e-mail when a customer registers to use the cart', '12', '10', 'choice(''true''=''true'',''false''=''false'')', sysdate);
DELETE FROM configuration WHERE configuration_key = 'SEND_NEW_PASSWORD_EMAIL';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (configuration_seq.nextval, 'Send New Password E-Mails', 'SEND_NEW_PASSWORD_EMAIL', 'true', 'Send out an e-mail containing a new password when requested by a customer', '12', '11', 'choice(''true''=''true'',''false''=''false'')', sysdate);

-- Add extra image fields to product
ALTER TABLE products ADD products_image2 varchar(64);
ALTER TABLE products ADD products_image3 varchar(64);
ALTER TABLE products ADD products_image4 varchar(64);

-- Add field for comparison data to products_description
ALTER TABLE products_description ADD products_comparison VARCHAR2(4000);

-- Initial configuration for the Order Total Shipping Module
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (configuration_seq.nextval, 'Allow Free Shipping', 'MODULE_ORDER_TOTAL_SHIPPING_FREE_SHIPPING', 'false', 'Do you want to allow free shipping?', '6', '3','choice(''true''=''true'',''false''=''false'')', sysdate);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, use_function, date_added) VALUES (configuration_seq.nextval, 'Free Shipping For Orders Over', 'MODULE_ORDER_TOTAL_SHIPPING_FREE_SHIPPING_OVER', '50', 'Provide free shipping for orders over the set amount.', '6', '4', 'currencies->format',sysdate);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (configuration_seq.nextval, 'Provide Free Shipping For Orders Made', 'MODULE_ORDER_TOTAL_SHIPPING_DESTINATION', 'national', 'Provide free shipping for orders sent to the set destination.', '6', '5', 'tep_cfg_select_option(array(''national'', ''international'', ''both''), ', sysdate);

-- API Call table
BEGIN EXECUTE IMMEDIATE 'DROP TABLE kk_api_call'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE kk_api_call (
  api_call_id NUMBER(10,0) NOT NULL,
  name VARCHAR2(128) NOT NULL,
  description VARCHAR2(255),
  date_added TIMESTAMP,
  last_modified TIMESTAMP,
  PRIMARY KEY(api_call_id)
);
BEGIN EXECUTE IMMEDIATE 'DROP SEQUENCE kk_api_call_SEQ'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE SEQUENCE kk_api_call_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

-- Role to API Call table
BEGIN EXECUTE IMMEDIATE 'DROP TABLE kk_role_to_api_call'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE kk_role_to_api_call (
  role_id NUMBER(10,0) DEFAULT 0 NOT NULL,
  api_call_id NUMBER(10,0) DEFAULT 0 NOT NULL,
  date_added TIMESTAMP,
  PRIMARY KEY(role_id, api_call_id)
);

-- Add the API Call Data
DELETE FROM kk_api_call;
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'deleteCurrency','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'insertCurrency','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'updateCurrency','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'deleteOrderStatusName','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'insertOrderStatusName','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'insertOrderStatusNames','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'updateOrderStatusName','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'deleteCountry','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'insertCountry','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'updateCountry','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'deleteLanguage','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'insertLanguage','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'updateLanguage','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'sendEmail','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'getOrdersCount','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'getOrdersLite','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'getOrders','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'getOrderForOrderId','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'getOrderForOrderIdAndLangId','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'getOrdersCreatedSince','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'updateOrderStatus','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'getHtml','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'getCustomersCount','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'getCustomersCountWhoHaventPlacedAnOrderSince','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'getCustomersCountWhoHavePlacedAnOrderSince','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'updateCustomer','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'deleteCustomer','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'deleteOrder','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'getCustomers','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'getCustomersLite','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'getCustomerForId','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'deleteTaxRate','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'insertTaxRate','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'updateTaxRate','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'deleteZone','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'insertZone','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'updateZone','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'deleteTaxClass','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'insertTaxClass','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'updateTaxClass','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'deleteAddressFormat','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'insertAddressFormat','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'updateAddressFormat','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'deleteGeoZone','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'insertGeoZone','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'updateGeoZone','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'deleteSubZone','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'insertSubZone','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'updateSubZone','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'getConfigurationInfo','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'getConfigurationsByGroup','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'saveConfigs','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'insertConfigs','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'removeConfigs','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'getModules','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'registerCustomer','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'resetCustomerPassword','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'changePassword','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'insertProduct','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'editProduct','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'getProduct','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'searchForProducts','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'deleteProduct','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'deleteCategoryTree','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'deleteSingleCategory','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'editCategory','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'insertCategory','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'moveCategory','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'deleteManufacturer','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'editManufacturer','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'insertManufacturer','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'deleteReview','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'editReview','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'getAllReviews','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'getReview','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'getReviewsPerProduct','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'insertReview','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'insertSpecial','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'getSpecial','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'deleteSpecial','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'editSpecial','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'getAllSpecials','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'getSpecialsPerCategory','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'deleteProductOptions','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'deleteProductOptionValues','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'getProductOptionsPerId','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'getProductOptionValuesPerId','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'insertProductOption','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'editProductOption','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'insertProductOptionValue','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'editProductOptionValue','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'getNextProductOptionId','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'getNextProductOptionValuesId','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'getProductAttributesPerProduct','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'deleteProductAttribute','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'deleteProductAttributesPerProduct','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'editProductAttribute','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'insertProductAttribute','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'insertProductOptionValues','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'insertProductOptions','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'checkSession','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'searchForIpnHistory','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'deleteExpiredSessions','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'getConfigFiles','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'getReports','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'reloadReports','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'getFileContents','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'saveFileContents','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'deleteFile','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'addCategoriesToPromotion','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'addCouponsToPromotion','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'addPromotionsToCoupon','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'addCustomersToPromotion','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'addCustomersToPromotionPerOrdersMade','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'addManufacturersToPromotion','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'addProductsToPromotion','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'deletePromotion','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'deleteCoupon','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'editCoupon','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'editPromotion','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'getCouponsPerPromotion','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'getCoupons','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'getCategoriesPerPromotion','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'getManufacturersPerPromotion','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'getProductsPerPromotion','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'getPromotion','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'getPromotions','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'getPromotionsCount','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'getPromotionsPerCoupon','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'insertCouponForPromotion','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'insertCoupon','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'insertPromotion','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'removeCategoriesFromPromotion','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'removeCouponsFromPromotion','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'removePromotionsFromCoupon','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'removeCustomersFromPromotion','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'removeManufacturersFromPromotion','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'removeProductsFromPromotion','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'getRelatedProducts','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'removeRelatedProducts','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'addRelatedProducts','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'readFromUrl','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'editOrderReturn','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'insertOrderReturn','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'deleteOrderReturn','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'getOrderReturns','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'getSku','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'getSkus','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'doesCustomerExistForEmail','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'getAuditData','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'deleteAuditData','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'getRolesPerSessionId','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'getRolesPerUser','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'addRolesToUser','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'removeRolesFromUser','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'removePanelsFromRole','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'removeApiCallsFromRole','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'addPanelsToRole','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'addApiCallsToRole','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'getPanelsPerRole','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'getApiCallsPerRole','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'getAllPanels','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'getAllApiCalls','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'getAllRoles','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'editRole','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'insertRole','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'deleteRole','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'deletePanel','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'deleteApiCall','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'editPanel','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'editApiCall','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'getPanel','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'getApiCall','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'getRole','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'insertPanel','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'insertApiCall','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'insertDigitalDownload','', sysdate);

-- Variable for enabling / disabling API Call Security
DELETE FROM configuration WHERE configuration_key = 'API_CALL_SECURITY';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (configuration_seq.nextval, 'Enable Security on API Calls', 'API_CALL_SECURITY', 'false', 'Do you want to enable security on API calls ?', '18', '5','choice(''true''=''true'',''false''=''false'')' , sysdate);

-- KonaKart Mail Properties file location
DELETE FROM configuration WHERE configuration_key = 'KONAKART_MAIL_PROPERTIES_FILE';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (configuration_seq.nextval, 'KonaKart mail properties filename', 'KONAKART_MAIL_PROPERTIES_FILE', 'C:/Program Files/KonaKart/conf/konakart_mail.properties', 'Location of the KonaKart mail properties file', '12', '8', sysdate);

-- Log file location
DELETE FROM configuration WHERE configuration_key = 'KONAKART_LOG_FILE_DIRECTORY';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (configuration_seq.nextval, 'KonaKart Log file Directory', 'KONAKART_LOG_FILE_DIRECTORY', 'C:/Program Files/KonaKart/logs', 'The location where KonaKart will write diagnostic log files', '20', '2', sysdate);

-- Extend the size of the country_name columns to match countries table
ALTER TABLE orders MODIFY customers_country VARCHAR(64);
ALTER TABLE orders MODIFY billing_country VARCHAR(64);
ALTER TABLE orders MODIFY delivery_country VARCHAR(64);

-- Extend the size of the products_model column to match products table
ALTER TABLE orders_products MODIFY products_model VARCHAR(64);

-- Do not allow checkout without registration by default
UPDATE configuration SET configuration_value = 'false', configuration_description='This allows checkout without registration only when one page checkout is enabled' WHERE configuration_key = 'ALLOW_CHECKOUT_WITHOUT_REGISTRATION';

-- Add a new panel
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval,  'kk_panel_communications','Customer Communications', sysdate);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 62, 1,1,1,sysdate);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (4, 62, 1,1,1,sysdate);

-- New API calls
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'sendTemplateEmailToCustomers1','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'insertProductNotification','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'deleteProductNotification','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'getCustomerForEmail','', sysdate);

-- Number of concurrent eMail sending threads to use for sending out the newsletter
DELETE FROM configuration WHERE configuration_key = 'EMAIL_THREADS';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (configuration_seq.nextval, 'Number of email sender threads', 'EMAIL_THREADS', '5', 'Number of concurrent threads used to send newsletter eMails', '12', '15', sysdate);

-- Addition of custom fields to orders_products and customers_basket

ALTER TABLE orders_products ADD custom1 varchar(128);
ALTER TABLE orders_products ADD custom2 varchar(128);
ALTER TABLE orders_products ADD custom3 varchar(128);
ALTER TABLE orders_products ADD custom4 varchar(128);
ALTER TABLE orders_products ADD custom5 varchar(128);

ALTER TABLE customers_basket ADD custom1 varchar(128);
ALTER TABLE customers_basket ADD custom2 varchar(128);
ALTER TABLE customers_basket ADD custom3 varchar(128);
ALTER TABLE customers_basket ADD custom4 varchar(128);
ALTER TABLE customers_basket ADD custom5 varchar(128);

-- Customer group
BEGIN EXECUTE IMMEDIATE 'DROP TABLE kk_customer_group'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE kk_customer_group (
  customer_group_id NUMBER(10,0) DEFAULT 0 NOT NULL,
  language_id NUMBER(10,0) DEFAULT 1 NOT NULL,
  name VARCHAR2(64) NOT NULL,
  description VARCHAR2(128),
  date_added TIMESTAMP,
  last_modified TIMESTAMP,
  PRIMARY KEY(customer_group_id, language_id)
);

ALTER TABLE customers ADD customers_group_id int default '-1';
ALTER TABLE promotion ADD customer_group_rule int default '0';

BEGIN EXECUTE IMMEDIATE 'DROP TABLE promotion_to_cust_group'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE promotion_to_cust_group (
  promotion_id NUMBER(10,0) NOT NULL,
  customers_group_id NUMBER(10,0) NOT NULL,
  PRIMARY KEY(promotion_id,customers_group_id)
);

-- Addition of custom fields to customer group

ALTER TABLE kk_customer_group ADD custom1 varchar(128);
ALTER TABLE kk_customer_group ADD custom2 varchar(128);
ALTER TABLE kk_customer_group ADD custom3 varchar(128);
ALTER TABLE kk_customer_group ADD custom4 varchar(128);
ALTER TABLE kk_customer_group ADD custom5 varchar(128);

-- Addition of price_id to customer group

ALTER TABLE kk_customer_group ADD price_id int default '0';

-- Addition of new price fields to product and order product

ALTER TABLE products ADD products_price_1 decimal(15,4);
ALTER TABLE products ADD products_price_2 decimal(15,4);
ALTER TABLE products ADD products_price_3 decimal(15,4);

ALTER TABLE orders_products ADD products_price_0 decimal(15,4);
ALTER TABLE orders_products ADD products_price_1 decimal(15,4);
ALTER TABLE orders_products ADD products_price_2 decimal(15,4);
ALTER TABLE orders_products ADD products_price_3 decimal(15,4);

ALTER TABLE products_attributes ADD options_values_price_1 decimal(15,4);
ALTER TABLE products_attributes ADD options_values_price_2 decimal(15,4);
ALTER TABLE products_attributes ADD options_values_price_3 decimal(15,4);

-- Add a new customer group panel
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval,  'kk_panel_custGroups','Customer Groups', sysdate);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 63, 1,1,1,sysdate);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (4, 63, 1,1,1,sysdate);

-- Address format template for address in admin app
DELETE FROM configuration WHERE configuration_key = 'ADMIN_APP_ADDRESS_FORMAT';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (configuration_seq.nextval, 'Address Format for Admin App', 'ADMIN_APP_ADDRESS_FORMAT', '$street $street1 $suburb $city $state $country', 'How the address is formatted in the customers panel', '21', '0', sysdate);

-- Add a new configuration panel
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval,  'kk_panel_adminAppConfig','Configure Admin App', sysdate);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 64, 1,1,1,sysdate);

-- Config variables for Admin customer login
DELETE FROM configuration WHERE configuration_key = 'ADMIN_APP_LOGIN_BASE_URL';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (configuration_seq.nextval, 'Base URL for logging into the App', 'ADMIN_APP_LOGIN_BASE_URL', 'https://localhost:8443/konakart/AdminLoginSubmit.do', 'Base URL for logging into the App from the Admin App', '21', '1', sysdate);

DELETE FROM configuration WHERE configuration_key = 'ADMIN_APP_LOGIN_WINDOW_FEATURES';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (configuration_seq.nextval, 'Window features', 'ADMIN_APP_LOGIN_WINDOW_FEATURES', 'resizable=yes,scrollbars=yes,status=yes,toolbar=yes,location=yes', 'Comma separated features for the application window opened by the login feature of the admin app', '21', '2', sysdate);

-- New API calls
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'removeCustomerGroupsFromPromotion','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'addCustomerGroupsToPromotion','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'getCustomerGroupsPerPromotion','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'insertCustomerGroup','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'updateCustomerGroup','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'deleteCustomerGroup','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'getCustomerGroups','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'editOrder','', sysdate);

-- Login integration class
DELETE FROM configuration WHERE configuration_key = 'LOGIN_INTEGRATION_CLASS';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (configuration_seq.nextval, 'Login Integration Class', 'LOGIN_INTEGRATION_CLASS','com.konakart.bl.LoginIntegrationMgr','The Login Integration Implementation Class, to allow custom credential checking', '18', '6', sysdate);
DELETE FROM configuration WHERE configuration_key = 'ADMIN_LOGIN_INTEGRATION_CLASS';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (configuration_seq.nextval, 'Admin Login Integration Class', 'ADMIN_LOGIN_INTEGRATION_CLASS','com.konakartadmin.bl.AdminLoginIntegrationMgr','The Login Integration Implementation Class, to allow custom credential checking for the Admin App', '18', '7', sysdate);

-- Add two custom privileges to the Orders screen for restricting access to PackingList and Invoice buttons
UPDATE kk_role_to_panel SET custom1=0, custom1_desc='If set packing list button not shown', custom2=0, custom2_desc='If set invoice button not shown' WHERE role_id=1 and panel_id=33;
UPDATE kk_role_to_panel SET custom1=0, custom1_desc='If set packing list button not shown', custom2=0, custom2_desc='If set invoice button not shown' WHERE role_id=3 and panel_id=33;

-- Config variables for Admin search definitions
DELETE FROM configuration WHERE configuration_key = 'ADMIN_APP_ADD_WILDCARD_BEFORE';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (configuration_seq.nextval, 'Add wildcard search before text', 'ADMIN_APP_ADD_WILDCARD_BEFORE', 'true', 'When set to true, a wildcard search character is added before the specified text', '21', '10', 'choice(''true''=''true'',''false''=''false'')', sysdate);
DELETE FROM configuration WHERE configuration_key = 'ADMIN_APP_ADD_WILDCARD_AFTER';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (configuration_seq.nextval, 'Add wildcard search after text', 'ADMIN_APP_ADD_WILDCARD_AFTER', 'true', 'When set to true, a wildcard search character is added after the specified text', '21', '11', 'choice(''true''=''true'',''false''=''false'')', sysdate);

-- v2.2.5.0 -------------------------------------------------------------------------------------------------------

-- Customer Panel Custom Command Definitions
DELETE FROM configuration WHERE configuration_key = 'ADMIN_APP_CUST_CUSTOM_LABEL';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (configuration_seq.nextval, 'Customer Custom Button Label', 'ADMIN_APP_CUST_CUSTOM_LABEL', '', 'When this is set, a custom button appears on the customer panel with this label', '21', '20', sysdate);
DELETE FROM configuration WHERE configuration_key = 'ADMIN_APP_CUST_CUSTOM_URL';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (configuration_seq.nextval, 'Customer Custom Button URL', 'ADMIN_APP_CUST_CUSTOM_URL', 'http://www.konakart.com', 'The URL that is launched when the Customer Custom button is clicked', '21', '21', sysdate);

-- Default Customer Panel Search Definition
DELETE FROM configuration WHERE configuration_key = 'ADMIN_APP_DEFAULT_CUST_CHOICE_IDX';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (configuration_seq.nextval, 'Default Customer Choice', 'ADMIN_APP_DEFAULT_CUST_CHOICE_IDX', 0, 'Sets the default customer choice droplist on the Customer Panel', '21', '22', 'CustomerChoices', sysdate);

-- Default Customer Group Search Definition
DELETE FROM configuration WHERE configuration_key = 'ADMIN_APP_DEFAULT_CUST_GROUP_IDX';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (configuration_seq.nextval, 'Default Customer Group', 'ADMIN_APP_DEFAULT_CUST_GROUP_IDX', 0, 'Sets the default customer group droplist on the Customer Panel', '21', '22', 'CustomerGroups', sysdate);

-- Add the custom3 privilege to enable/disable the customer search options on the Customer panel
UPDATE kk_role_to_panel SET custom3=0, custom3_desc='If set customer search droplists are disabled' WHERE panel_id=14;

-- Set customer type to 0 (customer) for all customers with null customer types
UPDATE customers SET customers_type=0 WHERE customers_type is null;

-- v2.2.6.0 -------------------------------------------------------------------------------------------------------

-- Add attributes for supporting bundles
ALTER TABLE products_to_products ADD products_options varchar(128);
ALTER TABLE products_to_products ADD products_quantity int;

-- New API calls
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'getBundleProductDetails','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'customSecure','', sysdate);

-- Insert a bundle product
INSERT INTO products (products_id, products_quantity, products_model, products_image, products_price, products_date_added, products_last_modified, products_date_available, products_weight, products_status, products_tax_class_id, manufacturers_id, products_ordered, products_type) VALUES (products_seq.nextval,0,'MSMOUSEKBBUNDLE','microsoft/bundle.gif',121.45, sysdate,null,sysdate,16.00,1,1,2,0,4);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (products_description_seq.nextval,1,'Bundle Saver','Buy the Microsoft IntelliMouse Explorer and the Internet Keyboard together\, to save  10% on the individual prices and to receive free shipping !','www.microsoft.com/hardware/',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (28,2,'Bundle Saver','Buy the Microsoft IntelliMouse Explorer and the Internet Keyboard together\, to save  10% on the individual prices and to receive free shipping !','www.microsoft.com/hardware/',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (28,3,'Bundle Saver','Buy the Microsoft IntelliMouse Explorer and the Internet Keyboard together\, to save  10% on the individual prices and to receive free shipping !','',0);
INSERT INTO products_to_categories VALUES (28,9);
INSERT INTO products_to_categories VALUES (28,8);
INSERT INTO products_to_products (products_to_products_id, id_from, id_to, relation_type, products_options, products_quantity) VALUES (products_to_products_seq.nextval,28,26,5,'3{8}',1);
INSERT INTO products_to_products (products_to_products_id, id_from, id_to, relation_type, products_options, products_quantity) VALUES (products_to_products_seq.nextval,28,25,5,'',1);

-- Tags

BEGIN EXECUTE IMMEDIATE 'DROP TABLE kk_tag_group'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE kk_tag_group (
  tag_group_id NUMBER(10,0) DEFAULT 0 NOT NULL,
  language_id NUMBER(10,0) DEFAULT 1 NOT NULL,
  name VARCHAR2(128) NOT NULL,
  description VARCHAR2(255),
  PRIMARY KEY(tag_group_id, language_id)
);

BEGIN EXECUTE IMMEDIATE 'DROP TABLE kk_tag'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE kk_tag (
  tag_id NUMBER(10,0) DEFAULT 0 NOT NULL,
  language_id NUMBER(10,0) DEFAULT 1 NOT NULL,
  name VARCHAR2(128) NOT NULL,
  sort_order NUMBER(10,0) DEFAULT 0,
  PRIMARY KEY(tag_id, language_id)
);

BEGIN EXECUTE IMMEDIATE 'DROP TABLE kk_category_to_tag_group'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE kk_category_to_tag_group (
  categories_id NUMBER(10,0) NOT NULL,
  tag_group_id NUMBER(10,0) NOT NULL,
  PRIMARY KEY(categories_id,tag_group_id)
);

BEGIN EXECUTE IMMEDIATE 'DROP TABLE kk_tag_group_to_tag'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE kk_tag_group_to_tag (
  tag_group_id NUMBER(10,0) NOT NULL,
  tag_id NUMBER(10,0) NOT NULL,
  PRIMARY KEY(tag_group_id,tag_id)
);

BEGIN EXECUTE IMMEDIATE 'DROP TABLE kk_tag_to_product'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE kk_tag_to_product (
  tag_id NUMBER(10,0) NOT NULL,
  products_id NUMBER(10,0) NOT NULL,
  date_added TIMESTAMP NOT NULL,
  PRIMARY KEY(tag_id,products_id)
);

-- Movie Rating Tags
DELETE FROM kk_tag;
INSERT INTO kk_tag (tag_id, language_id, name, sort_order)  VALUES (1,1,'General Audience: G',0);
INSERT INTO kk_tag (tag_id, language_id, name, sort_order)  VALUES (1,2,'General Audience: G',0);
INSERT INTO kk_tag (tag_id, language_id, name, sort_order)  VALUES (1,3,'General Audience: G',0);
INSERT INTO kk_tag (tag_id, language_id, name, sort_order)  VALUES (2,1,'Parental Guidance: PG',1);
INSERT INTO kk_tag (tag_id, language_id, name, sort_order)  VALUES (2,2,'Parental Guidance: PG',1);
INSERT INTO kk_tag (tag_id, language_id, name, sort_order)  VALUES (2,3,'Parental Guidance: PG',1);
INSERT INTO kk_tag (tag_id, language_id, name, sort_order)  VALUES (3,1,'Parents Cautioned: PG-13',2);
INSERT INTO kk_tag (tag_id, language_id, name, sort_order)  VALUES (3,2,'Parents Cautioned: PG-13',2);
INSERT INTO kk_tag (tag_id, language_id, name, sort_order)  VALUES (3,3,'Parents Cautioned: PG-13',2);
INSERT INTO kk_tag (tag_id, language_id, name, sort_order)  VALUES (4,1,'Restricted: R',3);
INSERT INTO kk_tag (tag_id, language_id, name, sort_order)  VALUES (4,2,'Restricted: R',3);
INSERT INTO kk_tag (tag_id, language_id, name, sort_order)  VALUES (4,3,'Restricted: R',3);
INSERT INTO kk_tag (tag_id, language_id, name, sort_order)  VALUES (5,1,'Adults Only: NC-17',4);
INSERT INTO kk_tag (tag_id, language_id, name, sort_order)  VALUES (5,2,'Adults Only: NC-17',4);
INSERT INTO kk_tag (tag_id, language_id, name, sort_order)  VALUES (5,3,'Adults Only: NC-17',4);
INSERT INTO kk_tag (tag_id, language_id, name, sort_order)  VALUES (6,1,'Blu-ray',0);
INSERT INTO kk_tag (tag_id, language_id, name, sort_order)  VALUES (6,2,'Blu-ray',0);
INSERT INTO kk_tag (tag_id, language_id, name, sort_order)  VALUES (6,3,'Blu-ray',0);
INSERT INTO kk_tag (tag_id, language_id, name, sort_order)  VALUES (7,1,'HD-DVD',1);
INSERT INTO kk_tag (tag_id, language_id, name, sort_order)  VALUES (7,2,'HD-DVD',1);
INSERT INTO kk_tag (tag_id, language_id, name, sort_order)  VALUES (7,3,'HD-DVD',1);

-- Tag group
DELETE FROM kk_tag_group;
INSERT INTO kk_tag_group (tag_group_id, language_id, name, description)  VALUES (1,1,'MPAA Movie Ratings','The MPAA rating given to each movie');
INSERT INTO kk_tag_group (tag_group_id, language_id, name, description)  VALUES (1,2,'MPAA Movie Ratings','The MPAA rating given to each movie');
INSERT INTO kk_tag_group (tag_group_id, language_id, name, description)  VALUES (1,3,'MPAA Movie Ratings','The MPAA rating given to each movie');
INSERT INTO kk_tag_group (tag_group_id, language_id, name, description)  VALUES (2,1,'DVD Format','The format of the DVD');
INSERT INTO kk_tag_group (tag_group_id, language_id, name, description)  VALUES (2,2,'DVD Format','The format of the DVD');
INSERT INTO kk_tag_group (tag_group_id, language_id, name, description)  VALUES (2,3,'DVD Format','The format of the DVD');

-- Add tags to group
DELETE FROM kk_tag_group_to_tag;
INSERT INTO kk_tag_group_to_tag (tag_group_id, tag_id)  VALUES (1,1);
INSERT INTO kk_tag_group_to_tag (tag_group_id, tag_id)  VALUES (1,2);
INSERT INTO kk_tag_group_to_tag (tag_group_id, tag_id)  VALUES (1,3);
INSERT INTO kk_tag_group_to_tag (tag_group_id, tag_id)  VALUES (1,4);
INSERT INTO kk_tag_group_to_tag (tag_group_id, tag_id)  VALUES (1,5);
INSERT INTO kk_tag_group_to_tag (tag_group_id, tag_id)  VALUES (2,6);
INSERT INTO kk_tag_group_to_tag (tag_group_id, tag_id)  VALUES (2,7);

-- Add tag group to category
DELETE FROM kk_category_to_tag_group;
INSERT INTO kk_category_to_tag_group (categories_id,tag_group_id)  VALUES (10,1);
INSERT INTO kk_category_to_tag_group (categories_id,tag_group_id)  VALUES (10,2);

-- Add tags to products
DELETE FROM kk_tag_to_product;
INSERT INTO kk_tag_to_product (tag_id, products_id, date_added)  VALUES (1,4,sysdate);
INSERT INTO kk_tag_to_product (tag_id, products_id, date_added)  VALUES (1,6,sysdate);
INSERT INTO kk_tag_to_product (tag_id, products_id, date_added)  VALUES (2,9,sysdate);
INSERT INTO kk_tag_to_product (tag_id, products_id, date_added)  VALUES (2,10,sysdate);
INSERT INTO kk_tag_to_product (tag_id, products_id, date_added)  VALUES (3,11,sysdate);
INSERT INTO kk_tag_to_product (tag_id, products_id, date_added)  VALUES (3,12,sysdate);
INSERT INTO kk_tag_to_product (tag_id, products_id, date_added)  VALUES (4,13,sysdate);
INSERT INTO kk_tag_to_product (tag_id, products_id, date_added)  VALUES (4,17,sysdate);
INSERT INTO kk_tag_to_product (tag_id, products_id, date_added)  VALUES (5,18,sysdate);
INSERT INTO kk_tag_to_product (tag_id, products_id, date_added)  VALUES (6,4,sysdate);
INSERT INTO kk_tag_to_product (tag_id, products_id, date_added)  VALUES (6,6,sysdate);
INSERT INTO kk_tag_to_product (tag_id, products_id, date_added)  VALUES (6,9,sysdate);
INSERT INTO kk_tag_to_product (tag_id, products_id, date_added)  VALUES (6,10,sysdate);
INSERT INTO kk_tag_to_product (tag_id, products_id, date_added)  VALUES (7,11,sysdate);
INSERT INTO kk_tag_to_product (tag_id, products_id, date_added)  VALUES (7,12,sysdate);
INSERT INTO kk_tag_to_product (tag_id, products_id, date_added)  VALUES (7,13,sysdate);
INSERT INTO kk_tag_to_product (tag_id, products_id, date_added)  VALUES (7,17,sysdate);
INSERT INTO kk_tag_to_product (tag_id, products_id, date_added)  VALUES (7,18,sysdate);

-- Tag API calls
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'getTags','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'getTagGroups','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'insertTag','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'insertTags','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'insertGroup','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'insertGroups','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'updateTag','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'updateTagGroup','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'deleteTag','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'deleteTagGroup','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'getTagGroupsPerCategory','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'addTagGroupsToCategory','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'removeTagGroupsFromCategory','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'getTagsPerProduct','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'addTagsToProduct','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'removeTagsFromProduct','', sysdate);

-- Panels for maintaining Tags
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval,  'kk_panel_tagGroups','Maintain Tag Groups', sysdate);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval,  'kk_panel_tags','Maintain Tags', sysdate);

-- Allow super-user to maintain tags
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 65, 1,1,1,sysdate);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 66, 1,1,1,sysdate);

-- Allow catalog maintainer to maintain tags
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (2, 65, 1,1,1,sysdate);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (2, 66, 1,1,1,sysdate);

-- Save shipping and payment module information with the order
ALTER TABLE orders ADD shipping_module_code varchar(64);
ALTER TABLE orders ADD payment_module_code varchar(64);

-- Returns Panel Custom Command Definitions
DELETE FROM configuration WHERE configuration_key = 'ADMIN_APP_RETURNS_CUSTOM_LABEL';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (configuration_seq.nextval, 'Returns Custom Button Label', 'ADMIN_APP_RETURNS_CUSTOM_LABEL', '', 'When this is set, a custom button appears on the returns panels with this label', '21', '22', sysdate);
DELETE FROM configuration WHERE configuration_key = 'ADMIN_APP_RETURNS_CUSTOM_URL';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (configuration_seq.nextval, 'Returns Custom Button URL', 'ADMIN_APP_RETURNS_CUSTOM_URL', 'http://www.konakart.com', 'The URL that is launched when the Returns Custom button is clicked', '21', '23', sysdate);

-- Add the custom3 privilege to enable/disable custom option on the 'Returns' and 'Returns from Orders' panel
UPDATE kk_role_to_panel SET custom3=0, custom3_desc='If set custom returns button is disabled' WHERE panel_id=46;
UPDATE kk_role_to_panel SET custom3=0, custom3_desc='If set custom returns button is disabled' WHERE panel_id=47;

-- Panel for viewing customer from orders panel. Also allow super-user and order maintainer to have access
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval,  'kk_panel_customerForOrder','Customer For Order', sysdate);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 67, 1,1,1,sysdate);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (3, 67, 0,0,0,sysdate);

-- Add the custom privileges to the CustomerForOrder panel to make it the same as the Customer panel
UPDATE kk_role_to_panel SET custom1=0, custom1_desc='If set email is disabled' WHERE panel_id=67;
UPDATE kk_role_to_panel SET custom2=0, custom2_desc='If set cannot reset password' WHERE panel_id=67;
UPDATE kk_role_to_panel SET custom3=0, custom3_desc='If set customer search droplists are disabled' WHERE panel_id=67;

-- Custom Panels
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval,  'kk_panel_custom1','Custom1', sysdate);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval,  'kk_panel_custom2','Custom2', sysdate);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval,  'kk_panel_custom3','Custom3', sysdate);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval,  'kk_panel_custom4','Custom4', sysdate);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval,  'kk_panel_custom5','Custom5', sysdate);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval,  'kk_panel_custom6','Custom6', sysdate);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval,  'kk_panel_custom7','Custom7', sysdate);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval,  'kk_panel_custom8','Custom8', sysdate);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval,  'kk_panel_custom9','Custom9', sysdate);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval,  'kk_panel_custom10','Custom10', sysdate);

-- Add the custom panels to super admin role
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 68, 1,1,1,sysdate);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 69, 1,1,1,sysdate);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 70, 1,1,1,sysdate);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 71, 1,1,1,sysdate);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 72, 1,1,1,sysdate);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 73, 1,1,1,sysdate);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 74, 1,1,1,sysdate);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 75, 1,1,1,sysdate);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 76, 1,1,1,sysdate);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 77, 1,1,1,sysdate);

-- Custom Panel URLs
DELETE FROM configuration WHERE configuration_key = 'ADMIN_APP_CUSTOM_PANEL1_URL';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (configuration_seq.nextval, 'URL for Custom1 panel', 'ADMIN_APP_CUSTOM_PANEL1_URL', 'http://www.konakart.com/?', 'The URL for Custom1 panel', '22', '0', sysdate);
DELETE FROM configuration WHERE configuration_key = 'ADMIN_APP_CUSTOM_PANEL2_URL';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (configuration_seq.nextval, 'URL for Custom2 panel', 'ADMIN_APP_CUSTOM_PANEL2_URL', 'http://www.konakart.com/?', 'The URL for Custom2 panel', '22', '1', sysdate);
DELETE FROM configuration WHERE configuration_key = 'ADMIN_APP_CUSTOM_PANEL3_URL';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (configuration_seq.nextval, 'URL for Custom3 panel', 'ADMIN_APP_CUSTOM_PANEL3_URL', 'http://www.konakart.com/?', 'The URL for Custom3 panel', '22', '2', sysdate);
DELETE FROM configuration WHERE configuration_key = 'ADMIN_APP_CUSTOM_PANEL4_URL';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (configuration_seq.nextval, 'URL for Custom4 panel', 'ADMIN_APP_CUSTOM_PANEL4_URL', 'http://www.konakart.com/?', 'The URL for Custom4 panel', '22', '3', sysdate);
DELETE FROM configuration WHERE configuration_key = 'ADMIN_APP_CUSTOM_PANEL5_URL';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (configuration_seq.nextval, 'URL for Custom5 panel', 'ADMIN_APP_CUSTOM_PANEL5_URL', 'http://www.konakart.com/?', 'The URL for Custom5 panel', '22', '4', sysdate);
DELETE FROM configuration WHERE configuration_key = 'ADMIN_APP_CUSTOM_PANEL6_URL';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (configuration_seq.nextval, 'URL for Custom6 panel', 'ADMIN_APP_CUSTOM_PANEL6_URL', 'http://www.konakart.com/?', 'The URL for Custom6 panel', '22', '5', sysdate);
DELETE FROM configuration WHERE configuration_key = 'ADMIN_APP_CUSTOM_PANEL7_URL';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (configuration_seq.nextval, 'URL for Custom7 panel', 'ADMIN_APP_CUSTOM_PANEL7_URL', 'http://www.konakart.com/?', 'The URL for Custom7 panel', '22', '6', sysdate);
DELETE FROM configuration WHERE configuration_key = 'ADMIN_APP_CUSTOM_PANEL8_URL';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (configuration_seq.nextval, 'URL for Custom8 panel', 'ADMIN_APP_CUSTOM_PANEL8_URL', 'http://www.konakart.com/?', 'The URL for Custom8 panel', '22', '7', sysdate);
DELETE FROM configuration WHERE configuration_key = 'ADMIN_APP_CUSTOM_PANEL9_URL';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (configuration_seq.nextval, 'URL for Custom9 panel', 'ADMIN_APP_CUSTOM_PANEL9_URL', 'http://www.konakart.com/?', 'The URL for Custom9 panel', '22', '8', sysdate);
DELETE FROM configuration WHERE configuration_key = 'ADMIN_APP_CUSTOM_PANEL10_URL';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (configuration_seq.nextval, 'URL for Custom10 panel', 'ADMIN_APP_CUSTOM_PANEL10_URL', 'http://www.konakart.com/?', 'The URL for Custom10 panel', '22', '9', sysdate);

-- Panel for configuring custom panels
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval,  'kk_panel_customConfig','Configure Custom Panels', sysdate);

-- Add configure custom panel to super admin role
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 78, 1,1,1,sysdate);

-- v3.0.1.0 -------------------------------------------------------------------------------------------------------

-- New API calls
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'updateCachedConfigurations','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'getKonakartPropertyValue','', sysdate);

-- Update the REPORTS_STATUS_PAGE_URL (adding the storeId parameter)
UPDATE configuration SET configuration_value = 'http://localhost:8780/birtviewer/run?__report=reports/OrdersInLast30DaysChart.rptdesign' WHERE configuration_key = 'REPORTS_STATUS_PAGE_URL';

-- Update the reports values after moving birt-viewer to birtviewer
UPDATE configuration SET configuration_value = 'C:/Program Files/KonaKart/webapps/birtviewer/reports/' WHERE configuration_key = 'REPORTS_DEFN_PATH';
UPDATE configuration SET configuration_value = 'http://localhost:8780/birtviewer/frameset?__report=reports/' WHERE configuration_key = 'REPORTS_URL';

-- Run Initial Search on Customer Panel
DELETE FROM configuration WHERE configuration_key = 'CUST_PANEL_RUN_INITIAL_SEARCH';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (configuration_seq.nextval, 'Run Initial Customer Search', 'CUST_PANEL_RUN_INITIAL_SEARCH', 'true', 'Set to true to always run the initial Customer Search', '21', '12', 'choice(''true''=''true'',''false''=''false'')', sysdate);

-- Clear button clears results on Customer Panel
DELETE FROM configuration WHERE configuration_key = 'CUST_PANEL_CLEAR_REMOVES_RESULTS';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (configuration_seq.nextval, 'Clear button on Customer Panel removes results', 'CUST_PANEL_CLEAR_REMOVES_RESULTS', 'false', 'Set to true to clear both the search criteria AND the results when the clear button is clicked', '21', '13', 'choice(''true''=''true'',''false''=''false'')', sysdate);

-- For Oracle Only - Increase size of Auditing column
ALTER TABLE kk_audit ADD tempcol CLOB;
UPDATE kk_audit SET tempcol = object_to_string;
ALTER TABLE kk_audit DROP COLUMN object_to_string;
ALTER TABLE kk_audit RENAME COLUMN tempcol to object_to_string;


-- Add the ENABLE_ANALYTICS config variable
DELETE FROM configuration WHERE configuration_key = 'ENABLE_ANALYTICS';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (configuration_seq.nextval, 'Enable Analytics', 'ENABLE_ANALYTICS', 'false', 'Enable analytics to have the analytics.code (in your Messages.properties file) inserted into the JSPs', '20', '3', 'choice(''true''=''true'',''false''=''false'')', sysdate);

-- Google Data Feed
BEGIN EXECUTE IMMEDIATE 'DROP TABLE kk_product_feed'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
--CREATE TABLE kk_product_feed (
--  product_id int NOT NULL,
--  language_id int NOT NULL,
--  feed_type int NOT NULL,
--  feed_key varchar(255) NOT NULL,
--  last_updated datetime NOT NULL,
--  PRIMARY KEY  (product_id, language_id, feed_type)
--);

-- Google Data Feed - Google Username config variable
DELETE FROM configuration WHERE configuration_key = 'GOOGLE_DATA_ENABLED';
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Google Data Enabled', 'GOOGLE_DATA_ENABLED', '', 'Set to true to enable Google Data updates when products are amended in KonaKart', '23', '1', 'choice(\'true\'=\'true\',\'false\'=\'false\')', now());
DELETE FROM configuration WHERE configuration_key = 'GOOGLE_API_KEY';
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Google API Key', 'GOOGLE_API_KEY', '', 'Google API Key (obtain from Google) for populating Google Data with Product Information', '23', '2', now());
DELETE FROM configuration WHERE configuration_key = 'GOOGLE_DATA_USERNAME';
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Google Data Username', 'GOOGLE_DATA_USERNAME', '', 'Username (obtain from Google) for populating Google Data with Product Information', '23', '3', now());
DELETE FROM configuration WHERE configuration_key = 'GOOGLE_DATA_PASSWORD';
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Google Data Password', 'GOOGLE_DATA_PASSWORD', '', 'Password (obtain from Google) for populating Google Data with Product Information', '23', '4', 'password', now());
DELETE FROM configuration WHERE configuration_key = 'GOOGLE_DATA_LOCATION';
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Store Location', 'GOOGLE_DATA_LOCATION', 'Lake Buena Vista, FL 32830, USA', 'Store location (address) to be published to Google Data', '23', '5', now());

-- Panel for configuring Data Feeds
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval,  'kk_panel_dataFeeds','Configure Data Feeds', sysdate);

-- Add configure Data Feeds to super admin role
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 79, 1,1,1,sysdate);

-- Panel for Publishing Products
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval,  'kk_panel_publishProducts','Publish Products', sysdate);

-- Add Publish Products panel to super admin role
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 80, 1,1,1,sysdate);

-- publishProducts API call
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'publishProducts','', sysdate);

-- Solr
DELETE FROM configuration WHERE configuration_key = 'USE_SOLR_SEARCH';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (configuration_seq.nextval, 'Use Solr Search Server','USE_SOLR_SEARCH','false','Use Solr search server to search for products','24', '1', 'choice(''true''=''true'',''false''=''false'')', sysdate);
DELETE FROM configuration WHERE configuration_key = 'SOLR_URL';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (configuration_seq.nextval, 'Base URL of Solr Search Server','SOLR_URL','http://localhost:8983/solr/konakart','Base URL of Solr Search Server','24', '2', sysdate);

-- New Solr API calls
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'addAllProductsToSearchEngine','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'addProductToSearchEngine','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'removeAllProductsFromSearchEngine','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'removeProductFromSearchEngine','', sysdate);

-- Configuration variable for enabling/disabling storage of credit card details
DELETE FROM configuration WHERE configuration_key = 'STORE_CC_DETAILS';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (configuration_seq.nextval, 'Store Credit Card Details', 'STORE_CC_DETAILS', 'false', 'Store credit card details', 9, 4, 'choice(''true''=''true'',''false''=''false'')', sysdate);

-- Save encrypted Credit Card details
ALTER TABLE orders ADD cc_cvv varchar(10);
ALTER TABLE orders ADD e1 varchar(100);
ALTER TABLE orders ADD e2 varchar(100);
ALTER TABLE orders ADD e3 varchar(100);
ALTER TABLE orders ADD e4 varchar(100);
ALTER TABLE orders ADD e5 varchar(100);
ALTER TABLE orders ADD e6 varchar(100);

-- Add the custom1 privilege to enable/disable the reading and editing of credit card details on the Edit Order Panel
UPDATE kk_role_to_panel SET custom1=0, custom1_desc='Set to allow read and edit of credit card details' WHERE panel_id=17;

-- Panel for Configuring Solr
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval,  'kk_panel_solr_search','Solr Search Engine Configuration', sysdate);

-- Add Configure Solr panel to super admin role
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 81, 1,1,1,sysdate);

-- Panel for Controling products in Solr
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval,  'kk_panel_solr_control','Solr Search Engine Control', sysdate);

-- Add Control Solr panel to super admin role
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 82, 1,1,1,sysdate);

-- KonaKart Application Base URL
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (configuration_seq.nextval, 'Store Base URL', 'KK_BASE_URL', 'http://localhost:8780/konakart/', 'KonaKart Base URL', '1', '25', sysdate);

-- v3.2.0.0 -------------------------------------------------------------------------------------------------------

-- API call for inserting a configuration group
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'insertConfigurationGroup','', sysdate);

-- Column for storing store_id on all tables
ALTER TABLE address_book ADD store_id varchar(64);
CREATE INDEX i_store_id_address_book ON address_book (store_id);

ALTER TABLE address_format ADD store_id varchar(64);
CREATE INDEX i_store_id_address_format ON address_format (store_id);

ALTER TABLE banners ADD store_id varchar(64);
CREATE INDEX i_store_id_banners ON banners (store_id);

ALTER TABLE banners_history ADD store_id varchar(64);
CREATE INDEX i_store_id_banners_history ON banners_history (store_id);

ALTER TABLE categories ADD store_id varchar(64);
CREATE INDEX i_store_id_categories ON categories (store_id);

ALTER TABLE categories_description ADD store_id varchar(64);
CREATE INDEX i_st_categories_description ON categories_description (store_id);

ALTER TABLE configuration ADD store_id varchar(64);
CREATE INDEX i_store_id_configuration ON configuration (store_id);

ALTER TABLE configuration_group ADD store_id varchar(64);
CREATE INDEX i_store_id_configuration_group ON configuration_group (store_id);

ALTER TABLE counter ADD store_id varchar(64);
CREATE INDEX i_store_id_counter ON counter (store_id);

ALTER TABLE counter_history ADD store_id varchar(64);
CREATE INDEX i_store_id_counter_history ON counter_history (store_id);

ALTER TABLE countries ADD store_id varchar(64);
CREATE INDEX i_store_id_countries ON countries (store_id);

ALTER TABLE coupon ADD store_id varchar(64);
CREATE INDEX i_store_id_coupon ON coupon (store_id);

ALTER TABLE currencies ADD store_id varchar(64);
CREATE INDEX i_store_id_currencies ON currencies (store_id);

ALTER TABLE customers ADD store_id varchar(64);
CREATE INDEX i_store_id_customers ON customers (store_id);

ALTER TABLE customers_basket ADD store_id varchar(64);
CREATE INDEX i_store_id_customers_basket ON customers_basket (store_id);

ALTER TABLE customers_basket_attrs ADD store_id varchar(64);
CREATE INDEX i_st_customers_basket_attrs ON customers_basket_attrs (store_id);

ALTER TABLE customers_info ADD store_id varchar(64);
CREATE INDEX i_store_id_customers_info ON customers_info (store_id);

ALTER TABLE geo_zones ADD store_id varchar(64);
CREATE INDEX i_store_id_geo_zones ON geo_zones (store_id);

ALTER TABLE ipn_history ADD store_id varchar(64);
CREATE INDEX i_store_id_ipn_history ON ipn_history (store_id);

ALTER TABLE kk_audit ADD store_id varchar(64);
CREATE INDEX i_store_id_kk_audit ON kk_audit (store_id);

ALTER TABLE kk_category_to_tag_group ADD store_id varchar(64);
CREATE INDEX i_st_kk_category_to_tag_group ON kk_category_to_tag_group (store_id);

ALTER TABLE kk_customer_group ADD store_id varchar(64);
CREATE INDEX i_store_id_kk_customer_group ON kk_customer_group (store_id);

ALTER TABLE kk_digital_download ADD store_id varchar(64);
CREATE INDEX i_store_id_kk_digital_download ON kk_digital_download (store_id);

--ALTER TABLE kk_product_feed ADD COLUMN store_id varchar(64);
--ALTER TABLE kk_product_feed ADD KEY idx_store_id (store_id);

ALTER TABLE kk_role_to_api_call ADD store_id varchar(64);
CREATE INDEX i_store_id_kk_role_to_api_call ON kk_role_to_api_call (store_id);

ALTER TABLE kk_role_to_panel ADD store_id varchar(64);
CREATE INDEX i_store_id_kk_role_to_panel ON kk_role_to_panel (store_id);

ALTER TABLE kk_tag ADD store_id varchar(64);
CREATE INDEX i_store_id_kk_tag ON kk_tag (store_id);

ALTER TABLE kk_tag_group ADD store_id varchar(64);
CREATE INDEX i_store_id_kk_tag_group ON kk_tag_group (store_id);

ALTER TABLE kk_tag_group_to_tag ADD store_id varchar(64);
CREATE INDEX i_store_id_kk_tag_group_to_tag ON kk_tag_group_to_tag (store_id);

ALTER TABLE kk_tag_to_product ADD store_id varchar(64);
CREATE INDEX i_store_id_kk_tag_to_product ON kk_tag_to_product (store_id);

ALTER TABLE languages ADD store_id varchar(64);
CREATE INDEX i_store_id_languages ON languages (store_id);

ALTER TABLE manufacturers ADD store_id varchar(64);
CREATE INDEX i_store_id_manufacturers ON manufacturers (store_id);

ALTER TABLE manufacturers_info ADD store_id varchar(64);
CREATE INDEX i_store_id_manufacturers_info ON manufacturers_info (store_id);

ALTER TABLE newsletters ADD store_id varchar(64);
CREATE INDEX i_store_id_newsletters ON newsletters (store_id);

ALTER TABLE orders ADD store_id varchar(64);
CREATE INDEX i_store_id_orders ON orders (store_id);

ALTER TABLE orders_products ADD store_id varchar(64);
CREATE INDEX i_store_id_orders_products ON orders_products (store_id);

ALTER TABLE orders_products_attributes ADD store_id varchar(64);
CREATE INDEX i_st_orders_products_attribute ON orders_products_attributes (store_id);

ALTER TABLE orders_products_download ADD store_id varchar(64);
CREATE INDEX i_st_orders_products_download ON orders_products_download (store_id);

ALTER TABLE orders_returns ADD store_id varchar(64);
CREATE INDEX i_store_id_orders_returns ON orders_returns (store_id);

ALTER TABLE orders_status ADD store_id varchar(64);
CREATE INDEX i_store_id_orders_status ON orders_status (store_id);

ALTER TABLE orders_status_history ADD store_id varchar(64);
CREATE INDEX i_st_orders_status_history ON orders_status_history (store_id);

ALTER TABLE orders_total ADD store_id varchar(64);
CREATE INDEX i_store_id_orders_total ON orders_total (store_id);

ALTER TABLE products ADD store_id varchar(64);
CREATE INDEX i_store_id_products ON products (store_id);

ALTER TABLE products_attributes ADD store_id varchar(64);
CREATE INDEX i_store_id_products_attributes ON products_attributes (store_id);

ALTER TABLE products_attrs_download ADD store_id varchar(64);
CREATE INDEX i_st_products_attrs_download ON products_attrs_download (store_id);

ALTER TABLE products_description ADD store_id varchar(64);
CREATE INDEX i_st_products_description ON products_description (store_id);

ALTER TABLE products_notifications ADD store_id varchar(64);
CREATE INDEX i_st_products_notifications ON products_notifications (store_id);

ALTER TABLE products_options ADD store_id varchar(64);
CREATE INDEX i_store_id_products_options ON products_options (store_id);

ALTER TABLE products_options_values ADD store_id varchar(64);
CREATE INDEX i_st_products_options_values ON products_options_values (store_id);

ALTER TABLE prod_opt_vals_to_prod_opt ADD store_id varchar(64);
CREATE INDEX i_st_prod_opt_vals_to_prod_opt ON prod_opt_vals_to_prod_opt (store_id);

ALTER TABLE products_quantity ADD store_id varchar(64);
CREATE INDEX i_store_id_products_quantity ON products_quantity (store_id);

ALTER TABLE products_to_categories ADD store_id varchar(64);
CREATE INDEX i_st_products_to_categories ON products_to_categories (store_id);

ALTER TABLE products_to_products ADD store_id varchar(64);
CREATE INDEX i_st_products_to_products ON products_to_products (store_id);

ALTER TABLE promotion ADD store_id varchar(64);
CREATE INDEX i_store_id_promotion ON promotion (store_id);

ALTER TABLE promotion_to_category ADD store_id varchar(64);
CREATE INDEX i_st_promotion_to_category ON promotion_to_category (store_id);

ALTER TABLE promotion_to_coupon ADD store_id varchar(64);
CREATE INDEX i_store_id_promotion_to_coupon ON promotion_to_coupon (store_id);

ALTER TABLE promotion_to_cust_group ADD store_id varchar(64);
CREATE INDEX i_st_promotion_to_cust_group ON promotion_to_cust_group (store_id);

ALTER TABLE promotion_to_customer ADD store_id varchar(64);
CREATE INDEX i_st_promotion_to_customer ON promotion_to_customer (store_id);

ALTER TABLE promotion_to_manufacturer ADD store_id varchar(64);
CREATE INDEX i_st_promotion_to_manufacturer ON promotion_to_manufacturer (store_id);

ALTER TABLE promotion_to_product ADD store_id varchar(64);
CREATE INDEX i_st_promotion_to_product ON promotion_to_product (store_id);

ALTER TABLE returns_to_ord_prods ADD store_id varchar(64);
CREATE INDEX i_st_returns_to_ord_prods ON returns_to_ord_prods (store_id);

ALTER TABLE reviews ADD store_id varchar(64);
CREATE INDEX i_store_id_reviews ON reviews (store_id);

ALTER TABLE reviews_description ADD store_id varchar(64);
CREATE INDEX i_store_id_reviews_description ON reviews_description (store_id);

ALTER TABLE sessions ADD store_id varchar(64);
CREATE INDEX i_store_id_sessions ON sessions (store_id);

ALTER TABLE specials ADD store_id varchar(64);
CREATE INDEX i_store_id_specials ON specials (store_id);

ALTER TABLE tax_class ADD store_id varchar(64);
CREATE INDEX i_store_id_tax_class ON tax_class (store_id);

ALTER TABLE tax_rates ADD store_id varchar(64);
CREATE INDEX i_store_id_tax_rates ON tax_rates (store_id);

--ALTER TABLE utility ADD COLUMN store_id varchar(64);
--ALTER TABLE utility ADD KEY idx_store_id (store_id);

ALTER TABLE whos_online ADD store_id varchar(64);
CREATE INDEX i_store_id_whos_online ON whos_online (store_id);

ALTER TABLE zones ADD store_id varchar(64);
CREATE INDEX i_store_id_zones ON zones (store_id);

ALTER TABLE zones_to_geo_zones ADD store_id varchar(64);
CREATE INDEX i_store_id_zones_to_geo_zones ON zones_to_geo_zones (store_id);

-- kk_store table for holding store instance information for multi-store
BEGIN EXECUTE IMMEDIATE 'DROP TABLE kk_store'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE kk_store (
  store_id VARCHAR2(64) NOT NULL,
  store_name VARCHAR2(64) NOT NULL,
  store_desc VARCHAR2(128) NOT NULL,
  store_enabled NUMBER(10,0) NOT NULL,
  store_under_maint NUMBER(10,0) NOT NULL,
  store_deleted NUMBER(10,0) NOT NULL,
  store_template NUMBER(10,0) NOT NULL,
  store_admin_email VARCHAR2(96),
  store_css_filename VARCHAR2(128),
  store_logo_filename VARCHAR2(128),
  store_url VARCHAR2(128),
  store_home VARCHAR2(64),
  store_max_products NUMBER(10,0) DEFAULT -1 NOT NULL,
  custom1 VARCHAR2(128),
  custom2 VARCHAR2(128),
  custom3 VARCHAR2(128),
  custom4 VARCHAR2(128),
  custom5 VARCHAR2(128),
  date_added TIMESTAMP,
  last_updated TIMESTAMP,
  PRIMARY KEY(store_id)
);

INSERT INTO kk_store (store_id, store_name, store_desc, store_enabled, store_under_maint, store_deleted, store_template, store_admin_email, store_logo_filename, store_css_filename, store_home, date_added) VALUES ('store1','store1','Store Number One', 1,0,0,0, 'admin@konakart.com', 'logo.png', 'style.css', 'derby', sysdate);

-- MultiStore Template StoreId
DELETE FROM configuration WHERE configuration_key = 'MULTISTORE_TEMPLATE_STORE';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (configuration_seq.nextval, 'Multi-Store Template Store', 'MULTISTORE_TEMPLATE_STORE', 'store1', 'This is the storeId of the template store used when creating new stores in a multi-store installation', '25', '5', sysdate);

-- MultiStore Admin Role
DELETE FROM configuration WHERE configuration_key = 'MULTISTORE_ADMIN_ROLE_IDX';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (configuration_seq.nextval, 'Multi-Store Admin Role', 'MULTISTORE_ADMIN_ROLE_IDX', '5', 'Defines the Role given to Admin users of new stores', '25', '6', 'Roles', sysdate);

-- MultiStore Super User Role
DELETE FROM configuration WHERE configuration_key = 'MULTISTORE_SUPER_USER_ROLE_IDX';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (configuration_seq.nextval, 'Multi-Store Super User Role', 'MULTISTORE_SUPER_USER_ROLE_IDX', '1', 'Defines the Role given to Super User user of new stores', '25', '6', 'Roles', sysdate);

-- Filenames for new store sql
DELETE FROM configuration WHERE configuration_key = 'KK_NEW_STORE_SQL_FILENAME';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (configuration_seq.nextval, 'KonaKart new store creation SQL','KK_NEW_STORE_SQL_FILENAME','C:/Program Files/KonaKart/database/MySQL/konakart_new_store.sql','Filename containing the KonaKart new store creation SQL commands','25', '10', sysdate);
DELETE FROM configuration WHERE configuration_key = 'USER_NEW_STORE_SQL_FILENAME';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (configuration_seq.nextval, 'User new store creation SQL','USER_NEW_STORE_SQL_FILENAME','C:/Program Files/KonaKart/database/MySQL/konakart_user_new_store.sql','Filename containing the user defined new store creation SQL commands - these are executed after the KonaKart cloning commands','25', '11', sysdate);

-- Table for wish list
BEGIN EXECUTE IMMEDIATE 'DROP TABLE kk_wishlist'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE kk_wishlist (
  kk_wishlist_id NUMBER(10,0) NOT NULL,
  store_id VARCHAR2(64),
  customers_id NUMBER(10,0) NOT NULL,
  name VARCHAR2(128),
  description VARCHAR2(255),
  public_or_private NUMBER(10,0) NOT NULL,
  date_added TIMESTAMP NOT NULL,
  customers_firstname VARCHAR2(32),
  customers_lastname VARCHAR2(32),
  customers_dob TIMESTAMP,
  customers_city VARCHAR2(32),
  customers_state VARCHAR2(32),
  custom1 VARCHAR2(128),
  custom2 VARCHAR2(128),
  custom3 VARCHAR2(128),
  custom4 VARCHAR2(128),
  custom5 VARCHAR2(128),
  PRIMARY KEY(kk_wishlist_id)
);
BEGIN EXECUTE IMMEDIATE 'DROP SEQUENCE kk_wishlist_SEQ'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE SEQUENCE kk_wishlist_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

-- Table for wish list items
BEGIN EXECUTE IMMEDIATE 'DROP TABLE kk_wishlist_item'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE kk_wishlist_item (
  kk_wishlist_item_id NUMBER(10,0) NOT NULL,
  store_id VARCHAR2(64),
  kk_wishlist_id NUMBER(10,0) NOT NULL,
  products_id VARCHAR2(255) NOT NULL,
  priority int,
  date_added TIMESTAMP NOT NULL,
  custom1 VARCHAR2(128),
  custom2 VARCHAR2(128),
  custom3 VARCHAR2(128),
  custom4 VARCHAR2(128),
  custom5 VARCHAR2(128),
  PRIMARY KEY(kk_wishlist_item_id)
);
BEGIN EXECUTE IMMEDIATE 'DROP SEQUENCE kk_wishlist_item_SEQ'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE SEQUENCE kk_wishlist_item_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

-- Enable / Disable wish list functionality from application
DELETE FROM configuration WHERE configuration_key = 'ENABLE_WISHLIST';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (configuration_seq.nextval, 'Enable Wish List functionality', 'ENABLE_WISHLIST', 'false', 'When set to true, wish list functionality is enabled in the application', '1', '24', 'choice(''true''=''true'',''false''=''false'')', sysdate);

-- Add column to orders table for order number
ALTER TABLE orders ADD orders_number varchar(128);

-- Orders Panel Show Order Number or Order Id
DELETE FROM configuration WHERE configuration_key = 'ADMIN_APP_ORDERS_DISPLAY_ORDER_NUM';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (configuration_seq.nextval, 'Display Order Number', 'ADMIN_APP_ORDERS_DISPLAY_ORDER_NUM', '', 'When this is set, the order number is displayed in the orders panel rather than the order id', '21', '24', 'choice(''true''=''true'',''false''=''false'')', sysdate);

-- Enable all customers
UPDATE customers SET customers_enabled = 1;

-- Panels for Managing Stores in a Multi-Store Environment
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval,  'kk_panel_stores','Manage Multiple Stores', sysdate);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval,  'kk_panel_editStore','Edit a Store in a Mall', sysdate);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval,  'kk_panel_insertStore','Insert a Store in a Mall', sysdate);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval,  'kk_panel_multistoreConfig','Multi-Store Configuration', sysdate);

-- Add MultiStore Management Panels to super admin role
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, custom1, custom1_desc, date_added) VALUES (1, 83, 1,1,1,1, 'Set to allow admin of all stores', sysdate);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 84, 1,1,1,sysdate);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 85, 1,1,1,sysdate);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 86, 1,1,1,sysdate);

-- API calls for Multi-Store Store Maintenance
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'getMallStores','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'insertMallStore','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'deleteMallStore','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'updateMallStore','', sysdate);

-- Add language code to products_description
ALTER TABLE products_description ADD language_code char(2);

UPDATE products_description SET language_code = 'en' WHERE language_id = 1;
UPDATE products_description SET language_code = 'de' WHERE language_id = 2;
UPDATE products_description SET language_code = 'es' WHERE language_id = 3;

-- Admin Store Integration Class
DELETE FROM configuration WHERE configuration_key = 'ADMIN_STORE_INTEGRATION_CLASS';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (configuration_seq.nextval, 'Admin Store Integration Class', 'ADMIN_STORE_INTEGRATION_CLASS','com.konakartadmin.bl.AdminStoreIntegrationMgr','The Store Integration Implementation Class, to allow custom store maintenance function', '25', '7', sysdate);

-- Add super_user and 5 custom fields to kk_role
ALTER TABLE kk_role ADD super_user NUMBER(10,0);
ALTER TABLE kk_role ADD custom1 varchar(128);
ALTER TABLE kk_role ADD custom2 varchar(128);
ALTER TABLE kk_role ADD custom3 varchar(128);
ALTER TABLE kk_role ADD custom4 varchar(128);
ALTER TABLE kk_role ADD custom5 varchar(128);
UPDATE kk_role SET super_user = 1 WHERE name = 'Super User';

-- Copy all the Super User role (role 1) permissions over to the Store Administrator role (role 5)
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, custom1, custom1_desc, custom2, custom2_desc, custom3, custom3_desc, date_added) select 5, panel_id, can_edit, can_insert, can_delete, custom1, custom1_desc, custom2, custom2_desc, custom3, custom3_desc, sysdate from kk_role_to_panel WHERE role_id = 1;

-- Take off the permissions that the Store Administrator role should not have
DELETE FROM kk_role_to_panel WHERE role_id = 5 and panel_id = 1;
DELETE FROM kk_role_to_panel WHERE role_id = 5 and panel_id = 6;
DELETE FROM kk_role_to_panel WHERE role_id = 5 and panel_id = 8;
DELETE FROM kk_role_to_panel WHERE role_id = 5 and panel_id = 11;
DELETE FROM kk_role_to_panel WHERE role_id = 5 and panel_id = 20;
DELETE FROM kk_role_to_panel WHERE role_id = 5 and panel_id = 21;
DELETE FROM kk_role_to_panel WHERE role_id = 5 and panel_id = 26;
DELETE FROM kk_role_to_panel WHERE role_id = 5 and panel_id = 28;
DELETE FROM kk_role_to_panel WHERE role_id = 5 and panel_id = 32;
DELETE FROM kk_role_to_panel WHERE role_id = 5 and panel_id = 54;
DELETE FROM kk_role_to_panel WHERE role_id = 5 and panel_id = 55;
DELETE FROM kk_role_to_panel WHERE role_id = 5 and panel_id = 56;
DELETE FROM kk_role_to_panel WHERE role_id = 5 and panel_id = 57;
DELETE FROM kk_role_to_panel WHERE role_id = 5 and panel_id = 58;
DELETE FROM kk_role_to_panel WHERE role_id = 5 and panel_id = 59;
DELETE FROM kk_role_to_panel WHERE role_id = 5 and panel_id = 60;
DELETE FROM kk_role_to_panel WHERE role_id = 5 and panel_id = 63;
DELETE FROM kk_role_to_panel WHERE role_id = 5 and panel_id = 85;
DELETE FROM kk_role_to_panel WHERE role_id = 5 and panel_id = 86;

-- Give Store Administrator Read-Only / special access to these:
UPDATE kk_role_to_panel SET can_insert = 0, can_delete = 0, custom1 = 0 WHERE role_id = 5 and panel_id = 83;
UPDATE kk_role_to_panel SET can_edit=0, can_insert=0, can_delete=0 WHERE role_id = 5 and panel_id = 12;
UPDATE kk_role_to_panel SET can_edit=0, can_insert=0, can_delete=0 WHERE role_id = 5 and panel_id = 14;

-- Reports re-located for MultiStore
UPDATE configuration SET configuration_value = 'C:/Program Files/KonaKart/webapps/birtviewer/reports/stores/store1/' WHERE configuration_key = 'REPORTS_DEFN_PATH';
UPDATE configuration SET configuration_value = 'http://localhost:8780/birtviewer/frameset?__report=reports/stores/store1/' WHERE configuration_key = 'REPORTS_URL';
UPDATE configuration SET configuration_value = 'http://localhost:8780/birtviewer/run?__report=reports/stores/store1/OrdersInLast25DaysChart.rptdesign' WHERE configuration_key = 'REPORTS_STATUS_PAGE_URL';

-- Add the custom1 privilege to enable/disable the reading and editing of custom fields and order number on the Edit Order Panel
UPDATE kk_role_to_panel SET custom2=0, custom2_desc='Set to allow read and edit of custom fields and order number' WHERE panel_id=17;

-- KonaKart Home Directory
DELETE FROM configuration WHERE configuration_key = 'INSTALLATION_HOME';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (configuration_seq.nextval, 'KonaKart Installation Home', 'INSTALLATION_HOME','C:/Program Files/KonaKart/','The home directory of this KonaKart Installation', '1', '26', sysdate);

-- Version 4.0.0.0 ---------------------------------------------------------------------

-- Add Custom fields for zones table
ALTER TABLE zones ADD custom1 varchar(128);
ALTER TABLE zones ADD custom2 varchar(128);
ALTER TABLE zones ADD custom3 varchar(128);

-- Configuration for product select panels in admin app
DELETE FROM configuration WHERE configuration_key = 'ADMIN_APP_PROD_SEL_TEMPLATE';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (configuration_seq.nextval, 'Product Select Template' , 'ADMIN_APP_PROD_SEL_TEMPLATE', '$name', 'Sets the template for which attributes to view when selecting a product ($name, $sku, $id, $model, $manufacturer, $custom1 ... $custom5', '21', '25', sysdate);
DELETE FROM configuration WHERE configuration_key = 'ADMIN_APP_PROD_SEL_NUM_PRODS';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (configuration_seq.nextval, 'Product Select Default Num Prods', 'ADMIN_APP_PROD_SEL_NUM_PRODS', '0', 'Sets the default number of products displayed in the product select dialogs when opened', '21', '26', sysdate);
DELETE FROM configuration WHERE configuration_key = 'ADMIN_APP_PROD_SEL_MAX_NUM_PRODS';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (configuration_seq.nextval, 'Product Select Max Num Prods', 'ADMIN_APP_PROD_SEL_MAX_NUM_PRODS', '100', 'Sets the maximum number of products displayed in the product select dialogs after a search', '21', '27', sysdate);

-- Add date available attribute to products quantity
ALTER TABLE products_quantity ADD products_date_available TIMESTAMP;

-- API calls for setting product quantity and product availability
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'setProductQuantity','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'setProductAvailability','', sysdate);

-- Extra attributes for product object
ALTER TABLE products ADD max_num_downloads int default -1 not null;
ALTER TABLE products ADD max_download_days int default -1 not null;
ALTER TABLE products ADD stock_reorder_level int default -1 not null;

-- Cookie table to save cookie information
BEGIN EXECUTE IMMEDIATE 'DROP TABLE kk_cookie'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE kk_cookie (
  customer_uuid VARCHAR2(128) NOT NULL,
  attribute_id VARCHAR2(64) NOT NULL,
  attribute_value VARCHAR2(256),
  date_added TIMESTAMP NOT NULL,
  last_read TIMESTAMP,
  last_modified TIMESTAMP,
  PRIMARY KEY(customer_uuid, attribute_id)
);

-- Add tracking number to orders table
ALTER TABLE orders ADD tracking_number varchar(128);

-- Update description of role to panel
UPDATE kk_role_to_panel SET custom2=0, custom2_desc='Set to allow read and edit of custom fields, order number, tracking number' WHERE panel_id=17;

-- Extra attribute for product object
ALTER TABLE products ADD can_order_when_not_in_stock int default -1 NOT NULL;

-- Add invisible attribute to categories table
ALTER TABLE categories ADD categories_invisible NUMBER(10,0) DEFAULT 0 NOT NULL;

-- API calls for getting product quantity and product availability
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'getProductQuantity','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'getProductAvailability','', sysdate);

-- Add a new panel for inserting product quantities
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval,  'kk_panel_productQuantity','Product Quantity', sysdate);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 87, 1,1,1,sysdate);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (2, 87, 1,1,1,sysdate);

-- API calls for XML import/export
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'insertTagGroupToTags','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'getTagGroupToTags','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'importCustomer','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'getProductNotificationsForCustomer','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'getProductOptionsPerName','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'getAllProductOptionValues','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'getProductOptionValuesPerName','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'insertProductsOptionsValuesToProductsOptions','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'getProductOptionValueToProductOptions','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'getAllConfigurations','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'getAllConfigurationGroups','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'updateConfiguration','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'updateConfigurationGroup','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'getConfigurationGroupsByTitle','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'getConfigurationByKey','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'insertConfiguration','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'insertConfigurationGroup','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'insertIpnHistory','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'importAudit','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'getCategoriesPerTagGroup','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'addCategoriesToTagGroups','', sysdate);



-- Add a new panel for inserting product available dates
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval,  'kk_panel_productAvailableDate','Product Available Date', sysdate);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 88, 1,1,1,sysdate);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (2, 88, 1,1,1,sysdate);

-- Extra attributes for order product and basket objects
ALTER TABLE orders_products ADD products_state int default '0';
ALTER TABLE orders_products ADD products_sku varchar(255);
ALTER TABLE customers_basket ADD products_sku varchar(255);

-- Add customer_id to sessions table - previously the customer_id was stored in the value column.  We also make value nullable.
-- For various reasons, mainly DB2 limitations, we drop the sessions table and recreate it
BEGIN EXECUTE IMMEDIATE 'DROP TABLE sessions'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE sessions (
  sesskey VARCHAR2(32) NOT NULL,
  expiry NUMBER(10,0) NOT NULL,
  customer_id NUMBER(10,0) NULL,
  value VARCHAR2(256) NULL,
  store_id VARCHAR2(64) NULL,
  custom1 VARCHAR2(128) NULL,
  custom2 VARCHAR2(128) NULL,
  custom3 VARCHAR2(128) NULL,
  custom4 VARCHAR2(128) NULL,
  custom5 VARCHAR2(128) NULL,
  PRIMARY KEY(sesskey)
);
CREATE INDEX i_store_id_sessions ON sessions (store_id);

-- Determine whether to show dialog to send mail after a group change
DELETE FROM configuration WHERE configuration_key = 'ADMIN_APP_ALLOW_GROUP_CHANGE_MAIL';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (configuration_seq.nextval, 'Allow Cust Group Change eMail', 'ADMIN_APP_ALLOW_GROUP_CHANGE_MAIL', 'true', 'When this is set, a popup window appears when the group of a customer is changed to allow you to send an eMail', '21', '28', 'choice(''true''=''true'',''false''=''false'')', sysdate);

-- Admin App session related API calls
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'addCustomDataToSession','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'getCustomDataFromSession','', sysdate);

-- New Batch jobs
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'com.konakartadmin.bl.AdminOrderBatchMgr.productAvailabilityNotificationBatch','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'com.konakartadmin.bl.AdminOrderBatchMgr.unpaidOrderNotificationBatch','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'com.konakartadmin.bl.AdminCustomerBatchMgr.removeExpiredCustomersBatch','', sysdate);

-- Version 4.1.0.0 ---------------------------------------------------------------------

-- Product to stores
BEGIN EXECUTE IMMEDIATE 'DROP TABLE kk_product_to_stores'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE kk_product_to_stores (
  store_id VARCHAR2(64) NOT NULL,
  products_id NUMBER(10,0) NOT NULL,
  price_id NUMBER(10,0) DEFAULT -1 NOT NULL,
  PRIMARY KEY(store_id ,products_id)
);

-- New Multi-Store Shared Products APIs
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'getProductsToStores','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'insertProductsToStores','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'removeProductsToStores','', sysdate);

-- New Categories to Tag Groups API
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'getCategoriesToTagGroups','', sysdate);

-- Modifications for gift registry support
ALTER TABLE customers_basket ADD kk_wishlist_id int;
ALTER TABLE orders_products ADD kk_wishlist_id int;
ALTER TABLE customers_basket ADD kk_wishlist_item_id int;
ALTER TABLE orders_products ADD kk_wishlist_item_id int;

ALTER TABLE kk_wishlist ADD customers1_firstname varchar(32);
ALTER TABLE kk_wishlist ADD customers1_lastname varchar(32);
ALTER TABLE kk_wishlist ADD link_url varchar(255);
ALTER TABLE kk_wishlist ADD list_type int;
ALTER TABLE kk_wishlist ADD address_id int;
ALTER TABLE kk_wishlist ADD event_date TIMESTAMP;

ALTER TABLE kk_wishlist_item ADD quantity_desired int;
ALTER TABLE kk_wishlist_item ADD quantity_bought int;
ALTER TABLE kk_wishlist_item ADD comments varchar(255);

-- Enable / Disable gift registry functionality from application
DELETE FROM configuration WHERE configuration_key = 'ENABLE_GIFT_REGISTRY';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (configuration_seq.nextval, 'Enable Gift Registry functionality', 'ENABLE_GIFT_REGISTRY', 'false', 'When set to true, gift registry functionality is enabled in the application', '1', '26', 'choice(''true''=''true'',''false''=''false'')', sysdate);

-- Maximum number of gift registries displayed in a search
DELETE FROM configuration WHERE configuration_key = 'MAX_DISPLAY_GIFT_REGISTRIES';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (configuration_seq.nextval, 'Gift Registry Search', 'MAX_DISPLAY_GIFT_REGISTRIES', '6', 'Maximum number of gift registries to display', '3', '24', 'integer(0,null)', sysdate);

-- New Insert Order API
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval,  'insertOrder','', sysdate);

-- Version 4.2.0.0 ---------------------------------------------------------------------

-- API call for forcing registration of admin users even if already registered - delete and re-insert (it may or may not be present)
DELETE FROM kk_role_to_api_call WHERE api_call_id in (select api_call_id from kk_api_call WHERE name='forceRegisterCustomer');
DELETE FROM kk_api_call WHERE name = 'forceRegisterCustomer';
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'forceRegisterCustomer','', sysdate);

-- Extra attribute for product object
ALTER TABLE products ADD index_attachment int default 0 not null;

-- Maximum number of gift registry items displayed
DELETE FROM configuration WHERE configuration_key = 'MAX_DISPLAY_GIFT_REGISTRY_ITEMS';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (configuration_seq.nextval, 'Gift Registry Items', 'MAX_DISPLAY_GIFT_REGISTRY_ITEMS', '20', 'Maximum number of gift registry items to display', '3', '25', 'integer(0,null)', sysdate);

-- WishList APIs for the Admin App... used by the XML_IO utility
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'getWishLists','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'insertWishList','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'deleteWishList','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'insertWishListItem','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'deleteWishListItem','', sysdate);

-- Tables for CustomerTags
BEGIN EXECUTE IMMEDIATE 'DROP TABLE kk_customer_tag'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE kk_customer_tag (
  kk_customer_tag_id NUMBER(10,0) NOT NULL,
  store_id VARCHAR2(64),
  name VARCHAR2(64) NOT NULL,
  description VARCHAR2(255) NOT NULL,
  validation VARCHAR2(128),
  tag_type integer DEFAULT 0 NOT NULL,
  max_ints integer DEFAULT 1,
  custom1 VARCHAR2(128),
  custom2 VARCHAR2(128),
  custom3 VARCHAR2(128),
  custom4 VARCHAR2(128),
  custom5 VARCHAR2(128),
  date_added TIMESTAMP NOT NULL,
  PRIMARY KEY(kk_customer_tag_id)
   );
CREATE INDEX idx_name_kk_customer_tag ON kk_customer_tag (name);
CREATE INDEX idx_store_id_kk_customer_tag ON kk_customer_tag (store_id);
BEGIN EXECUTE IMMEDIATE 'DROP SEQUENCE kk_customer_tag_SEQ'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE SEQUENCE kk_customer_tag_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

BEGIN EXECUTE IMMEDIATE 'DROP TABLE kk_customers_to_tag'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE kk_customers_to_tag (
  kk_customer_tag_id NUMBER(10,0) DEFAULT 0 NOT NULL,
  customers_id NUMBER(10,0) DEFAULT 0 NOT NULL,
  store_id VARCHAR2(64),
  name VARCHAR2(64) NOT NULL,
  tag_value VARCHAR2(255),
  date_added TIMESTAMP NOT NULL,
  PRIMARY KEY(kk_customer_tag_id, customers_id)
);
CREATE INDEX idx_name_kk_customers_to_tag ON kk_customers_to_tag (name);
CREATE INDEX idx_stor_kk_customers_to_tag ON kk_customers_to_tag (store_id);

-- AdminApp CustomerTag API calls
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'insertCustomerTag','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'getCustomerTag','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'deleteCustomerTag','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'updateCustomerTag','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'getCustomerTags','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'deleteCustomerTagForCustomer','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'getCustomerTagForCustomer','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'getCustomerTagForName','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'getCustomerTagsForCustomer','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'insertCustomerTagForCustomer','', sysdate);

-- Admin Engine Address API calls
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'getAddressById','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'getAddresses','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'insertAddress','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'updateAddress','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'deleteAddress','', sysdate);

-- Add a new panel for managing customer tags
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval,  'kk_panel_custTags','Customer Tags', sysdate);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 89, 1,1,1,sysdate);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (2, 89, 1,1,1,sysdate);

-- Email Integration Class
DELETE FROM configuration WHERE configuration_key = 'EMAIL_INTEGRATION_CLASS';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (configuration_seq.nextval, 'Email Integration Class', 'EMAIL_INTEGRATION_CLASS', 'com.konakart.bl.EmailIntegrationMgr', 'The Email Integration Implementation Class to enable you to change the toAddress of the mail', '12', '16', sysdate);

-- Tables for Expressions
BEGIN EXECUTE IMMEDIATE 'DROP TABLE kk_expression'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE kk_expression (
  kk_expression_id NUMBER(10,0) NOT NULL,
  store_id VARCHAR2(64),
  name VARCHAR2(64) NOT NULL,
  description VARCHAR2(255),
  num_variables integer DEFAULT 0 NOT NULL,
  custom1 VARCHAR2(128),
  custom2 VARCHAR2(128),
  custom3 VARCHAR2(128),
  date_added TIMESTAMP NOT NULL,
  PRIMARY KEY(kk_expression_id)
   );
CREATE INDEX idx_name_kk_expression ON kk_expression (name);
CREATE INDEX idx_store_id_kk_expression ON kk_expression (store_id);
BEGIN EXECUTE IMMEDIATE 'DROP SEQUENCE kk_expression_SEQ'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE SEQUENCE kk_expression_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

BEGIN EXECUTE IMMEDIATE 'DROP TABLE kk_expression_variable'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE kk_expression_variable (
  kk_expression_variable_id NUMBER(10,0) NOT NULL,
  kk_customer_tag_id NUMBER(10,0) DEFAULT 0 NOT NULL,
  kk_expression_id NUMBER(10,0) DEFAULT 0 NOT NULL,
  store_id VARCHAR2(64),
  tag_type integer DEFAULT 0 NOT NULL,
  tag_value VARCHAR2(255) NOT NULL,
  operator integer DEFAULT 0 NOT NULL,
  tag_order integer DEFAULT 0 NOT NULL,
  tag_and_or integer DEFAULT 0 NOT NULL,
  group_order integer DEFAULT 0 NOT NULL,
  group_and_or integer DEFAULT 0 NOT NULL,
  date_added TIMESTAMP NOT NULL,
  PRIMARY KEY(kk_expression_variable_id)
   );
CREATE INDEX idx_exp_kk_express_to_tag ON kk_expression_variable (kk_expression_id);
CREATE INDEX idx_stor_kk_express_to_tag ON kk_expression_variable (store_id);
BEGIN EXECUTE IMMEDIATE 'DROP SEQUENCE kk_expression_variable_SEQ'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE SEQUENCE kk_expression_variable_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

-- AdminApp Expression API calls
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'insertExpression','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'updateExpression','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'deleteExpression','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'getExpression','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'getExpressions','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'getExpressionVariable','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'getExpressionVariablesForExpression','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'getExpressionForName','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'insertExpressionVariables','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'updateExpressionVariable','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'deleteExpressionVariable','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'deleteExpressionVariablesForExpression','', sysdate);

-- Add new panels for managing expressions
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval,  'kk_panel_expressions','Expressions', sysdate);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 90, 1,1,1,sysdate);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (2, 90, 1,1,1,sysdate);

INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval,  'kk_panel_variablesFromExp','Expression Variables', sysdate);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 91, 1,1,1,sysdate);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (2, 91, 1,1,1,sysdate);

-- Connect the promotion to expressions
BEGIN EXECUTE IMMEDIATE 'DROP TABLE kk_promotion_to_expression'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE kk_promotion_to_expression (
  promotion_id NUMBER(10,0) NOT NULL,
  kk_expression_id NUMBER(10,0) NOT NULL,
  store_id VARCHAR2(64),
  PRIMARY KEY(promotion_id,kk_expression_id)
);
CREATE INDEX idx_store_id ON kk_promotion_to_expression (store_id);

-----------------------------------------------------------------------------------------------------------------------------
-- Add Portuguese
INSERT INTO languages VALUES (languages_seq.nextval,'Português','pt','icon.gif','portuguese',4, null);

-- Category Descriptions
INSERT INTO categories_description (categories_id, language_id, categories_name) VALUES ( '1', '4', 'Hardware');
INSERT INTO categories_description (categories_id, language_id, categories_name) VALUES ( '2', '4', 'Software');
INSERT INTO categories_description (categories_id, language_id, categories_name) VALUES ( '3', '4', 'DVD Filmes');
INSERT INTO categories_description (categories_id, language_id, categories_name) VALUES ( '4', '4', 'Placas Gráficas');
INSERT INTO categories_description (categories_id, language_id, categories_name) VALUES ( '5', '4', 'Impressoras');
INSERT INTO categories_description (categories_id, language_id, categories_name) VALUES ( '6', '4', 'Monitores');
INSERT INTO categories_description (categories_id, language_id, categories_name) VALUES ( '7', '4', 'Altavoces');
INSERT INTO categories_description (categories_id, language_id, categories_name) VALUES ( '8', '4', 'Teclados');
INSERT INTO categories_description (categories_id, language_id, categories_name) VALUES ( '9', '4', 'Ratones');
INSERT INTO categories_description (categories_id, language_id, categories_name) VALUES ( '10', '4', 'Accion');
INSERT INTO categories_description (categories_id, language_id, categories_name) VALUES ( '11', '4', 'Ciencia Ficcion');
INSERT INTO categories_description (categories_id, language_id, categories_name) VALUES ( '12', '4', 'Comedia');
INSERT INTO categories_description (categories_id, language_id, categories_name) VALUES ( '13', '4', 'Dibujos Animados');
INSERT INTO categories_description (categories_id, language_id, categories_name) VALUES ( '14', '4', 'Suspense');
INSERT INTO categories_description (categories_id, language_id, categories_name) VALUES ( '15', '4', 'Drama');
INSERT INTO categories_description (categories_id, language_id, categories_name) VALUES ( '16', '4', 'Memoria');
INSERT INTO categories_description (categories_id, language_id, categories_name) VALUES ( '17', '4', 'Unidades CDROM');
INSERT INTO categories_description (categories_id, language_id, categories_name) VALUES ( '18', '4', 'Simulacion');
INSERT INTO categories_description (categories_id, language_id, categories_name) VALUES ( '19', '4', 'Accion');
INSERT INTO categories_description (categories_id, language_id, categories_name) VALUES ( '20', '4', 'Estrategia');

-- Tags
INSERT INTO kk_tag (tag_id, language_id, name, sort_order)  VALUES (1,4,'Audiência Geral: G',0);
INSERT INTO kk_tag (tag_id, language_id, name, sort_order)  VALUES (2,4,'Parental Guidance: PG',1);
INSERT INTO kk_tag (tag_id, language_id, name, sort_order)  VALUES (3,4,'Pais Advertido: PG-13',2);
INSERT INTO kk_tag (tag_id, language_id, name, sort_order)  VALUES (4,4,'Restrito: R',3);
INSERT INTO kk_tag (tag_id, language_id, name, sort_order)  VALUES (5,4,'Adults Only: NC-17',4);
INSERT INTO kk_tag (tag_id, language_id, name, sort_order)  VALUES (6,4,'Blu-ray',0);
INSERT INTO kk_tag (tag_id, language_id, name, sort_order)  VALUES (7,4,'HD-DVD',1);

-- Tag groups
INSERT INTO kk_tag_group (tag_group_id, language_id, name, description)  VALUES (1,4,'Avaliações MPAA Movie','A MPAA rating dado a cada filme');
INSERT INTO kk_tag_group (tag_group_id, language_id, name, description)  VALUES (2,4,'Formato DVD','O formato do DVD');

-- Manfacturer's Info
INSERT INTO manufacturers_info VALUES (1, 4, 'http://www.matrox.com', 0, null, null);
INSERT INTO manufacturers_info VALUES (2, 4, 'http://www.microsoft.com', 0, null, null);
INSERT INTO manufacturers_info VALUES (3, 4, 'http://www.warner.com', 0, null, null);
INSERT INTO manufacturers_info VALUES (4, 4, 'http://www.fox.com', 0, null, null);
INSERT INTO manufacturers_info VALUES (5, 4, 'http://www.logitech.com', 0, null, null);
INSERT INTO manufacturers_info VALUES (6, 4, 'http://www.canon.com', 0, null, null);
INSERT INTO manufacturers_info VALUES (7, 4, 'http://www.sierra.com', 0, null, null);
INSERT INTO manufacturers_info VALUES (8, 4, 'http://www.infogrames.com', 0, null, null);
INSERT INTO manufacturers_info VALUES (9, 4, 'http://www.hewlettpackard.com', 0, null, null);

-- Order Statuses
INSERT INTO orders_status(orders_status_id, language_id, orders_status_name) VALUES (1,4,'Pendente');
INSERT INTO orders_status(orders_status_id, language_id, orders_status_name) VALUES (2,4,'Processamento');
INSERT INTO orders_status(orders_status_id, language_id, orders_status_name) VALUES (3,4,'Entregue');
INSERT INTO orders_status(orders_status_id, language_id, orders_status_name) VALUES (4,4,'À espera de pagamento');
INSERT INTO orders_status(orders_status_id, language_id, orders_status_name) VALUES (5,4,'Pagamento Recebido');
INSERT INTO orders_status(orders_status_id, language_id, orders_status_name) VALUES (6,4,'Pagamento recusado');
INSERT INTO orders_status(orders_status_id, language_id, orders_status_name) VALUES (7,4,'Parcialmente entregue');

-- Product Descriptions
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (1,4,'Matrox G200 MMS','(pt) Reinforcing its position as a multi-monitor trailblazer, Matrox Graphics Inc. has once again developed the most flexible and highly advanced solution in the industry. Introducing the new Matrox G200 Multi-Monitor Series; the first graphics card ever to support up to four DVI digital flat panel displays on a single 8' || chr(34) || ' PCI board.<br><br>With continuing demand for digital flat panels in the financial workplace, the Matrox G200 MMS is the ultimate in flexible solutions. The Matrox G200 MMS also supports the new digital video interface (DVI) created by the Digital Display Working Group (DDWG) designed to ease the adoption of digital flat panels. Other configurations include composite video capture ability and onboard TV tuner, making the Matrox G200 MMS the complete solution for business needs.<br><br>Based on the award-winning MGA-G200 graphics chip, the Matrox G200 Multi-Monitor Series provides superior 2D/3D graphics acceleration to meet the demanding needs of business applications such as real-time stock quotes (Versus), live video feeds (Reuters ' || chr(38) || ' Bloombergs), multiple windows applications, word processing, spreadsheets and CAD.','www.matrox.com/mga/products/g200_mms/home.cfm',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (2,4,'Matrox G400 32MB','(pt) <b>Dramatically Different High Performance Graphics</b><br><br>Introducing the Millennium G400 Series - a dramatically different, high performance graphics experience. Armed with the industry''s fastest graphics chip, the Millennium G400 Series takes explosive acceleration two steps further by adding unprecedented image quality, along with the most versatile display options for all your 3D, 2D and DVD applications. As the most powerful and innovative tools in your PC''s arsenal, the Millennium G400 Series will not only change the way you see graphics, but will revolutionize the way you use your computer.<br><br><b>Key features:</b><ul><li>New Matrox G400 256-bit DualBus graphics chip</li><li>Explosive 3D, 2D and DVD performance</li><li>DualHead Display</li><li>Superior DVD and TV output</li><li>3D Environment-Mapped Bump Mapping</li><li>Vibrant Color Quality rendering </li><li>UltraSharp DAC of up to 360 MHz</li><li>3D Rendering Array Processor</li><li>Support for 16 or 32 MB of memory</li></ul>','www.matrox.com/mga/products/mill_g400/home.htm',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (3,4,'Microsoft IntelliMouse Pro','(pt) Every element of IntelliMouse Pro - from its unique arched shape to the texture of the rubber grip around its base - is the product of extensive customer and ergonomic research. Microsoft''s popular wheel control, which now allows zooming and universal scrolling functions, gives IntelliMouse Pro outstanding comfort and efficiency.','www.microsoft.com/hardware/mouse/intellimouse.asp',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (4,4,'The Replacement Killers','(pt) Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br>Languages: English, Deutsch.<br>Subtitles: English, Deutsch, Spanish.<br>Audio: Dolby Surround 5.1.<br>Picture Format: 16:9 Wide-Screen.<br>Length: (approx) 80 minutes.<br>Other: Interactive Menus, Chapter Selection, Subtitles (more languages).','www.replacement-killers.com',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (5,4,'Blade Runner - Director''s Cut','(pt) Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br>Languages: English, Deutsch.<br>Subtitles: English, Deutsch, Spanish.<br>Audio: Dolby Surround 5.1.<br>Picture Format: 16:9 Wide-Screen.<br>Length: (approx) 112 minutes.<br>Other: Interactive Menus, Chapter Selection, Subtitles (more languages).','www.bladerunner.com',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (6,4,'The Matrix','(pt) Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br><br>Languages: English, Deutsch.<br><br>Subtitles: English, Deutsch.<br><br>Audio: Dolby Surround.<br><br>Picture Format: 16:9 Wide-Screen.<br><br>Length: (approx) 131 minutes.<br><br>Other: Interactive Menus, Chapter Selection, Making Of.','www.thematrix.com',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (7,4,'You''ve Got Mail','(pt) Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br><br>Languages: English, Deutsch, Spanish.<br><br>Subtitles: English, Deutsch, Spanish, French, Nordic, Polish.<br><br>Audio: Dolby Digital 5.1.<br><br>Picture Format: 16:9 Wide-Screen.<br><br>Length: (approx) 115 minutes.<br><br>Other: Interactive Menus, Chapter Selection, Subtitles (more languages).','www.youvegotmail.com',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (8,4,'A Bug''s Life','(pt) Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br><br>Languages: English, Deutsch.<br><br>Subtitles: English, Deutsch, Spanish.<br><br>Audio: Dolby Digital 5.1 / Dobly Surround Stereo.<br><br>Picture Format: 16:9 Wide-Screen.<br><br>Length: (approx) 91 minutes.<br><br>Other: Interactive Menus, Chapter Selection, Subtitles (more languages).','www.abugslife.com',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (9,4,'Under Siege','(pt) Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br><br>Languages: English, Deutsch.<br><br>Subtitles: English, Deutsch, Spanish.<br><br>Audio: Dolby Surround 5.1.<br><br>Picture Format: 16:9 Wide-Screen.<br><br>Length: (approx) 98 minutes.<br><br>Other: Interactive Menus, Chapter Selection, Subtitles (more languages).','',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (10,4,'Under Siege 2 - Dark Territory','(pt) Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br><br>Languages: English, Deutsch.<br><br>Subtitles: English, Deutsch, Spanish.<br><br>Audio: Dolby Surround 5.1.<br><br>Picture Format: 16:9 Wide-Screen.<br><br>Length: (approx) 98 minutes.<br><br>Other: Interactive Menus, Chapter Selection, Subtitles (more languages).','',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (11,4,'Fire Down Below','(pt) Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br><br>Languages: English, Deutsch.<br><br>Subtitles: English, Deutsch, Spanish.<br><br>Audio: Dolby Surround 5.1.<br><br>Picture Format: 16:9 Wide-Screen.<br><br>Length: (approx) 100 minutes.<br><br>Other: Interactive Menus, Chapter Selection, Subtitles (more languages).','',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (12,4,'Die Hard With A Vengeance','(pt) Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br><br>Languages: English, Deutsch.<br><br>Subtitles: English, Deutsch, Spanish.<br><br>Audio: Dolby Surround 5.1.<br><br>Picture Format: 16:9 Wide-Screen.<br><br>Length: (approx) 122 minutes.<br><br>Other: Interactive Menus, Chapter Selection, Subtitles (more languages).','',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (13,4,'Lethal Weapon','(pt) Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br><br>Languages: English, Deutsch.<br><br>Subtitles: English, Deutsch, Spanish.<br><br>Audio: Dolby Surround 5.1.<br><br>Picture Format: 16:9 Wide-Screen.<br><br>Length: (approx) 100 minutes.<br><br>Other: Interactive Menus, Chapter Selection, Subtitles (more languages).','',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (14,4,'Red Corner','(pt) Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br><br>Languages: English, Deutsch.<br><br>Subtitles: English, Deutsch, Spanish.<br><br>Audio: Dolby Surround 5.1.<br><br>Picture Format: 16:9 Wide-Screen.<br><br>Length: (approx) 117 minutes.<br><br>Other: Interactive Menus, Chapter Selection, Subtitles (more languages).','',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (15,4,'Frantic','(pt) Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br><br>Languages: English, Deutsch.<br><br>Subtitles: English, Deutsch, Spanish.<br><br>Audio: Dolby Surround 5.1.<br><br>Picture Format: 16:9 Wide-Screen.<br><br>Length: (approx) 115 minutes.<br><br>Other: Interactive Menus, Chapter Selection, Subtitles (more languages).','',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (16,4,'Courage Under Fire','(pt) Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br><br>Languages: English, Deutsch.<br><br>Subtitles: English, Deutsch, Spanish.<br><br>Audio: Dolby Surround 5.1.<br><br>Picture Format: 16:9 Wide-Screen.<br><br>Length: (approx) 112 minutes.<br><br>Other: Interactive Menus, Chapter Selection, Subtitles (more languages).','',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (17,4,'Speed','(pt) Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br><br>Languages: English, Deutsch.<br><br>Subtitles: English, Deutsch, Spanish.<br><br>Audio: Dolby Surround 5.1.<br><br>Picture Format: 16:9 Wide-Screen.<br><br>Length: (approx) 112 minutes.<br><br>Other: Interactive Menus, Chapter Selection, Subtitles (more languages).','',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (18,4,'Speed 2: Cruise Control','(pt) Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br><br>Languages: English, Deutsch.<br><br>Subtitles: English, Deutsch, Spanish.<br><br>Audio: Dolby Surround 5.1.<br><br>Picture Format: 16:9 Wide-Screen.<br><br>Length: (approx) 120 minutes.<br><br>Other: Interactive Menus, Chapter Selection, Subtitles (more languages).','',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (19,4,'There''s Something About Mary','(pt) Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br><br>Languages: English, Deutsch.<br><br>Subtitles: English, Deutsch, Spanish.<br><br>Audio: Dolby Surround 5.1.<br><br>Picture Format: 16:9 Wide-Screen.<br><br>Length: (approx) 114 minutes.<br><br>Other: Interactive Menus, Chapter Selection, Subtitles (more languages).','',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (20,4,'Beloved','(pt) Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br><br>Languages: English, Deutsch.<br><br>Subtitles: English, Deutsch, Spanish.<br><br>Audio: Dolby Surround 5.1.<br><br>Picture Format: 16:9 Wide-Screen.<br><br>Length: (approx) 164 minutes.<br><br>Other: Interactive Menus, Chapter Selection, Subtitles (more languages).','',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (21,4,'SWAT 3: Close Quarters Battle','(pt) <b>Windows 95/98</b><br><br>211 in progress with shots fired. Officer down. Armed suspects with hostages. Respond Code 3! Los Angles, 2005, In the next seven days, representatives from every nation around the world will converge on Las Angles to witness the signing of the United Nations Nuclear Abolishment Treaty. The protection of these dignitaries falls on the shoulders of one organization, LAPD SWAT. As part of this elite tactical organization, you and your team have the weapons and all the training necessary to protect, to serve, and \"When needed\" to use deadly force to keep the peace. It takes more than weapons to make it through each mission. Your arsenal includes C2 charges, flashbangs, tactical grenades. opti-Wand mini-video cameras, and other devices critical to meeting your objectives and keeping your men free of injury. Uncompromised Duty, Honor and Valor!','www.swat3.com',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (22,4,'Unreal Tournament','(pt) From the creators of the best-selling Unreal, comes Unreal Tournament. A new kind of single player experience. A ruthless multiplayer revolution.<br><br>This stand-alone game showcases completely new team-based gameplay, groundbreaking multi-faceted single player action or dynamic multi-player mayhem. It''s a fight to the finish for the title of Unreal Grand Master in the gladiatorial arena. A single player experience like no other! Guide your team of ''bots'' (virtual teamates) against the hardest criminals in the galaxy for the ultimate title - the Unreal Grand Master.','www.unrealtournament.net',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (23,4,'The Wheel Of Time','(pt) The world in which The Wheel of Time takes place is lifted directly out of Jordan''s pages; it''s huge and consists of many different environments. How you navigate the world will depend largely on which game - single player or multipayer - you''re playing. The single player experience, with a few exceptions, will see Elayna traversing the world mainly by foot (with a couple notable exceptions). In the multiplayer experience, your character will have more access to travel via Ter''angreal, Portal Stones, and the Ways. However you move around, though, you''ll quickly discover that means of locomotion can easily become the least of the your worries...<br><br>During your travels, you quickly discover that four locations are crucial to your success in the game. Not surprisingly, these locations are the homes of The Wheel of Time''s main characters. Some of these places are ripped directly from the pages of Jordan''s books, made flesh with Legend''s unparalleled pixel-pushing ways. Other places are specific to the game, conceived and executed with the intent of expanding this game world even further. Either way, they provide a backdrop for some of the most intense first person action and strategy you''ll have this year.','www.wheeloftime.com',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (24,4,'Disciples: Sacred Lands','(pt) A new age is dawning...<br><br>Enter the realm of the Sacred Lands, where the dawn of a New Age has set in motion the most momentous of wars. As the prophecies long foretold, four races now clash with swords and sorcery in a desperate bid to control the destiny of their gods. Take on the quest as a champion of the Empire, the Mountain Clans, the Legions of the Damned, or the Undead Hordes and test your faith in battles of brute force, spellbinding magic and acts of guile. Slay demons, vanquish giants and combat merciless forces of the dead and undead. But to ensure the salvation of your god, the hero within must evolve.<br><br>The day of reckoning has come... and only the chosen will survive.','',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (25,4,'Microsoft Internet Keyboard PS/2','(pt) The Internet Keyboard has 10 Hot Keys on a comfortable standard keyboard design that also includes a detachable palm rest. The Hot Keys allow you to browse the web, or check e-mail directly from your keyboard. The IntelliType Pro software also allows you to customize your hot keys - make the Internet Keyboard work the way you want it to!','',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (26,4,'Microsoft IntelliMouse Explorer','(pt) Microsoft introduces its most advanced mouse, the IntelliMouse Explorer! IntelliMouse Explorer features a sleek design, an industrial-silver finish, a glowing red underside and taillight, creating a style and look unlike any other mouse. IntelliMouse Explorer combines the accuracy and reliability of Microsoft IntelliEye optical tracking technology, the convenience of two new customizable function buttons, the efficiency of the scrolling wheel and the comfort of expert ergonomic design. All these great features make this the best mouse for the PC!','www.microsoft.com/hardware/mouse/explorer.asp',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (27,4,'Hewlett Packard LaserJet 1100Xi','(pt) HP has always set the pace in laser printing technology. The new generation HP LaserJet 1100 series sets another impressive pace, delivering a stunning 8 pages per minute print speed. The 600 dpi print resolution with HP''s Resolution Enhancement technology (REt) makes every document more professional.<br><br>Enhanced print speed and laser quality results are just the beginning. With 2MB standard memory, HP LaserJet 1100xi users will be able to print increasingly complex pages. Memory can be increased to 18MB to tackle even more complex documents with ease. The HP LaserJet 1100xi supports key operating systems including Windows 3.1, 3.11, 95, 98, NT 4.0, OS/2 and DOS. Network compatibility available via the optional HP JetDirect External Print Servers.<br><br>HP LaserJet 1100xi also features The Document Builder for the Web Era from Trellix Corp. (featuring software to create Web documents).','www.pandi.hp.com/pandi-db/prodinfo.main?product=laserjet1100',0);

UPDATE products_description SET language_code = 'pt' WHERE language_id = 4;

INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (28,4,'Bundle Saver','Buy the Microsoft IntelliMouse Explorer and the Internet Keyboard together\, to save  10% on the individual prices and to receive free shipping !','',0);

-- Product Options
INSERT INTO products_options (products_options_id, language_id, products_options_name) VALUES (1, 4, 'Cor');
INSERT INTO products_options (products_options_id, language_id, products_options_name) VALUES (2, 4, 'Tamanho');
INSERT INTO products_options (products_options_id, language_id, products_options_name) VALUES (3, 4, 'Modelo');
INSERT INTO products_options (products_options_id, language_id, products_options_name) VALUES (4, 4, 'Memória');

-- Product Option Values
INSERT INTO products_options_values (products_options_values_id, language_id, products_options_values_name) VALUES (1,4,'4 mb');
INSERT INTO products_options_values (products_options_values_id, language_id, products_options_values_name) VALUES (2,4,'8 mb');
INSERT INTO products_options_values (products_options_values_id, language_id, products_options_values_name) VALUES (3,4,'16 mb');
INSERT INTO products_options_values (products_options_values_id, language_id, products_options_values_name) VALUES (4,4,'32 mb');
INSERT INTO products_options_values (products_options_values_id, language_id, products_options_values_name) VALUES (5,4,'Valor');
INSERT INTO products_options_values (products_options_values_id, language_id, products_options_values_name) VALUES (6,4,'Premium');
INSERT INTO products_options_values (products_options_values_id, language_id, products_options_values_name) VALUES (7,4,'Deluxe');
INSERT INTO products_options_values (products_options_values_id, language_id, products_options_values_name) VALUES (8,4,'PS/2');
INSERT INTO products_options_values (products_options_values_id, language_id, products_options_values_name) VALUES (9,4,'USB');

-- Reviews
--INSERT INTO reviews_description (reviews_id, languages_id, reviews_text) VALUES (1,4, 'Isto tem de ser um dos mais engraçados filmes lançados em 1999');

-- AdminApp Promotion - Expression API calls
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'addExpressionsToPromotion','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'getExpressionsPerPromotion','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'removeExpressionsFromPromotion','', sysdate);

--Customer tag examples
DELETE FROM kk_customer_tag WHERE name ='PRODUCTS_VIEWED';
INSERT INTO kk_customer_tag (kk_customer_tag_id, name, description, validation, tag_type, max_ints, date_added) VALUES (kk_customer_tag_seq.nextval,'PRODUCTS_VIEWED', 'Recently viewed product id', '((:[0-9]*)*:|)', 2, 5, sysdate);
DELETE FROM kk_customer_tag WHERE name ='CATEGORIES_VIEWED';
INSERT INTO kk_customer_tag (kk_customer_tag_id, name, description, validation, tag_type, max_ints, date_added) VALUES (kk_customer_tag_seq.nextval,'CATEGORIES_VIEWED', 'Recently viewed category id', '((:[0-9]*)*:|)', 2, 5, sysdate);
DELETE FROM kk_customer_tag WHERE name ='MANUFACTURERS_VIEWED';
INSERT INTO kk_customer_tag (kk_customer_tag_id, name, description, validation, tag_type, max_ints, date_added) VALUES (kk_customer_tag_seq.nextval,'MANUFACTURERS_VIEWED', 'Recently viewed manufacturer id', '((:[0-9]*)*:|)', 2, 5, sysdate);
DELETE FROM kk_customer_tag WHERE name ='PRODUCTS_IN_CART';
INSERT INTO kk_customer_tag (kk_customer_tag_id, name, description, validation, tag_type, max_ints, date_added) VALUES (kk_customer_tag_seq.nextval,'PRODUCTS_IN_CART', 'Id of a product in the cart', '((:[0-9]*)*:|)', 2, 50, sysdate);
DELETE FROM kk_customer_tag WHERE name ='PRODUCTS_IN_WISHLIST';
INSERT INTO kk_customer_tag (kk_customer_tag_id, name, description, validation, tag_type, max_ints, date_added) VALUES (kk_customer_tag_seq.nextval,'PRODUCTS_IN_WISHLIST', 'Id of a product in the Wish List', '((:[0-9]*)*:|)', 2, 50, sysdate);
DELETE FROM kk_customer_tag WHERE name ='SEARCH_STRING';
INSERT INTO kk_customer_tag (kk_customer_tag_id, name, description, tag_type, max_ints, date_added) VALUES (kk_customer_tag_seq.nextval,'SEARCH_STRING', 'Product Search String', 0, 5, sysdate);
DELETE FROM kk_customer_tag WHERE name ='COUNTRY_CODE';
INSERT INTO kk_customer_tag (kk_customer_tag_id, name, description, tag_type, max_ints, date_added) VALUES (kk_customer_tag_seq.nextval,'COUNTRY_CODE', 'Country code of customer', 0, 5, sysdate);
DELETE FROM kk_customer_tag WHERE name ='CART_TOTAL';
INSERT INTO kk_customer_tag (kk_customer_tag_id, name, description, tag_type, max_ints, date_added) VALUES (kk_customer_tag_seq.nextval,'CART_TOTAL', 'Cart total', 3, 5, sysdate);
DELETE FROM kk_customer_tag WHERE name ='WISHLIST_TOTAL';
INSERT INTO kk_customer_tag (kk_customer_tag_id, name, description, tag_type, max_ints, date_added) VALUES (kk_customer_tag_seq.nextval,'WISHLIST_TOTAL', 'Wish List total', 3, 5, sysdate);
DELETE FROM kk_customer_tag WHERE name ='BIRTH_DATE';
INSERT INTO kk_customer_tag (kk_customer_tag_id, name, description, tag_type, max_ints, date_added) VALUES (kk_customer_tag_seq.nextval,'BIRTH_DATE', 'Date of Birth', 4, 5, sysdate);
DELETE FROM kk_customer_tag WHERE name ='IS_MALE';
INSERT INTO kk_customer_tag (kk_customer_tag_id, name, description, validation, tag_type, max_ints, date_added) VALUES (kk_customer_tag_seq.nextval,'IS_MALE', 'Customer is Male', 'true|false', 5, 5, sysdate);

-- Enable / Disable customer tag functionality from application
DELETE FROM configuration WHERE configuration_key = 'ENABLE_CUSTOMER_TAGS';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (configuration_seq.nextval, 'Enable Customer Tag functionality', 'ENABLE_CUSTOMER_TAGS', 'false', 'When set to true, the application sets customer tags. All tag functionality is disabled when false.', '5', '6', 'choice(''true''=''true'',''false''=''false'')', sysdate);

-- Enable / Disable customer cart tag functionality from application
DELETE FROM configuration WHERE configuration_key = 'ENABLE_CUSTOMER_CART_TAGS';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (configuration_seq.nextval, 'Enable Customer Cart Tag functionality', 'ENABLE_CUSTOMER_CART_TAGS', 'false', 'When set to true, the application sets customer cart tags', '5', '7', 'choice(''true''=''true'',''false''=''false'')', sysdate);

-- Enable / Disable customer wishlist tag functionality from application
DELETE FROM configuration WHERE configuration_key = 'ENABLE_CUSTOMER_WISHLIST_TAGS';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (configuration_seq.nextval, 'Enable Customer WishList Tag functionality', 'ENABLE_CUSTOMER_WISHLIST_TAGS', 'false', 'When set to true, the application sets customer wish list tags', '5', '8', 'choice(''true''=''true'',''false''=''false'')', sysdate);

-- Config variables to determine whether to show internal ids
DELETE FROM configuration WHERE configuration_key = 'ADMIN_APP_PRODUCTS_DISPLAY_ID';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (configuration_seq.nextval, 'Display Product Ids', 'ADMIN_APP_PRODUCTS_DISPLAY_ID', 'true', 'When this is set, the product id is displayed in the products panel', '21', '29', 'choice(''true''=''true'',''false''=''false'')', sysdate);
DELETE FROM configuration WHERE configuration_key = 'ADMIN_APP_MANUFACTURERS_DISPLAY_ID';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (configuration_seq.nextval, 'Display Manufacturer Ids', 'ADMIN_APP_MANUFACTURERS_DISPLAY_ID', 'true', 'When this is set, the manufacturer id is displayed in the manufacturers panel', '21', '30', 'choice(''true''=''true'',''false''=''false'')', sysdate);
DELETE FROM configuration WHERE configuration_key = 'ADMIN_APP_CATEGORIES_DISPLAY_ID';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (configuration_seq.nextval, 'Display Category Ids', 'ADMIN_APP_CATEGORIES_DISPLAY_ID', 'true', 'When this is set, the category id is displayed in the categories panel', '21', '31', 'choice(''true''=''true'',''false''=''false'')', sysdate);

-- Evaluate Expression Admin API call
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'evaluateExpression','', sysdate);

-- Product Price Table
BEGIN EXECUTE IMMEDIATE 'DROP TABLE kk_product_prices'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE kk_product_prices (
  store_id VARCHAR2(64),
  catalog_id VARCHAR2(32) NOT NULL,
  products_id NUMBER(10,0) NOT NULL,
  products_attributes_id NUMBER(10,0) NOT NULL,
  products_price_0 NUMBER(15,4),
  products_price_1 NUMBER(15,4),
  products_price_2 NUMBER(15,4),
  products_price_3 NUMBER(15,4),
  PRIMARY KEY(catalog_id,products_id, products_attributes_id)
);

-- Extra attribute for product object
ALTER TABLE products ADD rating decimal(15,4);

-- Update image names

UPDATE products SET products_image = 'dvd/replacement_killers.jpg'          WHERE products_image = 'dvd/replacement_killers.gif';
UPDATE products SET products_image = 'dvd/blade_runner.jpg'                 WHERE products_image = 'dvd/blade_runner.gif';
UPDATE products SET products_image = 'dvd/the_matrix.jpg'                   WHERE products_image = 'dvd/the_matrix.gif';
UPDATE products SET products_image = 'dvd/youve_got_mail.jpg'               WHERE products_image = 'dvd/youve_got_mail.gif';
UPDATE products SET products_image = 'dvd/a_bugs_life.jpg'                  WHERE products_image = 'dvd/a_bugs_life.gif';
UPDATE products SET products_image = 'dvd/under_siege.jpg'                  WHERE products_image = 'dvd/under_siege.gif';
UPDATE products SET products_image = 'dvd/under_siege2.jpg'                 WHERE products_image = 'dvd/under_siege2.gif';
UPDATE products SET products_image = 'dvd/fire_down_below.jpg'              WHERE products_image = 'dvd/fire_down_below.gif';
UPDATE products SET products_image = 'dvd/die_hard_3.jpg'                   WHERE products_image = 'dvd/die_hard_3.gif';
UPDATE products SET products_image = 'dvd/lethal_weapon.jpg'                WHERE products_image = 'dvd/lethal_weapon.gif';
UPDATE products SET products_image = 'dvd/red_corner.jpg'                   WHERE products_image = 'dvd/red_corner.gif';
UPDATE products SET products_image = 'dvd/frantic.jpg'                      WHERE products_image = 'dvd/frantic.gif';
UPDATE products SET products_image = 'dvd/courage_under_fire.jpg'           WHERE products_image = 'dvd/courage_under_fire.gif';
UPDATE products SET products_image = 'dvd/speed.jpg'                        WHERE products_image = 'dvd/speed.gif';
UPDATE products SET products_image = 'dvd/speed2.jpg'                       WHERE products_image = 'dvd/speed_2.gif';
UPDATE products SET products_image = 'dvd/theres_something_about_mary.jpg'  WHERE products_image = 'dvd/theres_something_about_mary.gif';
UPDATE products SET products_image = 'dvd/beloved.jpg'                      WHERE products_image = 'dvd/beloved.gif';

UPDATE products SET products_image = 'sierra/swat3.jpg'                     WHERE products_image = 'sierra/swat_3.gif';

UPDATE products SET products_image = 'gt_interactive/unreal_tournament.jpg' WHERE products_image = 'gt_interactive/unreal_tournament.gif';
UPDATE products SET products_image = 'gt_interactive/wheel_of_time.jpg'     WHERE products_image = 'gt_interactive/wheel_of_time.gif';
UPDATE products SET products_image = 'gt_interactive/disciples.jpg'         WHERE products_image = 'gt_interactive/disciples.gif';

UPDATE products SET products_image = 'hewlett_packard/lj1100xi.jpg'         WHERE products_image = 'hewlett_packard/lj1100xi.gif';

UPDATE products SET products_image = 'matrox/mg400-32mb.jpg'                WHERE products_image = 'matrox/mg400-32mb.gif';
UPDATE products SET products_image = 'matrox/mg200mms.jpg'                  WHERE products_image = 'matrox/mg200mms.gif';

UPDATE products SET products_image = 'microsoft/bundle.jpg'                 WHERE products_image = 'microsoft/bundle.gif';
UPDATE products SET products_image = 'microsoft/imexplorer.jpg'             WHERE products_image = 'microsoft/imexplorer.gif';
UPDATE products SET products_image = 'microsoft/intkeyboardps2.jpg'         WHERE products_image = 'microsoft/intkeyboardps2.gif';
UPDATE products SET products_image = 'microsoft/msimpro.jpg'                WHERE products_image = 'microsoft/msimpro.gif';

-- Add index to products_attributes table
CREATE INDEX i_pr_products_attributes ON products_attributes (products_id);

-- New Digital Download table
BEGIN EXECUTE IMMEDIATE 'DROP TABLE kk_digital_download'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE kk_digital_download_1'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE kk_digital_download_1 (
  kk_digital_download_id NUMBER(10,0) NOT NULL,
  store_id VARCHAR2(64),
  products_id NUMBER(10,0) DEFAULT 0 NOT NULL,
  customers_id NUMBER(10,0) DEFAULT 0 NOT NULL,
  products_file_path VARCHAR2(255),
  max_downloads NUMBER(10,0) DEFAULT -1,
  times_downloaded NUMBER(10,0) DEFAULT 0,
  expiration_date TIMESTAMP,
  date_added TIMESTAMP,
  last_modified TIMESTAMP,
  PRIMARY KEY(kk_digital_download_id)
);
CREATE INDEX i_prodid_kk_digdown_1 ON kk_digital_download_1 (products_id);
CREATE INDEX i_custid_kk_digdown_1 ON kk_digital_download_1 (customers_id);
CREATE INDEX i_storid_kk_digdown_1 ON kk_digital_download_1 (store_id);
BEGIN EXECUTE IMMEDIATE 'DROP SEQUENCE kk_digital_download_1_SEQ'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE SEQUENCE kk_digital_download_1_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

-- Add column to promotion_to_product table
ALTER TABLE promotion_to_product ADD relation_type int default '0';

-- GiftCertificate APIs for the Admin App
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'addGiftCertificatesToPromotion','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'getGiftCertificatesPerPromotion','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'removeGiftCertificatesFromPromotion','', sysdate);

-- Insert a gift certificate product

DELETE FROM products WHERE products_id = 29;
DELETE FROM products_description WHERE products_id = 29;
INSERT INTO products (products_id, products_quantity, products_model, products_image, products_price, products_date_added, products_last_modified, products_date_available, products_weight, products_status, products_tax_class_id, manufacturers_id, products_ordered, products_type) VALUES (products_seq.nextval,10000,'GIFTCERT','gifts/giftcert.jpg',10.00, sysdate,null,sysdate,0.1,1,1,10,0,5);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (products_description_seq.nextval,1,'Gift Certificate','The Perfect Gift ! <br><br>After checking out, your gift certificate will be available as a stylish pdf document that you can download from your account page. You may then send it as an eMail attachment or print it out and deliver a hard copy.<br>Each gift certificate contains a code that is redeemable online.','www.konakart.com',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (29,2,'Gift Certificate','The Perfect Gift ! <br><br>After checking out, your gift certificate will be available as a stylish pdf document that you can download from your account page. You may then send it as an eMail attachment or print it out and deliver a hard copy.<br>Each gift certificate contains a code that is redeemable online.','www.konakart.com',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (29,3,'Gift Certificate','The Perfect Gift ! <br><br>After checking out, your gift certificate will be available as a stylish pdf document that you can download from your account page. You may then send it as an eMail attachment or print it out and deliver a hard copy.<br>Each gift certificate contains a code that is redeemable online.','www.konakart.com',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (29,4,'Gift Certificate','The Perfect Gift ! <br><br>After checking out, your gift certificate will be available as a stylish pdf document that you can download from your account page. You may then send it as an eMail attachment or print it out and deliver a hard copy.<br>Each gift certificate contains a code that is redeemable online.','www.konakart.com',0);

DELETE FROM products_options WHERE products_options_id = 5;
INSERT INTO products_options (products_options_id, language_id, products_options_name) VALUES (5, 1, 'Type');
INSERT INTO products_options (products_options_id, language_id, products_options_name) VALUES (5, 2, 'Type');
INSERT INTO products_options (products_options_id, language_id, products_options_name) VALUES (5, 3, 'Type');
INSERT INTO products_options (products_options_id, language_id, products_options_name) VALUES (5, 4, 'Type');

DELETE FROM products_options_values WHERE products_options_values_id = 10;
DELETE FROM products_options_values WHERE products_options_values_id = 11;
DELETE FROM products_options_values WHERE products_options_values_id = 12;
INSERT INTO products_options_values (products_options_values_id, language_id, products_options_values_name) VALUES (10,1,'Bronze');
INSERT INTO products_options_values (products_options_values_id, language_id, products_options_values_name) VALUES (10,2,'Bronze');
INSERT INTO products_options_values (products_options_values_id, language_id, products_options_values_name) VALUES (10,3,'Bronze');
INSERT INTO products_options_values (products_options_values_id, language_id, products_options_values_name) VALUES (10,4,'Bronze');
INSERT INTO products_options_values (products_options_values_id, language_id, products_options_values_name) VALUES (11,1,'Silver');
INSERT INTO products_options_values (products_options_values_id, language_id, products_options_values_name) VALUES (11,2,'Silver');
INSERT INTO products_options_values (products_options_values_id, language_id, products_options_values_name) VALUES (11,3,'Silver');
INSERT INTO products_options_values (products_options_values_id, language_id, products_options_values_name) VALUES (11,4,'Silver');
INSERT INTO products_options_values (products_options_values_id, language_id, products_options_values_name) VALUES (12,1,'Gold');
INSERT INTO products_options_values (products_options_values_id, language_id, products_options_values_name) VALUES (12,2,'Gold');
INSERT INTO products_options_values (products_options_values_id, language_id, products_options_values_name) VALUES (12,3,'Gold');
INSERT INTO products_options_values (products_options_values_id, language_id, products_options_values_name) VALUES (12,4,'Gold');

DELETE FROM prod_opt_vals_to_prod_opt WHERE products_options_id = 5;
INSERT INTO prod_opt_vals_to_prod_opt (prod_opt_vals_to_prod_opt_id, products_options_id, products_options_values_id) VALUES (prod_opt_vals_to_prod_opt_seq.nextval, 5, 10);
INSERT INTO prod_opt_vals_to_prod_opt (prod_opt_vals_to_prod_opt_id, products_options_id, products_options_values_id) VALUES (prod_opt_vals_to_prod_opt_seq.nextval, 5, 11);
INSERT INTO prod_opt_vals_to_prod_opt (prod_opt_vals_to_prod_opt_id, products_options_id, products_options_values_id) VALUES (prod_opt_vals_to_prod_opt_seq.nextval, 5, 12);

DELETE FROM products_attributes WHERE options_id = 5;
INSERT INTO products_attributes (products_attributes_id, products_id, options_id, options_values_id, options_values_price, price_prefix) VALUES (products_attributes_seq.nextval,29,5,10,0.00,'+');
INSERT INTO products_attributes (products_attributes_id, products_id, options_id, options_values_id, options_values_price, price_prefix) VALUES (products_attributes_seq.nextval,29,5,11,15.00,'+');
INSERT INTO products_attributes (products_attributes_id, products_id, options_id, options_values_id, options_values_price, price_prefix) VALUES (products_attributes_seq.nextval,29,5,12,40.00,'+');

DELETE FROM categories WHERE categories_id = 21;
DELETE FROM categories_description WHERE categories_id = 21;
DELETE FROM products_to_categories WHERE categories_id = 21;
INSERT INTO categories (categories_id, categories_image, parent_id, sort_order, date_added, last_modified) VALUES (categories_seq.nextval, 'no-image.png', 0, 4, sysdate, null);
INSERT INTO categories_description (categories_id, language_id, categories_name) VALUES ( 21, 1, 'Gifts');
INSERT INTO categories_description (categories_id, language_id, categories_name) VALUES ( 21, 2, 'Gifts');
INSERT INTO categories_description (categories_id, language_id, categories_name) VALUES ( 21, 3, 'Gifts');
INSERT INTO categories_description (categories_id, language_id, categories_name) VALUES ( 21, 4, 'Gifts');
INSERT INTO products_to_categories (products_id, categories_id) VALUES (29, 21);

DELETE FROM manufacturers WHERE manufacturers_id = 10;
DELETE FROM manufacturers_info WHERE manufacturers_id = 10;
INSERT INTO manufacturers (manufacturers_id, manufacturers_name, manufacturers_image, date_added, last_modified) VALUES (manufacturers_seq.nextval,'KonaKart','konakart_tree_logo_60x60.jpg', sysdate, null);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (10, 1, 'http://www.konakart.com', 0, null);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (10, 2, 'http://www.konakart.com', 0, null);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (10, 3, 'http://www.konakart.com', 0, null);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (10, 4, 'http://www.konakart.com', 0, null);

-- Table to store secret key used in payment gateways
BEGIN EXECUTE IMMEDIATE 'DROP TABLE kk_secret_key'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE kk_secret_key (
  kk_secret_key_id NUMBER(10,0) NOT NULL,
  secret_key VARCHAR2(255) NOT NULL,
  orders_id integer NOT NULL,
  date_added TIMESTAMP NOT NULL,
  PRIMARY KEY(kk_secret_key_id)
   );
CREATE INDEX idx_secret_key_kk_secret_key ON kk_secret_key (secret_key);
BEGIN EXECUTE IMMEDIATE 'DROP SEQUENCE kk_secret_key_SEQ'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE SEQUENCE kk_secret_key_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

-- Digital Download Admin API calls
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'searchDigitalDownloads','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'importDigitalDownload','', sysdate);

-----------------  v5.0.0.0

-- Reward points table
BEGIN EXECUTE IMMEDIATE 'DROP TABLE kk_reward_points'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE kk_reward_points (
  kk_reward_points_id NUMBER(10,0) NOT NULL,
  store_id VARCHAR2(64),
  code VARCHAR2(64),
  description VARCHAR2(256),
  customers_id NUMBER(10,0) DEFAULT 0 NOT NULL,
  initial_points NUMBER(10,0) DEFAULT 0 NOT NULL,
  remaining_points NUMBER(10,0) DEFAULT 0 NOT NULL,
  expired NUMBER(10,0) DEFAULT 0 NOT NULL,
  tx_type NUMBER(10,0) DEFAULT 0 NOT NULL,
  date_added TIMESTAMP NOT NULL,
  PRIMARY KEY(kk_reward_points_id)
);
CREATE INDEX i_custid_kk_reward_pts ON kk_reward_points (customers_id);
CREATE INDEX i_storid_kk_reward_pts ON kk_reward_points (store_id);
BEGIN EXECUTE IMMEDIATE 'DROP SEQUENCE kk_reward_points_SEQ'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE SEQUENCE kk_reward_points_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

-- Reserved points table
BEGIN EXECUTE IMMEDIATE 'DROP TABLE kk_reserved_points'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE kk_reserved_points (
  kk_reserved_points_id NUMBER(10,0) NOT NULL,
  store_id VARCHAR2(64),
  customers_id NUMBER(10,0) DEFAULT 0 NOT NULL,
  reward_points_id NUMBER(10,0) DEFAULT 0 NOT NULL,
  reservation_id NUMBER(10,0) DEFAULT 0 NOT NULL,
  reserved_points NUMBER(10,0) DEFAULT 0 NOT NULL,
  date_added TIMESTAMP NOT NULL,
  PRIMARY KEY(kk_reserved_points_id)
);
CREATE INDEX i_custid_kk_reserved_pts ON kk_reserved_points (reservation_id);
CREATE INDEX i_storid_kk_reserved_pts ON kk_reserved_points (store_id);
BEGIN EXECUTE IMMEDIATE 'DROP SEQUENCE kk_reserved_points_SEQ'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE SEQUENCE kk_reserved_points_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

--Extra order attributes for reward points
ALTER TABLE orders ADD points_used int DEFAULT '0';
ALTER TABLE orders ADD points_awarded int DEFAULT '0';
ALTER TABLE orders ADD points_reservation_id int DEFAULT '-1';

-- Allow user to insert reward points
DELETE FROM configuration WHERE configuration_key = 'ENABLE_REWARD_POINTS';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, store_id) SELECT configuration_seq.nextval, 'Enable Reward Points', 'ENABLE_REWARD_POINTS', 'false', 'During checkout the customer will be allowed to enter reward points if set to true', '26', '1', 'choice(''true''=''true'',''false''=''false'')', sysdate, store_id FROM configuration WHERE configuration_key = 'STORE_COUNTRY';

-- Add a new order status
DELETE FROM orders_status WHERE orders_status_id = 8;
INSERT INTO orders_status(orders_status_id, language_id, orders_status_name) VALUES (8,1,'Cancelled');
INSERT INTO orders_status(orders_status_id, language_id, orders_status_name) VALUES (8,2,'Abgesagt');
INSERT INTO orders_status(orders_status_id, language_id, orders_status_name) VALUES (8,3,'Cancelado');
INSERT INTO orders_status(orders_status_id, language_id, orders_status_name) VALUES (8,4,'Cancelado');

-- Maximum number of reward point transactions displayed
DELETE FROM configuration WHERE configuration_key = 'MAX_DISPLAY_REWARD_POINTS';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, store_id) SELECT configuration_seq.nextval, 'Reward Point Transactions', 'MAX_DISPLAY_REWARD_POINTS', '15', 'Maximum number of reward point transactions to display', '3', '26', 'integer(0,null)', sysdate, store_id FROM configuration WHERE configuration_key = 'STORE_COUNTRY';
-- Number of reward point awarded for registering
DELETE FROM configuration WHERE configuration_key = 'REGISTRATION_REWARD_POINTS';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, store_id) SELECT configuration_seq.nextval, 'Reward Points for registering', 'REGISTRATION_REWARD_POINTS', '0', 'Reward points received for registration', '26', '2', 'integer(0,null)', sysdate, store_id FROM configuration WHERE configuration_key = 'STORE_COUNTRY';
-- Number of reward point awarded for writing a review
DELETE FROM configuration WHERE configuration_key = 'REVIEW_REWARD_POINTS';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, store_id) SELECT configuration_seq.nextval, 'Reward Points for writing a review', 'REVIEW_REWARD_POINTS', '0', 'Reward points received for writing a review', '26', '3', 'integer(0,null)', sysdate, store_id FROM configuration WHERE configuration_key = 'STORE_COUNTRY';

-- Panel for Configuring Reward Points
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval,  'kk_panel_reward_points','Reward Points Configuration', sysdate);

-- Add Configure Reward Points to super admin role
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 92, 1,1,1,sysdate);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (5, 92, 1,1,1,sysdate);

-- Reward Point API calls
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'getRewardPoints','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'deletePoints','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'importDigitalDownload','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'pointsAvailable','', sysdate);

-- Add locale to customer and order
ALTER TABLE customers ADD customers_locale varchar(16);
ALTER TABLE orders ADD customers_locale varchar(16);

-- To enable/disable the new Rich Text Product Description Editor
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (configuration_seq.nextval, 'Use Rich Text Editor', 'RICH_TEXT_EDITOR', 'true', 'If true the Rich Text Editor is used for product descriptions, otherwise the Plain Text Editor is used', '9', '12', 'choice(''true''=''true'',''false''=''false'')', sysdate);


INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (configuration_seq.nextval, '1st Day of the Week', '1ST_DAY_OF_WEEK', '0', 'Define the first day of the week for the calendars in the Admin App.', '21', '35', 'option(0=date.day.long.Sunday,1=date.day.long.Monday,2=date.day.long.Tuesday,3=date.day.long.Wednesday,4=date.day.long.Thursday,5=date.day.long.Friday,6=date.day.long.Saturday)', sysdate);

-- Allow user to insert gift certificate code
DELETE FROM configuration WHERE configuration_key = 'DISPLAY_GIFT_CERT_ENTRY';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (configuration_seq.nextval, 'Display Gift Cert Entry Field', 'DISPLAY_GIFT_CERT_ENTRY', 'false', 'During checkout the customer will be allowed to enter a gift certificate if set to true', '1', '22', 'choice(''true''=''true'',''false''=''false'')', sysdate);

-- Configure the customer communications panel to show or not show a drop list of templates
UPDATE kk_role_to_panel SET custom1=0, custom1_desc='If set, template names can be entered in a text box' WHERE panel_id=62;
-- Configure the customer communications panel to show or not show a file upload button
UPDATE kk_role_to_panel SET custom2=0, custom2_desc='If set, a file upload button is not displayed' WHERE panel_id=62;

-- PDF Creation API calls
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'getPdf','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'getFileContentsAsByteArray','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'getLanguageIdForLocale','', sysdate);

-- PDF Config panel
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval, 'kk_panel_pdfConfig', 'PDF Configuration', sysdate);

-- Grant access to PDF Config panel to the Super Admin and the Standard Admin Users
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) SELECT 1, panel_id, 1,1,1, sysdate from kk_panel WHERE code = 'kk_panel_pdfConfig';
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) SELECT 5, panel_id, 1,1,1, sysdate from kk_panel WHERE code = 'kk_panel_pdfConfig';

-- PDF Configuration Parameters
DELETE FROM configuration WHERE configuration_key = 'PDF_BASE_DIRECTORY';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (configuration_seq.nextval, 'PDF Directory', 'PDF_BASE_DIRECTORY', 'C:/Program Files/KonaKart/pdf/', 'Defines the root directory for the location of the PDF documents that are created', '27', '5', sysdate);
DELETE FROM configuration WHERE configuration_key = 'ENABLE_PDF_INVOICE_DOWNLOAD';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, store_id) SELECT configuration_seq.nextval, 'Enable PDF Invoice Download', 'ENABLE_PDF_INVOICE_DOWNLOAD', 'false', 'When set to true, invoices in PDF format can be downloaded from the application', '27', '10', 'choice(''true''=''true'',''false''=''false'')', sysdate, store_id FROM configuration WHERE configuration_key = 'STORE_COUNTRY';

-- Add column for Invoice filename
ALTER TABLE orders ADD invoice_filename varchar(255);

-- Velocity Template Configuration Parameters
DELETE FROM configuration WHERE configuration_key = 'TEMPLATE_BASE_DIRECTORY';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (configuration_seq.nextval, 'Templates Directory', 'TEMPLATE_BASE_DIRECTORY', 'C:/Program Files/KonaKart/templates', 'Defines the root directory where the velocity templates are stored', '28', '10', sysdate);

-- Velocity Template Config panel
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval, 'kk_panel_templates', 'Template Configuration', sysdate);

-- Grant access to Velocity Template Config panel to the Super Admin and the Standard Admin Users
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) SELECT 1, panel_id, 1,1,1, sysdate from kk_panel WHERE code = 'kk_panel_templates';
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) SELECT 5, panel_id, 1,1,1, sysdate from kk_panel WHERE code = 'kk_panel_templates';

-- Add extra column to returns table
ALTER TABLE orders_returns ADD orders_number varchar(128);

-- Config variable to automatically enable products when quantity > 0
DELETE FROM configuration WHERE configuration_key = 'STOCK_ENABLE_PRODUCT';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (configuration_seq.nextval, 'Automatically Enable Product', 'STOCK_ENABLE_PRODUCT', 'false', 'Automatically enable a product if quantity is set to a positive number', '9', '4', 'choice(''true''=''true'',''false''=''false'')', sysdate);

-- Configure the edit customer panel to allow editing of external customers only
UPDATE kk_role_to_panel SET custom1=0, custom1_desc='Set to allow editing of external customer fields only' WHERE panel_id in (select panel_id from kk_panel WHERE code='kk_panel_editCustomer');

-- Configure the edit config files panel to control the upload of new files
UPDATE kk_role_to_panel SET custom1=0, custom1_desc='Set to allow upload of configuration files' WHERE panel_id in (select panel_id from kk_panel WHERE code='kk_panel_configFiles');

-- Allow Super-User Role to upload new config files
UPDATE kk_role_to_panel SET custom1=1 WHERE panel_id in (select panel_id from kk_panel WHERE code='kk_panel_configFiles') and role_id=1;

-- New Batch job for Creating Invoices
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'com.konakartadmin.bl.AdminOrderBatchMgr.createInvoicesBatch','', sysdate);

-- Add new FileUpload configuration command
UPDATE configuration SET set_function='FileUpload' WHERE configuration_key = 'KONAKART_MAIL_PROPERTIES_FILE';
UPDATE configuration SET set_function='FileUpload' WHERE configuration_key = 'KK_NEW_STORE_SQL_FILENAME';
UPDATE configuration SET set_function='FileUpload' WHERE configuration_key = 'USER_NEW_STORE_SQL_FILENAME';

-- Added just as an example of using the FileUpload get_function in a module configuration parameter
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, use_function, date_added) VALUES (configuration_seq.nextval, 'Miscellaneous Config File', 'MODULE_PAYMENT_COD_MISC_CONFIG_FILE', 'C:/Temp/cod_misc.properties', 'Miscellaneous Configuration File (just an example - not actually used).', '6', '6', 'FileUpload', '', sysdate);

-- Add index to customers table
CREATE INDEX i_cu_customers ON customers (customers_email_address);

-- Addition of more custom fields to product object
ALTER TABLE products ADD custom6 varchar(128);
ALTER TABLE products ADD custom7 varchar(128);
ALTER TABLE products ADD custom8 varchar(128);
ALTER TABLE products ADD custom9 varchar(128);
ALTER TABLE products ADD custom10 varchar(128);
ALTER TABLE products ADD custom1Int int;
ALTER TABLE products ADD custom2Int int;
ALTER TABLE products ADD custom1Dec decimal(15,4);
ALTER TABLE products ADD custom2Dec decimal(15,4);
ALTER TABLE products ADD products_date_expiry TIMESTAMP;

-- Config variable to determine whether to show internal customer ids
DELETE FROM configuration WHERE configuration_key = 'ADMIN_APP_CUSTOMERS_DISPLAY_ID';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (configuration_seq.nextval, 'Display Customer Ids', 'ADMIN_APP_CUSTOMERS_DISPLAY_ID', 'true', 'When this is set, the customer id is displayed in the edit customer panel', '21', '29', 'choice(''true''=''true'',''false''=''false'')', sysdate);

-- Extra attributes for product object
ALTER TABLE products ADD payment_schedule_id int default -1 not null;

-- Payment Schedule
BEGIN EXECUTE IMMEDIATE 'DROP TABLE kk_payment_schedule'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE kk_payment_schedule (
  kk_payment_schedule_id NUMBER(10,0) NOT NULL,
  store_id VARCHAR2(64),
  name VARCHAR2(64),
  description VARCHAR2(256),
  length NUMBER(10,0) DEFAULT 0 NOT NULL,
  unit NUMBER(10,0) DEFAULT 0 NOT NULL,
  day_of_month NUMBER(10,0) DEFAULT 0 NOT NULL,
  occurrences NUMBER(10,0) DEFAULT 0 NOT NULL,
  trial_occurrences NUMBER(10,0) DEFAULT 0 NOT NULL,
  custom1 VARCHAR2(128),
  custom2 VARCHAR2(128),
  custom3 VARCHAR2(128),
  custom4 VARCHAR2(128),
  custom5 VARCHAR2(128),
  date_added TIMESTAMP NOT NULL,
  PRIMARY KEY(kk_payment_schedule_id)
);
CREATE INDEX i_storid_kk_pay_sched ON kk_payment_schedule (store_id);
BEGIN EXECUTE IMMEDIATE 'DROP SEQUENCE kk_payment_schedule_SEQ'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE SEQUENCE kk_payment_schedule_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

-- Subscription
BEGIN EXECUTE IMMEDIATE 'DROP TABLE kk_subscription'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE kk_subscription (
  kk_subscription_id NUMBER(10,0) NOT NULL,
  store_id VARCHAR2(64),
  orders_id NUMBER(10,0) DEFAULT 0 NOT NULL,
  orders_number VARCHAR2(128),
  customers_id NUMBER(10,0) DEFAULT 0 NOT NULL,
  products_id NUMBER(10,0) DEFAULT 0 NOT NULL,
  payment_schedule_id NUMBER(10,0) DEFAULT 0 NOT NULL,
  products_sku VARCHAR2(255),
  subscription_code VARCHAR2(128),
  start_date TIMESTAMP,
  amount NUMBER(15,4) NOT NULL,
  trial_amount NUMBER(15,4),
  active NUMBER(10,0) DEFAULT 0 NOT NULL,
  problem NUMBER(10,0) DEFAULT 0 NOT NULL,
  problem_description VARCHAR2(255),
  last_billing_date TIMESTAMP,
  next_billing_date TIMESTAMP,
  custom1 VARCHAR2(128),
  custom2 VARCHAR2(128),
  custom3 VARCHAR2(128),
  custom4 VARCHAR2(128),
  custom5 VARCHAR2(128),
  date_added TIMESTAMP NOT NULL,
  last_modified TIMESTAMP,
  PRIMARY KEY(kk_subscription_id)
);
CREATE INDEX i_storid_kk_subscription ON kk_subscription (store_id);
BEGIN EXECUTE IMMEDIATE 'DROP SEQUENCE kk_subscription_SEQ'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE SEQUENCE kk_subscription_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

-- Payment Schedule Panel
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval, 'kk_panel_payment_schedule', 'Payment Schedule', sysdate);

-- Grant access to Payment Schedule panel to the Super Admin and the Standard Admin and Catalog Maintenance Users
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) SELECT 1, panel_id, 1,1,1, sysdate FROM kk_panel WHERE code = 'kk_panel_payment_schedule';
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) SELECT 2, panel_id, 1,1,1, sysdate FROM kk_panel WHERE code = 'kk_panel_payment_schedule';
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) SELECT 5, panel_id, 1,1,1, sysdate FROM kk_panel WHERE code = 'kk_panel_payment_schedule';

-- Subscription Panel
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval, 'kk_panel_subscription', 'Subscription', sysdate);

-- Grant access to Subscription panel to the Super Admin and the Standard Admin and Order Maintenance Users
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) SELECT 1, panel_id, 1,1,1, sysdate FROM kk_panel WHERE code = 'kk_panel_subscription';
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) SELECT 3, panel_id, 1,1,1, sysdate FROM kk_panel WHERE code = 'kk_panel_subscription';
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) SELECT 5, panel_id, 1,1,1, sysdate FROM kk_panel WHERE code = 'kk_panel_subscription';

-- Subscription From Orders Panel
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval, 'kk_panel_subscriptionFromOrders', 'Subscription From Orders', sysdate);

-- Grant access to Subscription From Orders panel to the Super Admin and the Standard Admin and Order Maintenance Users
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) SELECT 1, panel_id, 1,1,1, sysdate FROM kk_panel WHERE code = 'kk_panel_subscriptionFromOrders';
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) SELECT 3, panel_id, 1,1,1, sysdate FROM kk_panel WHERE code = 'kk_panel_subscriptionFromOrders';
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) SELECT 5, panel_id, 1,1,1, sysdate FROM kk_panel WHERE code = 'kk_panel_subscriptionFromOrders';

-- Subscription from Customers Panel
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval, 'kk_panel_subscriptionFromCustomers', 'Subscription From Customers', sysdate);

-- Grant access to Subscription from Customers panel to the Super Admin and the Standard Admin and Order Maintenance Users
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) SELECT 1, panel_id, 1,1,1, sysdate FROM kk_panel WHERE code = 'kk_panel_subscriptionFromCustomers';
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) SELECT 3, panel_id, 1,1,1, sysdate FROM kk_panel WHERE code = 'kk_panel_subscriptionFromCustomers';
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) SELECT 5, panel_id, 1,1,1, sysdate FROM kk_panel WHERE code = 'kk_panel_subscriptionFromCustomers';

-- Extra attributes for ipn_history object
ALTER TABLE ipn_history ADD kk_subscription_id int DEFAULT -1 not null;

-- Config variable to determine whether to show button for subscriptions panel
DELETE FROM configuration WHERE configuration_key = 'ADMIN_APP_DISPLAY_SUBSCRIPTIONS_BUTTON';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (configuration_seq.nextval, 'Display Subscriptions Button', 'ADMIN_APP_DISPLAY_SUBSCRIPTIONS_BUTTON', 'false', 'When this is set, a Subscriptions button is displayed in the Customers and Orders panels', '21', '30', 'choice(''true''=''true'',''false''=''false'')', sysdate);

-- Allow the same product to be entered into the basket more than once without updating the quantity of the existing one
DELETE FROM configuration WHERE configuration_key = 'ALLOW_MULTIPLE_BASKET_ENTRIES';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (configuration_seq.nextval, 'Allow multiple basket entries', 'ALLOW_MULTIPLE_BASKET_ENTRIES', 'false', 'When set, allow the same product to be entered into the basket more than once without updating the quantity of the existing one', '9', '11', 'choice(''true''=''true'',''false''=''false'')', sysdate);

-- Addition of extra telephone and eMail attributes
ALTER TABLE customers ADD customers_telephone_1 varchar(32);
ALTER TABLE address_book ADD entry_telephone varchar(32);
ALTER TABLE address_book ADD entry_telephone_1 varchar(32);
ALTER TABLE address_book ADD entry_email_address varchar(96);
ALTER TABLE orders ADD customers_telephone_1 varchar(32);
ALTER TABLE orders ADD delivery_telephone varchar(32);
ALTER TABLE orders ADD delivery_telephone_1 varchar(32);
ALTER TABLE orders ADD delivery_email_address varchar(96);
ALTER TABLE orders ADD billing_telephone varchar(32);
ALTER TABLE orders ADD billing_telephone_1 varchar(32);
ALTER TABLE orders ADD billing_email_address varchar(96);

-- Make address format fields bigger
ALTER TABLE address_format MODIFY address_format VARCHAR(255);
ALTER TABLE address_format MODIFY address_summary VARCHAR(255);

-- Make product image fields bigger
ALTER TABLE products MODIFY products_image VARCHAR(255);
ALTER TABLE products MODIFY products_image2 VARCHAR(255);
ALTER TABLE products MODIFY products_image3 VARCHAR(255);
ALTER TABLE products MODIFY products_image4 VARCHAR(255);

-----------------  v5.1.0.0

-- These are required because we changed the default https port in server.xml

UPDATE configuration SET configuration_value='8783' WHERE configuration_key = 'SSL_PORT_NUMBER' AND configuration_value = '8443';
UPDATE configuration SET configuration_value='https://localhost:8783/konakart/AdminLoginSubmit.do' WHERE configuration_key = 'ADMIN_APP_LOGIN_BASE_URL' AND configuration_value = 'https://localhost:8443/konakart/AdminLoginSubmit.do';

-- Add attribute to determine whether to use basket price or product price
ALTER TABLE customers_basket ADD use_basket_price int DEFAULT '0';

-- Allow usage of basket price
DELETE FROM configuration WHERE configuration_key = 'ALLOW_BASKET_PRICE';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (configuration_seq.nextval, 'Allow using the basket price', 'ALLOW_BASKET_PRICE','false','Allows you to define the price in the basket object when adding a product to the basket', '18', '8', 'choice(''true''=''true'',''false''=''false'')', sysdate);

-- Add attribute to define the default behavior of the admin app when changing order status
ALTER TABLE orders_status ADD notify_customer int DEFAULT 0;

-- Add special price expiry date
ALTER TABLE specials ADD starts_date TIMESTAMP DEFAULT NULL;

-- Add a new key to the external product prices
-- Re-create Product Price Table with a new key
BEGIN EXECUTE IMMEDIATE 'DROP TABLE kk_product_prices'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE kk_product_prices (
  store_id VARCHAR2(64),
  catalog_id VARCHAR2(32) NOT NULL,
  products_id NUMBER(10,0) NOT NULL,
  products_attributes_id NUMBER(10,0) NOT NULL,
  tier_price_id NUMBER(10,0) DEFAULT 0 NOT NULL,
  products_price_0 NUMBER(15,4),
  products_price_1 NUMBER(15,4),
  products_price_2 NUMBER(15,4),
  products_price_3 NUMBER(15,4),
  PRIMARY KEY(catalog_id, products_id, products_attributes_id, tier_price_id)
);

-- Add a tier price table
BEGIN EXECUTE IMMEDIATE 'DROP TABLE kk_tier_price'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE kk_tier_price (
  kk_tier_price_id NUMBER(10,0) NOT NULL,
  store_id VARCHAR2(64),
  products_id NUMBER(10,0) NOT NULL,
  products_quantity NUMBER(10,0) NOT NULL,
  tier_price NUMBER(15,4),
  tier_price_1 NUMBER(15,4),
  tier_price_2 NUMBER(15,4),
  tier_price_3 NUMBER(15,4),
  use_percentage_discount int,
  custom1 VARCHAR2(128),
  date_added TIMESTAMP NOT NULL,
  last_modified TIMESTAMP,
  PRIMARY KEY(kk_tier_price_id)
);
CREATE INDEX i_prodid_kk_tier_price ON kk_tier_price (products_id);
CREATE INDEX i_storid_kk_tier_price ON kk_tier_price (store_id);
BEGIN EXECUTE IMMEDIATE 'DROP SEQUENCE kk_tier_price_SEQ'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE SEQUENCE kk_tier_price_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

--Add discount attribute to Orders Products table
ALTER TABLE orders_products ADD discount_percent decimal(15,4);

-- Set the rule for calculating tax
DELETE FROM configuration where configuration_key = 'TAX_QUANTITY_RULE';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (configuration_seq.nextval, 'Tax Quantity Rule', 'TAX_QUANTITY_RULE', '1', 'Tax calculated on total=1\nTax calculated per item and then rounded=2', '9', '13', 'integer(1,2), ', sysdate);

-- Set the number of decimal places for currency in the admin app
DELETE FROM configuration where configuration_key = 'ADMIN_CURRENCY_DECIMAL_PLACES';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (configuration_seq.nextval, 'No of decimal places for currency', 'ADMIN_CURRENCY_DECIMAL_PLACES', '2', 'No of decimal places allowed for entering prices in the admin app', '1', '27', 'integer(0,9), ', sysdate);

-- Add extra street address to various tables
ALTER TABLE address_book ADD entry_street_address_1 varchar(64);
ALTER TABLE orders ADD customers_street_address_1 varchar(64);
ALTER TABLE orders ADD delivery_street_address_1 varchar(64);
ALTER TABLE orders ADD billing_street_address_1 varchar(64);

-- Config variable to decide whether to show 2nd street address
DELETE FROM configuration where configuration_key = 'ACCOUNT_STREET_ADDRESS_1';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (configuration_seq.nextval, 'Street Address 1', 'ACCOUNT_STREET_ADDRESS_1', 'false', 'Display 2nd street address in the customers account', '5', '4', 'choice(''true''=''true'',''false''=''false'')', sysdate);

-- Config variable to define min length of 2nd street address
DELETE FROM configuration where configuration_key = 'ENTRY_STREET_ADDRESS1_MIN_LENGTH';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (configuration_seq.nextval, 'Street Address 1', 'ENTRY_STREET_ADDRESS1_MIN_LENGTH', '5', 'Minimum length of street address 1', '2', '5', 'integer(0,null)', sysdate);

-- Addition of custom fields to products_attributes
ALTER TABLE products_attributes ADD custom1 varchar(128);
ALTER TABLE products_attributes ADD custom2 varchar(128);

-- Addition of custom fields to products_options
ALTER TABLE products_options ADD custom1 varchar(128);
ALTER TABLE products_options ADD custom2 varchar(128);

-- Addition of custom fields to products_options_values
ALTER TABLE products_options_values ADD custom1 varchar(128);
ALTER TABLE products_options_values ADD custom2 varchar(128);

-- Config variable to issue warning for matching SKUs in Admin App
DELETE FROM configuration where configuration_key = 'ADMIN_APP_WARN_OF_DUPLICATE_SKUS';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (configuration_seq.nextval, 'Warn of Duplicate SKUs', 'ADMIN_APP_WARN_OF_DUPLICATE_SKUS', 'false', 'Issue warning in Admin App of duplicate SKUs', '21', '32', 'choice(''true''=''true'',''false''=''false'')', sysdate);

-- Move the Rich Text Editor Configuration Variable to the Admn App Configuration Panel
UPDATE configuration set configuration_group_id = 21, sort_order = 32 where configuration_key = 'RICH_TEXT_EDITOR' and configuration_group_id = 9;

-----------------  v5.2.0.0

-- Add extra columns to the Zones table
ALTER TABLE zones ADD zone_invisible int DEFAULT 0 NOT NULL;
ALTER TABLE zones ADD zone_search varchar(64);
CREATE INDEX i_zone_search_zones ON zones (zone_search);

-- New API call for checking Data Integrity
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'checkDataIntegrity','', sysdate);

-- Addition of custom fields to digital_downloads
ALTER TABLE kk_digital_download_1 ADD custom1 varchar(128);
ALTER TABLE kk_digital_download_1 ADD custom2 varchar(128);
ALTER TABLE kk_digital_download_1 ADD custom3 varchar(128);

-- Add an attribute to the orders table
ALTER TABLE orders ADD shipping_service_code varchar(128);

-- Add custom field descriptions for Shipping Command on Order panels
UPDATE kk_role_to_panel SET custom3=0, custom3_desc='If set Export For Shipping button not shown' WHERE panel_id in (select panel_id from kk_panel WHERE code='kk_panel_customerOrders');
UPDATE kk_role_to_panel SET custom3=0, custom3_desc='If set Export For Shipping button not shown' WHERE panel_id in (select panel_id from kk_panel WHERE code='kk_panel_orders');

UPDATE kk_role_to_panel SET custom4=0, custom4_desc='If set Export button not shown' WHERE panel_id in (select panel_id from kk_panel WHERE code='kk_panel_customerOrders');
UPDATE kk_role_to_panel SET custom4=0, custom4_desc='If set Export button not shown' WHERE panel_id in (select panel_id from kk_panel WHERE code='kk_panel_orders');

-- Config variable to define the location of the Shipping Orders
DELETE FROM configuration where configuration_key = 'EXPORT_ORDERS_BASE_DIRECTORY';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (configuration_seq.nextval, 'Exported Orders Directory', 'EXPORT_ORDERS_BASE_DIRECTORY', 'C:/Program Files/KonaKart/orders', 'Defines the root directory where the Orders are exported to', '7', '7', sysdate);

-- New exportOrder API call
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'exportOrder','', sysdate);

-- Add description field to category
ALTER TABLE categories_description ADD description VARCHAR2(4000);

-- Move the Admin Currency Decimal Place Configuration Variable to the Admn App Configuration Panel
UPDATE configuration set configuration_group_id = 21, sort_order = 40 where configuration_key = 'ADMIN_CURRENCY_DECIMAL_PLACES' and configuration_group_id = 1;

-- Move the Email From and Send Extra Emails Configuration Variable to the Email Configuration Panel
UPDATE configuration set configuration_group_id = 12, sort_order = 6 where configuration_key = 'EMAIL_FROM' and configuration_group_id = 1;
UPDATE configuration set configuration_group_id = 12, sort_order = 6 where configuration_key = 'SEND_EXTRA_EMAILS_TO' and configuration_group_id = 1;

-- Config variable to define whether to allow wish lists for non logged in users
DELETE FROM configuration where configuration_key = 'ALLOW_WISHLIST_WHEN_NOT_LOGGED_IN';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (configuration_seq.nextval, 'Allow Wish List when not logged in', 'ALLOW_WISHLIST_WHEN_NOT_LOGGED_IN', 'false', 'Allow wish list functionality to be available for customers that have not logged in', '1', '25', 'choice(''true''=''true'',''false''=''false'')', sysdate);

-- Config variable to define the Address that Orders are shipped from
DELETE FROM configuration where configuration_key = 'SHIP_FROM_STREET_ADDRESS';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (configuration_seq.nextval, 'Ship From Street Address', 'SHIP_FROM_STREET_ADDRESS', '', 'Ship From Street Address - used by some of the Shipping Modules', '7', '2', sysdate);

-- Config variable to define the City that Orders are shipped from
DELETE FROM configuration where configuration_key = 'SHIP_FROM_CITY';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (configuration_seq.nextval, 'Ship From City', 'SHIP_FROM_CITY', '', 'Ship From City - used by some of the Shipping Modules', '7', '2', sysdate);

-- Add weight attribute to Orders Products table
ALTER TABLE orders_products ADD weight decimal(10,2);

-- Config variable to define the Product Types that are not shown in the droplist on the Edit Product Panel
DELETE FROM configuration where configuration_key = 'HIDDEN_PRODUCT_TYPES';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (configuration_seq.nextval, 'Hidden Product Types', 'HIDDEN_PRODUCT_TYPES', '', 'The Product Types that are not shown in the droplist on the Edit Product Panel', '21', '27', sysdate);

-- Set the default customer to be John Doe
UPDATE customers SET customers_type = 3 where customers_email_address = 'root@localhost';

-- Product Quantity Table for different catalog ids
BEGIN EXECUTE IMMEDIATE 'DROP TABLE kk_catalog_quantity'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE kk_catalog_quantity (
  store_id VARCHAR2(64),
  catalog_id VARCHAR2(32) NOT NULL,
  products_id NUMBER(10,0) NOT NULL,
  products_options VARCHAR2(128) NOT NULL,
  products_quantity NUMBER(10,0) NOT NULL,
  products_date_available TIMESTAMP,
  PRIMARY KEY(catalog_id,products_id, products_options)
);

-- Set the custom1 field of the Super User role to Administrator (for Liferay SSO example)
UPDATE kk_role SET custom1 = 'Administrator' where role_id = 1;

-- Add new column to promotions table
ALTER TABLE promotion ADD max_use int DEFAULT '-1' NOT NULL;

-- Tracks the number of times a promotion has been used
BEGIN EXECUTE IMMEDIATE 'DROP TABLE promotion_to_customer_use'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE promotion_to_customer_use (
  store_id VARCHAR2(64),
  promotion_id NUMBER(10,0) NOT NULL,
  customers_id NUMBER(10,0) NOT NULL,
  times_used NUMBER(10,0) DEFAULT 0 NOT NULL,
  PRIMARY KEY(promotion_id,customers_id)
);

-- Page links
DELETE FROM configuration where configuration_key = 'MAX_DISPLAY_PAGE_LINKS';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (configuration_seq.nextval, 'Search Result Page Links', 'MAX_DISPLAY_PAGE_LINKS', '5', 'Maximum number of links used for page-sets - must be odd number', '3', '3', 'integer(3,null)', sysdate);

-- Define the default state for reviews when written by a customer
DELETE FROM configuration where configuration_key = 'DEFAULT_REVIEW_STATE';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (configuration_seq.nextval, 'Default state for reviews', 'DEFAULT_REVIEW_STATE', '0', 'Allows you to make reviews visible only after approval if initial state is set to 1', '18', '10', 'integer(0,null)', sysdate);

-- Add state attribute to reviews table
ALTER TABLE reviews ADD state int DEFAULT 0 NOT NULL;

-- Reviews Panel
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval, 'kk_panel_reviews', 'Maintain Product Reviews', sysdate);
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval, 'kk_panel_prod_reviews', 'Product Reviews for Product', sysdate);
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval, 'kk_panel_cust_reviews', 'Product Reviews for Customer', sysdate);

-- Add Reviews Panel access to all roles that can access the Product panel
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, sysdate, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_products' and p2.code='kk_panel_reviews';
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, sysdate, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_products' and p2.code='kk_panel_prod_reviews';
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, sysdate, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_products' and p2.code='kk_panel_cust_reviews';

-- getReviews API call
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'getReviews','', sysdate);

-- For storing all messages in the database
BEGIN EXECUTE IMMEDIATE 'DROP TABLE kk_msg'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE kk_msg (
  msg_key VARCHAR2(100) NOT NULL,
  msg_locale VARCHAR2(10) NOT NULL,
  msg_type NUMBER(10,0) NOT NULL,
  msg_value VARCHAR2(4000),
  PRIMARY KEY(msg_key,msg_type,msg_locale)
);

-- Add locale to languages table
ALTER TABLE languages ADD locale varchar(10);
UPDATE languages SET locale = code;
UPDATE languages SET locale = 'en_GB' where code = 'en';
UPDATE languages SET locale = 'de_DE' where code = 'de';
UPDATE languages SET locale = 'es_ES' where code = 'es';
UPDATE languages SET locale = 'pt_BR' where code = 'pt';

-- Messages Panel
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval, 'kk_panel_messages', 'Maintain Application Messages', sysdate);

-- Grant access to Messages Panel to the Super Admin and the Standard Admin Users
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) SELECT 1, panel_id, 1,1,1, sysdate FROM kk_panel WHERE code = 'kk_panel_messages';
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) SELECT 5, panel_id, 1,1,1, sysdate FROM kk_panel WHERE code = 'kk_panel_messages';

-- Config variable to define the Messsage Types allowed in the System
DELETE FROM configuration where configuration_key = 'MESSAGE_TYPES';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (configuration_seq.nextval, 'Message Types', 'MESSAGE_TYPES', 'Application,AdminApp,AdminAppHelp', 'Used to populate the Message Types droplist in the Messages section', '21', '41', sysdate);

-- Config variable to define whether we use files (the default) or the database for storing system messages
DELETE FROM configuration where configuration_key = 'USE_DB_FOR_MESSAGES';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (configuration_seq.nextval, 'Use D/B For Messages', 'USE_DB_FOR_MESSAGES', 'false', 'If true use the Database for the system messsages, if false use file-based messages', '21', '40', 'choice(''true''=''true'',''false''=''false'')', sysdate);

-- New Messages APIs
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'searchMsg','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'getMsgValue','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'deleteMsg','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'insertMsg','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'updateMsg','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'importMsgs','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'exportMsgs','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'getLanguageById','', sysdate);

-- Add indexes on product table
CREATE INDEX i_manufacturers_id_products ON products (manufacturers_id);

-- Add new attribute to address_book table
ALTER TABLE address_book ADD manufacturers_id int DEFAULT 0 NOT NULL;

-- Address Panel
--INSERT INTO kk_panel (code, description, date_added) VALUES ('kk_panel_address', 'All Addresses', now());
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval, 'kk_panel_prod_address', 'Product Addresses', sysdate);
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval, 'kk_panel_manu_address', 'Manufacturer Addresses', sysdate);
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval, 'kk_panel_cust_address', 'Customer Addresses', sysdate);

-- Add Address Panel access to all roles that can access the Customer panel
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, sysdate, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_customers' and p2.code='kk_panel_address';
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, sysdate, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_customers' and p2.code='kk_panel_prod_address';
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, sysdate, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_customers' and p2.code='kk_panel_manu_address';
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, sysdate, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_customers' and p2.code='kk_panel_cust_address';

-- Table to connect products to addresses
BEGIN EXECUTE IMMEDIATE 'DROP TABLE kk_addr_to_product'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE kk_addr_to_product (
  store_id VARCHAR2(64),
  address_book_id NUMBER(10,0) NOT NULL,
  products_id NUMBER(10,0) NOT NULL,
  relation_type NUMBER(10,0) DEFAULT 0 NOT NULL,
  PRIMARY KEY(address_book_id,products_id)
);

-- Configuration for address select panels in admin app
DELETE FROM configuration WHERE configuration_key = 'ADMIN_APP_ADDR_SEL_NUM_ADDRS';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (configuration_seq.nextval, 'Address Select Default Num Addrs', 'ADMIN_APP_ADDR_SEL_NUM_ADDRS', '50', 'Sets the default number of addresses displayed in the address select dialogs when opened', '21', '50', sysdate);
DELETE FROM configuration WHERE configuration_key = 'ADMIN_APP_ADDR_SEL_MAX_NUM_ADDRS';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (configuration_seq.nextval, 'Address Select Max Num Addrs', 'ADMIN_APP_ADDR_SEL_MAX_NUM_ADDRS', '100', 'Sets the maximum number of addresses displayed in the address select dialogs after a search', '21', '51', sysdate);
DELETE FROM configuration WHERE configuration_key = 'ADMIN_APP_SELECT_PROD_ADDR_FORMAT';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (configuration_seq.nextval, 'Addr Format for Prod Addr Sel', 'ADMIN_APP_SELECT_PROD_ADDR_FORMAT', '$company $street $street1 $suburb $city $state $country', 'How the address is formatted in the product select address panel', '21', '0', sysdate);
DELETE FROM configuration WHERE configuration_key = 'ADMIN_APP_PROD_ADDR_FORMAT';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (configuration_seq.nextval, 'Addr Format for Prod Addr', 'ADMIN_APP_PROD_ADDR_FORMAT', '$company $street $street1 $suburb $city $state $country', 'How the address is formatted in the product address panel', '21', '0', sysdate);
DELETE FROM configuration WHERE configuration_key = 'ADMIN_APP_CUST_ADDR_FORMAT';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (configuration_seq.nextval, 'Addr Format for Cust Addr', 'ADMIN_APP_CUST_ADDR_FORMAT', '$street $street1 $suburb $city $state $country', 'How the address is formatted in the customer address panel', '21', '0', sysdate);
DELETE FROM configuration WHERE configuration_key = 'ADMIN_APP_MANU_ADDR_FORMAT';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (configuration_seq.nextval, 'Addr Format for Manu Addr', 'ADMIN_APP_MANU_ADDR_FORMAT', '$street $street1 $suburb $city $state $country', 'How the address is formatted in the manufacturer address panel', '21', '0', sysdate);

-- New address related API calls
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'addAddressesToProduct','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'removeAddressFromProduct','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'getProductCountPerAddress','', sysdate);

-- New Manufacturer API call
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'getManufacturers','', sysdate);

-- New Product Option API call
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'getProductOptions','', sysdate);

-- Configuration for manufacturer panels in admin app
DELETE FROM configuration WHERE configuration_key = 'ADMIN_APP_MANU_SEL_NUM_MANUS';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (configuration_seq.nextval, 'Manufacturer Panel Default Num Manus', 'ADMIN_APP_MANU_SEL_NUM_MANUS', '50', 'Sets the default number of manufacturers displayed in the manufacturer panels and dialogs when opened', '21', '52', sysdate);
DELETE FROM configuration WHERE configuration_key = 'ADMIN_APP_MANU_SEL_MAX_NUM_MANUS';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (configuration_seq.nextval, 'Manufacturer Panel Max Num Manus', 'ADMIN_APP_MANU_SEL_MAX_NUM_MANUS', '100', 'Sets the maximum number of manufacturers displayed in the manufacturer panels and dialogs after a search', '21', '53', sysdate);

-- Configuration for product option panel in admin app
DELETE FROM configuration WHERE configuration_key = 'ADMIN_APP_PROD_OPT_SEL_NUM_PROD_OPTS';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (configuration_seq.nextval, 'Prod Option Panel Default Num Prod Opts', 'ADMIN_APP_PROD_OPT_SEL_NUM_PROD_OPTS', '50', 'Sets the default number of product options displayed in the prod option panel when opened', '21', '54', sysdate);
DELETE FROM configuration WHERE configuration_key = 'ADMIN_APP_PROD_OPT_SEL_MAX_NUM_PROD_OPTS';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (configuration_seq.nextval, 'Prod Option Panel Max Num Prod Opts', 'ADMIN_APP_PROD_OPT_SEL_MAX_NUM_PROD_OPTS', '100', 'Sets the maximum number of product options displayed in the prod option panel after a search', '21', '55', sysdate);

-----------------  v5.3.0.0

-- Tables for Custom Product Attributes
BEGIN EXECUTE IMMEDIATE 'DROP TABLE kk_cust_attr'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE kk_cust_attr (
  kk_cust_attr_id NUMBER(10,0) NOT NULL,
  store_id VARCHAR2(64),
  name VARCHAR2(64) NOT NULL,
  msg_cat_key VARCHAR2(128),
  attr_type integer DEFAULT -1,
  template VARCHAR2(128),
  validation VARCHAR2(512),
  set_function VARCHAR2(512),
  custom1 VARCHAR2(128),
  custom2 VARCHAR2(128),
  custom3 VARCHAR2(128),
  date_added TIMESTAMP NOT NULL,
  PRIMARY KEY(kk_cust_attr_id)
   );
CREATE INDEX idx_nm_kk_cust_attr ON kk_cust_attr (name);
CREATE INDEX idx_st_id_kk_cust_attr ON kk_cust_attr (store_id);
BEGIN EXECUTE IMMEDIATE 'DROP SEQUENCE kk_cust_attr_SEQ'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE SEQUENCE kk_cust_attr_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

BEGIN EXECUTE IMMEDIATE 'DROP TABLE kk_cust_attr_tmpl'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE kk_cust_attr_tmpl (
  kk_cust_attr_tmpl_id NUMBER(10,0) NOT NULL,
  store_id VARCHAR2(64),
  name VARCHAR2(64) NOT NULL,
  description VARCHAR2(255),
  custom1 VARCHAR2(128),
  custom2 VARCHAR2(128),
  custom3 VARCHAR2(128),
  date_added TIMESTAMP NOT NULL,
  PRIMARY KEY(kk_cust_attr_tmpl_id)
   );
CREATE INDEX idx_nm_kk_cust_attr_tmpl ON kk_cust_attr_tmpl (name);
CREATE INDEX idx_st_kk_cust_attr_tmpl ON kk_cust_attr_tmpl (store_id);
BEGIN EXECUTE IMMEDIATE 'DROP SEQUENCE kk_cust_attr_tmpl_SEQ'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE SEQUENCE kk_cust_attr_tmpl_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

BEGIN EXECUTE IMMEDIATE 'DROP TABLE kk_tmpl_to_cust_attr'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE kk_tmpl_to_cust_attr (
  kk_cust_attr_tmpl_id NUMBER(10,0) DEFAULT 0 NOT NULL,
  kk_cust_attr_id NUMBER(10,0) DEFAULT 0 NOT NULL,
  store_id VARCHAR2(64),
  sort_order NUMBER(10,0) DEFAULT 0 NOT NULL,
  PRIMARY KEY(kk_cust_attr_tmpl_id, kk_cust_attr_id)
);
CREATE INDEX idx_st_kk_tmpl_to_cust_attr ON kk_tmpl_to_cust_attr (store_id);

-- Custom product attribute panels
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval, 'kk_panel_prodAttrTemplates', 'Product Custom Attribute Templates', sysdate);
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval, 'kk_panel_prodAttrDescs', 'Product Custom Attributes', sysdate);

-- Add Panel access to all roles that can access the Product maintenance panel
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, sysdate, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_products' and p2.code='kk_panel_prodAttrTemplates';
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, sysdate, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_products' and p2.code='kk_panel_prodAttrDescs';

-- New Product Custom Attribute APIs
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'deleteProdAttrDesc','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'deleteProdAttrTemplate','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'getProdAttrDesc','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'getProdAttrTemplate','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'getProdAttrDescs','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'getProdAttrDescsForTemplate','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'getProdAttrTemplates','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'insertProdAttrDesc','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'insertProdAttrTemplate','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'updateProdAttrDesc','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'updateProdAttrTemplate','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'removeProdAttrDescsFromTemplate','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'addProdAttrDescsToTemplate','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'getTemplateCountPerProdAttrDesc','', sysdate);

-- Configuration for select product custom attr panels in admin app
DELETE FROM configuration WHERE configuration_key = 'ADMIN_APP_PROD_ATTR_SEL_NUM_PROD_ATTRS';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (configuration_seq.nextval, 'Prod Custom Attr Panel Default Num Attrs', 'ADMIN_APP_PROD_ATTR_SEL_NUM_PROD_ATTRS', '50', 'Sets the default number of product attributes displayed in the product attribute dialogs when opened', '21', '56', sysdate);
DELETE FROM configuration WHERE configuration_key = 'ADMIN_APP_PROD_ATTR_SEL_MAX_NUM_PROD_ATTRS';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (configuration_seq.nextval, 'Prod Custom Attr Panel Max Num Attrs', 'ADMIN_APP_PROD_ATTR_SEL_MAX_NUM_PROD_ATTRS', '100', 'Sets the maximum number of product attributes displayed in the product attribute dialogs after a search', '21', '57', sysdate);

-- Configuration for select template panels in admin app
DELETE FROM configuration WHERE configuration_key = 'ADMIN_APP_TMPL_SEL_NUM_TMPLS';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (configuration_seq.nextval, 'Template Panel Default Num Templates', 'ADMIN_APP_TMPL_SEL_NUM_TMPLS', '50', 'Sets the default number of templates displayed in the select template dialogs when opened', '21', '58', sysdate);
DELETE FROM configuration WHERE configuration_key = 'ADMIN_APP_TMPL_SEL_MAX_NUM_TMPLS';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (configuration_seq.nextval, 'Template Panel Max Num Templates', 'ADMIN_APP_TMPL_SEL_MAX_NUM_TMPLS', '100', 'Sets the maximum number of templatess displayed in the select template dialogs after a search', '21', '59', sysdate);

-- Add template / custom attribute attributes to product
ALTER TABLE products ADD cust_attr_tmpl_id int DEFAULT -1;
ALTER TABLE products ADD custom_attrs VARCHAR2(4000);

-- Demo data for Custom product attributes
INSERT INTO kk_cust_attr (kk_cust_attr_id, name, msg_cat_key, attr_type, template, validation, set_function, date_added) VALUES (kk_cust_attr_SEQ.nextval, 'radio', 'label.size', 0, null, null, 'choice(''label.small'',''label.medium'',''label.large'')', sysdate);
INSERT INTO kk_cust_attr (kk_cust_attr_id, name, msg_cat_key, attr_type, template, validation, set_function, date_added) VALUES (kk_cust_attr_SEQ.nextval, 'true-false', 'label.true.false', 4, null, 'true|false', null, sysdate);
INSERT INTO kk_cust_attr (kk_cust_attr_id, name, msg_cat_key, attr_type, template, validation, set_function, date_added) VALUES (kk_cust_attr_SEQ.nextval, 'dropList', 'label.size', 0, null, null, 'option(s=label.small,m=label.medium,l=label.large)', sysdate);
INSERT INTO kk_cust_attr (kk_cust_attr_id, name, msg_cat_key, attr_type, template, validation, set_function, date_added) VALUES (kk_cust_attr_SEQ.nextval, 'integer-1-to-10', null, 1, null, null, 'integer(1,10)', sysdate);
INSERT INTO kk_cust_attr (kk_cust_attr_id, name, msg_cat_key, attr_type, template, validation, set_function, date_added) VALUES (kk_cust_attr_SEQ.nextval, 'any-int', null, 1, null, null, 'integer(null,null)', sysdate);
INSERT INTO kk_cust_attr (kk_cust_attr_id, name, msg_cat_key, attr_type, template, validation, set_function, date_added) VALUES (kk_cust_attr_SEQ.nextval, 'decimal-1.5-to-2.3', null, 2, null, null, 'double(1.5,2.3)', sysdate);
INSERT INTO kk_cust_attr (kk_cust_attr_id, name, msg_cat_key, attr_type, template, validation, set_function, date_added) VALUES (kk_cust_attr_SEQ.nextval, 'string-length-4', null, 0, null, null, 'string(4,4)', sysdate);
INSERT INTO kk_cust_attr (kk_cust_attr_id, name, msg_cat_key, attr_type, template, validation, set_function, date_added) VALUES (kk_cust_attr_SEQ.nextval, 'date-dd/MM/yyyy', null, 3, 'dd/MM/yyyy', '^(((0[1-9]|[12]\d|3[01])\/(0[13578]|1[02])\/((1[6-9]|[2-9]\d)\d{2}))|((0[1-9]|[12]\d|30)\/(0[13456789]|1[012])\/((1[6-9]|[2-9]\d)\d{2}))|((0[1-9]|1\d|2[0-8])\/02\/((1[6-9]|[2-9]\d)\d{2}))|(29\/02\/((1[6-9]|[2-9]\d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00))))$', null, sysdate);
INSERT INTO kk_cust_attr (kk_cust_attr_id, name, msg_cat_key, attr_type, template, validation, set_function, custom1, custom2, custom3, date_added) VALUES (kk_cust_attr_SEQ.nextval, 'any-string-use-custom', null, 0, null, null, null, 'c1', 'c2', 'c3', sysdate);

-- Configuration variable for defining the way searches are done - for Oracle CLOB support etc
DELETE FROM configuration WHERE configuration_key = 'FETCH_PRODUCT_DESCRIPTIONS_SEPARATELY';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (configuration_seq.nextval, 'Fetch Descriptions Separately', 'FETCH_PRODUCT_DESCRIPTIONS_SEPARATELY', 'false', 'Fetch Product Descriptions Separately', '9', '30', 'choice(''true''=''true'',''false''=''false'')', sysdate);

-- Customer tags for preferences
DELETE FROM kk_customer_tag WHERE name ='PROD_PAGE_SIZE';
INSERT INTO kk_customer_tag (kk_customer_tag_id, name, description, tag_type, max_ints, date_added) VALUES (kk_customer_tag_seq.nextval,'PROD_PAGE_SIZE', 'The page size for product lists', 1, 1, sysdate);
DELETE FROM kk_customer_tag WHERE name ='ORDER_PAGE_SIZE';
INSERT INTO kk_customer_tag (kk_customer_tag_id, name, description, tag_type, max_ints, date_added) VALUES (kk_customer_tag_seq.nextval,'ORDER_PAGE_SIZE', 'The page size for order lists', 1, 1, sysdate);
DELETE FROM kk_customer_tag WHERE name ='REVIEW_PAGE_SIZE';
INSERT INTO kk_customer_tag (kk_customer_tag_id, name, description, tag_type, max_ints, date_added) VALUES (kk_customer_tag_seq.nextval,'REVIEW_PAGE_SIZE', 'The page size for review lists', 1, 1, sysdate);

-- Add a Message Catalog Key to the countries table to allow country names in multiple languages - default the value of this to 'CTRY.' + ISO-3 value
ALTER TABLE countries ADD msgCatKey VARCHAR(32);
UPDATE countries set msgCatKey = CONCAT('CTRY.',countries_iso_code_3);

-- Configuration variable for defining whether to look up country names in the message catalog or not
DELETE FROM configuration WHERE configuration_key = 'USE_MSG_CAT_FOR_COUNTRY_NAMES';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order,  set_function, date_added) VALUES (configuration_seq.nextval, 'Use Country Names in Msg Cat', 'USE_MSG_CAT_FOR_COUNTRY_NAMES', 'false', 'Use the Country Names in the Message Catalogues', '1', '29', 'choice(''true''=''true'',''false''=''false'')', sysdate);

-- Table for storing customer statistics data
BEGIN EXECUTE IMMEDIATE 'DROP TABLE kk_cust_stats'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE kk_cust_stats (
  cust_stats_id NUMBER(10,0) NOT NULL,
  store_id VARCHAR2(64),
  customers_id NUMBER(10,0) DEFAULT 0,
  event_type NUMBER(10,0) DEFAULT 0,
  data1Str VARCHAR2(128),
  data2Str VARCHAR2(128),
  data1Int int,
  data2Int int,
  data1Dec NUMBER(15,4),
  data2Dec NUMBER(15,4),
  date_added TIMESTAMP NOT NULL,
  PRIMARY KEY(cust_stats_id)
   );
BEGIN EXECUTE IMMEDIATE 'DROP SEQUENCE kk_cust_stats_SEQ'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE SEQUENCE kk_cust_stats_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

-- Enable / Disable customer event functionality from application
DELETE FROM configuration WHERE configuration_key = 'ENABLE_CUSTOMER_EVENTS';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (configuration_seq.nextval, 'Enable Customer Event functionality', 'ENABLE_CUSTOMER_EVENTS', 'false', 'When set to true, the application inserts customer events. All event functionality is disabled when false.', '5', '9', 'choice(''true''=''true'',''false''=''false'')', sysdate);

-- Visibility of Customers - Customers are visible by default
ALTER TABLE customers ADD invisible NUMBER(10,0) DEFAULT 0 NOT NULL;

-- Virtual Customer 2 Panel
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval, 'kk_panel_customers_2', 'Customers 2', sysdate);

-- Add Panel access to all roles that can access the Customer panel - default to not allow access to invisible customers
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, custom1, custom1_desc, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, 0, 'Set to Access Invisible Customers', sysdate, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_customers' and p2.code='kk_panel_customers_2';

-- New Admin Payment Module API
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'callPaymentModule','', sysdate);

-----------------  v5.4.0.0

-- Delete the Rich Text selection configuration variable since no longer used
DELETE FROM configuration where configuration_key = 'RICH_TEXT_EDITOR';

-- Extend the size of the products_name field
ALTER TABLE products_description MODIFY products_name VARCHAR(255);

-- For the New Google Shopping Interface
DELETE FROM configuration WHERE configuration_key = 'GOOGLE_DATA_ACCOUNT_ID';
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Google Shopping Account Id', 'GOOGLE_DATA_ACCOUNT_ID', '', 'Account Id (obtain from Google) for populating Google Shopping with Product Information', '23', '3', now());

-- Move the two Google Base configs to the end
--UPDATE configuration set sort_order = 100 where configuration_key = 'GOOGLE_API_KEY';
--UPDATE configuration set sort_order = 101 where configuration_key = 'GOOGLE_DATA_LOCATION';

-- For defining the height of the Custom Panels
DELETE FROM configuration WHERE configuration_key = 'ADMIN_APP_CUSTOM_PANEL_HEIGHT';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (configuration_seq.nextval, 'Custom Panel Height', 'ADMIN_APP_CUSTOM_PANEL_HEIGHT', '500px', 'Custom Panel Height eg. 100% or 700px etc', '22', '20',  sysdate);

--Add tax code to tax_class table and order_product
ALTER TABLE tax_class ADD tax_code VARCHAR(64);
ALTER TABLE orders_products ADD tax_code VARCHAR(64);

--Add lifecycle_id to order table
ALTER TABLE orders ADD lifecycle_id VARCHAR(128);

-- Add custom fields to product to stores
ALTER TABLE kk_product_to_stores ADD custom1 varchar(128);
ALTER TABLE kk_product_to_stores ADD custom2 varchar(128);
ALTER TABLE kk_product_to_stores ADD custom3 varchar(128);

-- Add custom privileges for the Customer and CustomerForOrder panels - default to allow access to Reviews button
UPDATE kk_role_to_panel SET custom4=0, custom4_desc='If set reviews button is hidden' WHERE panel_id IN (SELECT panel_id FROM kk_panel where code='kk_panel_customers');
UPDATE kk_role_to_panel SET custom4=0, custom4_desc='If set reviews button is hidden' WHERE panel_id IN (SELECT panel_id FROM kk_panel where code='kk_panel_customerForOrder');
-- Virtual CustomerForOrder 2 Panel
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval, 'kk_panel_customerForOrder_2', 'Customer For Order 2', sysdate);

-- Add Panel access to all roles that can access the CustomerForOrders panel - default to not allow access to invisible customers
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, custom1, custom1_desc, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, 0, 'Set to Access Invisible Customers', sysdate, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_customerForOrder' and p2.code='kk_panel_customerForOrder_2';

-- Add custom privileges for the Customer2 and CustomerForOrder2 panels - default to allow access to Reviews button
UPDATE kk_role_to_panel SET custom2=0, custom2_desc='If set reviews button is hidden' WHERE panel_id IN (SELECT panel_id FROM kk_panel where code='kk_panel_customers_2');
UPDATE kk_role_to_panel SET custom2=0, custom2_desc='If set reviews button is hidden' WHERE panel_id IN (SELECT panel_id FROM kk_panel where code='kk_panel_customerForOrder_2');

-- Add custom privileges for the Customer and CustomerForOrder panels - default to allow access to login button
UPDATE kk_role_to_panel SET custom4=0, custom4_desc='If set login button is hidden' WHERE panel_id IN (SELECT panel_id FROM kk_panel where code='kk_panel_customers');
UPDATE kk_role_to_panel SET custom4=0, custom4_desc='If set login button is hidden' WHERE panel_id IN (SELECT panel_id FROM kk_panel where code='kk_panel_customerForOrder');

-- Add custom privileges for the Customer and CustomerForOrder panels - default to allow access to Addresses button
UPDATE kk_role_to_panel SET custom5=0, custom5_desc='If set addresses button is hidden' WHERE panel_id IN (SELECT panel_id FROM kk_panel where code='kk_panel_customers');
UPDATE kk_role_to_panel SET custom5=0, custom5_desc='If set addresses button is hidden' WHERE panel_id IN (SELECT panel_id FROM kk_panel where code='kk_panel_customerForOrder');

-- Add custom privileges for the CustomerOrders panel - default to allow access to Packing List and Invoice buttons
UPDATE kk_role_to_panel SET custom1=0, custom1_desc='If set packing list button not shown' WHERE panel_id IN (SELECT panel_id FROM kk_panel where code='kk_panel_customerOrders');
UPDATE kk_role_to_panel SET custom2=0, custom2_desc='If set invoice button not shown'      WHERE panel_id IN (SELECT panel_id FROM kk_panel where code='kk_panel_customerOrders');

-- Add custom privileges for the Promotions panel - default to allow access to Coupons and Gift Certificates buttons
UPDATE kk_role_to_panel SET custom1=0, custom1_desc='If set coupons button not shown'           WHERE panel_id IN (SELECT panel_id FROM kk_panel where code='kk_panel_promotions');
UPDATE kk_role_to_panel SET custom2=0, custom2_desc='If set gift certificates button not shown' WHERE panel_id IN (SELECT panel_id FROM kk_panel where code='kk_panel_promotions');

-- Add custom privileges for the Products panel - default to allow access to Reviews and Addresses buttons
UPDATE kk_role_to_panel SET custom1=0, custom1_desc='If set reviews button not shown'   WHERE panel_id IN (SELECT panel_id FROM kk_panel where code='kk_panel_products');
UPDATE kk_role_to_panel SET custom2=0, custom2_desc='If set addresses button not shown' WHERE panel_id IN (SELECT panel_id FROM kk_panel where code='kk_panel_products');

-- For defining the number of suggested search terms to show
DELETE FROM configuration WHERE configuration_key = 'MAX_NUM_SUGGESTED_SEARCH_ITEMS';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (configuration_seq.nextval, 'Suggested Search Items','MAX_NUM_SUGGESTED_SEARCH_ITEMS','10','Max number of suggested search items to display','3', '3','integer(0,null)', sysdate);

-- Table for bookable products
BEGIN EXECUTE IMMEDIATE 'DROP TABLE kk_bookable_prod'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE kk_bookable_prod (
  products_id NUMBER(10,0) NOT NULL,
  store_id VARCHAR2(64),
  start_date TIMESTAMP NOT NULL,
  end_date TIMESTAMP NOT NULL,
  max_num_bookings NUMBER(10,0) DEFAULT -1,
  bookings_made NUMBER(10,0) DEFAULT 0,
  monday VARCHAR2(128),
  tuesday VARCHAR2(128),
  wednesday VARCHAR2(128),
  thursday VARCHAR2(128),
  friday VARCHAR2(128),
  saturday VARCHAR2(128),
  sunday VARCHAR2(128),
  custom1 VARCHAR2(128),
  custom2 VARCHAR2(128),
  custom3 VARCHAR2(128),
  custom4 VARCHAR2(128),
  custom5 VARCHAR2(128),
  PRIMARY KEY(products_id)
);

-- Table for bookings
BEGIN EXECUTE IMMEDIATE 'DROP TABLE kk_booking'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE kk_booking (
  booking_id NUMBER(10,0) NOT NULL,
  store_id VARCHAR2(64),
  products_id NUMBER(10,0) NOT NULL,
  quantity NUMBER(10,0) DEFAULT 0,
  customers_id NUMBER(10,0) DEFAULT 0,
  orders_id NUMBER(10,0) DEFAULT 0,
  orders_products_id NUMBER(10,0) DEFAULT 0,
  firstname VARCHAR2(32),
  lastname VARCHAR2(32),
  custom1 VARCHAR2(128),
  custom2 VARCHAR2(128),
  custom3 VARCHAR2(128),
  date_added TIMESTAMP,
  PRIMARY KEY(booking_id)
);
BEGIN EXECUTE IMMEDIATE 'DROP SEQUENCE kk_booking_SEQ'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE SEQUENCE kk_booking_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;


-----------------  v5.5.0.0

-- New Bookings Panels
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval, 'kk_panel_bookingsForOrder', 'Bookings For Order', sysdate);
-- Add access to the Bookings Panel to all roles that can access the Orders panel
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, sysdate, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_orders' and p2.code='kk_panel_bookingsForOrder';

INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval, 'kk_panel_bookingsForProduct', 'Bookings For Product', sysdate);
-- Add access to the Bookings Panel to all roles that can access the Products panel
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, sysdate, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_products' and p2.code='kk_panel_bookingsForProduct';

INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval, 'kk_panel_bookingsForCustomer', 'Bookings For Customer', sysdate);
-- Add access to the Bookings Panel to all roles that can access the Customers panel
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, sysdate, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_customers' and p2.code='kk_panel_bookingsForCustomer';

-- Add active flag on countries table
ALTER TABLE countries ADD active int DEFAULT 1 NOT NULL;
UPDATE countries SET active = 1;

-- store address ids in order table
ALTER TABLE orders ADD billing_addr_id int default '-1';
ALTER TABLE orders ADD delivery_addr_id int default '-1';
ALTER TABLE orders ADD customer_addr_id int default '-1';

-- Table for catalogs
BEGIN EXECUTE IMMEDIATE 'DROP TABLE kk_catalog'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE kk_catalog (
  catalog_id NUMBER(10,0) NOT NULL,
  store_id VARCHAR2(64),
  cat_name VARCHAR2(32) NOT NULL,
  description VARCHAR2(255),
  use_cat_prices int,
  use_cat_quantities int,
  PRIMARY KEY(catalog_id)
);
BEGIN EXECUTE IMMEDIATE 'DROP SEQUENCE kk_catalog_SEQ'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE SEQUENCE kk_catalog_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

-- New Product Catalog Definition Panel
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval, 'kk_panel_catalogs', 'Product Catalog Definitions', sysdate);
-- Add access to the Bookings Panel to all roles that can access the Products panel
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, sysdate, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_products' and p2.code='kk_panel_catalogs';

-----------------  v5.6.0.0

-- New Other Modules Panel
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval, 'kk_panel_otherModules', 'Other Modules Configuration', sysdate);
-- Add access to the Other Modules Panel to all roles that can access the Payment Modules panel
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, sysdate, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_paymentModules' and p2.code='kk_panel_otherModules';

-- For defining the list of Other modules installed
DELETE FROM configuration WHERE configuration_key = 'MODULE_OTHERS_INSTALLED';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (configuration_seq.nextval, 'Installed Other Modules','MODULE_OTHERS_INSTALLED','','List of Other modules separated by a semi-colon.  Automatically updated.  No need to edit.','6', '0', sysdate);

-----------------  v5.7.0.0

-- Add custom fields to Order Total
ALTER TABLE orders_total ADD custom1 varchar(128);
ALTER TABLE orders_total ADD custom2 varchar(128);
ALTER TABLE orders_total ADD custom3 varchar(128);

-- Add creator field to order
ALTER TABLE orders ADD order_creator varchar(128);

-----------------  v5.7.5.0

-- Configuration variable to define how to format the URLs for SEO
DELETE FROM configuration WHERE configuration_key = 'SEO_URL_FORMAT';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (configuration_seq.nextval, 'How to format the URLs for SEO', 'SEO_URL_FORMAT', '2', 'Decide the format of the URLs for SEO', '1', '30', 'option(0=OFF,1=SEO Parameters,2=SEO Directory Structure)', sysdate);

-- Configuration variables for defining-store front base paths
DELETE FROM configuration WHERE configuration_key = 'STORE_FRONT_BASE';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (configuration_seq.nextval, 'Store-Front base','STORE_FRONT_BASE','/konakart','Base directory used in JSPs for store-front application','4', '12', sysdate);
DELETE FROM configuration WHERE configuration_key = 'STORE_FRONT_IMG_BASE';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (configuration_seq.nextval, 'Store-Front image base','STORE_FRONT_IMG_BASE','/konakart/images','Image base used in JSPs for store-front application','4', '13', sysdate);
DELETE FROM configuration WHERE configuration_key = 'STORE_FRONT_SCRIPT_BASE';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (configuration_seq.nextval, 'Store-Front script base','STORE_FRONT_SCRIPT_BASE','/konakart/script','Script base used in JSPs for store-front application','4', '14', sysdate);
DELETE FROM configuration WHERE configuration_key = 'STORE_FRONT_STYLE_BASE';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (configuration_seq.nextval, 'Store-Front style sheet base','STORE_FRONT_STYLE_BASE','/konakart/styles','Style sheet base used in JSPs for store-front application','4', '15', sysdate);

-- New doesProductExist Admin API
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'doesProductExist','', sysdate);

-- Extend the size of the categories_name field
ALTER TABLE categories_description MODIFY categories_name VARCHAR(255);

-----------------  v5.8.0.0

-- Extend the size of the products_name field
ALTER TABLE orders_products MODIFY products_name VARCHAR(255);

-- Table to facilitate SSO
BEGIN EXECUTE IMMEDIATE 'DROP TABLE kk_sso'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE kk_sso (
  kk_sso_id NUMBER(10,0) NOT NULL,
  secret_key VARCHAR2(255) NOT NULL,
  customers_id NUMBER(10,0) DEFAULT 0,
  sesskey VARCHAR2(32),
  custom1 VARCHAR2(128),
  custom2 VARCHAR2(128),
  custom3 VARCHAR2(128),
  date_added TIMESTAMP,
  PRIMARY KEY(kk_sso_id)
);
CREATE INDEX i_kk_sso_1 ON kk_sso (secret_key);
BEGIN EXECUTE IMMEDIATE 'DROP SEQUENCE kk_sso_SEQ'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE SEQUENCE kk_sso_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

-- Add sort order to the kk_category_to_tag_group table
ALTER TABLE kk_category_to_tag_group ADD sort_order int DEFAULT '0' NOT NULL;

-- Add facet number to the kk_cust_attr table
ALTER TABLE kk_cust_attr ADD facet_number int DEFAULT '0' NOT NULL;

-- Add facet number to the kk_tag_group table
ALTER TABLE kk_tag_group ADD facet_number int DEFAULT '0' NOT NULL;

-- Table for Miscellaneous Item Types
BEGIN EXECUTE IMMEDIATE 'DROP TABLE kk_misc_item_type'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE kk_misc_item_type (
  kk_misc_item_type_id NUMBER(10,0) NOT NULL,
  language_id NUMBER(10,0) NOT NULL,
  name VARCHAR2(128),
  description VARCHAR2(256),
  store_id VARCHAR2(64),
  date_added TIMESTAMP,
  PRIMARY KEY(kk_misc_item_type_id, language_id)
);

-- Table for Miscellaneous Item Type Associations
BEGIN EXECUTE IMMEDIATE 'DROP TABLE kk_misc_item'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE kk_misc_item (
  kk_misc_item_id NUMBER(10,0) NOT NULL,
  kk_obj_id NUMBER(10,0) NOT NULL,
  kk_obj_type_id NUMBER(10,0) NOT NULL,
  kk_misc_item_type_id NUMBER(10,0) NOT NULL,
  item_value VARCHAR2(512),
  custom1 VARCHAR2(128),
  custom2 VARCHAR2(128),
  custom3 VARCHAR2(128),
  store_id VARCHAR2(64),
  date_added TIMESTAMP,
  PRIMARY KEY(kk_misc_item_id)
);
BEGIN EXECUTE IMMEDIATE 'DROP SEQUENCE kk_misc_item_SEQ'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE SEQUENCE kk_misc_item_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

-- New Admin API calls
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'getProductCountPerProdAttrDesc','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'updateProductsUsingProdAttrDesc','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'updateProductsUsingTemplates','', sysdate);

-- New Miscellaneous Item Types Panel
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval, 'kk_panel_miscItemTypes', 'Miscellaneous Item Types', sysdate);
-- Add access to the Miscellaneous Item Types Panel to all roles that can access the Products panel
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, sysdate, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_products' and p2.code='kk_panel_miscItemTypes';

-- New Miscellaneous Items Panel
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval, 'kk_panel_miscItems', 'Miscellaneous Items', sysdate);
-- Add access to the Miscellaneous Items Panel to all roles that can access the Products panel
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, sysdate, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_products' and p2.code='kk_panel_miscItems';

-- New Miscellaneous Items For Categories Panel
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval, 'kk_panel_cat_miscItems', 'Miscellaneous Category Items', sysdate);
-- Add access to the Miscellaneous Items for Categories Panel to all roles that can access the Products panel
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, sysdate, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_products' and p2.code='kk_panel_cat_miscItems';

-- New Miscellaneous Items For Products Panel
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval, 'kk_panel_prod_miscItems', 'Miscellaneous Product Items', sysdate);
-- Add access to the Miscellaneous Items for Products Panel to all roles that can access the Products panel
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, sysdate, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_products' and p2.code='kk_panel_prod_miscItems';

-- New Admin API calls
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'insertMiscItemType','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'updateMiscItemType','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'deleteMiscItemType','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'getMiscItemTypes','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'insertMiscItems','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'updateMiscItems','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'deleteMiscItem','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'getMiscItems','', sysdate);

-- Demo data for Rich Text custom attribute
INSERT INTO kk_cust_attr (kk_cust_attr_id, name, msg_cat_key, attr_type, template, validation, set_function, date_added) VALUES (kk_cust_attr_SEQ.nextval, 'RichText', null, 0, null, null, 'RichText(8)', sysdate);

-- Install Digital Download Shipping Module
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (configuration_seq.nextval, 'Enable Digital Downloads', 'MODULE_SHIPPING_DD_STATUS', 'True', 'Set it to true if you sell digital downloads', '6', '0', 'choice(''true''=''true'',''false''=''false'')', sysdate);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (configuration_seq.nextval, 'Sort Order', 'MODULE_SHIPPING_DD_SORT_ORDER', '0', 'Sort order of display.', '6', '0', sysdate);
UPDATE configuration set configuration_value = 'DigitalDownload;flat.php' where configuration_key = 'MODULE_SHIPPING_INSTALLED';

-----------------  v6.0.0.0

-- Add new attributes to ipn_history table
ALTER TABLE ipn_history ADD transaction_type varchar(128);
ALTER TABLE ipn_history ADD transaction_amount decimal(15,4);
ALTER TABLE ipn_history ADD custom1 varchar(128);
ALTER TABLE ipn_history ADD custom2 varchar(128);
ALTER TABLE ipn_history ADD custom3 varchar(128);
ALTER TABLE ipn_history ADD custom4 varchar(128);
ALTER TABLE ipn_history ADD custom1Dec decimal(15,4);
ALTER TABLE ipn_history ADD custom2Dec decimal(15,4);

-- Extend the size of the product option and option value fields
ALTER TABLE products_options MODIFY products_options_name VARCHAR(64);
ALTER TABLE orders_products_attributes MODIFY products_options VARCHAR(64);
ALTER TABLE orders_products_attributes MODIFY products_options_values VARCHAR(64);

-- Add a new product option type
ALTER TABLE products_options ADD option_type int DEFAULT '0' NOT NULL;
ALTER TABLE customers_basket_attrs ADD attr_type int DEFAULT '0' NOT NULL;
ALTER TABLE customers_basket_attrs ADD attr_quantity int DEFAULT '0';
ALTER TABLE customers_basket_attrs ADD customers_basket_id int DEFAULT '0' NOT NULL;
ALTER TABLE orders_products_attributes ADD attr_type int DEFAULT '0' NOT NULL;
ALTER TABLE orders_products_attributes ADD attr_quantity int DEFAULT '0';

-----------------  v6.1.0.0

-- Product attributes to manage catalog maintenance workflow
ALTER TABLE products ADD product_uuid varchar(128) DEFAULT NULL;
ALTER TABLE products ADD source_last_modified TIMESTAMP DEFAULT NULL;
CREATE INDEX i_product_uuid_products ON products (product_uuid);

-- New Admin API calls
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'copyProductToStore','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'getProductsToSynchronize','', sysdate);

-- New Synchronize Products Panel
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval, 'kk_panel_syncProducts', 'Synchronize Products', sysdate);
-- Add access to the Synchronize Products Panel to all roles that can access the Products panel
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, sysdate, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_products' and p2.code='kk_panel_syncProducts';

-- Add attribute to allow display only languages that are not used to define language variants for products etc
ALTER TABLE languages ADD display_only int DEFAULT 0;
UPDATE languages SET display_only = 0;

-- New Admin API call
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'getLanguageForLocale','', sysdate);

-----------------  v6.2.0.0

-- New View Logs Panel
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval, 'kk_panel_viewLogs', 'View Logs', sysdate);
-- Add access to the View Logs Panel to all roles that can access the Configuration Files panel
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, custom1, custom1_desc, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 0, 0, 'Set to hide the View button', sysdate, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_configFiles' and p2.code='kk_panel_viewLogs';

-- Modify tag type of BIRTH_DATE to AGE_TYPE
DELETE FROM kk_customer_tag WHERE name ='BIRTH_DATE';
INSERT INTO kk_customer_tag (kk_customer_tag_id, name, description, tag_type, max_ints, date_added) VALUES (kk_customer_tag_seq.nextval,'BIRTH_DATE', 'Age of Customer', 6, 5, sysdate);
-- Add last login date tag
DELETE FROM kk_customer_tag WHERE name ='LOGIN_DATE';
INSERT INTO kk_customer_tag (kk_customer_tag_id, name, description, tag_type, max_ints, date_added) VALUES (kk_customer_tag_seq.nextval,'LOGIN_DATE', 'Time of Last Login', 6, 5, sysdate);

-- Allow null values for entry_firstname and entry_lastname on addresses (useful for Manufacturer addresses particularly)
ALTER TABLE address_book MODIFY entry_firstname VARCHAR(32) NULL;
ALTER TABLE address_book MODIFY entry_lastname VARCHAR(32) NULL;

-- Table for KonaKart Config Values
BEGIN EXECUTE IMMEDIATE 'DROP TABLE kk_config'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE kk_config (
  kk_config_id NUMBER(10,0) NOT NULL,
  kk_config_key VARCHAR2(16),
  kk_config_value VARCHAR2(256),
  date_added TIMESTAMP,
  PRIMARY KEY(kk_config_id)
);
BEGIN EXECUTE IMMEDIATE 'DROP SEQUENCE kk_config_SEQ'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE SEQUENCE kk_config_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

-- New Admin API call
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'getConfigData','', sysdate);

-- Customer from Reviews Panel
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval, 'kk_panel_customerForReview', 'Customer From Reviews', sysdate);

-- Add access to the Customer from Reviews Panel to all roles that can access the Customers panel
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, sysdate, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_customers' and p2.code='kk_panel_customerForReview';
-- Add "Updated By Customer Id" to the Orders Status History table to record who updated the order
ALTER TABLE orders_status_history ADD updated_by_id int DEFAULT 0;

-- New Admin API call
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'updateOrder','', sysdate);

-----------------  v6.3.0.0

-- New Admin API call - to get the version of the KonaKart Admin Engine
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'getKonaKartAdminVersion','', sysdate);

-- Add affiliate id field to order
ALTER TABLE orders ADD affiliate_id varchar(128);

-- For specifying whether or not to return configuration parameters in API calls
ALTER TABLE configuration ADD return_by_api NUMBER(10,0) DEFAULT 0 NOT NULL;

-- Set some defaults by configuration_group
UPDATE configuration set return_by_api = 1 where configuration_group_id in (1, 2, 3, 4, 5, 11, 19);
UPDATE configuration set return_by_api = 1 where configuration_key in ('ADMIN_CURRENCY_DECIMAL_PLACES', 'CLIENT_CONFIG_CACHE_CHECK_FLAG', 'DEFAULT_CURRENCY', 'DEFAULT_LANGUAGE');
UPDATE configuration set return_by_api = 1 where configuration_key in ('ALLOW_BASKET_PRICE', 'DEFAULT_REVIEW_STATE', 'ENABLE_ANALYTICS', 'ENABLE_SSL', 'SSL_BASE_URL');
UPDATE configuration set return_by_api = 1 where configuration_key in ('ENABLE_PDF_INVOICE_DOWNLOAD', 'ENABLE_REWARD_POINTS', 'SSL_PORT_NUMBER', 'STANDARD_PORT_NUMBER');
UPDATE configuration set return_by_api = 1 where configuration_key in ('SEND_EMAILS', 'SEND_ORDER_CONF_EMAIL', 'USE_DB_FOR_MESSAGES');
UPDATE configuration set return_by_api = 1 where configuration_key in ('STOCK_CHECK', 'STOCK_ALLOW_CHECKOUT', 'ALLOW_MULTIPLE_BASKET_ENTRIES');
UPDATE configuration set return_by_api = 1 where configuration_key in ('USE_SOLR_SEARCH');

-- Extend the size of the city columns
ALTER TABLE address_book MODIFY entry_city VARCHAR(64) ;
ALTER TABLE orders MODIFY customers_city VARCHAR(64) ;
ALTER TABLE orders MODIFY delivery_city VARCHAR(64) ;
ALTER TABLE orders MODIFY billing_city VARCHAR(64) ;
ALTER TABLE kk_wishlist MODIFY customers_city VARCHAR(64);

-- Regex for SOLR suggested search
DELETE FROM configuration WHERE configuration_key = 'SOLR_TERMS_PRE_REGEX';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, return_by_api) VALUES (configuration_seq.nextval, 'Suggested Search prepend regex','SOLR_TERMS_PRE_REGEX','.*','Regex prepended to search string used for searching within SOLR term','24', '3', sysdate, '0');
DELETE FROM configuration WHERE configuration_key = 'SOLR_TERMS_POST_REGEX';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, return_by_api) VALUES (configuration_seq.nextval, 'Suggested Search append regex','SOLR_TERMS_POST_REGEX','.*','Regex appended to search string used for searching within SOLR term','24', '4', sysdate, '0');
DELETE FROM configuration WHERE configuration_key = 'SOLR_DELETE_ON_COMMIT';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api) VALUES (configuration_seq.nextval, 'Delete from index on commit','SOLR_DELETE_ON_COMMIT','true','On commit, delete from index products marked for deletion','24', '5', 'choice(''true''=''true'',''false''=''false'')', sysdate, '0');

-----------------  v6.4.0.0

-- Set some defaults by configuration_group
UPDATE configuration set return_by_api = 1 where configuration_group_id in (26);

-- Return the STOCK_REORDER_LEVEL configuration variable
UPDATE configuration set return_by_api = 1 where configuration_key in ('STOCK_REORDER_LEVEL');

-- Admin API calls
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'editProductWithOptions','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'insertProductWithOptions','', sysdate);

-- Save payment module sub-code information with the order
ALTER TABLE orders ADD payment_module_subcode varchar(64);

-- Add number of reviews to product table
ALTER TABLE products ADD number_reviews int DEFAULT '0';

-- Change the email address for John Doe
UPDATE customers SET customers_email_address = 'doe@konakart.com' where customers_email_address = 'root@localhost';

-- Change previous occurrences of root@localhost
UPDATE configuration SET configuration_value = 'admin@konakart.com' where configuration_value = 'root@localhost' and configuration_key = 'STORE_OWNER_EMAIL_ADDRESS';
UPDATE configuration SET configuration_value = 'admin@konakart.com' where configuration_value = 'KonaKart <root@localhost>' and configuration_key = 'EMAIL_FROM';

-----------------  v6.5.0.0

-- New Canon Printer

INSERT INTO products (products_id, products_model, products_image, products_price, products_weight, products_status, products_tax_class_id, manufacturers_id, products_quantity, products_ordered, products_date_added, products_date_available) VALUES (products_seq.nextval, 'LBP7680CX', 'canon/lbp7680cx.jpg', 309.99, 44.00, 1, 1, 6, 100, 0, sysdate, sysdate);

INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (30, 1, 'Canon I-SENSYS LBP7680CX Printer','- Print Speed: Up to 20 ppm<br>- Max Resolution ( Colour ): 9600 dpi x 600 dpi<br>- Total Media Capacity: 300 sheets<br>- Interface: USB, Ethernet','http://www.canon.co.uk/For_Home/Product_Finder/Printers/Laser/',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (30, 2, 'Canon I-SENSYS LBP7680CX Drucker','- Drucker Speed: Up to 20 ppm<br>- Max Resolution ( Colour ): 9600 dpi x 600 dpi<br>- Total Media Capacity: 300 sheets<br>- Interface: USB, Ethernet','http://www.canon.co.uk/For_Home/Product_Finder/Printers/Laser/',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (30, 3, 'Canon I-SENSYS LBP7680CX Impresora','- Impresora Speed: Up to 20 ppm<br>- Max Resolution ( Colour ): 9600 dpi x 600 dpi<br>- Total Media Capacity: 300 sheets<br>- Interface: USB, Ethernet','http://www.canon.co.uk/For_Home/Product_Finder/Printers/Laser/',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (30, 4, 'Canon I-SENSYS LBP7680CX Impressora','- Impressora Speed: Up to 20 ppm<br>- Max Resolution ( Colour ): 9600 dpi x 600 dpi<br>- Total Media Capacity: 300 sheets<br>- Interface: USB, Ethernet','http://www.canon.co.uk/For_Home/Product_Finder/Printers/Laser/',0);

INSERT INTO products_to_categories (products_id, categories_id) VALUES (30,5);

-- Update Laserjet Printer

UPDATE products SET products_price=65.00, products_image='hewlett_packard/hp5510e.jpg' WHERE products_model='HPLJ1100XI';
UPDATE products_description set products_name='HP Photosmart 5510 e', products_url='http://www.shopping.hp.com/en_US/home-office/-/products/Printers/Printers', products_description='HP Photosmart 5510 e-All-in-One with Photo value pack<br>(English Version) Print, scan, copy and browse the Web with one convenient device<br>Enjoy speeds of up to 11 ppm black, 7.5 colour<br>Large 80-sheet input tray, 15-sheet output tray<br>Share with and print from multiple PCs via the integrated wireless' WHERE products_name='Hewlett Packard LaserJet 1100Xi' AND language_id=1;
UPDATE products_description set products_name='HP Photosmart 5510 e', products_url='http://www.shopping.hp.com/en_US/home-office/-/products/Printers/Printers', products_description='HP Photosmart 5510 e-All-in-One with Photo value pack<br>(Deutsch Version) Print, scan, copy and browse the Web with one convenient device<br>Enjoy speeds of up to 11 ppm black, 7.5 colour<br>Large 80-sheet input tray, 15-sheet output tray<br>Share with and print from multiple PCs via the integrated wireless' WHERE products_name='Hewlett Packard LaserJet 1100Xi' AND language_id=2;
UPDATE products_description set products_name='HP Photosmart 5510 e', products_url='http://www.shopping.hp.com/en_US/home-office/-/products/Printers/Printers', products_description='HP Photosmart 5510 e-All-in-One with Photo value pack<br>(Versión en Español) Print, scan, copy and browse the Web with one convenient device<br>Enjoy speeds of up to 11 ppm black, 7.5 colour<br>Large 80-sheet input tray, 15-sheet output tray<br>Share with and print from multiple PCs via the integrated wireless' WHERE products_name='Hewlett Packard LaserJet 1100Xi' AND language_id=3;
UPDATE products_description set products_name='HP Photosmart 5510 e', products_url='http://www.shopping.hp.com/en_US/home-office/-/products/Printers/Printers', products_description='HP Photosmart 5510 e-All-in-One with Photo value pack<br>(Versão em Português) Print, scan, copy and browse the Web with one convenient device<br>Enjoy speeds of up to 11 ppm black, 7.5 colour<br>Large 80-sheet input tray, 15-sheet output tray<br>Share with and print from multiple PCs via the integrated wireless' WHERE products_name='Hewlett Packard LaserJet 1100Xi' AND language_id=4;

-- New Logitech Keyboard

INSERT INTO products (products_id, products_model, products_image, products_price, products_weight, products_status, products_tax_class_id, manufacturers_id, products_quantity, products_ordered, products_date_added, products_date_available) VALUES (products_seq.nextval, 'LOGITECHIK', 'logitech/p800-0148872.jpg', 75.99, 6.00, 1, 1, 5, 100, 0, sysdate, sysdate);

INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (31, 1, 'Logitech Illuminated Keyboard','- Ultra Thin: 9.3 mm profile and transparent frame<br>- Bright, laser-etched, backlighted keys<br>- Sleek, minimalist design<br>- One-touch multimedia controls','http://www.logitech.com/en-gb/keyboards',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (31, 2, '(DE) Logitech Illuminated Keyboard','- Ultra Thin: 9.3 mm profile and transparent frame<br>- Bright, laser-etched, backlighted keys<br>- Sleek, minimalist design<br>- One-touch multimedia controls','http://www.logitech.com/en-gb/keyboards',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (31, 3, '(ES) Logitech Illuminated Keyboard','- Ultra Thin: 9.3 mm profile and transparent frame<br>- Bright, laser-etched, backlighted keys<br>- Sleek, minimalist design<br>- One-touch multimedia controls','http://www.logitech.com/en-gb/keyboards',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (31, 4, '(PT) Logitech Illuminated Keyboard','- Ultra Thin: 9.3 mm profile and transparent frame<br>- Bright, laser-etched, backlighted keys<br>- Sleek, minimalist design<br>- One-touch multimedia controls','http://www.logitech.com/en-gb/keyboards',0);

INSERT INTO products_to_categories (products_id, categories_id) VALUES (31,8);

-- Replace The Replacement Killers with Hunger Games - new Lionsgate Manufacturer

INSERT INTO manufacturers (manufacturers_id, manufacturers_name, manufacturers_image, date_added, last_modified) VALUES (manufacturers_seq.nextval,'Lionsgate','manufacturer/lionsgate.jpg', sysdate, null);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (11, 1, 'http://www.lionsgate.com', 0, null);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (11, 2, 'http://www.lionsgate.com', 0, null);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (11, 3, 'http://www.lionsgate.com', 0, null);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (11, 4, 'http://www.lionsgate.com', 0, null);
UPDATE products SET products_price=24.99, manufacturers_id=11 WHERE products_model='DVD-RPMK';
UPDATE products_description SET products_name='The Hunger Games', products_url='http://www.scholastic.com/thehungergames/' WHERE products_id=4;

-- Replace Courage Under Fire with Titanic

UPDATE products_description set products_name='Titanic', products_url='http://www.titanicmovie.com/' WHERE products_id=16;

-- Replace Beloved with Dark Knight

UPDATE products_description SET products_name='The Dark Knight', products_url='http://thedarkknight.warnerbros.com' WHERE products_id=20;

-- Replace Fire Down Below with Harry Potter

UPDATE products_description SET products_name='Harry Potter - The Goblet of Fire', products_url='http://harrypotter.warnerbros.co.uk/gobletoffire/master/' WHERE products_id=11;

-- For new Struts2 storefront

-- Maximum number of special price products to cache in client engine
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, return_by_api, date_added) VALUES (configuration_seq.nextval, 'Special Price Products', 'MAX_DISPLAY_SPECIALS', '9', 'Maximum number of special price products to cache', '3', '5', 'integer(0,null)', '1', sysdate);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, return_by_api, date_added) VALUES (configuration_seq.nextval, 'Stock warn level', 'STOCK_WARN_LEVEL', '5', 'Warn customer when stock reaches this level', '9', '5', 'integer(null,null)', '1', sysdate);

-- Modify some configuration variables
UPDATE configuration SET configuration_value = '10', configuration_description = 'Maximum number of latest products to cache' WHERE configuration_key = 'MAX_DISPLAY_NEW_PRODUCTS';
UPDATE configuration SET configuration_value = '15' WHERE configuration_key = 'MAX_DISPLAY_MANUFACTURERS_IN_A_LIST';
UPDATE configuration SET configuration_title='KonaKart cache refresh check interval', configuration_description = 'Interval in seconds for checking to see whether to refresh the KonaKart caches' WHERE configuration_key = 'CLIENT_CONFIG_CACHE_CHECK_SECS';
UPDATE configuration SET configuration_description='This allows checkout without registration' WHERE configuration_key = 'ALLOW_CHECKOUT_WITHOUT_REGISTRATION';

-- Add number of reviews to Something about mary
UPDATE products SET number_reviews = 1 WHERE products_id = 19 AND products_model = 'DVD-TSAB';

-- Delete some config variables
DELETE FROM configuration WHERE configuration_key = 'MAX_RANDOM_SELECT_NEW';
DELETE FROM configuration WHERE configuration_key = 'MAX_RANDOM_SELECT_SPECIALS';
DELETE FROM configuration WHERE configuration_key = 'MAX_RANDOM_SELECT_REVIEWS';
DELETE FROM configuration WHERE configuration_key = 'MAX_DISPLAY_PRODUCTS_IN_ORDER_HISTORY_BOX';
DELETE FROM configuration WHERE configuration_key = 'MAX_DISPLAY_CATEGORIES_PER_ROW';
DELETE FROM configuration WHERE configuration_key = 'HEADING_IMAGE_WIDTH';
DELETE FROM configuration WHERE configuration_key = 'HEADING_IMAGE_HEIGHT';
DELETE FROM configuration WHERE configuration_key = 'SUBCATEGORY_IMAGE_WIDTH';
DELETE FROM configuration WHERE configuration_key = 'SUBCATEGORY_IMAGE_HEIGHT';
DELETE FROM configuration WHERE configuration_key = 'ENTRY_DOB_MIN_LENGTH';
DELETE FROM configuration WHERE configuration_key = 'ENTRY_EMAIL_ADDRESS_MIN_LENGTH';
DELETE FROM configuration WHERE configuration_key = 'MAX_DISPLAY_BESTSELLERS';
DELETE FROM configuration WHERE configuration_key = 'CLIENT_CACHE_UPDATE_SECS';
DELETE FROM configuration WHERE configuration_key = 'ONE_PAGE_CHECKOUT';
DELETE FROM configuration WHERE configuration_key = 'SMALL_IMAGE_WIDTH';
DELETE FROM configuration WHERE configuration_key = 'SMALL_IMAGE_HEIGHT';
DELETE FROM configuration WHERE configuration_key = 'MAX_DISPLAY_MANUFACTURER_NAME_LEN';

-- Add data to set up demo for faceted search using Solr. Only for struts2 store-front.
INSERT INTO kk_cust_attr (kk_cust_attr_id, name, msg_cat_key, attr_type, template, validation, set_function, facet_number, date_added) VALUES (kk_cust_attr_SEQ.nextval, 'DVD Format', null, 0, null, null, 'option(facet.blu.ray=Blu-ray,facet.hd.dvd=HD-DVD)' ,1, sysdate);
INSERT INTO kk_cust_attr (kk_cust_attr_id, name, msg_cat_key, attr_type, template, validation, set_function, facet_number, date_added) VALUES (kk_cust_attr_SEQ.nextval, 'Movie Ratings', null, 0, null, null, 'option(facet.mpaa.g=General Audience: G,facet.mpaa.pg=Parental Guidance: PG,facet.mpaa.pg.13=Parents Cautioned: PG-13,facet.mpaa.r=Restricted: R,facet.mpaa.nc.17=Adults Only: NC-17)',2, sysdate);
INSERT INTO kk_cust_attr_tmpl (kk_cust_attr_tmpl_id, name, description, date_added) VALUES (kk_cust_attr_tmpl_SEQ.nextval, 'Movie Template', 'Template for DVD Movies', sysdate);
INSERT INTO kk_tmpl_to_cust_attr (kk_cust_attr_tmpl_id, kk_cust_attr_id, sort_order) VALUES (1, 11, 0);
INSERT INTO kk_tmpl_to_cust_attr (kk_cust_attr_tmpl_id, kk_cust_attr_id, sort_order) VALUES (1, 12, 1);
UPDATE products SET cust_attr_tmpl_id = 1, custom_attrs='<kk_d><kk_a><kk_v><![CDATA[facet.blu.ray]]></kk_v><kk_ty>0</kk_ty><kk_n><![CDATA[DVD Format]]></kk_n><kk_k><![CDATA[facet.dvd.format]]></kk_k><kk_f>1</kk_f></kk_a><kk_a><kk_v><![CDATA[facet.mpaa.g]]></kk_v><kk_ty>0</kk_ty><kk_n><![CDATA[Movie Ratings]]></kk_n><kk_k><![CDATA[facet.mpaa.movie.ratings]]></kk_k><kk_f>2</kk_f></kk_a></kk_d>' WHERE products_id = 4;
UPDATE products SET cust_attr_tmpl_id = 1, custom_attrs='<kk_d><kk_a><kk_v><![CDATA[facet.blu.ray]]></kk_v><kk_ty>0</kk_ty><kk_n><![CDATA[DVD Format]]></kk_n><kk_k><![CDATA[facet.dvd.format]]></kk_k><kk_f>1</kk_f></kk_a><kk_a><kk_v><![CDATA[facet.mpaa.g]]></kk_v><kk_ty>0</kk_ty><kk_n><![CDATA[Movie Ratings]]></kk_n><kk_k><![CDATA[facet.mpaa.movie.ratings]]></kk_k><kk_f>2</kk_f></kk_a></kk_d>' WHERE products_id = 6;
UPDATE products SET cust_attr_tmpl_id = 1, custom_attrs='<kk_d><kk_a><kk_v><![CDATA[facet.blu.ray]]></kk_v><kk_ty>0</kk_ty><kk_n><![CDATA[DVD Format]]></kk_n><kk_k><![CDATA[facet.dvd.format]]></kk_k><kk_f>1</kk_f></kk_a><kk_a><kk_v><![CDATA[facet.mpaa.pg]]></kk_v><kk_ty>0</kk_ty><kk_n><![CDATA[Movie Ratings]]></kk_n><kk_k><![CDATA[facet.mpaa.movie.ratings]]></kk_k><kk_f>2</kk_f></kk_a></kk_d>' WHERE products_id = 9;
UPDATE products SET cust_attr_tmpl_id = 1, custom_attrs='<kk_d><kk_a><kk_v><![CDATA[facet.blu.ray]]></kk_v><kk_ty>0</kk_ty><kk_n><![CDATA[DVD Format]]></kk_n><kk_k><![CDATA[facet.dvd.format]]></kk_k><kk_f>1</kk_f></kk_a><kk_a><kk_v><![CDATA[facet.mpaa.pg]]></kk_v><kk_ty>0</kk_ty><kk_n><![CDATA[Movie Ratings]]></kk_n><kk_k><![CDATA[facet.mpaa.movie.ratings]]></kk_k><kk_f>2</kk_f></kk_a></kk_d>' WHERE products_id = 10;
UPDATE products SET cust_attr_tmpl_id = 1, custom_attrs='<kk_d><kk_a><kk_v><![CDATA[facet.hd.dvd]]></kk_v><kk_ty>0</kk_ty><kk_n><![CDATA[DVD Format]]></kk_n><kk_k><![CDATA[facet.dvd.format]]></kk_k><kk_f>1</kk_f></kk_a><kk_a><kk_v><![CDATA[facet.mpaa.pg.13]]></kk_v><kk_ty>0</kk_ty><kk_n><![CDATA[Movie Ratings]]></kk_n><kk_k><![CDATA[facet.mpaa.movie.ratings]]></kk_k><kk_f>2</kk_f></kk_a></kk_d>' WHERE products_id = 11;
UPDATE products SET cust_attr_tmpl_id = 1, custom_attrs='<kk_d><kk_a><kk_v><![CDATA[facet.hd.dvd]]></kk_v><kk_ty>0</kk_ty><kk_n><![CDATA[DVD Format]]></kk_n><kk_k><![CDATA[facet.dvd.format]]></kk_k><kk_f>1</kk_f></kk_a><kk_a><kk_v><![CDATA[facet.mpaa.pg.13]]></kk_v><kk_ty>0</kk_ty><kk_n><![CDATA[Movie Ratings]]></kk_n><kk_k><![CDATA[facet.mpaa.movie.ratings]]></kk_k><kk_f>2</kk_f></kk_a></kk_d>' WHERE products_id = 12;
UPDATE products SET cust_attr_tmpl_id = 1, custom_attrs='<kk_d><kk_a><kk_v><![CDATA[facet.hd.dvd]]></kk_v><kk_ty>0</kk_ty><kk_n><![CDATA[DVD Format]]></kk_n><kk_k><![CDATA[facet.dvd.format]]></kk_k><kk_f>1</kk_f></kk_a><kk_a><kk_v><![CDATA[facet.mpaa.r]]></kk_v><kk_ty>0</kk_ty><kk_n><![CDATA[Movie Ratings]]></kk_n><kk_k><![CDATA[facet.mpaa.movie.ratings]]></kk_k><kk_f>2</kk_f></kk_a></kk_d>' WHERE products_id = 13;
UPDATE products SET cust_attr_tmpl_id = 1, custom_attrs='<kk_d><kk_a><kk_v><![CDATA[facet.hd.dvd]]></kk_v><kk_ty>0</kk_ty><kk_n><![CDATA[DVD Format]]></kk_n><kk_k><![CDATA[facet.dvd.format]]></kk_k><kk_f>1</kk_f></kk_a><kk_a><kk_v><![CDATA[facet.mpaa.r]]></kk_v><kk_ty>0</kk_ty><kk_n><![CDATA[Movie Ratings]]></kk_n><kk_k><![CDATA[facet.mpaa.movie.ratings]]></kk_k><kk_f>2</kk_f></kk_a></kk_d>' WHERE products_id = 17;
UPDATE products SET cust_attr_tmpl_id = 1, custom_attrs='<kk_d><kk_a><kk_v><![CDATA[facet.hd.dvd]]></kk_v><kk_ty>0</kk_ty><kk_n><![CDATA[DVD Format]]></kk_n><kk_k><![CDATA[facet.dvd.format]]></kk_k><kk_f>1</kk_f></kk_a><kk_a><kk_v><![CDATA[facet.mpaa.nc.17]]></kk_v><kk_ty>0</kk_ty><kk_n><![CDATA[Movie Ratings]]></kk_n><kk_k><![CDATA[facet.mpaa.movie.ratings]]></kk_k><kk_f>2</kk_f></kk_a></kk_d>' WHERE products_id = 18;
UPDATE kk_tag_group SET facet_number = 1 where tag_group_id = 2;
UPDATE kk_tag_group SET facet_number = 2 where tag_group_id = 1;

-- Zone update
UPDATE zones SET zone_code='NL', zone_name='Newfoundland and Labrador' where zone_code='NF' and zone_name='Newfoundland' and zone_country_id in (select countries_id from countries WHERE countries_name='Canada');

-- Address book entry updates
UPDATE configuration SET configuration_value = '10' WHERE configuration_key = 'MAX_ADDRESS_BOOK_ENTRIES';

-- Solr faceted search
DELETE FROM configuration WHERE configuration_key = 'SOLR_DYNAMIC_FACETS';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api) VALUES (configuration_seq.nextval, 'Use Solr dynamic facets','SOLR_DYNAMIC_FACETS','false','When true, the displayed facets are valid for only the products returned by the search rather than for all the available products.','24', '6', 'choice(''true''=''true'',''false''=''false'')', sysdate, '1');
DELETE FROM configuration WHERE configuration_key = 'PRICE_FACETS_SLIDER';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api) VALUES (configuration_seq.nextval, 'Use Slider for price filter','PRICE_FACETS_SLIDER','true','When false, price facets are displayed instead of a slider for filtering a result set by price.','1', '31', 'choice(''true''=''true'',''false''=''false'')', sysdate, '1');

-- Rename manufacturer images

UPDATE manufacturers SET manufacturers_image = 'manufacturer/matrox.gif'          WHERE manufacturers_image = 'manufacturer_matrox.gif';
UPDATE manufacturers SET manufacturers_image = 'manufacturer/microsoft.gif'       WHERE manufacturers_image = 'manufacturer_microsoft.gif';
UPDATE manufacturers SET manufacturers_image = 'manufacturer/warner.gif'          WHERE manufacturers_image = 'manufacturer_warner.gif';
UPDATE manufacturers SET manufacturers_image = 'manufacturer/fox.gif'             WHERE manufacturers_image = 'manufacturer_fox.gif';
UPDATE manufacturers SET manufacturers_image = 'manufacturer/logitech.gif'        WHERE manufacturers_image = 'manufacturer_logitech.gif';
UPDATE manufacturers SET manufacturers_image = 'manufacturer/canon.gif'           WHERE manufacturers_image = 'manufacturer_canon.gif';
UPDATE manufacturers SET manufacturers_image = 'manufacturer/sierra.gif'          WHERE manufacturers_image = 'manufacturer_sierra.gif';
UPDATE manufacturers SET manufacturers_image = 'manufacturer/gt_interactive.gif'  WHERE manufacturers_image = 'manufacturer_gt_interactive.gif';
UPDATE manufacturers SET manufacturers_image = 'manufacturer/hewlett_packard.gif' WHERE manufacturers_image = 'manufacturer_hewlett_packard.gif';
UPDATE manufacturers SET manufacturers_image = 'manufacturer/konakart.jpg'        WHERE manufacturers_image = 'konakart_tree_logo_60x60.jpg';

-- Change Name of Software Catgeory to Games

UPDATE categories set categories_image = 'no-image.png' where categories_id = 2;
UPDATE categories_description set categories_name = 'Games' where categories_id = 2 and language_id = 1;
UPDATE categories_description set categories_name = 'Games' where categories_id = 2 and language_id = 2;
UPDATE categories_description set categories_name = 'Juegos' where categories_id = 2 and language_id = 3;
UPDATE categories_description set categories_name = 'Jogos' where categories_id = 2 and language_id = 4;

-- Change Name of Hardware Catgeory to Computer Peripherals

UPDATE categories_description set categories_name = 'Computer Peripherals' where categories_id = 1 and language_id = 1;
UPDATE categories_description set categories_name = 'Computer Peripherals' where categories_id = 1 and language_id = 2;
UPDATE categories_description set categories_name = 'Periféricos' where categories_id = 1 and language_id = 3;
UPDATE categories_description set categories_name = 'Periféricos' where categories_id = 1 and language_id = 4;

-- New Software Catgeory

INSERT INTO categories (categories_id, categories_image, parent_id, sort_order, date_added, last_modified) VALUES (categories_seq.nextval, 'no-image.png', '0', '3', sysdate, null);
INSERT INTO categories_description (categories_id, language_id, categories_name) VALUES (22, 1, 'Software');
INSERT INTO categories_description (categories_id, language_id, categories_name) VALUES (22, 2, 'Software');
INSERT INTO categories_description (categories_id, language_id, categories_name) VALUES (22, 3, 'Software');
INSERT INTO categories_description (categories_id, language_id, categories_name) VALUES (22, 4, 'Software');

-- New Electronics Category

INSERT INTO categories (categories_id, categories_image, parent_id, sort_order, date_added, last_modified) VALUES (categories_seq.nextval, 'no-image.png', '0', '3', sysdate, null);
INSERT INTO categories_description (categories_id, language_id, categories_name) VALUES (23, 1, 'Electronics');
INSERT INTO categories_description (categories_id, language_id, categories_name) VALUES (23, 2, 'Elektronik');
INSERT INTO categories_description (categories_id, language_id, categories_name) VALUES (23, 3, 'Electrónica');
INSERT INTO categories_description (categories_id, language_id, categories_name) VALUES (23, 4, 'Eletrônica');

-- New Home & Garden Category

INSERT INTO categories (categories_id, categories_image, parent_id, sort_order, date_added, last_modified) VALUES (categories_seq.nextval, 'no-image.png', '0', '3', sysdate, null);
INSERT INTO categories_description (categories_id, language_id, categories_name) VALUES (24, 1, 'Home ' || chr(38) || ' Garden');
INSERT INTO categories_description (categories_id, language_id, categories_name) VALUES (24, 2, 'Home ' || chr(38) || ' Garden');
INSERT INTO categories_description (categories_id, language_id, categories_name) VALUES (24, 3, 'Casa y Jardín');
INSERT INTO categories_description (categories_id, language_id, categories_name) VALUES (24, 4, 'Casa e Jardim');

-- New Cameras Sub-Category

INSERT INTO categories (categories_id, categories_image, parent_id, sort_order, date_added, last_modified) VALUES (categories_seq.nextval, 'no-image.png', 23, 5, sysdate, null);
INSERT INTO categories_description (categories_id, language_id, categories_name) VALUES (25, 1, 'Cameras');
INSERT INTO categories_description (categories_id, language_id, categories_name) VALUES (25, 2, 'Cameras');
INSERT INTO categories_description (categories_id, language_id, categories_name) VALUES (25, 3, 'Cameras');
INSERT INTO categories_description (categories_id, language_id, categories_name) VALUES (25, 4, 'Cameras');

-- New Tablets Sub-Category

INSERT INTO categories (categories_id, categories_image, parent_id, sort_order, date_added, last_modified) VALUES (categories_seq.nextval, 'no-image.png', 23, 15, sysdate, null);
INSERT INTO categories_description (categories_id, language_id, categories_name) VALUES (26, 1, 'Tablets');
INSERT INTO categories_description (categories_id, language_id, categories_name) VALUES (26, 2, 'Tablets');
INSERT INTO categories_description (categories_id, language_id, categories_name) VALUES (26, 3, 'Tablets');
INSERT INTO categories_description (categories_id, language_id, categories_name) VALUES (26, 4, 'Tablets');

-- New Phones Sub-Category

INSERT INTO categories (categories_id, categories_image, parent_id, sort_order, date_added, last_modified) VALUES (categories_seq.nextval, 'no-image.png', 23, 10, sysdate, null);
INSERT INTO categories_description (categories_id, language_id, categories_name) VALUES (27, 1, 'Phones');
INSERT INTO categories_description (categories_id, language_id, categories_name) VALUES (27, 2, 'Phones');
INSERT INTO categories_description (categories_id, language_id, categories_name) VALUES (27, 3, 'Phones');
INSERT INTO categories_description (categories_id, language_id, categories_name) VALUES (27, 4, 'Phones');

-- New Kitchen Sub-Category

INSERT INTO categories (categories_id, categories_image, parent_id, sort_order, date_added, last_modified) VALUES (categories_seq.nextval, 'no-image.png', 24, 10, sysdate, null);
INSERT INTO categories_description (categories_id, language_id, categories_name) VALUES (28, 1, 'Kitchen');
INSERT INTO categories_description (categories_id, language_id, categories_name) VALUES (28, 2, 'Kitchen');
INSERT INTO categories_description (categories_id, language_id, categories_name) VALUES (28, 3, 'Kitchen');
INSERT INTO categories_description (categories_id, language_id, categories_name) VALUES (28, 4, 'Kitchen');

-- New Clocks Sub-Category

INSERT INTO categories (categories_id, categories_image, parent_id, sort_order, date_added, last_modified) VALUES (categories_seq.nextval, 'no-image.png', 24, 5, sysdate, null);
INSERT INTO categories_description (categories_id, language_id, categories_name) VALUES (29, 1, 'Clocks');
INSERT INTO categories_description (categories_id, language_id, categories_name) VALUES (29, 2, 'Clocks');
INSERT INTO categories_description (categories_id, language_id, categories_name) VALUES (29, 3, 'Clocks');
INSERT INTO categories_description (categories_id, language_id, categories_name) VALUES (29, 4, 'Clocks');

-- New Lawnmowers Sub-Category

INSERT INTO categories (categories_id, categories_image, parent_id, sort_order, date_added, last_modified) VALUES (categories_seq.nextval, 'no-image.png', 24, 15, sysdate, null);
INSERT INTO categories_description (categories_id, language_id, categories_name) VALUES (30, 1, 'Lawnmowers');
INSERT INTO categories_description (categories_id, language_id, categories_name) VALUES (30, 2, 'Lawnmowers');
INSERT INTO categories_description (categories_id, language_id, categories_name) VALUES (30, 3, 'Lawnmowers');
INSERT INTO categories_description (categories_id, language_id, categories_name) VALUES (30, 4, 'Lawnmowers');

-- New Windows8 Software

INSERT INTO products (products_id, products_model, products_price, products_weight, products_status, products_tax_class_id, manufacturers_id, products_quantity, products_ordered, products_date_added, products_date_available) VALUES (products_seq.nextval, 'WIN8PRO', 79.99, 6, 1, 1, 2, 100, 0, sysdate, sysdate);

INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (32, 1, 'Windows 8', 'This product comes in 5 different box designs. The box design you receive may differ from that shown in the image above. The image to the right shows the different designs available.<br>If you currently have a personal computer running Windows 7, Windows XP or Windows Vista then you can upgrade to Windows 8 Pro (Professional). With Windows 8 Pro, you can connect and share your files. Windows 8 Pro also adds enhanced features if you need to connect to company networks, access remote files, encrypt sensitive data, and other more advanced tasks.<br>The new Windows 8 start screen is your personalized home for items you use the most and can be customized according to your user preferences. Windows 8 Live tiles provide real-time updates from your Facebook, Twitter, and e-mail accounts. Along with the new Start screen, the lock screen now includes e-mail, calendar, and clock widgets.','http://windows.microsoft.com/',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (32, 2, 'Windows 8', 'This product comes in 5 different box designs. The box design you receive may differ from that shown in the image above. The image to the right shows the different designs available.<br>If you currently have a personal computer running Windows 7, Windows XP or Windows Vista then you can upgrade to Windows 8 Pro (Professional). With Windows 8 Pro, you can connect and share your files. Windows 8 Pro also adds enhanced features if you need to connect to company networks, access remote files, encrypt sensitive data, and other more advanced tasks.<br>The new Windows 8 start screen is your personalized home for items you use the most and can be customized according to your user preferences. Windows 8 Live tiles provide real-time updates from your Facebook, Twitter, and e-mail accounts. Along with the new Start screen, the lock screen now includes e-mail, calendar, and clock widgets.','http://windows.microsoft.com/',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (32, 3, 'Windows 8', 'This product comes in 5 different box designs. The box design you receive may differ from that shown in the image above. The image to the right shows the different designs available.<br>If you currently have a personal computer running Windows 7, Windows XP or Windows Vista then you can upgrade to Windows 8 Pro (Professional). With Windows 8 Pro, you can connect and share your files. Windows 8 Pro also adds enhanced features if you need to connect to company networks, access remote files, encrypt sensitive data, and other more advanced tasks.<br>The new Windows 8 start screen is your personalized home for items you use the most and can be customized according to your user preferences. Windows 8 Live tiles provide real-time updates from your Facebook, Twitter, and e-mail accounts. Along with the new Start screen, the lock screen now includes e-mail, calendar, and clock widgets.','http://windows.microsoft.com/',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (32, 4, 'Windows 8', 'This product comes in 5 different box designs. The box design you receive may differ from that shown in the image above. The image to the right shows the different designs available.<br>If you currently have a personal computer running Windows 7, Windows XP or Windows Vista then you can upgrade to Windows 8 Pro (Professional). With Windows 8 Pro, you can connect and share your files. Windows 8 Pro also adds enhanced features if you need to connect to company networks, access remote files, encrypt sensitive data, and other more advanced tasks.<br>The new Windows 8 start screen is your personalized home for items you use the most and can be customized according to your user preferences. Windows 8 Live tiles provide real-time updates from your Facebook, Twitter, and e-mail accounts. Along with the new Start screen, the lock screen now includes e-mail, calendar, and clock widgets.','http://windows.microsoft.com/',0);

INSERT INTO products_to_categories (products_id, categories_id) VALUES (32, 22);

-- New DeLonghi Manufacturer

INSERT INTO manufacturers (manufacturers_id, manufacturers_name, manufacturers_image, date_added, last_modified) VALUES (manufacturers_seq.nextval,'DeLonghi','manufacturer/delonghi.jpg', sysdate, null);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (12, 1, 'http://www.delonghi.com/us_en/agency/', 0, null);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (12, 2, 'http://www.delonghi.com/de_de/agency/', 0, null);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (12, 3, 'http://www.delonghi.com/es_es/agency/', 0, null);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (12, 4, 'http://www.delonghi.com/pt_pt/agency/', 0, null);

-- DeLonghi Coffee Maker

INSERT INTO products (products_id, products_model, products_price, products_weight, products_status, products_tax_class_id, manufacturers_id, products_quantity, products_ordered, products_date_added, products_date_available) VALUES (products_seq.nextval, 'DLBCO410', 159.99, 9, 1, 1, 12, 100, 0, sysdate, sysdate);

INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (33, 1, 'De''Longhi BCO 410', 'The De''Longhi BCO 410 is a 15 bar espresso/filter coffee machine that will ensure you get the perfect coffee experience, regardless of your tastes. Able to make 10 cups of filter coffee or individual espressos (either via ground coffee or with "Easy Serving Espresso" pods), the BCO 410 is a versatile and high-quality machine. The espresso portion of the machine comes complete with a crema filter holder, adjustable steam emission, removable water reservoir and cup holder. The filter coffee portion of the machine comes complete with a jug warmer to ensure the coffee remains hot after brewing, frontal loading to make the machine incredibly easy to refill (both water and coffee) and a water filtration system to make your coffee taste that much better.','http://www.delonghi.com/us_en/family/combi/',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (33, 2, 'De''Longhi BCO 410', 'The De''Longhi BCO 410 is a 15 bar espresso/filter coffee machine that will ensure you get the perfect coffee experience, regardless of your tastes. Able to make 10 cups of filter coffee or individual espressos (either via ground coffee or with "Easy Serving Espresso" pods), the BCO 410 is a versatile and high-quality machine. The espresso portion of the machine comes complete with a crema filter holder, adjustable steam emission, removable water reservoir and cup holder. The filter coffee portion of the machine comes complete with a jug warmer to ensure the coffee remains hot after brewing, frontal loading to make the machine incredibly easy to refill (both water and coffee) and a water filtration system to make your coffee taste that much better.','http://www.delonghi.com/de_de/family/combi/',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (33, 3, 'De''Longhi BCO 410', 'The De''Longhi BCO 410 is a 15 bar espresso/filter coffee machine that will ensure you get the perfect coffee experience, regardless of your tastes. Able to make 10 cups of filter coffee or individual espressos (either via ground coffee or with "Easy Serving Espresso" pods), the BCO 410 is a versatile and high-quality machine. The espresso portion of the machine comes complete with a crema filter holder, adjustable steam emission, removable water reservoir and cup holder. The filter coffee portion of the machine comes complete with a jug warmer to ensure the coffee remains hot after brewing, frontal loading to make the machine incredibly easy to refill (both water and coffee) and a water filtration system to make your coffee taste that much better.','http://www.delonghi.com/es_es/family/combi/',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (33, 4, 'De''Longhi BCO 410', 'The De''Longhi BCO 410 is a 15 bar espresso/filter coffee machine that will ensure you get the perfect coffee experience, regardless of your tastes. Able to make 10 cups of filter coffee or individual espressos (either via ground coffee or with "Easy Serving Espresso" pods), the BCO 410 is a versatile and high-quality machine. The espresso portion of the machine comes complete with a crema filter holder, adjustable steam emission, removable water reservoir and cup holder. The filter coffee portion of the machine comes complete with a jug warmer to ensure the coffee remains hot after brewing, frontal loading to make the machine incredibly easy to refill (both water and coffee) and a water filtration system to make your coffee taste that much better.','http://www.delonghi.com/pt_pt/family/combi/',0);

INSERT INTO products_to_categories (products_id, categories_id) VALUES (33, 28);

-- New Amazon Manufacturer

INSERT INTO manufacturers (manufacturers_id, manufacturers_name, manufacturers_image, date_added, last_modified) VALUES (manufacturers_seq.nextval,'Amazon','manufacturer/amazon.jpg', sysdate, null);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (13, 1, 'http://www.amazon.com/', 0, null);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (13, 2, 'http://www.amazon.co.de/', 0, null);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (13, 3, 'http://www.amazon.co.de/', 0, null);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (13, 4, 'http://www.amazon.co.pt/', 0, null);

-- New Kindle Fire HD

INSERT INTO products (products_id, products_model, products_price, products_weight, products_status, products_tax_class_id, manufacturers_id, products_quantity, products_ordered, products_date_added, products_date_available) VALUES (products_seq.nextval, 'DLBCO410', 199.99, 3, 1, 1, 13, 100, 0, sysdate, sysdate);

INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (34, 1, 'Kindle Fire HD', 'World''s most advanced 7" tablet<br>1280x800 HD display with polarizing filter and anti-glare technology for rich color and deep contrast from any viewing angle<br>Exclusive Dolby audio and dual-driver stereo speakers for immersive, virtual surround sound<br>World''s first tablet with dual-band, dual-antenna Wi-Fi for 40% faster downloads and streaming (compared to iPad 3)<br>High performance 1.2 Ghz dual-core processor with Imagination PowerVR 3D graphics core for fast and fluid performance','http://www.amazon.com/Kindle-Fire-HD/',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (34, 2, 'Kindle Fire HD', 'World''s most advanced 7" tablet<br>1280x800 HD display with polarizing filter and anti-glare technology for rich color and deep contrast from any viewing angle<br>Exclusive Dolby audio and dual-driver stereo speakers for immersive, virtual surround sound<br>World''s first tablet with dual-band, dual-antenna Wi-Fi for 40% faster downloads and streaming (compared to iPad 3)<br>High performance 1.2 Ghz dual-core processor with Imagination PowerVR 3D graphics core for fast and fluid performance','http://www.amazon.com/Kindle-Fire-HD/',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (34, 3, 'Kindle Fire HD', 'World''s most advanced 7" tablet<br>1280x800 HD display with polarizing filter and anti-glare technology for rich color and deep contrast from any viewing angle<br>Exclusive Dolby audio and dual-driver stereo speakers for immersive, virtual surround sound<br>World''s first tablet with dual-band, dual-antenna Wi-Fi for 40% faster downloads and streaming (compared to iPad 3)<br>High performance 1.2 Ghz dual-core processor with Imagination PowerVR 3D graphics core for fast and fluid performance','http://www.amazon.com/Kindle-Fire-HD/',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (34, 4, 'Kindle Fire HD', 'World''s most advanced 7" tablet<br>1280x800 HD display with polarizing filter and anti-glare technology for rich color and deep contrast from any viewing angle<br>Exclusive Dolby audio and dual-driver stereo speakers for immersive, virtual surround sound<br>World''s first tablet with dual-band, dual-antenna Wi-Fi for 40% faster downloads and streaming (compared to iPad 3)<br>High performance 1.2 Ghz dual-core processor with Imagination PowerVR 3D graphics core for fast and fluid performance','http://www.amazon.com/Kindle-Fire-HD/',0);

INSERT INTO products_to_categories (products_id, categories_id) VALUES (34, 26);

-- New Apple Manufacturer

INSERT INTO manufacturers (manufacturers_id, manufacturers_name, manufacturers_image, date_added, last_modified) VALUES (manufacturers_seq.nextval,'Apple','manufacturer/apple.jpg', sysdate, null);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (14, 1, 'http://www.apple.com/', 0, null);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (14, 2, 'http://www.apple.co.de/', 0, null);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (14, 3, 'http://www.apple.co.de/', 0, null);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (14, 4, 'http://www.apple.co.pt/', 0, null);

-- New iPhone 5

INSERT INTO products (products_id, products_model, products_price, products_weight, products_status, products_tax_class_id, manufacturers_id, products_quantity, products_ordered, products_date_added, products_date_available) VALUES (products_seq.nextval, 'DLBCO410', 999.99, 2, 1, 1, 14, 100, 0, sysdate, sysdate);

INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (35, 1, 'iPhone 5', 'Thin, sleek and very capable. It''s hard to believe a phone so thin could offer so many features: a larger display, a faster chip, the latest wireless technology, an 8MP iSight camera and more. All in a beautiful aluminium body designed and made with an unprecedented level of precision. iPhone 5 measures a mere 7.6 millimetres thin and weighs just 112 grams.1 That''s 18 per cent thinner and 20 per cent lighter than iPhone 4S. The only way to achieve a design like this is by relentlessly considering (and reconsidering) every single detail — including the details you don''t see.','http://www.apple.com/uk/iphone/features/',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (35, 2, 'iPhone 5', 'Dünn, elegant und leistungsfähig. Kaum zu glauben, dass ein so dünnes Telefon so viel zu bieten hat: ein größeres Display, einen schnelleren Chip, die neuesten drahtlosen Technologien, eine 8-Megapixel iSight Kamera und mehr. Alles in einem eleganten Aluminiumgehäuse, das mit einer unglaublichen Präzision designt und gefertigt wurde. Das iPhone 5 ist gerade einmal 7,6mm dünn und wiegt nur 112g. Damit ist es 18% dünner und 20% leichter als das iPhone 4S. Ein solches Design kann man nur erreichen, indem man immer und immer wieder jedes einzelne Detail überdenkt. Und zwar auch die Details, die man gar nicht sieht.','http://www.apple.com/de/iphone/features/',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (35, 3, 'iPhone 5', 'Fino, estilizado y capaz de cualquier cosa. Parece increíble que un teléfono tan fino pueda tener tantas cosas: una pantalla más grande, un chip más rápido, la última tecnología inalámbrica, una cámara de 8 megapíxeles... Y todo dentro de una espectacular carcasa de aluminio elaborada con un nivel de precisión sin precedentes. El iPhone 5 solo tiene 0,76 cm de grosor y 112 gramos de peso.1 O sea, es un 18% más fino y un 20% más ligero que el iPhone 4S. Solo hay una manera de conseguir algo así: analizando una y otra vez hasta el último detalle, incluso los que no se ven.','http://www.apple.com/es/iphone/features/',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (35, 4, 'iPhone 5', 'Fino, elegante e muito potente. É difícil de acreditar que um telefone tão leve tenha tantas funcionalidades: um ecrã maior, um chip mais rápido, a mais recente tecnologia sem fios, uma câmara iSight de 8 megapíxeis e muito mais. Tudo numa elegante estrutura em alumínio, concebida e construída com um nível de precisão sem precedentes. O iPhone 5 tem apenas 7,6 milímetros de espessura e só pesa 112 gramas.1 O que significa que é 18% mais fino e 20% mais leve do que o iPhone 4S. A única forma de se conseguir este feito, é estudando e analisando exaustivamente cada detalhe, mesmo aqueles que não se veem.','http://www.apple.com/pt/iphone/features/',0);

INSERT INTO products_to_categories (products_id, categories_id) VALUES (35, 27);

-- New Acctim Manufacturer

INSERT INTO manufacturers (manufacturers_id, manufacturers_name, manufacturers_image, date_added, last_modified) VALUES (manufacturers_seq.nextval,'Acctim','manufacturer/acctim.jpg', sysdate, null);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (15, 1, 'http://www.acctim.com/', 0, null);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (15, 2, 'http://www.acctim.co.de/', 0, null);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (15, 3, 'http://www.acctim.co.de/', 0, null);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (15, 4, 'http://www.acctim.co.pt/', 0, null);

-- New Cadiz 74137 clock

INSERT INTO products (products_id, products_model, products_price, products_weight, products_status, products_tax_class_id, manufacturers_id, products_quantity, products_ordered, products_date_added, products_date_available) VALUES (products_seq.nextval, 'CD74137', 19.99, 5, 1, 1, 15, 100, 0, sysdate, sysdate);

INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (36, 1, 'Cadiz Clock', 'MSF Radio Controlled<br>Split Second Accuracy<br>Black Numbers With Black Hand<br>Excellent Design ' || chr(38) || ' Quality<br>Dimensions: 255mm / 10" Colour: Silver','http://www.acctim.com/',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (36, 2, 'Cadiz Clock', 'MSF Radio Controlled<br>Split Second Accuracy<br>Black Numbers With Black Hand<br>Excellent Design ' || chr(38) || ' Quality<br>Dimensions: 255mm / 10" Colour: Silver','http://www.acctim.com/',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (36, 3, 'Cadiz Clock', 'MSF Radio Controlled<br>Split Second Accuracy<br>Black Numbers With Black Hand<br>Excellent Design ' || chr(38) || ' Quality<br>Dimensions: 255mm / 10" Colour: Silver','http://www.acctim.com/',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (36, 4, 'Cadiz Clock', 'MSF Radio Controlled<br>Split Second Accuracy<br>Black Numbers With Black Hand<br>Excellent Design ' || chr(38) || ' Quality<br>Dimensions: 255mm / 10" Colour: Silver','http://www.acctim.com/',0);

INSERT INTO products_to_categories (products_id, categories_id) VALUES (36, 29);

-- New Milan 93 clock

INSERT INTO products (products_id, products_model, products_price, products_weight, products_status, products_tax_class_id, manufacturers_id, products_quantity, products_ordered, products_date_added, products_date_available) VALUES (products_seq.nextval, 'MI93', 12.99, 5, 1, 1, 15, 100, 0, sysdate, sysdate);

INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (37, 1, 'Milan 93 Clock', 'Radio Controlled for split second accuracy, automatically sets to correct time<br>255mm Diameter<br>12/24 hour dial<br>Plastic case and lens<br>Dimensions H.W.L 255mm x 255mm x 37mm','http://www.acctim.com/',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (37, 2, 'Milan 93 Clock', 'Radio Controlled for split second accuracy, automatically sets to correct time<br>255mm Diameter<br>12/24 hour dial<br>Plastic case and lens<br>Dimensions H.W.L 255mm x 255mm x 37mm','http://www.acctim.com/',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (37, 3, 'Milan 93 Clock', 'Radio Controlled for split second accuracy, automatically sets to correct time<br>255mm Diameter<br>12/24 hour dial<br>Plastic case and lens<br>Dimensions H.W.L 255mm x 255mm x 37mm','http://www.acctim.com/',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (37, 4, 'Milan 93 Clock', 'Radio Controlled for split second accuracy, automatically sets to correct time<br>255mm Diameter<br>12/24 hour dial<br>Plastic case and lens<br>Dimensions H.W.L 255mm x 255mm x 37mm','http://www.acctim.com/',0);

INSERT INTO products_to_categories (products_id, categories_id) VALUES (37, 29);

-- New Acctim Metal clock

INSERT INTO products (products_id, products_model, products_price, products_weight, products_status, products_tax_class_id, manufacturers_id, products_quantity, products_ordered, products_date_added, products_date_available) VALUES (products_seq.nextval, 'B000H1QSJY', 21.99, 5, 1, 1, 15, 100, 0, sysdate, sysdate);

INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (38, 1, 'Acctim Metal Clock', 'Acctim wall clock<br>Radio controlled for split second accuracy<br>12/24 hour dial<br>Metal case<br>Diameter 300mm','http://www.acctim.com/',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (38, 2, 'Acctim Metal Clock', 'Acctim wall clock<br>Radio controlled for split second accuracy<br>12/24 hour dial<br>Metal case<br>Diameter 300mm','http://www.acctim.com/',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (38, 3, 'Acctim Metal Clock', 'Acctim wall clock<br>Radio controlled for split second accuracy<br>12/24 hour dial<br>Metal case<br>Diameter 300mm','http://www.acctim.com/',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (38, 4, 'Acctim Metal Clock', 'Acctim wall clock<br>Radio controlled for split second accuracy<br>12/24 hour dial<br>Metal case<br>Diameter 300mm','http://www.acctim.com/',0);

INSERT INTO products_to_categories (products_id, categories_id) VALUES (38, 29);

-- New Eddingtons Manufacturer

INSERT INTO manufacturers (manufacturers_id, manufacturers_name, manufacturers_image, date_added, last_modified) VALUES (manufacturers_seq.nextval,'Eddingtons','manufacturer/eddingtons.jpg', sysdate, null);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (16, 1, 'http://www.eddingtons.co.uk/', 0, null);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (16, 2, 'http://www.eddingtons.co.uk/', 0, null);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (16, 3, 'http://www.eddingtons.co.uk/', 0, null);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (16, 4, 'http://www.eddingtons.co.uk/', 0, null);

-- New Bosch Manufacturer

INSERT INTO manufacturers (manufacturers_id, manufacturers_name, manufacturers_image, date_added, last_modified) VALUES (manufacturers_seq.nextval,'Bosch','manufacturer/bosch.jpg', sysdate, null);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (17, 1, 'http://www.bosch.com/', 0, null);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (17, 2, 'http://www.bosch.com/', 0, null);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (17, 3, 'http://www.bosch.com/', 0, null);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (17, 4, 'http://www.bosch.com/', 0, null);

-- New Rotak 40 Ergoflex

INSERT INTO products (products_id, products_model, products_price, products_weight, products_status, products_tax_class_id, manufacturers_id, products_quantity, products_ordered, products_date_added, products_date_available) VALUES (products_seq.nextval, 'B004GTMNXI', 159.99, 16, 1, 1, 17, 100, 0, sysdate, sysdate);

INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (39, 1, 'Rotak 40 Ergoflex', 'Ergoflex System. Ergonomically shaped and adjustable handles for a better body posture and reduced muscle strain when mowing<br>1700W Powerdrive motor ensures a reliable cut, even in the most difficult conditions<br>Light weight for easy handling<br>Folding handles for compact storage<br>Innovative grass combs. Cut close to the edge of walls, flower beds and lawns','http://www.bosch.com/',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (39, 2, 'Rotak 40 Ergoflex', 'Ergoflex System. Ergonomically shaped and adjustable handles for a better body posture and reduced muscle strain when mowing<br>1700W Powerdrive motor ensures a reliable cut, even in the most difficult conditions<br>Light weight for easy handling<br>Folding handles for compact storage<br>Innovative grass combs. Cut close to the edge of walls, flower beds and lawns','http://www.bosch.com/',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (39, 3, 'Rotak 40 Ergoflex', 'Ergoflex System. Ergonomically shaped and adjustable handles for a better body posture and reduced muscle strain when mowing<br>1700W Powerdrive motor ensures a reliable cut, even in the most difficult conditions<br>Light weight for easy handling<br>Folding handles for compact storage<br>Innovative grass combs. Cut close to the edge of walls, flower beds and lawns','http://www.bosch.com/',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (39, 4, 'Rotak 40 Ergoflex', 'Ergoflex System. Ergonomically shaped and adjustable handles for a better body posture and reduced muscle strain when mowing<br>1700W Powerdrive motor ensures a reliable cut, even in the most difficult conditions<br>Light weight for easy handling<br>Folding handles for compact storage<br>Innovative grass combs. Cut close to the edge of walls, flower beds and lawns','http://www.bosch.com/',0);

INSERT INTO products_to_categories (products_id, categories_id) VALUES (39, 30);

-- New Rotak 32

INSERT INTO products (products_id, products_model, products_price, products_weight, products_status, products_tax_class_id, manufacturers_id, products_quantity, products_ordered, products_date_added, products_date_available) VALUES (products_seq.nextval, '0600885B71', 89.99, 7, 1, 1, 17, 100, 0, sysdate, sysdate);

INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (40, 1, 'Rotak 32', 'Ergonomic handle design for easy manoeuvrability<br>Lightweight and compact for convenient carrying and problem-free manoeuvrability<br>Powerdrive motor ensures a reliable cut, even under difficult circumstances<br>Innovative grass combs. Cut close to the edge of walls, flower beds and lawns<br>31-litre grass box for greater capacity and reduced need for emptying','http://www.bosch.com/',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (40, 2, 'Rotak 32', 'Ergonomic handle design for easy manoeuvrability<br>Lightweight and compact for convenient carrying and problem-free manoeuvrability<br>Powerdrive motor ensures a reliable cut, even under difficult circumstances<br>Innovative grass combs. Cut close to the edge of walls, flower beds and lawns<br>31-litre grass box for greater capacity and reduced need for emptying','http://www.bosch.com/',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (40, 3, 'Rotak 32', 'Ergonomic handle design for easy manoeuvrability<br>Lightweight and compact for convenient carrying and problem-free manoeuvrability<br>Powerdrive motor ensures a reliable cut, even under difficult circumstances<br>Innovative grass combs. Cut close to the edge of walls, flower beds and lawns<br>31-litre grass box for greater capacity and reduced need for emptying','http://www.bosch.com/',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (40, 4, 'Rotak 32', 'Ergonomic handle design for easy manoeuvrability<br>Lightweight and compact for convenient carrying and problem-free manoeuvrability<br>Powerdrive motor ensures a reliable cut, even under difficult circumstances<br>Innovative grass combs. Cut close to the edge of walls, flower beds and lawns<br>31-litre grass box for greater capacity and reduced need for emptying','http://www.bosch.com/',0);

INSERT INTO products_to_categories (products_id, categories_id) VALUES (40, 30);

-- New Flymo Manufacturer

INSERT INTO manufacturers (manufacturers_id, manufacturers_name, manufacturers_image, date_added, last_modified) VALUES (manufacturers_seq.nextval,'Flymo','manufacturer/flymo.jpg', sysdate, null);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (18, 1, 'http://www.flymo.com/', 0, null);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (18, 2, 'http://www.flymo.com/', 0, null);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (18, 3, 'http://www.flymo.com/', 0, null);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (18, 4, 'http://www.flymo.com/', 0, null);

-- New Flymo Chevron 34VC

INSERT INTO products (products_id, products_model, products_price, products_weight, products_status, products_tax_class_id, manufacturers_id, products_quantity, products_ordered, products_date_added, products_date_available) VALUES (products_seq.nextval, 'CHEVRON34VC', 109.99, 7, 1, 1, 18, 100, 0, sysdate, sysdate);

INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (41, 1, 'Flymo Chevron 34VC', 'The Chevron 34VC from Flymo is a lightweight, easy to use electric wheeled mower with a rear roller that will give your lawn that classic striped finish.<br>1400 watt motor<br>5 heights of cut (20 - 60mm)<br>40 litre collection box<br>12 metre mains cable<br>34cm metal cutting blade','http://www.flymo.com/int/products/lawn-mowers/chevron-34vc/',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (41, 2, 'Flymo Chevron 34VC', 'The Chevron 34VC from Flymo is a lightweight, easy to use electric wheeled mower with a rear roller that will give your lawn that classic striped finish.<br>1400 watt motor<br>5 heights of cut (20 - 60mm)<br>40 litre collection box<br>12 metre mains cable<br>34cm metal cutting blade','http://www.flymo.com/int/products/lawn-mowers/chevron-34vc/',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (41, 3, 'Flymo Chevron 34VC', 'The Chevron 34VC from Flymo is a lightweight, easy to use electric wheeled mower with a rear roller that will give your lawn that classic striped finish.<br>1400 watt motor<br>5 heights of cut (20 - 60mm)<br>40 litre collection box<br>12 metre mains cable<br>34cm metal cutting blade','http://www.flymo.com/int/products/lawn-mowers/chevron-34vc/',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (41, 4, 'Flymo Chevron 34VC', 'The Chevron 34VC from Flymo is a lightweight, easy to use electric wheeled mower with a rear roller that will give your lawn that classic striped finish.<br>1400 watt motor<br>5 heights of cut (20 - 60mm)<br>40 litre collection box<br>12 metre mains cable<br>34cm metal cutting blade','http://www.flymo.com/int/products/lawn-mowers/chevron-34vc/',0);

INSERT INTO products_to_categories (products_id, categories_id) VALUES (41, 30);

-- New Bosch SHM 38G

INSERT INTO products (products_id, products_model, products_price, products_weight, products_status, products_tax_class_id, manufacturers_id, products_quantity, products_ordered, products_date_added, products_date_available) VALUES (products_seq.nextval, '0600886102', 55.95, 7, 1, 1, 17, 100, 0, sysdate, sysdate);

INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (42, 1, 'Bosch SHM 38G', 'Cylinder cut system with 5 curved blades made from hardened steel<br>Variable height-of-cut adjustment and a cutting width of 38cm<br>Simple bottom blade adjustment with "click" locking system<br>Maintenance-free cutting cylinder on ball bearings<br>Easy-to-use bar for better ergonomics<br>Smooth-running wheels with special gear reduction for easy pushing','http://www.bosch.com/',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (42, 2, 'Bosch SHM 38G', 'Cylinder cut system with 5 curved blades made from hardened steel<br>Variable height-of-cut adjustment and a cutting width of 38cm<br>Simple bottom blade adjustment with "click" locking system<br>Maintenance-free cutting cylinder on ball bearings<br>Easy-to-use bar for better ergonomics<br>Smooth-running wheels with special gear reduction for easy pushing','http://www.bosch.com/',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (42, 3, 'Bosch SHM 38G', 'Cylinder cut system with 5 curved blades made from hardened steel<br>Variable height-of-cut adjustment and a cutting width of 38cm<br>Simple bottom blade adjustment with "click" locking system<br>Maintenance-free cutting cylinder on ball bearings<br>Easy-to-use bar for better ergonomics<br>Smooth-running wheels with special gear reduction for easy pushing','http://www.bosch.com/',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (42, 4, 'Bosch SHM 38G', 'Cylinder cut system with 5 curved blades made from hardened steel<br>Variable height-of-cut adjustment and a cutting width of 38cm<br>Simple bottom blade adjustment with "click" locking system<br>Maintenance-free cutting cylinder on ball bearings<br>Easy-to-use bar for better ergonomics<br>Smooth-running wheels with special gear reduction for easy pushing','http://www.bosch.com/',0);

INSERT INTO products_to_categories (products_id, categories_id) VALUES (42, 30);

-- New Brita Manufacturer

INSERT INTO manufacturers (manufacturers_id, manufacturers_name, manufacturers_image, date_added, last_modified) VALUES (manufacturers_seq.nextval,'Brita','manufacturer/brita.jpg', sysdate, null);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (19, 1, 'http://www.brita.com/', 0, null);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (19, 2, 'http://www.brita.de/', 0, null);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (19, 3, 'http://www.brita.es/', 0, null);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (19, 4, 'http://www.brita.pt', 0, null);

-- New Brita Marella XL Water Filter

INSERT INTO products (products_id, products_model, products_price, products_weight, products_status, products_tax_class_id, manufacturers_id, products_quantity, products_ordered, products_date_added, products_date_available) VALUES (products_seq.nextval, '219185', 15.19, 1, 1, 1, 19, 100, 0, sysdate, sysdate);

INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (43, 1, 'Brita Marella XL Water Filter', 'Handy filling orifice in lid for easy filling<br>Electronic cartridge change display: BRITA MEMO<br>Dishwasher-safe up to 50°C (exception: lid)<br>XL version for larger demand, total volume: 3.5 L, filtered water: 2.0 L<br>Including 1x Maxtra cartridge','http://www.brita.com/',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (43, 2, 'Brita Marella XL Water Filter', 'Handy filling orifice in lid for easy filling<br>Electronic cartridge change display: BRITA MEMO<br>Dishwasher-safe up to 50°C (exception: lid)<br>XL version for larger demand, total volume: 3.5 L, filtered water: 2.0 L<br>Including 1x Maxtra cartridge','http://www.brita.com/',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (43, 3, 'Brita Marella XL Water Filter', 'Handy filling orifice in lid for easy filling<br>Electronic cartridge change display: BRITA MEMO<br>Dishwasher-safe up to 50°C (exception: lid)<br>XL version for larger demand, total volume: 3.5 L, filtered water: 2.0 L<br>Including 1x Maxtra cartridge','http://www.brita.com/',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (43, 4, 'Brita Marella XL Water Filter', 'Handy filling orifice in lid for easy filling<br>Electronic cartridge change display: BRITA MEMO<br>Dishwasher-safe up to 50°C (exception: lid)<br>XL version for larger demand, total volume: 3.5 L, filtered water: 2.0 L<br>Including 1x Maxtra cartridge','http://www.brita.com/',0);

INSERT INTO products_to_categories (products_id, categories_id) VALUES (43, 28);

-- New Brabantia Manufacturer

INSERT INTO manufacturers (manufacturers_id, manufacturers_name, manufacturers_image, date_added, last_modified) VALUES (manufacturers_seq.nextval,'Brabantia','manufacturer/brabantia.jpg', sysdate, null);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (20, 1, 'http://www.brabantia.com/', 0, null);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (20, 2, 'http://www.brabantia.de/', 0, null);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (20, 3, 'http://www.brabantia.es/', 0, null);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (20, 4, 'http://www.brabantia.pt', 0, null);

-- New Brabantia Touch Bin

INSERT INTO products (products_id, products_model, products_price, products_weight, products_status, products_tax_class_id, manufacturers_id, products_quantity, products_ordered, products_date_added, products_date_available) VALUES (products_seq.nextval, '424625', 149.49, 7, 1, 1, 20, 100, 0, sysdate, sysdate);

INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (44, 1, 'Brabantia Touch Bin', 'Brabantia Soft-Touch closure - easy and light operation<br>Unique hinge design - lid opens silently<br>Matching Brabantia bin liners available with tie-tape (size L) - perfect fit and no ugly over wrap<br>Dimensions: height 75.5cm, diameter 37cm, capacity 45 litres<br>10 year guarantee','http://www.brabantia.com/',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (44, 2, 'Brabantia Touch Bin', 'Brabantia Soft-Touch closure - easy and light operation<br>Unique hinge design - lid opens silently<br>Matching Brabantia bin liners available with tie-tape (size L) - perfect fit and no ugly over wrap<br>Dimensions: height 75.5cm, diameter 37cm, capacity 45 litres<br>10 year guarantee','http://www.brabantia.com/',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (44, 3, 'Brabantia Touch Bin', 'Brabantia Soft-Touch closure - easy and light operation<br>Unique hinge design - lid opens silently<br>Matching Brabantia bin liners available with tie-tape (size L) - perfect fit and no ugly over wrap<br>Dimensions: height 75.5cm, diameter 37cm, capacity 45 litres<br>10 year guarantee','http://www.brabantia.com/',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (44, 4, 'Brabantia Touch Bin', 'Brabantia Soft-Touch closure - easy and light operation<br>Unique hinge design - lid opens silently<br>Matching Brabantia bin liners available with tie-tape (size L) - perfect fit and no ugly over wrap<br>Dimensions: height 75.5cm, diameter 37cm, capacity 45 litres<br>10 year guarantee','http://www.brabantia.com/',0);

INSERT INTO products_to_categories (products_id, categories_id) VALUES (44, 28);

-- New Samsung Manufacturer

INSERT INTO manufacturers (manufacturers_id, manufacturers_name, manufacturers_image, date_added, last_modified) VALUES (manufacturers_seq.nextval,'Samsung','manufacturer/samsung.jpg', sysdate, null);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (21, 1, 'http://www.samsung.com/', 0, null);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (21, 2, 'http://www.samsung.de/', 0, null);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (21, 3, 'http://www.samsung.es/', 0, null);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (21, 4, 'http://www.samsung.pt', 0, null);

-- New Samsung Galaxy S III

INSERT INTO products (products_id, products_model, products_price, products_weight, products_status, products_tax_class_id, manufacturers_id, products_quantity, products_ordered, products_date_added, products_date_available) VALUES (products_seq.nextval, 'GALAXYSIII', 589.99, 2, 1, 1, 21, 100, 0, sysdate, sysdate);

INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (45, 1, 'Galaxy S III', 'Designed for humans<br>Samsung GALAXY S III just gets us. Little things, like staying awake when you look at it and keeping track of loved ones. Designed for humans, it goes beyond smart and fulfills your needs by thinking as you think, acting as you act','http://www.samsung.com/uk/consumer/mobile-devices/smartphones/android/GT-I9300MBDBTU',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (45, 2, 'Galaxy S III', 'Designed for humans<br>Samsung GALAXY S III just gets us. Little things, like staying awake when you look at it and keeping track of loved ones. Designed for humans, it goes beyond smart and fulfills your needs by thinking as you think, acting as you act','http://www.samsung.com/uk/consumer/mobile-devices/smartphones/android/GT-I9300MBDBTU',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (45, 3, 'Galaxy S III', 'Designed for humans<br>Samsung GALAXY S III just gets us. Little things, like staying awake when you look at it and keeping track of loved ones. Designed for humans, it goes beyond smart and fulfills your needs by thinking as you think, acting as you act','http://www.samsung.com/uk/consumer/mobile-devices/smartphones/android/GT-I9300MBDBTU',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (45, 4, 'Galaxy S III', 'Designed for humans<br>Samsung GALAXY S III just gets us. Little things, like staying awake when you look at it and keeping track of loved ones. Designed for humans, it goes beyond smart and fulfills your needs by thinking as you think, acting as you act','http://www.samsung.com/uk/consumer/mobile-devices/smartphones/android/GT-I9300MBDBTU',0);

INSERT INTO products_to_categories (products_id, categories_id) VALUES (45, 27);

-- New Samsung Galaxy Ace Plus

INSERT INTO products (products_id, products_model, products_price, products_weight, products_status, products_tax_class_id, manufacturers_id, products_quantity, products_ordered, products_date_added, products_date_available) VALUES (products_seq.nextval, 'GT-S7500ABABTU', 289.99, 2, 1, 1, 21, 100, 0, sysdate, sysdate);

INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (46, 1, 'Galaxy Ace Plus', 'A stylishly designed smartphone contained in a modern and minimalist casing with HVGA display<br>Complete with Samsung''s Social Hub, Music Hub and ChatON services<br>2Gb shared storage capacity for multimedia content and up to 1 Gb of direct storage for applications - more than any smartphone in its category','http://www.samsung.com/uk/consumer/mobile-devices/smartphones/android/GT-S7500ABABTU',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (46, 2, 'Galaxy Ace Plus', 'A stylishly designed smartphone contained in a modern and minimalist casing with HVGA display<br>Complete with Samsung''s Social Hub, Music Hub and ChatON services<br>2Gb shared storage capacity for multimedia content and up to 1 Gb of direct storage for applications - more than any smartphone in its category','http://www.samsung.com/uk/consumer/mobile-devices/smartphones/android/GT-S7500ABABTU',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (46, 3, 'Galaxy Ace Plus', 'A stylishly designed smartphone contained in a modern and minimalist casing with HVGA display<br>Complete with Samsung''s Social Hub, Music Hub and ChatON services<br>2Gb shared storage capacity for multimedia content and up to 1 Gb of direct storage for applications - more than any smartphone in its category','http://www.samsung.com/uk/consumer/mobile-devices/smartphones/android/GT-S7500ABABTU',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (46, 4, 'Galaxy Ace Plus', 'A stylishly designed smartphone contained in a modern and minimalist casing with HVGA display<br>Complete with Samsung''s Social Hub, Music Hub and ChatON services<br>2Gb shared storage capacity for multimedia content and up to 1 Gb of direct storage for applications - more than any smartphone in its category','http://www.samsung.com/uk/consumer/mobile-devices/smartphones/android/GT-S7500ABABTU',0);

INSERT INTO products_to_categories (products_id, categories_id) VALUES (46, 27);

-- New iPhone 4S

INSERT INTO products (products_id, products_model, products_price, products_weight, products_status, products_tax_class_id, manufacturers_id, products_quantity, products_ordered, products_date_added, products_date_available) VALUES (products_seq.nextval, 'MD242B/A', 899.99, 3, 1, 1, 14, 100, 0, sysdate, sysdate);

INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (47, 1, 'iPhone 4S', 'Dual-core A5 chip. All-new 8MP camera and optics. iOS 5 and iCloud. Retina 3.5-inch (diagonal) widescreen Multi-Touch display. Fingerprint-resistant oleophobic coating on front and back. It was the most amazing iPhone before the iPhone 5, but still great.','http://www.apple.com/iphone/iphone-4s/specs.html',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (47, 2, 'iPhone 4S', 'Dual-Core A5 Chip. Alle neuen 8MP Kamera und Optik. iOS 5 und iCloud. Retina 3,5-Zoll (Diagonale) im Breitbildformat Multi-Touch-Display. Fettabweisende Beschichtung auf Vorder-und Rückseite. Es war das schönste iPhone vor dem iPhone 5, aber immer noch groß.','http://www.apple.com/de/iphone/iphone-4s/specs.html',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (47, 3, 'iPhone 4S', 'Dual-core A5 chip. Todo nueva cámara de 8 megapíxeles y la óptica. iOS 5 y iCloud. Retina de 3,5 pulgadas (en diagonal) widescreen Multi-Touch. Resistente a huellas dactilares Cubierta oleófuga en la parte delantera y trasera. Fue el iPhone más asombroso antes de que el iPhone 5, pero sigue estando fenomenal.','http://www.apple.com/es/iphone/iphone-4s/specs.html',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (47, 4, 'iPhone 4S', 'Dual-core chip A5. Todos nova câmera de 8MP e óptica. iOS 5 e iCloud. Retina de 3,5 polegadas (diagonal) com tecnologia Multi-Touch widescreen. Fingerprint revestimento resistente oleophobic na frente e atrás. Foi o iPhone mais incrível antes de o iPhone 5, mas ainda grande.','http://www.apple.com/pt/iphone/iphone-4s/specs.html',0);

INSERT INTO products_to_categories (products_id, categories_id) VALUES (47, 27);

-- New Sony Manufacturer

INSERT INTO manufacturers (manufacturers_id, manufacturers_name, manufacturers_image, date_added, last_modified) VALUES (manufacturers_seq.nextval,'Sony','manufacturer/sony.jpg', sysdate, null);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (22, 1, 'http://www.sony.com/', 0, null);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (22, 2, 'http://www.sony.de/', 0, null);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (22, 3, 'http://www.sony.es/', 0, null);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (22, 4, 'http://www.sony.pt', 0, null);

-- New XPERIA S

INSERT INTO products (products_id, products_model, products_price, products_weight, products_status, products_tax_class_id, manufacturers_id, products_quantity, products_ordered, products_date_added, products_date_available) VALUES (products_seq.nextval, '1257-3114', 459.99, 1, 1, 1, 22, 100, 0, sysdate, sysdate);

INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (48, 1, 'Sony XPERIA S', 'See movies and photos in crisp, clear HD on the large Reality Display with Mobile BRAVIA Engine. The full HD video recording and fast 12MP camera lets you shoot everything in sharp detail, even in low light, and view it on your TV via an HDMI cable. Xperia S is PlayStation Certified, so you can play the perfect game. And you can enjoy millions of songs from Music Unlimited. Or download hit movies from Video Unlimited.','http://www.sonymobile.com/gb/products/phones/xperia-s',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (48, 2, 'Sony XPERIA S', 'Sehen Sie Filme und Fotos in gestochen scharfe, klare HD auf dem großen Reality Display mit Mobile BRAVIA Engine. Die Full-HD-Video-Aufzeichnung und schnelle 12MP Kamera können Sie schießen alles in scharfe Details, auch bei schwachem Licht, und zeigen Sie sie auf dem Fernseher über ein HDMI-Kabel. Xperia S PlayStation Certified, so können Sie das perfekte Spiel zu spielen. Und Sie können Millionen von Songs aus Music Unlimited genießen. Oder laden Sie hit Filme von Video Unlimited.','http://www.sonymobile.com/gb/products/phones/xperia-s',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (48, 3, 'Sony XPERIA S', 'Ver películas y fotografías en claro y nítido de alta definición en la pantalla grande Reality con Mobile BRAVIA Engine. La plena grabación de vídeo HD y cámara de 12MP rápido le permite tomar todo con todo detalle, incluso en condiciones de poca luz, y verla en la TV mediante un cable HDMI. Xperia S es PlayStation Certified, para que pueda jugar el juego perfecto. Y usted puede disfrutar de millones de canciones de Music Unlimited. O descargar películas de éxito de Video Unlimited.','http://www.sonymobile.com/gb/products/phones/xperia-s',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (48, 4, 'Sony XPERIA S', 'Ver filmes e fotos em nítido, HD claro no visor Reality grande com o Mobile BRAVIA Engine. A gravação de vídeo Full HD e câmera de 12MP rápido permite gravar tudo em detalhes nítidos, mesmo em condições de pouca luz, e vê-lo na sua TV através de um cabo HDMI. Xperia S é PlayStation Certified, de modo que você pode jogar o jogo perfeito. E você pode desfrutar de milhões de músicas do Music Unlimited. Ou fazer o download de filmes de sucesso Video Unlimited.','http://www.sonymobile.com/gb/products/phones/xperia-s',0);

INSERT INTO products_to_categories (products_id, categories_id) VALUES (48, 27);

-- New Canon Powershot G15

INSERT INTO products (products_id, products_model, products_price, products_weight, products_status, products_tax_class_id, manufacturers_id, products_quantity, products_ordered, products_date_added, products_date_available) VALUES (products_seq.nextval, '6350B009', 829.99, 1, 1, 1, 6, 100, 0, sysdate, sysdate);

INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (49, 1, 'Canon PowerShot G15', 'The fast, bright expert compact<br><br>Equipped for serious photography, the compact PowerShot G15 boasts a bright f/1.8-2.8, 5x zoom lens, fast AF and a high-sensitivity Canon CMOS sensor for capturing superior photos and Full HD movies.','http://www.canon.co.uk/For_Home/Product_Finder/Cameras/Digital_Camera/PowerShot/PowerShot_G15/',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (49, 2, 'Canon PowerShot G15', 'The fast, bright expert compact<br><br>Equipped for serious photography, the compact PowerShot G15 boasts a bright f/1.8-2.8, 5x zoom lens, fast AF and a high-sensitivity Canon CMOS sensor for capturing superior photos and Full HD movies.','http://www.canon.co.uk/For_Home/Product_Finder/Cameras/Digital_Camera/PowerShot/PowerShot_G15/',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (49, 3, 'Canon PowerShot G15', 'The fast, bright expert compact<br><br>Equipped for serious photography, the compact PowerShot G15 boasts a bright f/1.8-2.8, 5x zoom lens, fast AF and a high-sensitivity Canon CMOS sensor for capturing superior photos and Full HD movies.','http://www.canon.co.uk/For_Home/Product_Finder/Cameras/Digital_Camera/PowerShot/PowerShot_G15/',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (49, 4, 'Canon PowerShot G15', 'The fast, bright expert compact<br><br>Equipped for serious photography, the compact PowerShot G15 boasts a bright f/1.8-2.8, 5x zoom lens, fast AF and a high-sensitivity Canon CMOS sensor for capturing superior photos and Full HD movies.','http://www.canon.co.uk/For_Home/Product_Finder/Cameras/Digital_Camera/PowerShot/PowerShot_G15/',0);

INSERT INTO products_to_categories (products_id, categories_id) VALUES (49, 25);

-- New Samsung MV800

INSERT INTO products (products_id, products_model, products_price, products_weight, products_status, products_tax_class_id, manufacturers_id, products_quantity, products_ordered, products_date_added, products_date_available) VALUES (products_seq.nextval, '6350B009', 189.99, 1, 1, 1, 21, 100, 0, sysdate, sysdate);

INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (50, 1, 'Samsung MV800 Digital Camera', 'The Flip-out Display - Life, from all angles<br><br>Easily capture your unique perspective. The MV800’s 3.0" Display flips up and down so you can frame shots at any angle without having to twist your body or bend your back. Snap a high-angle shot over a crowd to effortlessly capture a street performance, or get waist-level candids of your dog. Take low angle shots without getting on the ground, or spin the display all the way around for dazzling self-portraits.The LCD lets you stand the camera so everyone can enjoy from a comfortable position. Life’s more fun when you can cover all the angles.','http://www.samsung.com/uk/consumer/camera-camcorder/cameras/compact/EC-MV800ZBPBGB',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (50, 2, 'Samsung MV800 Digital Camera', 'The Flip-out Display - Life, from all angles<br><br>Easily capture your unique perspective. The MV800’s 3.0" Display flips up and down so you can frame shots at any angle without having to twist your body or bend your back. Snap a high-angle shot over a crowd to effortlessly capture a street performance, or get waist-level candids of your dog. Take low angle shots without getting on the ground, or spin the display all the way around for dazzling self-portraits.The LCD lets you stand the camera so everyone can enjoy from a comfortable position. Life’s more fun when you can cover all the angles.','http://www.samsung.com/uk/consumer/camera-camcorder/cameras/compact/EC-MV800ZBPBGB',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (50, 3, 'Samsung MV800 Digital Camera', 'The Flip-out Display - Life, from all angles<br><br>Easily capture your unique perspective. The MV800’s 3.0" Display flips up and down so you can frame shots at any angle without having to twist your body or bend your back. Snap a high-angle shot over a crowd to effortlessly capture a street performance, or get waist-level candids of your dog. Take low angle shots without getting on the ground, or spin the display all the way around for dazzling self-portraits.The LCD lets you stand the camera so everyone can enjoy from a comfortable position. Life’s more fun when you can cover all the angles.','http://www.samsung.com/uk/consumer/camera-camcorder/cameras/compact/EC-MV800ZBPBGB',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (50, 4, 'Samsung MV800 Digital Camera', 'The Flip-out Display - Life, from all angles<br><br>Easily capture your unique perspective. The MV800’s 3.0" Display flips up and down so you can frame shots at any angle without having to twist your body or bend your back. Snap a high-angle shot over a crowd to effortlessly capture a street performance, or get waist-level candids of your dog. Take low angle shots without getting on the ground, or spin the display all the way around for dazzling self-portraits.The LCD lets you stand the camera so everyone can enjoy from a comfortable position. Life’s more fun when you can cover all the angles.','http://www.samsung.com/uk/consumer/camera-camcorder/cameras/compact/EC-MV800ZBPBGB',0);

INSERT INTO products_to_categories (products_id, categories_id) VALUES (50, 25);

-- New Canon Powershot SX40

INSERT INTO products (products_id, products_model, products_price, products_weight, products_status, products_tax_class_id, manufacturers_id, products_quantity, products_ordered, products_date_added, products_date_available) VALUES (products_seq.nextval, '5251B011AA', 439.99, 1, 1, 1, 6, 100, 0, sysdate, sysdate);

INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (51, 1, 'Canon PowerShot SX40', 'Go far, get closer with 35x zoom<br><br>Get closer with the PowerShot SX40 HS. An ultra-wide 35x optical zoom, great low light results of the HS System, Full HD and high-speed shooting make this the travel powerhouse for those who want it all.<br>35x ultra wide-angle zoom with USM<br>Image Stabilizer (4.5-stop). Intelligent IS<br>HS System (12.1 MP) with DIGIC 5<br>Full HD, HDMI','http://www.canon.co.uk/For_Home/Product_Finder/Cameras/Digital_Camera/PowerShot/PowerShot_SX40_HS/',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (51, 2, 'Canon PowerShot SX40', 'Go far, get closer with 35x zoom<br><br>Get closer with the PowerShot SX40 HS. An ultra-wide 35x optical zoom, great low light results of the HS System, Full HD and high-speed shooting make this the travel powerhouse for those who want it all.<br>35x ultra wide-angle zoom with USM<br>Image Stabilizer (4.5-stop). Intelligent IS<br>HS System (12.1 MP) with DIGIC 5<br>Full HD, HDMI','http://www.canon.co.uk/For_Home/Product_Finder/Cameras/Digital_Camera/PowerShot/PowerShot_SX40_HS/',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (51, 3, 'Canon PowerShot SX40', 'Go far, get closer with 35x zoom<br><br>Get closer with the PowerShot SX40 HS. An ultra-wide 35x optical zoom, great low light results of the HS System, Full HD and high-speed shooting make this the travel powerhouse for those who want it all.<br>35x ultra wide-angle zoom with USM<br>Image Stabilizer (4.5-stop). Intelligent IS<br>HS System (12.1 MP) with DIGIC 5<br>Full HD, HDMI','http://www.canon.co.uk/For_Home/Product_Finder/Cameras/Digital_Camera/PowerShot/PowerShot_SX40_HS/',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (51, 4, 'Canon PowerShot SX40', 'Go far, get closer with 35x zoom<br><br>Get closer with the PowerShot SX40 HS. An ultra-wide 35x optical zoom, great low light results of the HS System, Full HD and high-speed shooting make this the travel powerhouse for those who want it all.<br>35x ultra wide-angle zoom with USM<br>Image Stabilizer (4.5-stop). Intelligent IS<br>HS System (12.1 MP) with DIGIC 5<br>Full HD, HDMI','http://www.canon.co.uk/For_Home/Product_Finder/Cameras/Digital_Camera/PowerShot/PowerShot_SX40_HS/',0);

INSERT INTO products_to_categories (products_id, categories_id) VALUES (51, 25);

-- New Nikon Manufacturer

INSERT INTO manufacturers (manufacturers_id, manufacturers_name, manufacturers_image, date_added, last_modified) VALUES (manufacturers_seq.nextval, 'Nikon', 'manufacturer/nikon.jpg', sysdate, null);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (23, 1, 'http://www.nikon.com/', 0, null);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (23, 2, 'http://www.nikon.de/', 0, null);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (23, 3, 'http://www.nikon.es/', 0, null);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (23, 4, 'http://www.nikon.pt', 0, null);

-- New Nikon COOLPIX L810

INSERT INTO products (products_id, products_model, products_price, products_weight, products_status, products_tax_class_id, manufacturers_id, products_quantity, products_ordered, products_date_added, products_date_available) VALUES (products_seq.nextval, 'L810', 279.99, 1, 1, 1, 23, 100, 0, sysdate, sysdate);

INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (52, 1, 'Nikon COOLPIX L810', 'The Nikon COOLPIX L810 - Stabilised 26x zoom, compact and user-friendly<br><br>This compact camera lets curious photographers get up close from anywhere with the incredible Nikon COOLPIX NIKKOR 26x optical zoom lens (22.5mm – 585mm). Taking the perfect picture is made simple with Easy Auto mode which takes care of all the camera settings. For super-sharp shots it has Nikon''s clever anti-blur technology and a side zoom lever to help keep a steady hand.','http://www.nikonusa.com/en/Nikon-Products/Product/Compact-Digital-Cameras/26294/COOLPIX-L810.html',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (52, 2, 'Nikon COOLPIX L810', 'The Nikon COOLPIX L810 - Stabilised 26x zoom, compact and user-friendly<br><br>This compact camera lets curious photographers get up close from anywhere with the incredible Nikon COOLPIX NIKKOR 26x optical zoom lens (22.5mm – 585mm). Taking the perfect picture is made simple with Easy Auto mode which takes care of all the camera settings. For super-sharp shots it has Nikon''s clever anti-blur technology and a side zoom lever to help keep a steady hand.','http://www.nikonusa.com/en/Nikon-Products/Product/Compact-Digital-Cameras/26294/COOLPIX-L810.html',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (52, 3, 'Nikon COOLPIX L810', 'The Nikon COOLPIX L810 - Stabilised 26x zoom, compact and user-friendly<br><br>This compact camera lets curious photographers get up close from anywhere with the incredible Nikon COOLPIX NIKKOR 26x optical zoom lens (22.5mm – 585mm). Taking the perfect picture is made simple with Easy Auto mode which takes care of all the camera settings. For super-sharp shots it has Nikon''s clever anti-blur technology and a side zoom lever to help keep a steady hand.','http://www.nikonusa.com/en/Nikon-Products/Product/Compact-Digital-Cameras/26294/COOLPIX-L810.html',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (52, 4, 'Nikon COOLPIX L810', 'The Nikon COOLPIX L810 - Stabilised 26x zoom, compact and user-friendly<br><br>This compact camera lets curious photographers get up close from anywhere with the incredible Nikon COOLPIX NIKKOR 26x optical zoom lens (22.5mm – 585mm). Taking the perfect picture is made simple with Easy Auto mode which takes care of all the camera settings. For super-sharp shots it has Nikon''s clever anti-blur technology and a side zoom lever to help keep a steady hand.','http://www.nikonusa.com/en/Nikon-Products/Product/Compact-Digital-Cameras/26294/COOLPIX-L810.html',0);

INSERT INTO products_to_categories (products_id, categories_id) VALUES (52, 25);

-- New Nikon D5100 Digital SLR

INSERT INTO products (products_id, products_model, products_price, products_weight, products_status, products_tax_class_id, manufacturers_id, products_quantity, products_ordered, products_date_added, products_date_available) VALUES (products_seq.nextval, '25478', 849.99, 1, 1, 1, 23, 100, 0, sysdate, sysdate);

INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (53, 1, 'Nikon D5100 SLR', 'The Nikon D5100 and its included AF-S 18-55mm VR lens offer a host of new photographic and video tools including a 16.2 MP DX-format CMOS sensor, 4 fps continuous shooting and breathtaking Full 1080p HD Movies with full time autofocus.','http://www.nikonusa.com/en/Nikon-Products/Product/Digital-SLR-Cameras/25478/D5100.html',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (53, 2, 'Nikon D5100 SLR', 'The Nikon D5100 and its included AF-S 18-55mm VR lens offer a host of new photographic and video tools including a 16.2 MP DX-format CMOS sensor, 4 fps continuous shooting and breathtaking Full 1080p HD Movies with full time autofocus.','http://www.nikonusa.com/en/Nikon-Products/Product/Digital-SLR-Cameras/25478/D5100.html',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (53, 3, 'Nikon D5100 SLR', 'The Nikon D5100 and its included AF-S 18-55mm VR lens offer a host of new photographic and video tools including a 16.2 MP DX-format CMOS sensor, 4 fps continuous shooting and breathtaking Full 1080p HD Movies with full time autofocus.','http://www.nikonusa.com/en/Nikon-Products/Product/Digital-SLR-Cameras/25478/D5100.html',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (53, 4, 'Nikon D5100 SLR', 'The Nikon D5100 and its included AF-S 18-55mm VR lens offer a host of new photographic and video tools including a 16.2 MP DX-format CMOS sensor, 4 fps continuous shooting and breathtaking Full 1080p HD Movies with full time autofocus.','http://www.nikonusa.com/en/Nikon-Products/Product/Digital-SLR-Cameras/25478/D5100.html',0);

INSERT INTO products_to_categories (products_id, categories_id) VALUES (53, 25);

-- New Nikon 1 J2 Compact

INSERT INTO products (products_id, products_model, products_price, products_weight, products_status, products_tax_class_id, manufacturers_id, products_quantity, products_ordered, products_date_added, products_date_available) VALUES (products_seq.nextval, '27577', 549.95, 1, 1, 1, 23, 100, 0, sysdate, sysdate);

INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (54, 1, 'Nikon 1 J2 Compact', 'Create your most exciting photos and HD videos yet.<br><br>Capture all the wonderful moments of your life in the brilliance they deserve. The Nikon 1 J2 will inspire your creativity to new heights with fun, artistic in-camera effects, an ultra-high-resolution display for framing and sharing your shots, enhanced controls and the remarkable speed, precision, low-light performance and stylish, compact design that has made the Nikon 1 system so popular. Discover a new passion for creative photography.','http://www.nikonusa.com/en/Nikon-Products/Product/Nikon1/V27573.27573/Nikon-1-J2.html',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (54, 2, 'Nikon 1 J2 Compact', 'Create your most exciting photos and HD videos yet.<br><br>Capture all the wonderful moments of your life in the brilliance they deserve. The Nikon 1 J2 will inspire your creativity to new heights with fun, artistic in-camera effects, an ultra-high-resolution display for framing and sharing your shots, enhanced controls and the remarkable speed, precision, low-light performance and stylish, compact design that has made the Nikon 1 system so popular. Discover a new passion for creative photography.','http://www.nikonusa.com/en/Nikon-Products/Product/Nikon1/V27573.27573/Nikon-1-J2.html',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (54, 3, 'Nikon 1 J2 Compact', 'Create your most exciting photos and HD videos yet.<br><br>Capture all the wonderful moments of your life in the brilliance they deserve. The Nikon 1 J2 will inspire your creativity to new heights with fun, artistic in-camera effects, an ultra-high-resolution display for framing and sharing your shots, enhanced controls and the remarkable speed, precision, low-light performance and stylish, compact design that has made the Nikon 1 system so popular. Discover a new passion for creative photography.','http://www.nikonusa.com/en/Nikon-Products/Product/Nikon1/V27573.27573/Nikon-1-J2.html',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (54, 4, 'Nikon 1 J2 Compact', 'Create your most exciting photos and HD videos yet.<br><br>Capture all the wonderful moments of your life in the brilliance they deserve. The Nikon 1 J2 will inspire your creativity to new heights with fun, artistic in-camera effects, an ultra-high-resolution display for framing and sharing your shots, enhanced controls and the remarkable speed, precision, low-light performance and stylish, compact design that has made the Nikon 1 system so popular. Discover a new passion for creative photography.','http://www.nikonusa.com/en/Nikon-Products/Product/Nikon1/V27573.27573/Nikon-1-J2.html',0);

INSERT INTO products_to_categories (products_id, categories_id) VALUES (54, 25);

-- New Newgate Manufacturer

INSERT INTO manufacturers (manufacturers_id, manufacturers_name, manufacturers_image, date_added, last_modified) VALUES (manufacturers_seq.nextval,'Newgate','manufacturer/newgate.jpg', sysdate, null);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (24, 1, 'http://www.newgateclocks.com/', 0, null);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (24, 2, 'http://www.newgateclocks.com/', 0, null);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (24, 3, 'http://www.newgateclocks.com/', 0, null);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (24, 4, 'http://www.newgateclocks.com/', 0, null);

-- New Newgate Ministry Clock

INSERT INTO products (products_id, products_model, products_price, products_weight, products_status, products_tax_class_id, manufacturers_id, products_quantity, products_ordered, products_date_added, products_date_available) VALUES (products_seq.nextval, 'MINISTRY', 83.99, 2, 1, 1, 24, 100, 0, sysdate, sysdate);

INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (55, 1, 'Ministry Clock', 'Inspiration for this design came from the vintage enamel signage that was once found in stations and shops, but are now only found in flea markets.','http://www.newgateclocks.com/store/Wall-Clocks/min203ar.asp?sn=1',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (55, 2, 'Ministry Clock', 'Inspiration for this design came from the vintage enamel signage that was once found in stations and shops, but are now only found in flea markets.','http://www.newgateclocks.com/store/Wall-Clocks/min203ar.asp?sn=1',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (55, 3, 'Ministry Clock', 'Inspiration for this design came from the vintage enamel signage that was once found in stations and shops, but are now only found in flea markets.','http://www.newgateclocks.com/store/Wall-Clocks/min203ar.asp?sn=1',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (55, 4, 'Ministry Clock', 'Inspiration for this design came from the vintage enamel signage that was once found in stations and shops, but are now only found in flea markets.','http://www.newgateclocks.com/store/Wall-Clocks/min203ar.asp?sn=1',0);

INSERT INTO products_to_categories (products_id, categories_id) VALUES (55, 29);

-- New Newgate 60s Starburst Clock

INSERT INTO products (products_id, products_model, products_price, products_weight, products_status, products_tax_class_id, manufacturers_id, products_quantity, products_ordered, products_date_added, products_date_available) VALUES (products_seq.nextval, 'PLUTOG', 133.99, 2, 1, 1, 24, 100, 0, sysdate, sysdate);

INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (56, 1, '60s Pluto Starburst Clock', 'You can have sun shine in your room 24/7 with our eye-catching Pluto Starburst Clock. It has been a few decades since the originals first made an appearance but our nostalgic Pluto is still going strong and as popular as ever!','http://www.newgateclocks.com/store/Wall-Clocks/plutog.asp?sn=2',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (56, 2, '60s Pluto Starburst Clock', 'You can have sun shine in your room 24/7 with our eye-catching Pluto Starburst Clock. It has been a few decades since the originals first made an appearance but our nostalgic Pluto is still going strong and as popular as ever!','http://www.newgateclocks.com/store/Wall-Clocks/plutog.asp?sn=2',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (56, 3, '60s Pluto Starburst Clock', 'You can have sun shine in your room 24/7 with our eye-catching Pluto Starburst Clock. It has been a few decades since the originals first made an appearance but our nostalgic Pluto is still going strong and as popular as ever!','http://www.newgateclocks.com/store/Wall-Clocks/plutog.asp?sn=2',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (56, 4, '60s Pluto Starburst Clock', 'You can have sun shine in your room 24/7 with our eye-catching Pluto Starburst Clock. It has been a few decades since the originals first made an appearance but our nostalgic Pluto is still going strong and as popular as ever!','http://www.newgateclocks.com/store/Wall-Clocks/plutog.asp?sn=2',0);

INSERT INTO products_to_categories (products_id, categories_id) VALUES (56, 29);

-- New Newgate Vision Clock

INSERT INTO products (products_id, products_model, products_price, products_weight, products_status, products_tax_class_id, manufacturers_id, products_quantity, products_ordered, products_date_added, products_date_available) VALUES (products_seq.nextval, 'PLUTOG', 79.99, 2, 1, 1, 24, 100, 0, sysdate, sysdate);

INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (57, 1, 'Vision Clock', 'You can''t miss this clock when its in pride of place on the wall. Its striking bold acrylic numbers, chrome spokes and bold metal hands, make The Vision a vintage, retro, iconic and contemporary timepiece all rolled into one!','http://www.newgateclocks.com/store/Wall-Clocks/visionk.asp?sn=1',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (57, 2, 'Vision Clock', 'You can''t miss this clock when its in pride of place on the wall. Its striking bold acrylic numbers, chrome spokes and bold metal hands, make The Vision a vintage, retro, iconic and contemporary timepiece all rolled into one!','http://www.newgateclocks.com/store/Wall-Clocks/visionk.asp?sn=1',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (57, 3, 'Vision Clock', 'You can''t miss this clock when its in pride of place on the wall. Its striking bold acrylic numbers, chrome spokes and bold metal hands, make The Vision a vintage, retro, iconic and contemporary timepiece all rolled into one!','http://www.newgateclocks.com/store/Wall-Clocks/visionk.asp?sn=1',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (57, 4, 'Vision Clock', 'You can''t miss this clock when its in pride of place on the wall. Its striking bold acrylic numbers, chrome spokes and bold metal hands, make The Vision a vintage, retro, iconic and contemporary timepiece all rolled into one!','http://www.newgateclocks.com/store/Wall-Clocks/visionk.asp?sn=1',0);

INSERT INTO products_to_categories (products_id, categories_id) VALUES (57, 29);

-- New Office 2010 Software

INSERT INTO products (products_id, products_model, products_price, products_weight, products_status, products_tax_class_id, manufacturers_id, products_quantity, products_ordered, products_date_added, products_date_available) VALUES (products_seq.nextval, 'OFFHOMESTUD', 159.99, 6, 1, 1, 2, 100, 0, sysdate, sysdate);

INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (58, 1, 'Office Home and Student 2010', 'With Microsoft Office Home and Student 2010, you and your kids can create great schoolwork and home projects from multi-page bibliographies to multimedia presentations. Capture ideas and set them apart with video-editing features and dynamic text effects. Then easily collaborate with classmates without being face-to-face thanks to new Web Apps tools. The results go well beyond expectations with a little inspiration, a lot of creativity and Office Home and Student 2010.','http://windows.microsoft.com/',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (58, 2, 'Office Home and Student 2010', 'With Microsoft Office Home and Student 2010, you and your kids can create great schoolwork and home projects from multi-page bibliographies to multimedia presentations. Capture ideas and set them apart with video-editing features and dynamic text effects. Then easily collaborate with classmates without being face-to-face thanks to new Web Apps tools. The results go well beyond expectations with a little inspiration, a lot of creativity and Office Home and Student 2010.','http://windows.microsoft.com/',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (58, 3, 'Office Home and Student 2010', 'With Microsoft Office Home and Student 2010, you and your kids can create great schoolwork and home projects from multi-page bibliographies to multimedia presentations. Capture ideas and set them apart with video-editing features and dynamic text effects. Then easily collaborate with classmates without being face-to-face thanks to new Web Apps tools. The results go well beyond expectations with a little inspiration, a lot of creativity and Office Home and Student 2010.','http://windows.microsoft.com/',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (58, 4, 'Office Home and Student 2010', 'With Microsoft Office Home and Student 2010, you and your kids can create great schoolwork and home projects from multi-page bibliographies to multimedia presentations. Capture ideas and set them apart with video-editing features and dynamic text effects. Then easily collaborate with classmates without being face-to-face thanks to new Web Apps tools. The results go well beyond expectations with a little inspiration, a lot of creativity and Office Home and Student 2010.','http://windows.microsoft.com/',0);

INSERT INTO products_to_categories (products_id, categories_id) VALUES (58, 22);

-- New Bosch MUM48R1 Food Processor

INSERT INTO products (products_id, products_model, products_price, products_weight, products_status, products_tax_class_id, manufacturers_id, products_quantity, products_ordered, products_date_added, products_date_available) VALUES (products_seq.nextval, 'SL500', 199.49, 5, 1, 1, 17, 100, 0, sysdate, sysdate);

INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (59, 1, 'MUM48R1 Food Processor', 'The Bosch MUM48R1 is an irreplaceable kitchen appliance with a clever product design and great range of accessories. The appliance can handle everything from kneading, mixing, slicing, grating as well as a whole host of other tasks that any home chef could need! The 600W power can be set to 4 different levels depending on the specific food or recipe. A food processor is the ideal solution for saving space in the kitchen, and the Bosch MUM48R1 is perfect for performing a wide variety of tasks in a very limited space. The appliance can be easily cleaned after use.','http://www.bosch-home.co.uk/store/category/food_preparation/food_preparation_food_mixers',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (59, 2, 'MUM48R1 Food Processor', 'The Bosch MUM48R1 is an irreplaceable kitchen appliance with a clever product design and great range of accessories. The appliance can handle everything from kneading, mixing, slicing, grating as well as a whole host of other tasks that any home chef could need! The 600W power can be set to 4 different levels depending on the specific food or recipe. A food processor is the ideal solution for saving space in the kitchen, and the Bosch MUM48R1 is perfect for performing a wide variety of tasks in a very limited space. The appliance can be easily cleaned after use.','http://www.bosch-home.co.uk/store/category/food_preparation/food_preparation_food_mixers',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (59, 3, 'MUM48R1 Food Processor', 'The Bosch MUM48R1 is an irreplaceable kitchen appliance with a clever product design and great range of accessories. The appliance can handle everything from kneading, mixing, slicing, grating as well as a whole host of other tasks that any home chef could need! The 600W power can be set to 4 different levels depending on the specific food or recipe. A food processor is the ideal solution for saving space in the kitchen, and the Bosch MUM48R1 is perfect for performing a wide variety of tasks in a very limited space. The appliance can be easily cleaned after use.','http://www.bosch-home.co.uk/store/category/food_preparation/food_preparation_food_mixers',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (59, 4, 'MUM48R1 Food Processor', 'The Bosch MUM48R1 is an irreplaceable kitchen appliance with a clever product design and great range of accessories. The appliance can handle everything from kneading, mixing, slicing, grating as well as a whole host of other tasks that any home chef could need! The 600W power can be set to 4 different levels depending on the specific food or recipe. A food processor is the ideal solution for saving space in the kitchen, and the Bosch MUM48R1 is perfect for performing a wide variety of tasks in a very limited space. The appliance can be easily cleaned after use.','http://www.bosch-home.co.uk/store/category/food_preparation/food_preparation_food_mixers',0);

INSERT INTO products_to_categories (products_id, categories_id) VALUES (59, 28);

-- New Apple iPad with Retina Display

INSERT INTO products (products_id, products_model, products_price, products_weight, products_status, products_tax_class_id, manufacturers_id, products_quantity, products_ordered, products_date_added, products_date_available) VALUES (products_seq.nextval, 'IPADRET', 599.99, 2, 1, 1, 14, 100, 0, sysdate, sysdate);

INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (60, 1, 'iPad', 'Pick up the iPad with Retina display and suddenly, it''s clear. You''re actually touching your photos, reading a book, playing the piano. Nothing comes between you and what you love. That''s because the fundamental elements of iPad — the display, the processor, the cameras, the wireless connection — all work together to create the best possible experience. And they make iPad capable of so much more than you ever imagined.', 'http://www.apple.com/uk/ipad/features/',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (60, 2, 'iPad', 'Pick up the iPad with Retina display and suddenly, it''s clear. You''re actually touching your photos, reading a book, playing the piano. Nothing comes between you and what you love. That''s because the fundamental elements of iPad — the display, the processor, the cameras, the wireless connection — all work together to create the best possible experience. And they make iPad capable of so much more than you ever imagined.', 'http://www.apple.com/uk/ipad/features/',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (60, 3, 'iPad', 'Pick up the iPad with Retina display and suddenly, it''s clear. You''re actually touching your photos, reading a book, playing the piano. Nothing comes between you and what you love. That''s because the fundamental elements of iPad — the display, the processor, the cameras, the wireless connection — all work together to create the best possible experience. And they make iPad capable of so much more than you ever imagined.', 'http://www.apple.com/uk/ipad/features/',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (60, 4, 'iPad', 'Pick up the iPad with Retina display and suddenly, it''s clear. You''re actually touching your photos, reading a book, playing the piano. Nothing comes between you and what you love. That''s because the fundamental elements of iPad — the display, the processor, the cameras, the wireless connection — all work together to create the best possible experience. And they make iPad capable of so much more than you ever imagined.', 'http://www.apple.com/uk/ipad/features/',0);

INSERT INTO products_to_categories (products_id, categories_id) VALUES (60, 26);

-- New Samsung Galaxy Tab 2

INSERT INTO products (products_id, products_model, products_price, products_weight, products_status, products_tax_class_id, manufacturers_id, products_quantity, products_ordered, products_date_added, products_date_available) VALUES (products_seq.nextval, 'GALTAB2', 549.99, 2, 1, 1, 21, 100, 0, sysdate, sysdate);

INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (61, 1, 'Galaxy Tab 2', 'Experience more possibilities on the go with the Samsung Galaxy Tab 10.1. Light and thin and packed with a powerful performance. Supported by the latest Android 4.0 Ice Cream Sandwich operating system, which has been designed specifically for tablet use, everything from the 3D graphics to the latest apps will capture your imagination. It also features Touch Wiz 4.0 for effortless and intuitive multitasking.', 'http://www.samsung.com/global/microsite/galaxytab2/',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (61, 2, 'Galaxy Tab 2', 'Experience more possibilities on the go with the Samsung Galaxy Tab 10.1. Light and thin and packed with a powerful performance. Supported by the latest Android 4.0 Ice Cream Sandwich operating system, which has been designed specifically for tablet use, everything from the 3D graphics to the latest apps will capture your imagination. It also features Touch Wiz 4.0 for effortless and intuitive multitasking.', 'http://www.samsung.com/global/microsite/galaxytab2/',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (61, 3, 'Galaxy Tab 2', 'Experience more possibilities on the go with the Samsung Galaxy Tab 10.1. Light and thin and packed with a powerful performance. Supported by the latest Android 4.0 Ice Cream Sandwich operating system, which has been designed specifically for tablet use, everything from the 3D graphics to the latest apps will capture your imagination. It also features Touch Wiz 4.0 for effortless and intuitive multitasking.', 'http://www.samsung.com/global/microsite/galaxytab2/',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (61, 4, 'Galaxy Tab 2', 'Experience more possibilities on the go with the Samsung Galaxy Tab 10.1. Light and thin and packed with a powerful performance. Supported by the latest Android 4.0 Ice Cream Sandwich operating system, which has been designed specifically for tablet use, everything from the 3D graphics to the latest apps will capture your imagination. It also features Touch Wiz 4.0 for effortless and intuitive multitasking.', 'http://www.samsung.com/global/microsite/galaxytab2/',0);

INSERT INTO products_to_categories (products_id, categories_id) VALUES (61, 26);

-- New Weather Station clock

INSERT INTO products (products_id, products_model, products_price, products_weight, products_status, products_tax_class_id, manufacturers_id, products_quantity, products_ordered, products_date_added, products_date_available) VALUES (products_seq.nextval, 'B000H1QSJY', 21.99, 5, 1, 1, 16, 100, 0, sysdate, sysdate);

INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (62, 1, 'Weather Station Clock', 'Stylish clock featuring hygrometer (humidity) and thermometer dials and sweeping second hand. Aluminium rim. 30.5cm diameter. Retail box.','http://www.eddingtons.co.uk/',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (62, 2, 'Weather Station Clock', 'Stylish clock featuring hygrometer (humidity) and thermometer dials and sweeping second hand. Aluminium rim. 30.5cm diameter. Retail box.','http://www.eddingtons.co.uk/',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (62, 3, 'Weather Station Clock', 'Stylish clock featuring hygrometer (humidity) and thermometer dials and sweeping second hand. Aluminium rim. 30.5cm diameter. Retail box.','http://www.eddingtons.co.uk/',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (62, 4, 'Weather Station Clock', 'Stylish clock featuring hygrometer (humidity) and thermometer dials and sweeping second hand. Aluminium rim. 30.5cm diameter. Retail box.','http://www.eddingtons.co.uk/',0);

INSERT INTO products_to_categories (products_id, categories_id) VALUES (62, 29);

-- Add index to coupon table
CREATE INDEX i_coupon_code_coupon ON coupon (coupon_code);

-- Mouse had wrong manufacturer
UPDATE products SET manufacturers_id = 2 where products_id = 3 and products_model = 'MSIMPRO' and manufacturers_id = 3;

-- Panel for Licensing
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval, 'kk_panel_license','Licensing', sysdate);

-- Add access to the Licensing Panel to all roles that can access the Configuration panel
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, sysdate, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_storeConfiguration' and p2.code='kk_panel_license';

-- ConfigData API calls
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'insertConfigData','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'updateConfigData','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'removeConfigData','', sysdate);

-- Add Euro currency symbol
UPDATE currencies set symbol_left = '€', symbol_right = '' where currencies_id = 2;

-- Google Data Feed - Google Product Link
DELETE FROM configuration WHERE configuration_key = 'GOOGLE_PRODUCT_LINK';
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Google Product Link', 'GOOGLE_PRODUCT_LINK', 'SelectProd.action?prodId=', 'Added to the KonaKart base URL to form a link to a product that is sent to Google.  The ProductId is appended at the end.', '23', '105', now());

-- Image APIs
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'scaleImage','', sysdate);

-- Add extra fields to products table
ALTER TABLE products ADD product_image_dir varchar(64);
ALTER TABLE products ADD product_depth int DEFAULT 0 NOT NULL;
ALTER TABLE products ADD product_width int DEFAULT 0 NOT NULL;
ALTER TABLE products ADD product_length int DEFAULT 0 NOT NULL;
ALTER TABLE products MODIFY products_weight NUMBER(15,2) DEFAULT 0.00;


-- New Activision Manufacturer

INSERT INTO manufacturers (manufacturers_id, manufacturers_name, manufacturers_image, date_added, last_modified) VALUES (manufacturers_seq.nextval,'Activision','manufacturer/activision.jpg', sysdate, null);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (25, 1, 'http://www.activision.com/', 0, null);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (25, 2, 'http://www.activision.com/', 0, null);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (25, 3, 'http://www.activision.com/', 0, null);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (25, 4, 'http://www.activision.com/', 0, null);

-- New Black Ops Game

INSERT INTO products (products_id, products_model, products_price, products_weight, products_status, products_tax_class_id, manufacturers_id, products_quantity, products_ordered, products_date_added, products_date_available) VALUES (products_seq.nextval, 'BLACKOPS2', 39.99, 1, 1, 1, 25, 200, 0, sysdate, sysdate);

INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (63, 1, 'Call Of Duty', 'Call Of Duty - Black Ops2 - Stunning but Violent','http://www.callofduty.com/blackops2',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (63, 2, 'Call Of Duty', 'Call Of Duty - Black Ops2 - Stunning but Violent','http://www.callofduty.com/blackops2',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (63, 3, 'Call Of Duty', 'Call Of Duty - Black Ops2 - Stunning but Violent','http://www.callofduty.com/blackops2',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (63, 4, 'Call Of Duty', 'Call Of Duty - Black Ops2 - Stunning but Violent','http://www.callofduty.com/blackops2',0);

INSERT INTO products_to_categories (products_id, categories_id) VALUES (63, 19);

-- Set new locations for product images
UPDATE products SET products_image = '/prod/9/5/9/9/95992CDB-33D0-46BE-A6EF-4C973B3221B5_1_big.jpg', product_image_dir = '/prod/9/5/9/9/', product_uuid = '95992CDB-33D0-46BE-A6EF-4C973B3221B5' WHERE products_id = 1;
UPDATE products SET products_image = '/prod/7/8/5/7/7857D709-61C6-44C1-A5D4-52E463CBEAA9_1_big.jpg', product_image_dir = '/prod/7/8/5/7/', product_uuid = '7857D709-61C6-44C1-A5D4-52E463CBEAA9' WHERE products_id = 2;
UPDATE products SET products_image = '/prod/1/8/5/3/18536902-5B5C-4FF2-859B-A927EE8F38AF_1_big.jpg', product_image_dir = '/prod/1/8/5/3/', product_uuid = '18536902-5B5C-4FF2-859B-A927EE8F38AF' WHERE products_id = 3;
UPDATE products SET products_image = '/prod/9/3/E/E/93EE9E10-709E-4517-9041-D07C577AFBC9_1_big.jpg', product_image_dir = '/prod/9/3/E/E/', product_uuid = '93EE9E10-709E-4517-9041-D07C577AFBC9' WHERE products_id = 4;
UPDATE products SET products_image = '/prod/8/3/7/7/8377214C-C4A5-41C5-93A5-3A580132C55A_1_big.jpg', product_image_dir = '/prod/8/3/7/7/', product_uuid = '8377214C-C4A5-41C5-93A5-3A580132C55A' WHERE products_id = 5;
UPDATE products SET products_image = '/prod/9/5/2/1/95214187-5DF3-403B-BFEF-16DECA237BF6_1_big.jpg', product_image_dir = '/prod/9/5/2/1/', product_uuid = '95214187-5DF3-403B-BFEF-16DECA237BF6' WHERE products_id = 6;
UPDATE products SET products_image = '/prod/9/2/9/3/92937B41-BC5C-4CB8-92E3-4380A933F6E2_1_big.jpg', product_image_dir = '/prod/9/2/9/3/', product_uuid = '92937B41-BC5C-4CB8-92E3-4380A933F6E2' WHERE products_id = 7;
UPDATE products SET products_image = '/prod/0/6/D/A/06DAD86E-0FA8-4B42-9184-CE1B3F3CE4A6_1_big.jpg', product_image_dir = '/prod/0/6/D/A/', product_uuid = '06DAD86E-0FA8-4B42-9184-CE1B3F3CE4A6' WHERE products_id = 8;
UPDATE products SET products_image = '/prod/A/E/C/2/AEC246F9-F629-4657-B563-15B10F644CC8_1_big.jpg', product_image_dir = '/prod/A/E/C/2/', product_uuid = 'AEC246F9-F629-4657-B563-15B10F644CC8' WHERE products_id = 9;
UPDATE products SET products_image = '/prod/9/6/3/9/9639041E-710D-472A-B87C-85E59C435D82_1_big.jpg', product_image_dir = '/prod/9/6/3/9/', product_uuid = '9639041E-710D-472A-B87C-85E59C435D82' WHERE products_id = 10;
UPDATE products SET products_image = '/prod/3/F/D/D/3FDD11D0-C6F2-45D0-B906-7DDFDA015594_1_big.jpg', product_image_dir = '/prod/3/F/D/D/', product_uuid = '3FDD11D0-C6F2-45D0-B906-7DDFDA015594' WHERE products_id = 11;
UPDATE products SET products_image = '/prod/F/7/E/6/F7E61CE3-5778-4790-A705-EE2D9980E979_1_big.jpg', product_image_dir = '/prod/F/7/E/6/', product_uuid = 'F7E61CE3-5778-4790-A705-EE2D9980E979' WHERE products_id = 12;
UPDATE products SET products_image = '/prod/6/7/7/E/677E32E4-1DB2-44AD-A5BF-3CE389A25D3F_1_big.jpg', product_image_dir = '/prod/6/7/7/E/', product_uuid = '677E32E4-1DB2-44AD-A5BF-3CE389A25D3F' WHERE products_id = 13;
UPDATE products SET products_image = '/prod/F/3/1/8/F3186F6D-20DB-49A8-84F8-3F98BE3BA076_1_big.jpg', product_image_dir = '/prod/F/3/1/8/', product_uuid = 'F3186F6D-20DB-49A8-84F8-3F98BE3BA076' WHERE products_id = 14;
UPDATE products SET products_image = '/prod/E/6/A/B/E6AB1135-5B32-4FD1-BF28-12C5CD256CD9_1_big.jpg', product_image_dir = '/prod/E/6/A/B/', product_uuid = 'E6AB1135-5B32-4FD1-BF28-12C5CD256CD9' WHERE products_id = 15;
UPDATE products SET products_image = '/prod/2/1/E/0/21E0683C-62A7-4282-A36F-E0D6BC9AE8A2_1_big.jpg', product_image_dir = '/prod/2/1/E/0/', product_uuid = '21E0683C-62A7-4282-A36F-E0D6BC9AE8A2' WHERE products_id = 16;
UPDATE products SET products_image = '/prod/8/C/7/A/8C7A57B8-A6B5-48A5-A965-87A7D728F1BE_1_big.jpg', product_image_dir = '/prod/8/C/7/A/', product_uuid = '8C7A57B8-A6B5-48A5-A965-87A7D728F1BE' WHERE products_id = 17;
UPDATE products SET products_image = '/prod/C/5/1/A/C51A6C94-27CC-4159-89CF-D8EEFDBB2928_1_big.jpg', product_image_dir = '/prod/C/5/1/A/', product_uuid = 'C51A6C94-27CC-4159-89CF-D8EEFDBB2928' WHERE products_id = 18;
UPDATE products SET products_image = '/prod/C/1/9/2/C1929825-BD7C-4FE3-8AE8-DFEA73A230F0_1_big.jpg', product_image_dir = '/prod/C/1/9/2/', product_uuid = 'C1929825-BD7C-4FE3-8AE8-DFEA73A230F0' WHERE products_id = 19;
UPDATE products SET products_image = '/prod/6/8/9/6/68965D51-F873-4D1B-8A37-92A340E5B913_1_big.jpg', product_image_dir = '/prod/6/8/9/6/', product_uuid = '68965D51-F873-4D1B-8A37-92A340E5B913' WHERE products_id = 20;
UPDATE products SET products_image = '/prod/C/4/9/4/C4941395-021B-4C97-B46C-A4491AD3D620_1_big.jpg', product_image_dir = '/prod/C/4/9/4/', product_uuid = 'C4941395-021B-4C97-B46C-A4491AD3D620' WHERE products_id = 21;
UPDATE products SET products_image = '/prod/5/7/D/3/57D32457-0C8A-4387-9680-1B4861AE6178_1_big.jpg', product_image_dir = '/prod/5/7/D/3/', product_uuid = '57D32457-0C8A-4387-9680-1B4861AE6178' WHERE products_id = 22;
UPDATE products SET products_image = '/prod/F/9/8/F/F98FF9EA-110B-4096-AD22-1423E0E78C36_1_big.jpg', product_image_dir = '/prod/F/9/8/F/', product_uuid = 'F98FF9EA-110B-4096-AD22-1423E0E78C36' WHERE products_id = 23;
UPDATE products SET products_image = '/prod/3/8/3/B/383B8D87-B3EA-4AAF-B0AB-9614C17463F3_1_big.jpg', product_image_dir = '/prod/3/8/3/B/', product_uuid = '383B8D87-B3EA-4AAF-B0AB-9614C17463F3' WHERE products_id = 24;
UPDATE products SET products_image = '/prod/0/0/1/F/001F1EAA-2910-440E-BB8D-C714E0E859B4_1_big.jpg', product_image_dir = '/prod/0/0/1/F/', product_uuid = '001F1EAA-2910-440E-BB8D-C714E0E859B4' WHERE products_id = 25;
UPDATE products SET products_image = '/prod/F/E/F/2/FEF2DB86-728E-4C6A-A3FA-4F4B099D28E6_1_big.jpg', product_image_dir = '/prod/F/E/F/2/', product_uuid = 'FEF2DB86-728E-4C6A-A3FA-4F4B099D28E6' WHERE products_id = 26;
UPDATE products SET products_image = '/prod/5/1/B/7/51B73EC2-0845-4837-B125-EC8041C0EA76_1_big.jpg', product_image_dir = '/prod/5/1/B/7/', product_uuid = '51B73EC2-0845-4837-B125-EC8041C0EA76' WHERE products_id = 27;
UPDATE products SET products_image = '/prod/E/3/8/4/E384D77F-69C0-4DA9-97DE-32F042B437DB_1_big.jpg', product_image_dir = '/prod/E/3/8/4/', product_uuid = 'E384D77F-69C0-4DA9-97DE-32F042B437DB' WHERE products_id = 28;
UPDATE products SET products_image = '/prod/E/D/7/0/ED709A75-1C44-4983-ADB5-B42E963452C3_1_big.jpg', product_image_dir = '/prod/E/D/7/0/', product_uuid = 'ED709A75-1C44-4983-ADB5-B42E963452C3' WHERE products_id = 29;
UPDATE products SET products_image = '/prod/D/A/1/A/DA1A02B1-B200-4125-BBFA-22EE7D01963A_1_big.jpg', product_image_dir = '/prod/D/A/1/A/', product_uuid = 'DA1A02B1-B200-4125-BBFA-22EE7D01963A' WHERE products_id = 30;
UPDATE products SET products_image = '/prod/B/9/9/0/B990FBA5-CCFF-467D-A6ED-230298BB609E_1_big.jpg', product_image_dir = '/prod/B/9/9/0/', product_uuid = 'B990FBA5-CCFF-467D-A6ED-230298BB609E' WHERE products_id = 31;
UPDATE products SET products_image = '/prod/D/D/D/4/DDD4F497-9212-4E73-BD2E-2B56428E51A2_1_big.jpg', product_image_dir = '/prod/D/D/D/4/', product_uuid = 'DDD4F497-9212-4E73-BD2E-2B56428E51A2' WHERE products_id = 32;
UPDATE products SET products_image = '/prod/F/9/8/F/F98F155B-2D6D-41C0-897F-3071B6354AD8_1_big.jpg', product_image_dir = '/prod/F/9/8/F/', product_uuid = 'F98F155B-2D6D-41C0-897F-3071B6354AD8' WHERE products_id = 33;
UPDATE products SET products_image = '/prod/5/A/A/C/5AAC7490-1BB8-4980-BA0A-F49B25ADBA71_1_big.jpg', product_image_dir = '/prod/5/A/A/C/', product_uuid = '5AAC7490-1BB8-4980-BA0A-F49B25ADBA71' WHERE products_id = 34;
UPDATE products SET products_image = '/prod/3/7/4/F/374F4985-53E5-49FF-A277-4A8AEE40FE0D_1_big.jpg', product_image_dir = '/prod/3/7/4/F/', product_uuid = '374F4985-53E5-49FF-A277-4A8AEE40FE0D' WHERE products_id = 35;
UPDATE products SET products_image = '/prod/A/F/0/E/AF0E40B3-70C4-4A12-9026-5784BBD23C06_1_big.jpg', product_image_dir = '/prod/A/F/0/E/', product_uuid = 'AF0E40B3-70C4-4A12-9026-5784BBD23C06' WHERE products_id = 36;
UPDATE products SET products_image = '/prod/A/5/9/6/A5966A16-B912-47C8-980C-60B7CDFC9177_1_big.jpg', product_image_dir = '/prod/A/5/9/6/', product_uuid = 'A5966A16-B912-47C8-980C-60B7CDFC9177' WHERE products_id = 37;
UPDATE products SET products_image = '/prod/B/1/8/1/B181BD28-2701-4703-A30F-5056517A55C7_1_big.jpg', product_image_dir = '/prod/B/1/8/1/', product_uuid = 'B181BD28-2701-4703-A30F-5056517A55C7' WHERE products_id = 38;
UPDATE products SET products_image = '/prod/1/5/F/8/15F8FBB1-13DA-4A47-B3D2-0F1E7BECAE7C_1_big.jpg', product_image_dir = '/prod/1/5/F/8/', product_uuid = '15F8FBB1-13DA-4A47-B3D2-0F1E7BECAE7C' WHERE products_id = 39;
UPDATE products SET products_image = '/prod/4/A/6/B/4A6B2621-4689-41D7-9BB6-9C2A4200F39E_1_big.jpg', product_image_dir = '/prod/4/A/6/B/', product_uuid = '4A6B2621-4689-41D7-9BB6-9C2A4200F39E' WHERE products_id = 40;
UPDATE products SET products_image = '/prod/9/5/7/8/95782936-65F3-448F-BF8E-A0F5409B5048_1_big.jpg', product_image_dir = '/prod/9/5/7/8/', product_uuid = '95782936-65F3-448F-BF8E-A0F5409B5048' WHERE products_id = 41;
UPDATE products SET products_image = '/prod/1/1/B/C/11BC0D25-1B08-4141-BABB-1B1E633CB382_1_big.jpg', product_image_dir = '/prod/1/1/B/C/', product_uuid = '11BC0D25-1B08-4141-BABB-1B1E633CB382' WHERE products_id = 42;
UPDATE products SET products_image = '/prod/A/2/1/C/A21CA25F-645B-4D88-9539-1407737EC790_1_big.jpg', product_image_dir = '/prod/A/2/1/C/', product_uuid = 'A21CA25F-645B-4D88-9539-1407737EC790' WHERE products_id = 43;
UPDATE products SET products_image = '/prod/9/4/C/A/94CA0B48-0BCA-4696-A688-93C626E120F0_1_big.jpg', product_image_dir = '/prod/9/4/C/A/', product_uuid = '94CA0B48-0BCA-4696-A688-93C626E120F0' WHERE products_id = 44;
UPDATE products SET products_image = '/prod/4/0/4/1/4041A0F2-D827-4E55-ACAB-A1FDC48E423A_1_big.jpg', product_image_dir = '/prod/4/0/4/1/', product_uuid = '4041A0F2-D827-4E55-ACAB-A1FDC48E423A' WHERE products_id = 45;
UPDATE products SET products_image = '/prod/9/0/D/6/90D61688-734D-47CE-B98E-D4AAD5C5AA81_1_big.jpg', product_image_dir = '/prod/9/0/D/6/', product_uuid = '90D61688-734D-47CE-B98E-D4AAD5C5AA81' WHERE products_id = 46;
UPDATE products SET products_image = '/prod/6/D/F/6/6DF6E083-1AFA-4ADB-B91D-8C82D2CB3013_1_big.jpg', product_image_dir = '/prod/6/D/F/6/', product_uuid = '6DF6E083-1AFA-4ADB-B91D-8C82D2CB3013' WHERE products_id = 47;
UPDATE products SET products_image = '/prod/A/3/8/B/A38BC2F7-4BC2-4602-ABC1-053ABF1664DB_1_big.jpg', product_image_dir = '/prod/A/3/8/B/', product_uuid = 'A38BC2F7-4BC2-4602-ABC1-053ABF1664DB' WHERE products_id = 48;
UPDATE products SET products_image = '/prod/2/D/F/3/2DF3A010-69FC-4C33-B412-CC9921D162FB_1_big.jpg', product_image_dir = '/prod/2/D/F/3/', product_uuid = '2DF3A010-69FC-4C33-B412-CC9921D162FB' WHERE products_id = 49;
UPDATE products SET products_image = '/prod/9/6/A/2/96A22190-8D96-430E-8D29-F1B203994759_1_big.jpg', product_image_dir = '/prod/9/6/A/2/', product_uuid = '96A22190-8D96-430E-8D29-F1B203994759' WHERE products_id = 50;
UPDATE products SET products_image = '/prod/B/0/C/B/B0CBFAA6-C865-4DDC-9451-3ABEC85FB2D2_1_big.jpg', product_image_dir = '/prod/B/0/C/B/', product_uuid = 'B0CBFAA6-C865-4DDC-9451-3ABEC85FB2D2' WHERE products_id = 51;
UPDATE products SET products_image = '/prod/7/0/2/6/70261953-3F55-4999-A644-5EC19A321886_1_big.jpg', product_image_dir = '/prod/7/0/2/6/', product_uuid = '70261953-3F55-4999-A644-5EC19A321886' WHERE products_id = 52;
UPDATE products SET products_image = '/prod/1/B/3/F/1B3F5FA1-469D-4B95-8EE1-42A5856961BC_1_big.jpg', product_image_dir = '/prod/1/B/3/F/', product_uuid = '1B3F5FA1-469D-4B95-8EE1-42A5856961BC' WHERE products_id = 53;
UPDATE products SET products_image = '/prod/E/C/D/2/ECD283D0-BFFD-4639-8B08-965C3470B895_1_big.jpg', product_image_dir = '/prod/E/C/D/2/', product_uuid = 'ECD283D0-BFFD-4639-8B08-965C3470B895' WHERE products_id = 54;
UPDATE products SET products_image = '/prod/5/E/8/9/5E89B135-269C-4094-81F1-A71C98D1412A_1_big.jpg', product_image_dir = '/prod/5/E/8/9/', product_uuid = '5E89B135-269C-4094-81F1-A71C98D1412A' WHERE products_id = 55;
UPDATE products SET products_image = '/prod/A/8/6/C/A86C794E-5C00-4F5D-8D01-121C01E6A470_1_big.jpg', product_image_dir = '/prod/A/8/6/C/', product_uuid = 'A86C794E-5C00-4F5D-8D01-121C01E6A470' WHERE products_id = 56;
UPDATE products SET products_image = '/prod/1/0/3/0/10301426-3620-418E-AF4D-4319F708E564_1_big.jpg', product_image_dir = '/prod/1/0/3/0/', product_uuid = '10301426-3620-418E-AF4D-4319F708E564' WHERE products_id = 57;
UPDATE products SET products_image = '/prod/F/F/0/6/FF06923B-46B1-4F4B-9A6F-A68276A56FE5_1_big.jpg', product_image_dir = '/prod/F/F/0/6/', product_uuid = 'FF06923B-46B1-4F4B-9A6F-A68276A56FE5' WHERE products_id = 58;
UPDATE products SET products_image = '/prod/E/7/B/8/E7B8896B-3199-4C4A-966D-9CCD3EFAA33C_1_big.jpg', product_image_dir = '/prod/E/7/B/8/', product_uuid = 'E7B8896B-3199-4C4A-966D-9CCD3EFAA33C' WHERE products_id = 59;
UPDATE products SET products_image = '/prod/5/4/F/D/54FDD302-5B74-4075-8C2E-B9E11A0EEF2E_1_big.jpg', product_image_dir = '/prod/5/4/F/D/', product_uuid = '54FDD302-5B74-4075-8C2E-B9E11A0EEF2E' WHERE products_id = 60;
UPDATE products SET products_image = '/prod/3/1/1/1/3111B14C-0BC1-45E4-A4F9-968DAD99B6F2_1_big.jpg', product_image_dir = '/prod/3/1/1/1/', product_uuid = '3111B14C-0BC1-45E4-A4F9-968DAD99B6F2' WHERE products_id = 61;
UPDATE products SET products_image = '/prod/C/0/2/C/C02C89ED-CB73-4150-BB41-0726DEE2E5A1_1_big.jpg', product_image_dir = '/prod/C/0/2/C/', product_uuid = 'C02C89ED-CB73-4150-BB41-0726DEE2E5A1' WHERE products_id = 62;
UPDATE products SET products_image = '/prod/8/6/D/7/86D70649-28A3-492D-A18E-B6BB0934EB7C_1_big.jpg', product_image_dir = '/prod/8/6/D/7/', product_uuid = '86D70649-28A3-492D-A18E-B6BB0934EB7C' WHERE products_id = 63;

-- Reset Login base URL for new storefront
UPDATE configuration SET configuration_value='https://localhost:8783/konakart/AdminLoginSubmit.action' WHERE configuration_key='ADMIN_APP_LOGIN_BASE_URL';

-- Misc Items types
INSERT INTO kk_misc_item_type (kk_misc_item_type_id, language_id, name, description) VALUES (1, 1, 'Banner_1', 'Top banner');
INSERT INTO kk_misc_item_type (kk_misc_item_type_id, language_id, name, description) VALUES (1, 2, 'Banner_1', 'Top banner');
INSERT INTO kk_misc_item_type (kk_misc_item_type_id, language_id, name, description) VALUES (1, 3, 'Banner_1', 'Top banner');
INSERT INTO kk_misc_item_type (kk_misc_item_type_id, language_id, name, description) VALUES (1, 4, 'Banner_1', 'Top banner');
INSERT INTO kk_misc_item_type (kk_misc_item_type_id, language_id, name, description) VALUES (2, 1, 'Banner_2', '2nd banner');
INSERT INTO kk_misc_item_type (kk_misc_item_type_id, language_id, name, description) VALUES (2, 2, 'Banner_2', '2nd banner');
INSERT INTO kk_misc_item_type (kk_misc_item_type_id, language_id, name, description) VALUES (2, 3, 'Banner_2', '2nd banner');
INSERT INTO kk_misc_item_type (kk_misc_item_type_id, language_id, name, description) VALUES (2, 4, 'Banner_2', '2nd banner');
INSERT INTO kk_misc_item_type (kk_misc_item_type_id, language_id, name, description) VALUES (3, 1, 'Banner_3', '3rd banner');
INSERT INTO kk_misc_item_type (kk_misc_item_type_id, language_id, name, description) VALUES (3, 2, 'Banner_3', '3rd banner');
INSERT INTO kk_misc_item_type (kk_misc_item_type_id, language_id, name, description) VALUES (3, 3, 'Banner_3', '3rd banner');
INSERT INTO kk_misc_item_type (kk_misc_item_type_id, language_id, name, description) VALUES (3, 4, 'Banner_3', '3rd banner');

-- Misc Items for categories
--cat 1 Computer Peripherals
INSERT INTO kk_misc_item (kk_misc_item_id, kk_obj_id, kk_obj_type_id, kk_misc_item_type_id, item_value, custom1) VALUES (kk_misc_item_seq.nextval,  1, 2, 1, 'images/banners/computer-peripherals/logitech-keyboard.jpg', 'SelectProd.action?prodId=31' );
INSERT INTO kk_misc_item (kk_misc_item_id, kk_obj_id, kk_obj_type_id, kk_misc_item_type_id, item_value, custom1) VALUES (kk_misc_item_seq.nextval,  1, 2, 2, 'images/banners/computer-peripherals/hp-photosmart.jpg','SelectProd.action?prodId=27' );
INSERT INTO kk_misc_item (kk_misc_item_id, kk_obj_id, kk_obj_type_id, kk_misc_item_type_id, item_value, custom1) VALUES (kk_misc_item_seq.nextval,  1, 2, 3, 'images/banners/computer-peripherals/deals-of-the-week.jpg', '' );
--cat 2 Games
INSERT INTO kk_misc_item (kk_misc_item_id, kk_obj_id, kk_obj_type_id, kk_misc_item_type_id, item_value, custom1) VALUES (kk_misc_item_seq.nextval,  2, 2, 1, 'images/banners/games/black-ops-2.jpg', 'SelectProd.action?prodId=63' );
INSERT INTO kk_misc_item (kk_misc_item_id, kk_obj_id, kk_obj_type_id, kk_misc_item_type_id, item_value, custom1) VALUES (kk_misc_item_seq.nextval,  2, 2, 2, 'images/banners/games/swat3.jpg','SelectProd.action?prodId=21' );
INSERT INTO kk_misc_item (kk_misc_item_id, kk_obj_id, kk_obj_type_id, kk_misc_item_type_id, item_value, custom1) VALUES (kk_misc_item_seq.nextval,  2, 2, 3, 'images/banners/games/winter-deals.jpg', '' );
--cat 3 DVD Movies
INSERT INTO kk_misc_item (kk_misc_item_id, kk_obj_id, kk_obj_type_id, kk_misc_item_type_id, item_value, custom1) VALUES (kk_misc_item_seq.nextval,  3, 2, 1, 'images/banners/movies/dark-knight.jpg', 'SelectProd.action?prodId=20' );
INSERT INTO kk_misc_item (kk_misc_item_id, kk_obj_id, kk_obj_type_id, kk_misc_item_type_id, item_value, custom1) VALUES (kk_misc_item_seq.nextval,  3, 2, 2, 'images/banners/movies/harry-potter.jpg','SelectProd.action?prodId=11' );
INSERT INTO kk_misc_item (kk_misc_item_id, kk_obj_id, kk_obj_type_id, kk_misc_item_type_id, item_value, custom1) VALUES (kk_misc_item_seq.nextval,  3, 2, 3, 'images/banners/movies/movie-deals.jpg', '' );
--cat 23 Electronics
INSERT INTO kk_misc_item (kk_misc_item_id, kk_obj_id, kk_obj_type_id, kk_misc_item_type_id, item_value, custom1) VALUES (kk_misc_item_seq.nextval,  23, 2, 1, 'images/banners/electronics/kindle-fire-hd.jpg', 'SelectProd.action?prodId=34' );
INSERT INTO kk_misc_item (kk_misc_item_id, kk_obj_id, kk_obj_type_id, kk_misc_item_type_id, item_value, custom1) VALUES (kk_misc_item_seq.nextval,  23, 2, 2, 'images/banners/electronics/canon-powershot.jpg','SelectProd.action?prodId=49' );
INSERT INTO kk_misc_item (kk_misc_item_id, kk_obj_id, kk_obj_type_id, kk_misc_item_type_id, item_value, custom1) VALUES (kk_misc_item_seq.nextval,  23, 2, 3, 'images/banners/electronics/electronics-sale.jpg', '' );
--cat 24 Home and Garden
INSERT INTO kk_misc_item (kk_misc_item_id, kk_obj_id, kk_obj_type_id, kk_misc_item_type_id, item_value, custom1) VALUES (kk_misc_item_seq.nextval,  24, 2, 1, 'images/banners/home-and-garden/delonghi.jpg', 'SelectProd.action?prodId=33' );
INSERT INTO kk_misc_item (kk_misc_item_id, kk_obj_id, kk_obj_type_id, kk_misc_item_type_id, item_value, custom1) VALUES (kk_misc_item_seq.nextval,  24, 2, 2, 'images/banners/home-and-garden/rotak-40.jpg','SelectProd.action?prodId=39' );
INSERT INTO kk_misc_item (kk_misc_item_id, kk_obj_id, kk_obj_type_id, kk_misc_item_type_id, item_value, custom1) VALUES (kk_misc_item_seq.nextval,  24, 2, 3, 'images/banners/home-and-garden/gifts-for-the-home.jpg', '' );

-- Assign some featured products
UPDATE products SET custom1 = 'featured' where products_id = 39;
UPDATE products SET custom1 = 'featured' where products_id = 40;
UPDATE products SET custom1 = 'featured' where products_id = 41;
UPDATE products SET custom1 = 'featured' where products_id = 42;
UPDATE products SET custom1 = 'featured' where products_id = 33;
UPDATE products SET custom1 = 'featured' where products_id = 43;
UPDATE products SET custom1 = 'featured' where products_id = 44;
UPDATE products SET custom1 = 'featured' where products_id = 59;

-----------------  v6.6.0.0

-- Add custom privileges for the Customers panel - default to allow access to the Custom button - custom 3 hides it
UPDATE kk_role_to_panel SET custom3=0, custom3_desc='If set custom button is hidden' WHERE panel_id IN (SELECT panel_id FROM kk_panel where code='kk_panel_customerForOrder_2');
UPDATE kk_role_to_panel SET custom3=0, custom3_desc='If set custom button is hidden' WHERE panel_id IN (SELECT panel_id FROM kk_panel where code='kk_panel_customers_2');

-- Increase the minimum password length to match the storefront validation
UPDATE configuration SET configuration_value='8' WHERE configuration_key = 'ENTRY_PASSWORD_MIN_LENGTH';

-- Modify image path for Misc Items for categories
--cat 1 Computer Peripherals
UPDATE kk_misc_item set item_value = 'banners/computer-peripherals/logitech-keyboard.jpg' where item_value='images/banners/computer-peripherals/logitech-keyboard.jpg';
UPDATE kk_misc_item set item_value = 'banners/computer-peripherals/hp-photosmart.jpg' where item_value='images/banners/computer-peripherals/hp-photosmart.jpg';
UPDATE kk_misc_item set item_value = 'banners/computer-peripherals/deals-of-the-week.jpg' where item_value='images/banners/computer-peripherals/deals-of-the-week.jpg';
--cat 2 Games
UPDATE kk_misc_item set item_value = 'banners/games/black-ops-2.jpg' where item_value='images/banners/games/black-ops-2.jpg';
UPDATE kk_misc_item set item_value = 'banners/games/swat3.jpg' where item_value='images/banners/games/swat3.jpg';
UPDATE kk_misc_item set item_value = 'banners/games/winter-deals.jpg' where item_value='images/banners/games/winter-deals.jpg';
--cat 3 DVD Movies
UPDATE kk_misc_item set item_value = 'banners/movies/dark-knight.jpg' where item_value='images/banners/movies/dark-knight.jpg';
UPDATE kk_misc_item set item_value = 'banners/movies/harry-potter.jpg' where item_value='images/banners/movies/harry-potter.jpg';
UPDATE kk_misc_item set item_value = 'banners/movies/movie-deals.jpg' where item_value='images/banners/movies/movie-deals.jpg';
--cat 23 Electronics
UPDATE kk_misc_item set item_value = 'banners/electronics/kindle-fire-hd.jpg' where item_value='images/banners/electronics/kindle-fire-hd.jpg';
UPDATE kk_misc_item set item_value = 'banners/electronics/canon-powershot.jpg' where item_value='images/banners/electronics/canon-powershot.jpg';
UPDATE kk_misc_item set item_value = 'banners/electronics/electronics-sale.jpg' where item_value='images/banners/electronics/electronics-sale.jpg';
--cat 24 Home and Garden
UPDATE kk_misc_item set item_value = 'banners/home-and-garden/delonghi.jpg' where item_value='images/banners/home-and-garden/delonghi.jpg';
UPDATE kk_misc_item set item_value = 'banners/home-and-garden/rotak-40.jpg' where item_value='images/banners/home-and-garden/rotak-40.jpg';
UPDATE kk_misc_item set item_value = 'banners/home-and-garden/gifts-for-the-home.jpg' where item_value='images/banners/home-and-garden/gifts-for-the-home.jpg';

-- Add extra custom fields to the kk_cust_attr table
ALTER TABLE kk_cust_attr ADD custom4 varchar(128);
ALTER TABLE kk_cust_attr ADD custom5 varchar(128);

-- Add some dimensions to the sample products (in mm)
UPDATE products SET product_length=200, product_width=50, product_depth=20 where products_id=1;
UPDATE products SET product_length=200, product_width=50, product_depth=20 where products_id=2;
UPDATE products SET product_length=260, product_width=140, product_depth=40 where products_id=3;
UPDATE products SET product_length=200, product_width=140, product_depth=20 where products_id=4;
UPDATE products SET product_length=200, product_width=140, product_depth=20 where products_id=5;
UPDATE products SET product_length=200, product_width=140, product_depth=20 where products_id=6;
UPDATE products SET product_length=200, product_width=140, product_depth=20 where products_id=7;
UPDATE products SET product_length=200, product_width=140, product_depth=20 where products_id=8;
UPDATE products SET product_length=200, product_width=140, product_depth=20 where products_id=9;
UPDATE products SET product_length=200, product_width=140, product_depth=20 where products_id=10;
UPDATE products SET product_length=200, product_width=140, product_depth=20 where products_id=11;
UPDATE products SET product_length=200, product_width=140, product_depth=20 where products_id=12;
UPDATE products SET product_length=200, product_width=140, product_depth=20 where products_id=13;
UPDATE products SET product_length=200, product_width=140, product_depth=20 where products_id=14;
UPDATE products SET product_length=200, product_width=140, product_depth=20 where products_id=15;
UPDATE products SET product_length=200, product_width=140, product_depth=20 where products_id=16;
UPDATE products SET product_length=200, product_width=140, product_depth=20 where products_id=17;
UPDATE products SET product_length=200, product_width=140, product_depth=20 where products_id=18;
UPDATE products SET product_length=200, product_width=140, product_depth=20 where products_id=19;
UPDATE products SET product_length=200, product_width=140, product_depth=20 where products_id=20;
UPDATE products SET product_length=200, product_width=140, product_depth=20 where products_id=21;
UPDATE products SET product_length=200, product_width=140, product_depth=20 where products_id=22;
UPDATE products SET product_length=200, product_width=140, product_depth=20 where products_id=23;
UPDATE products SET product_length=200, product_width=140, product_depth=20 where products_id=24;
UPDATE products SET product_length=550, product_width=160, product_depth=60 where products_id=25;
UPDATE products SET product_length=300, product_width=140, product_depth=60 where products_id=26;
UPDATE products SET product_length=900, product_width=600, product_depth=600 where products_id=27;
UPDATE products SET product_length=600, product_width=240, product_depth=100 where products_id=28;
UPDATE products SET product_length=0, product_width=0, product_depth=0 where products_id=29;
UPDATE products SET product_length=900, product_width=600, product_depth=600 where products_id=30;
UPDATE products SET product_length=550, product_width=160, product_depth=60 where products_id=31;
UPDATE products SET product_length=240, product_width=120, product_depth=80 where products_id=32;
UPDATE products SET product_length=500, product_width=400, product_depth=200 where products_id=33;
UPDATE products SET product_length=260, product_width=240, product_depth=100 where products_id=34;
UPDATE products SET product_length=260, product_width=240, product_depth=100 where products_id=35;
UPDATE products SET product_length=500, product_width=500, product_depth=120 where products_id=36;
UPDATE products SET product_length=500, product_width=500, product_depth=120 where products_id=37;
UPDATE products SET product_length=500, product_width=500, product_depth=120 where products_id=38;
UPDATE products SET product_length=2800, product_width=1200, product_depth=1000 where products_id=39;
UPDATE products SET product_length=2800, product_width=1200, product_depth=1000 where products_id=40;
UPDATE products SET product_length=2800, product_width=1200, product_depth=1000 where products_id=41;
UPDATE products SET product_length=2800, product_width=1200, product_depth=1000 where products_id=42;
UPDATE products SET product_length=600, product_width=400, product_depth=220 where products_id=43;
UPDATE products SET product_length=1000, product_width=500, product_depth=500 where products_id=44;
UPDATE products SET product_length=260, product_width=240, product_depth=100 where products_id=45;
UPDATE products SET product_length=260, product_width=240, product_depth=100 where products_id=46;
UPDATE products SET product_length=260, product_width=240, product_depth=100 where products_id=47;
UPDATE products SET product_length=260, product_width=240, product_depth=100 where products_id=48;
UPDATE products SET product_length=320, product_width=280, product_depth=180 where products_id=49;
UPDATE products SET product_length=320, product_width=280, product_depth=180 where products_id=50;
UPDATE products SET product_length=320, product_width=280, product_depth=180 where products_id=51;
UPDATE products SET product_length=320, product_width=280, product_depth=180 where products_id=52;
UPDATE products SET product_length=320, product_width=280, product_depth=180 where products_id=53;
UPDATE products SET product_length=320, product_width=280, product_depth=180 where products_id=54;
UPDATE products SET product_length=500, product_width=500, product_depth=120 where products_id=55;
UPDATE products SET product_length=500, product_width=500, product_depth=120 where products_id=56;
UPDATE products SET product_length=500, product_width=500, product_depth=120 where products_id=57;
UPDATE products SET product_length=240, product_width=120, product_depth=80 where products_id=58;
UPDATE products SET product_length=800, product_width=600, product_depth=240 where products_id=59;
UPDATE products SET product_length=320, product_width=180, product_depth=180 where products_id=60;
UPDATE products SET product_length=320, product_width=180, product_depth=180 where products_id=61;
UPDATE products SET product_length=500, product_width=500, product_depth=120 where products_id=62;
UPDATE products SET product_length=200, product_width=140, product_depth=20 where products_id=63;

-- Make model codes unique
UPDATE products SET products_model='KFIREHD' where products_id=34;
UPDATE products SET products_model='IPHONE5' where products_id=35;
UPDATE products SET products_model='MV800' where products_id=50;
UPDATE products SET products_model='VISCLOCK' where products_id=57;
UPDATE products SET products_model='WSCLOCK' where products_id=62;

-- Batch Log file location
DELETE FROM configuration WHERE configuration_key = 'BATCH_LOG_FILE_DIRECTORY';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (configuration_seq.nextval, 'Batch Log file Directory', 'BATCH_LOG_FILE_DIRECTORY', 'C:/Program Files/KonaKart/batchlogs/', 'The location where KonaKart will write batch log files', '20', '2', sysdate);

-- Scheduler APIs
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'getJobStatus','', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'runBatchJob','', sysdate);

-- Panels for Scheduling
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval, 'kk_panel_jobs','Scheduled Jobs', sysdate);
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval, 'kk_panel_viewBatchLogs','View Batch Jobs', sysdate);

-- Add access to the Scheduling Panel to all roles that can access the Configuration panel
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, sysdate, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_storeConfiguration' and p2.code='kk_panel_jobs';

-- Add access to the View Batch Logs Panel to all roles that can access the Configuration panel
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, sysdate, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_storeConfiguration' and p2.code='kk_panel_viewBatchLogs';

-- Admin APIs
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'insertProductCategory', '', sysdate);

-- Extend the size of the order name fields
ALTER TABLE orders MODIFY customers_name VARCHAR(66);
ALTER TABLE orders MODIFY delivery_name VARCHAR(66);
ALTER TABLE orders MODIFY billing_name VARCHAR(66);

-- New Batch jobs
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'com.konakartadmin.bl.AdminCustomerBatchMgr.countCustomersBatch', '', sysdate);

-- New config variables for mobile application
DELETE FROM configuration WHERE configuration_key = 'STORE_FRONT_SCRIPT_BASE_M';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, return_by_api, date_added) VALUES (configuration_seq.nextval, 'Mobile Store-Front script base','STORE_FRONT_SCRIPT_BASE_M','/konakart-m/script','Script base used in JSPs for mobile store-front application','4', '20', 1, sysdate);
DELETE FROM configuration WHERE configuration_key = 'STORE_FRONT_STYLE_BASE_M';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, return_by_api, date_added) VALUES (configuration_seq.nextval, 'Mobile Store-Front style sheet base','STORE_FRONT_STYLE_BASE_M','/konakart-m/styles','Style sheet base used in JSPs for mobile store-front application','4', '21', 1, sysdate);

-- Note that here we only create them as VARCHAR(2) here (to optimise performance for users who don't need these)
-- If you need them to be longer you can modify these columns and change the Admin App validation to suit your needs
ALTER TABLE products_description ADD customd1 VARCHAR(2);
ALTER TABLE products_description ADD customd2 VARCHAR(2);
ALTER TABLE products_description ADD customd3 VARCHAR(2);
ALTER TABLE products_description ADD customd4 VARCHAR(2);
ALTER TABLE products_description ADD customd5 VARCHAR(2);
ALTER TABLE products_description ADD customd6 VARCHAR(2);

-- New tailFile API
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'tailFile', '', sysdate);


-----------------  v7.0.0.0

-- New DB table for allowing a product to be associated with multiple custom attribute templates
BEGIN EXECUTE IMMEDIATE 'DROP TABLE kk_product_to_templates'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE kk_product_to_templates (
  store_id VARCHAR2(64),
  products_id NUMBER(10,0) NOT NULL,
  cust_attr_tmpl_id NUMBER(10,0) NOT NULL,
  sort_order NUMBER(10,0) DEFAULT 0 NOT NULL,
  PRIMARY KEY(products_id ,cust_attr_tmpl_id)
);

-- Sitemap file location
DELETE FROM configuration WHERE configuration_key = 'SITEMAP_FILE_DIRECTORY';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (configuration_seq.nextval, 'Sitemap file Directory', 'SITEMAP_FILE_DIRECTORY', 'C:/Program Files/KonaKart/batchlogs/', 'The location where KonaKart will write sitemap files', '30', '1', sysdate);

-- Sitemap Config panel
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval, 'kk_panel_sitemap', 'SitemapConfiguration', sysdate);

-- Add access to the Sitemap Config Panel to all roles that can access the Configuration panel
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, sysdate, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_storeConfiguration' and p2.code='kk_panel_sitemap';

-- Insert a Configuration for the Importer File Path
DELETE FROM configuration WHERE configuration_key = 'IMPORT_FILES_PATH';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (configuration_seq.nextval, 'Import files path','IMPORT_FILES_PATH','C:/Program Files/KonaKart/data/','The import data files location',29,50,sysdate);

-- Importer Log file location
DELETE FROM configuration WHERE configuration_key = 'IMPORTER_LOG_FILE_DIRECTORY';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (configuration_seq.nextval, 'Importer Log file Directory', 'IMPORTER_LOG_FILE_DIRECTORY', 'C:/Program Files/KonaKart/importerlogs/', 'The location where KonaKart will write importer log files', 29, 60, sysdate);

-- Add some Configuration Groups
INSERT INTO configuration_group VALUES (configuration_group_seq.nextval, 'Reward Points', 'Reward Points Configuration', 26, 1, null);
INSERT INTO configuration_group VALUES (configuration_group_seq.nextval, 'PDF Configuration', 'PDF Configuration', 27, 1, null);
INSERT INTO configuration_group VALUES (configuration_group_seq.nextval, 'Velocity Templates', 'Velocity Templates Configuration', 28, 1, null);
INSERT INTO configuration_group VALUES (configuration_group_seq.nextval, 'Importer Config', 'Importer Configuration', 29, 1, null);
INSERT INTO configuration_group VALUES (configuration_group_seq.nextval, 'Sitemap', 'Sitemap Configuration', 30, 1, null);

INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval, 'kk_panel_importer','Importer', sysdate);
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval, 'kk_panel_importerConfig','Importer Configuration', sysdate);
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval, 'kk_panel_resetDatabase','Reset Database', sysdate);
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval, 'kk_panel_viewImporterLogs','View Importer Jobs', sysdate);

-- Add access to the Importer Panel to all roles that can access the Configuration panel
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, sysdate, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_storeConfiguration' and p2.code='kk_panel_importer';

-- Add access to the Importer Config Panel to all roles that can access the Configuration panel
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, sysdate, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_storeConfiguration' and p2.code='kk_panel_importerConfig';

-- Add access to the Reset Database Panel to all roles that can access the Configuration panel
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, sysdate, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_storeConfiguration' and p2.code='kk_panel_resetDatabase';

-- Add access to the View Importer Logs Panel to all roles that can access the Configuration panel
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, sysdate, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_storeConfiguration' and p2.code='kk_panel_viewImporterLogs';

-- Add custom privileges for the Importer panel - default to allow access to the Custom Importer1 button - custom 1 hides it
UPDATE kk_role_to_panel SET custom1=0, custom1_desc='If set Custom1 button is not shown' WHERE panel_id IN (SELECT panel_id FROM kk_panel where code='kk_panel_importer');
-- Add custom privileges for the Importer panel - default to allow access to the Custom Importer2 button - custom 2 hides it
UPDATE kk_role_to_panel SET custom2=0, custom2_desc='If set Custom2 button is not shown' WHERE panel_id IN (SELECT panel_id FROM kk_panel where code='kk_panel_importer');
-- Add custom privileges for the Importer panel - default to allow access to the Custom Importer3 button - custom 3 hides it
UPDATE kk_role_to_panel SET custom3=0, custom3_desc='If set Custom3 button is not shown' WHERE panel_id IN (SELECT panel_id FROM kk_panel where code='kk_panel_importer');
-- Add custom privileges for the Importer panel - default to allow access to the Upload button - custom 4 hides it
UPDATE kk_role_to_panel SET custom4=0, custom4_desc='If set Upload button is not shown' WHERE panel_id IN (SELECT panel_id FROM kk_panel where code='kk_panel_importer');

-----------------  v7.1.0.0

-- Add extra attributes to Order for multi-vendor mode
ALTER TABLE orders ADD store_name VARCHAR(64);
ALTER TABLE orders ADD parent_id int DEFAULT 0;

-- Configuration variable to enable multi-vendor mode
DELETE FROM configuration WHERE configuration_key = 'MULTI_VENDOR_MODE';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api) VALUES (configuration_seq.nextval, 'Enable multi-vendor mode','MULTI_VENDOR_MODE','false','Set to true to enable multi-vendor mode. KK Engine must be in shared products mode.','1', '35', 'choice(''true''=''true'',''false''=''false'')', sysdate, '1');

-- Addr addr store id to address table
ALTER TABLE address_book ADD addr_store_id varchar(64);

-- New Velocity Templates Panel
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval, 'kk_panel_velocityTemplates','Maintain Velocity Templates', sysdate);

-- Add access to the Velocity Templates Panel to all roles that can access the Configuration panel
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, sysdate, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_storeConfiguration' and p2.code='kk_panel_velocityTemplates';

-- New copyFile API
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'copyFile', '', sysdate);

-- Config variable for formatting store addresses in admin app
DELETE FROM configuration WHERE configuration_key = 'ADMIN_APP_STORE_ADDR_FORMAT';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, return_by_api) VALUES (configuration_seq.nextval, 'Addr Format for Store Addr', 'ADMIN_APP_STORE_ADDR_FORMAT', '$street $street1 $suburb $city $state $country', 'How the address is formatted in the store address panel', '21', '1', sysdate, '0');

-- Address Panel for stores
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval, 'kk_panel_store_address', 'Store Addresses', sysdate);

-- Add Address Panel access to all roles that can access the Customer panel
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, sysdate, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_customers' and p2.code='kk_panel_store_address';

-- Configuration variable to force login for storefront app
DELETE FROM configuration WHERE configuration_key = 'APP_FORCE_LOOGIN';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api) VALUES (configuration_seq.nextval, 'Storefront force login','APP_FORCE_LOOGIN','false','Set to true to force customers to login in order to be able to use the storefront application.','1', '38', 'choice(''true''=''true'',''false''=''false'')', sysdate, '1');

-----------------  v7.1.1.0

-- No Database Changes in v7.1.1.0

-----------------  v7.2.0.0

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

-- Add a new order status
DELETE FROM orders_status WHERE orders_status_id = 9;
INSERT INTO orders_status(orders_status_id, language_id, orders_status_name) VALUES (9,(SELECT languages_id FROM languages WHERE code = 'en'),'Refund Approved');
INSERT INTO orders_status(orders_status_id, language_id, orders_status_name) VALUES (9,(SELECT languages_id FROM languages WHERE code = 'de'),'Rückerstattung Genehmigt');
INSERT INTO orders_status(orders_status_id, language_id, orders_status_name) VALUES (9,(SELECT languages_id FROM languages WHERE code = 'es'),'Reembolso Aprobado');
INSERT INTO orders_status(orders_status_id, language_id, orders_status_name) VALUES (9,(SELECT languages_id FROM languages WHERE code = 'pt'),'Reembolso Aprovado');

-- Add a new order status
DELETE FROM orders_status WHERE orders_status_id = 10;
INSERT INTO orders_status(orders_status_id, language_id, orders_status_name) VALUES (10,(SELECT languages_id FROM languages WHERE code = 'en'),'Refund Declined');
INSERT INTO orders_status(orders_status_id, language_id, orders_status_name) VALUES (10,(SELECT languages_id FROM languages WHERE code = 'de'),'Rückerstattung Abgelehnt');
INSERT INTO orders_status(orders_status_id, language_id, orders_status_name) VALUES (10,(SELECT languages_id FROM languages WHERE code = 'es'),'Reembolso Rehusó');
INSERT INTO orders_status(orders_status_id, language_id, orders_status_name) VALUES (10,(SELECT languages_id FROM languages WHERE code = 'pt'),'Reembolso Recusado');

-- Add new product option types
ALTER TABLE customers_basket_attrs ADD customer_price NUMBER(15,2);
ALTER TABLE customers_basket_attrs ADD customer_string VARCHAR(512);
ALTER TABLE orders_products_attributes ADD customer_price NUMBER(15,2);
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
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api) VALUES (configuration_seq.nextval, 'Cache Products','CACHE_PRODUCTS','true','Set to true to Cache Products in memory.','11', '15', 'choice(''true''=''true'',''false''=''false'')', sysdate, '1');

-- Configuration variable to enable/disable Product Image Name Caching
DELETE FROM configuration WHERE configuration_key = 'CACHE_PRODUCT_IMAGES';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api) VALUES (configuration_seq.nextval, 'Cache Product Images','CACHE_PRODUCT_IMAGES','true','Set to true to Cache Product Image Names in memory.','11', '20', 'choice(''true''=''true'',''false''=''false'')', sysdate, '1');

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

-- refactor order status table to introduce non semantic key
BEGIN EXECUTE IMMEDIATE 'DROP TABLE orders_status'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
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

-- Add order statuses

--1
INSERT INTO orders_status (orders_status_pk, orders_status_id, language_id, orders_status_name) VALUES (orders_status_seq.nextval,1,(SELECT languages_id FROM languages WHERE code = 'en'),'Pending');
INSERT INTO orders_status (orders_status_pk, orders_status_id, language_id, orders_status_name) VALUES (orders_status_seq.nextval,1,(SELECT languages_id FROM languages WHERE code = 'de'),'Offen');
INSERT INTO orders_status (orders_status_pk, orders_status_id, language_id, orders_status_name) VALUES (orders_status_seq.nextval,1,(SELECT languages_id FROM languages WHERE code = 'es'),'Pendiente');
INSERT INTO orders_status (orders_status_pk, orders_status_id, language_id, orders_status_name) VALUES (orders_status_seq.nextval,1,(SELECT languages_id FROM languages WHERE code = 'pt'),'Pendente');
--2
INSERT INTO orders_status (orders_status_pk, orders_status_id, language_id, orders_status_name) VALUES (orders_status_seq.nextval,2,(SELECT languages_id FROM languages WHERE code = 'en'),'Processing');
INSERT INTO orders_status (orders_status_pk, orders_status_id, language_id, orders_status_name) VALUES (orders_status_seq.nextval,2,(SELECT languages_id FROM languages WHERE code = 'de'),'In Bearbeitung');
INSERT INTO orders_status (orders_status_pk, orders_status_id, language_id, orders_status_name) VALUES (orders_status_seq.nextval,2,(SELECT languages_id FROM languages WHERE code = 'es'),'Proceso');
INSERT INTO orders_status (orders_status_pk, orders_status_id, language_id, orders_status_name) VALUES (orders_status_seq.nextval,2,(SELECT languages_id FROM languages WHERE code = 'pt'),'Processamento');
--3
INSERT INTO orders_status (orders_status_pk, orders_status_id, language_id, orders_status_name) VALUES (orders_status_seq.nextval,3,(SELECT languages_id FROM languages WHERE code = 'en'),'Delivered');
INSERT INTO orders_status (orders_status_pk, orders_status_id, language_id, orders_status_name) VALUES (orders_status_seq.nextval,3,(SELECT languages_id FROM languages WHERE code = 'de'),'Versendet');
INSERT INTO orders_status (orders_status_pk, orders_status_id, language_id, orders_status_name) VALUES (orders_status_seq.nextval,3,(SELECT languages_id FROM languages WHERE code = 'es'),'Entregado');
INSERT INTO orders_status (orders_status_pk, orders_status_id, language_id, orders_status_name) VALUES (orders_status_seq.nextval,3,(SELECT languages_id FROM languages WHERE code = 'pt'),'Entregue');
--4
INSERT INTO orders_status (orders_status_pk, orders_status_id, language_id, orders_status_name) VALUES (orders_status_seq.nextval,4,(SELECT languages_id FROM languages WHERE code = 'en'),'Waiting for Payment');
INSERT INTO orders_status (orders_status_pk, orders_status_id, language_id, orders_status_name) VALUES (orders_status_seq.nextval,4,(SELECT languages_id FROM languages WHERE code = 'de'),'Wartezahlung');
INSERT INTO orders_status (orders_status_pk, orders_status_id, language_id, orders_status_name) VALUES (orders_status_seq.nextval,4,(SELECT languages_id FROM languages WHERE code = 'es'),'Para pago que espera');
INSERT INTO orders_status (orders_status_pk, orders_status_id, language_id, orders_status_name) VALUES (orders_status_seq.nextval,4,(SELECT languages_id FROM languages WHERE code = 'pt'),'Ã espera de pagamento');
--5
INSERT INTO orders_status (orders_status_pk, orders_status_id, language_id, orders_status_name) VALUES (orders_status_seq.nextval,5,(SELECT languages_id FROM languages WHERE code = 'en'),'Payment Received');
INSERT INTO orders_status (orders_status_pk, orders_status_id, language_id, orders_status_name) VALUES (orders_status_seq.nextval,5,(SELECT languages_id FROM languages WHERE code = 'de'),'Zahlung empfing');
INSERT INTO orders_status (orders_status_pk, orders_status_id, language_id, orders_status_name) VALUES (orders_status_seq.nextval,5,(SELECT languages_id FROM languages WHERE code = 'es'),'Pago recibido');
INSERT INTO orders_status (orders_status_pk, orders_status_id, language_id, orders_status_name) VALUES (orders_status_seq.nextval,5,(SELECT languages_id FROM languages WHERE code = 'pt'),'Pagamento Recebido');
--6
INSERT INTO orders_status (orders_status_pk, orders_status_id, language_id, orders_status_name) VALUES (orders_status_seq.nextval,6,(SELECT languages_id FROM languages WHERE code = 'en'),'Payment Declined');
INSERT INTO orders_status (orders_status_pk, orders_status_id, language_id, orders_status_name) VALUES (orders_status_seq.nextval,6,(SELECT languages_id FROM languages WHERE code = 'de'),'Zahlung sank');
INSERT INTO orders_status (orders_status_pk, orders_status_id, language_id, orders_status_name) VALUES (orders_status_seq.nextval,6,(SELECT languages_id FROM languages WHERE code = 'es'),'Pago declinado');
INSERT INTO orders_status (orders_status_pk, orders_status_id, language_id, orders_status_name) VALUES (orders_status_seq.nextval,6,(SELECT languages_id FROM languages WHERE code = 'pt'),'Pagamento recusado');
--7
INSERT INTO orders_status (orders_status_pk, orders_status_id, language_id, orders_status_name) VALUES (orders_status_seq.nextval,7,(SELECT languages_id FROM languages WHERE code = 'en'),'Partially Delivered');
INSERT INTO orders_status (orders_status_pk, orders_status_id, language_id, orders_status_name) VALUES (orders_status_seq.nextval,7,(SELECT languages_id FROM languages WHERE code = 'de'),'Teilweise geliefert');
INSERT INTO orders_status (orders_status_pk, orders_status_id, language_id, orders_status_name) VALUES (orders_status_seq.nextval,7,(SELECT languages_id FROM languages WHERE code = 'es'),'Entregado parcialmente');
INSERT INTO orders_status (orders_status_pk, orders_status_id, language_id, orders_status_name) VALUES (orders_status_seq.nextval,7,(SELECT languages_id FROM languages WHERE code = 'pt'),'Parcialmente Entregues');
--8
INSERT INTO orders_status (orders_status_pk, orders_status_id, language_id, orders_status_name) VALUES (orders_status_seq.nextval,8,(SELECT languages_id FROM languages WHERE code = 'en'),'Cancelled');
INSERT INTO orders_status (orders_status_pk, orders_status_id, language_id, orders_status_name) VALUES (orders_status_seq.nextval,8,(SELECT languages_id FROM languages WHERE code = 'de'),'Abgesagt');
INSERT INTO orders_status (orders_status_pk, orders_status_id, language_id, orders_status_name) VALUES (orders_status_seq.nextval,8,(SELECT languages_id FROM languages WHERE code = 'es'),'Cancelado');
INSERT INTO orders_status (orders_status_pk, orders_status_id, language_id, orders_status_name) VALUES (orders_status_seq.nextval,8,(SELECT languages_id FROM languages WHERE code = 'pt'),'Cancelado');
--9
INSERT INTO orders_status (orders_status_pk, orders_status_id, language_id, orders_status_name) VALUES (orders_status_seq.nextval,9,(SELECT languages_id FROM languages WHERE code = 'en'),'Refund Approved');
INSERT INTO orders_status (orders_status_pk, orders_status_id, language_id, orders_status_name) VALUES (orders_status_seq.nextval,9,(SELECT languages_id FROM languages WHERE code = 'de'),'Rückerstattung Genehmigt');
INSERT INTO orders_status (orders_status_pk, orders_status_id, language_id, orders_status_name) VALUES (orders_status_seq.nextval,9,(SELECT languages_id FROM languages WHERE code = 'es'),'Reembolso Aprobado');
INSERT INTO orders_status (orders_status_pk, orders_status_id, language_id, orders_status_name) VALUES (orders_status_seq.nextval,9,(SELECT languages_id FROM languages WHERE code = 'pt'),'Reembolso Aprovado');
--10
INSERT INTO orders_status (orders_status_pk, orders_status_id, language_id, orders_status_name) VALUES (orders_status_seq.nextval,10,(SELECT languages_id FROM languages WHERE code = 'en'),'Refund Declined');
INSERT INTO orders_status (orders_status_pk, orders_status_id, language_id, orders_status_name) VALUES (orders_status_seq.nextval,10,(SELECT languages_id FROM languages WHERE code = 'de'),'Rückerstattung Abgelehnt');
INSERT INTO orders_status (orders_status_pk, orders_status_id, language_id, orders_status_name) VALUES (orders_status_seq.nextval,10,(SELECT languages_id FROM languages WHERE code = 'es'),'Reembolso Rehusó');
INSERT INTO orders_status (orders_status_pk, orders_status_id, language_id, orders_status_name) VALUES (orders_status_seq.nextval,10,(SELECT languages_id FROM languages WHERE code = 'pt'),'Reembolso Recusado');

-- Increase the size of the custom panel
UPDATE configuration set configuration_value = '600px' where configuration_key = 'ADMIN_APP_CUSTOM_PANEL_HEIGHT';

-- Control for SOLR suggested search and spelling
DELETE FROM configuration WHERE configuration_key = 'SOLR_ADD_TERM_IF_INVISIBLE';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api) VALUES (configuration_seq.nextval, 'Add suggested search for invisible prods.','SOLR_ADD_TERM_IF_INVISIBLE','true','Adds a suggested search entry even when products are invisible','24', '5', 'choice(''true''=''true'',''false''=''false'')', sysdate, '0');
DELETE FROM configuration WHERE configuration_key = 'SOLR_ADD_TERM_IF_DISABLED';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api) VALUES (configuration_seq.nextval, 'Add suggested search for disabled prods.','SOLR_ADD_TERM_IF_DISABLED','true','Adds a suggested search entry even when products are disabled','24', '5', 'choice(''true''=''true'',''false''=''false'')', sysdate, '0');

DELETE FROM configuration WHERE configuration_key = 'SOLR_ENABLE_SPELLING_SUGGESTION';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api) VALUES (configuration_seq.nextval, 'Enable spelling suggestions','SOLR_ENABLE_SPELLING_SUGGESTION','true','Enables spelling suggestion functionality','24', '20', 'choice(''true''=''true'',''false''=''false'')', sysdate, '1');
DELETE FROM configuration WHERE configuration_key = 'SOLR_ADD_SPELLING_IF_INVISIBLE';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api) VALUES (configuration_seq.nextval, 'Add spelling data for invisible prods.','SOLR_ADD_SPELLING_IF_INVISIBLE','true','Adds data used for spelling suggestions even when products are invisible','24', '21', 'choice(''true''=''true'',''false''=''false'')', sysdate, '0');
DELETE FROM configuration WHERE configuration_key = 'SOLR_ADD_SPELLING_IF_DISABLED';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api) VALUES (configuration_seq.nextval, 'Add spelling data for disabled prods.','SOLR_ADD_SPELLING_IF_DISABLED','true','Adds data used for spelling suggestions even when products are disabled','24', '22', 'choice(''true''=''true'',''false''=''false'')', sysdate, '0');

-- Move single custom attribute templates to the new multiple template structure
INSERT INTO kk_product_to_templates (products_id, cust_attr_tmpl_id) SELECT products_id, cust_attr_tmpl_id FROM products WHERE cust_attr_tmpl_id > -1;

-- Reset the single cust_attr_tmpl_id now that we've migrated to the new multiple template structure
UPDATE products SET cust_attr_tmpl_id = -1 WHERE cust_attr_tmpl_id > -1;

-- Add sort order to product attributes
ALTER TABLE products_attributes ADD sort_order int DEFAULT '0';

-- Set sort field of product attributes
update products_attributes set sort_order = 0 where products_id = 1 and options_id = 3 and options_values_id = 5;
update products_attributes set sort_order = 1 where products_id = 1 and options_id = 3 and options_values_id = 6;
update products_attributes set sort_order = 2 where products_id = 1 and options_id = 4 and options_values_id = 1;
update products_attributes set sort_order = 3 where products_id = 1 and options_id = 4 and options_values_id = 2;
update products_attributes set sort_order = 4 where products_id = 1 and options_id = 4 and options_values_id = 3;

update products_attributes set sort_order = 0 where products_id = 2 and options_id = 3 and options_values_id = 6;
update products_attributes set sort_order = 1 where products_id = 2 and options_id = 3 and options_values_id = 7;
update products_attributes set sort_order = 2 where products_id = 2 and options_id = 4 and options_values_id = 3;
update products_attributes set sort_order = 3 where products_id = 2 and options_id = 4 and options_values_id = 4;

update products_attributes set sort_order = 0 where products_id = 26 and options_id = 3 and options_values_id = 8;
update products_attributes set sort_order = 1 where products_id = 26 and options_id = 3 and options_values_id = 9;

update products_attributes set sort_order = 0 where products_id = 29 and options_id = 5 and options_values_id = 10;
update products_attributes set sort_order = 1 where products_id = 29 and options_id = 5 and options_values_id = 11;
update products_attributes set sort_order = 2 where products_id = 29 and options_id = 5 and options_values_id = 12;

-- Set a description on the EditProduct Panel custom1 field for assigning products to stores
UPDATE kk_role_to_panel SET custom1=0, custom1_desc='Set to allow assignment of products to stores' WHERE panel_id IN (SELECT panel_id FROM kk_panel where code='kk_panel_editProduct');

-- Allow super-users to assign products to stores
UPDATE kk_role_to_panel SET custom1=1 WHERE panel_id IN (SELECT panel_id FROM kk_panel where code='kk_panel_editProduct') AND role_id IN (SELECT role_id FROM kk_role where super_user=1);

-----------------  v7.3.0.0

BEGIN EXECUTE IMMEDIATE 'DROP TABLE kk_cust_pwd_hist'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE kk_cust_pwd_hist (
  id NUMBER(10,0) NOT NULL,
  cust_id NUMBER(10,0) NOT NULL,
  password VARCHAR2(40),
  date_created TIMESTAMP,
  custom1 VARCHAR2(128),
  PRIMARY KEY(id)
);
CREATE INDEX idx_kk_cust_pwd_hist_cust_id ON kk_cust_pwd_hist (cust_id);
BEGIN EXECUTE IMMEDIATE 'DROP SEQUENCE kk_cust_pwd_hist_SEQ'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE SEQUENCE kk_cust_pwd_hist_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'changeUserPassword', '', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'checkPasswordValidity', '', sysdate);

-- For Enabling "Other" Gender
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api) VALUES (configuration_seq.nextval, 'Enable "Other" Gender', 'ENABLE_OTHER_GENDER', 'false', 'Enable "Other" gender in addition to Male and Female', '5', '1', 'choice(''true''=''true'',''false''=''false'')', sysdate, '1');

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
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api) VALUES (configuration_seq.nextval, 'Tax Id','ACCOUNT_TAX_ID','false','Display tax id in the customers account','5', '3', 'choice(''true''=''true'',''false''=''false'')', sysdate, '1');

-- Remove configuration of the edit customer panel to allow editing of external customers only
UPDATE kk_role_to_panel SET custom1='0', custom1_desc=null WHERE panel_id in (select panel_id from kk_panel WHERE code='kk_panel_editCustomer');

-- For specifying whether or not to Cache Bundle Products
DELETE FROM configuration WHERE configuration_key = 'CACHE_BUNDLE_PRODUCTS';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api) VALUES (configuration_seq.nextval, 'Cache Bundle Products','CACHE_BUNDLE_PRODUCTS','false','If true bundle products are cached; if false they are never cached','11', '25', 'choice(''true''=''true'',''false''=''false'')', sysdate, '1');

-- For specifying whether or not to create Product Viewed Events
DELETE FROM configuration WHERE configuration_key = 'CREATE_PRODUCT_VIEWED_EVENTS';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api) VALUES (configuration_seq.nextval, 'Create Product Viewed Events','CREATE_PRODUCT_VIEWED_EVENTS','false','If true product viewed events are created; if false they are not.','11', '25', 'choice(''true''=''true'',''false''=''false'')', sysdate, '1');

-- For specifying whether or not to Create Product Quantity Events
DELETE FROM configuration WHERE configuration_key = 'CREATE_PRODUCT_QTY_EVENTS';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api) VALUES (configuration_seq.nextval, 'Create Product Quantity Events','CREATE_PRODUCT_QTY_EVENTS','true','If true product quantity change events are created; if false they are not.','11', '29', 'choice(''true''=''true'',''false''=''false'')', sysdate, '1');

-- For specifying whether or not to Create Products Ordered Events
DELETE FROM configuration WHERE configuration_key = 'CREATE_PRODUCT_ORDERED_EVENTS';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api) VALUES (configuration_seq.nextval, 'Create Products Ordered Events','CREATE_PRODUCT_ORDERED_EVENTS','true','If true products ordered change events are created; if false they are not.','11', '32', 'choice(''true''=''true'',''false''=''false'')', sysdate, '1');

-- For specifying whether or not to Create Product Review Events
DELETE FROM configuration WHERE configuration_key = 'CREATE_PRODUCT_REVIEW_EVENTS';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api) VALUES (configuration_seq.nextval, 'Create Product Review Events','CREATE_PRODUCT_REVIEW_EVENTS','true','If true product review change events are created; if false they are not.','11', '35', 'choice(''true''=''true'',''false''=''false'')', sysdate, '1');

-- For specifying whether or not to Create Product Booking Events
DELETE FROM configuration WHERE configuration_key = 'CREATE_PRODUCT_BOOKING_EVENTS';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api) VALUES (configuration_seq.nextval, 'Create Product Booking Events','CREATE_PRODUCT_BOOKING_EVENTS','true','If true product booking change events are created; if false they are not.','11', '38', 'choice(''true''=''true'',''false''=''false'')', sysdate, '1');

-- Max size of KonaKart Product cache
DELETE FROM configuration WHERE configuration_key = 'KK_PRODUCT_CACHE_MAX_SIZE';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api) VALUES (configuration_seq.nextval, 'KonaKart Product Cache Max Size','KK_PRODUCT_CACHE_MAX_SIZE','1000','Maximum Size (maximum number of Products) in the KonaKart Product Cache','11', '46', 'integer(1,10000)', sysdate, '1');

-- Example config parameter for the User Defined Configuration Panel
DELETE FROM configuration WHERE configuration_key = 'USER_DEFINED_EXAMPLE';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, return_by_api) VALUES (configuration_seq.nextval, 'Example Parameter','USER_DEFINED_EXAMPLE','Example Value','Add your own configuration parameters to group 31 to appear in the User Defined Configs Panel','31', '10', sysdate, '1');

INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval, 'kk_panel_userDefinedConfig','User Defined Configurations', sysdate);

-- Add User Defined Configurations Panel access to all roles that can access the 'kk_panel_storeConfiguration' panel
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, sysdate, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_storeConfiguration' and p2.code='kk_panel_userDefinedConfig';

-- Add new image API calls
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'addImage', '', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'removeImage', '', sysdate);

-- Add new API calls
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'removeProductFromCatalog', '', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'getRMACode', '', sysdate);

-- Misc Items types for responsive banners
INSERT INTO kk_misc_item_type (kk_misc_item_type_id, language_id, name, description) VALUES (4, 1, 'Banner_1_Medium', 'Top medium banner');
INSERT INTO kk_misc_item_type (kk_misc_item_type_id, language_id, name, description) VALUES (4, 2, 'Banner_1_Medium', 'Top medium banner');
INSERT INTO kk_misc_item_type (kk_misc_item_type_id, language_id, name, description) VALUES (4, 3, 'Banner_1_Medium', 'Top medium banner');
INSERT INTO kk_misc_item_type (kk_misc_item_type_id, language_id, name, description) VALUES (4, 4, 'Banner_1_Medium', 'Top medium banner');
INSERT INTO kk_misc_item_type (kk_misc_item_type_id, language_id, name, description) VALUES (5, 1, 'Banner_2_Medium', '2nd medium banner');
INSERT INTO kk_misc_item_type (kk_misc_item_type_id, language_id, name, description) VALUES (5, 2, 'Banner_2_Medium', '2nd medium banner');
INSERT INTO kk_misc_item_type (kk_misc_item_type_id, language_id, name, description) VALUES (5, 3, 'Banner_2_Medium', '2nd medium banner');
INSERT INTO kk_misc_item_type (kk_misc_item_type_id, language_id, name, description) VALUES (5, 4, 'Banner_2_Medium', '2nd medium banner');
INSERT INTO kk_misc_item_type (kk_misc_item_type_id, language_id, name, description) VALUES (6, 1, 'Banner_3_Medium', '3rd medium banner');
INSERT INTO kk_misc_item_type (kk_misc_item_type_id, language_id, name, description) VALUES (6, 2, 'Banner_3_Medium', '3rd medium banner');
INSERT INTO kk_misc_item_type (kk_misc_item_type_id, language_id, name, description) VALUES (6, 3, 'Banner_3_Medium', '3rd medium banner');
INSERT INTO kk_misc_item_type (kk_misc_item_type_id, language_id, name, description) VALUES (6, 4, 'Banner_3_Medium', '3rd medium banner');

INSERT INTO kk_misc_item_type (kk_misc_item_type_id, language_id, name, description) VALUES (7, 1, 'Banner_1_Small', 'Top small banner');
INSERT INTO kk_misc_item_type (kk_misc_item_type_id, language_id, name, description) VALUES (7, 2, 'Banner_1_Small', 'Top small banner');
INSERT INTO kk_misc_item_type (kk_misc_item_type_id, language_id, name, description) VALUES (7, 3, 'Banner_1_Small', 'Top small banner');
INSERT INTO kk_misc_item_type (kk_misc_item_type_id, language_id, name, description) VALUES (7, 4, 'Banner_1_Small', 'Top small banner');
INSERT INTO kk_misc_item_type (kk_misc_item_type_id, language_id, name, description) VALUES (8, 1, 'Banner_2_Small', '2nd small banner');
INSERT INTO kk_misc_item_type (kk_misc_item_type_id, language_id, name, description) VALUES (8, 2, 'Banner_2_Small', '2nd small banner');
INSERT INTO kk_misc_item_type (kk_misc_item_type_id, language_id, name, description) VALUES (8, 3, 'Banner_2_Small', '2nd small banner');
INSERT INTO kk_misc_item_type (kk_misc_item_type_id, language_id, name, description) VALUES (8, 4, 'Banner_2_Small', '2nd small banner');
INSERT INTO kk_misc_item_type (kk_misc_item_type_id, language_id, name, description) VALUES (9, 1, 'Banner_3_Small', '3rd small banner');
INSERT INTO kk_misc_item_type (kk_misc_item_type_id, language_id, name, description) VALUES (9, 2, 'Banner_3_Small', '3rd small banner');
INSERT INTO kk_misc_item_type (kk_misc_item_type_id, language_id, name, description) VALUES (9, 3, 'Banner_3_Small', '3rd small banner');
INSERT INTO kk_misc_item_type (kk_misc_item_type_id, language_id, name, description) VALUES (9, 4, 'Banner_3_Small', '3rd small banner');

-- Misc Items for categories
delete from kk_misc_item;
--cat 1 Computer Peripherals
INSERT INTO kk_misc_item (kk_misc_item_id, kk_obj_id, kk_obj_type_id, kk_misc_item_type_id, item_value, custom1) VALUES (kk_misc_item_seq.nextval,  1, 2, 1, 'banners/computer-peripherals/logitech.png', 'SelectProd.action?prodId=31' );
INSERT INTO kk_misc_item (kk_misc_item_id, kk_obj_id, kk_obj_type_id, kk_misc_item_type_id, item_value, custom1) VALUES (kk_misc_item_seq.nextval,  1, 2, 4, 'banners/computer-peripherals/logitech-medium.png', 'SelectProd.action?prodId=31' );
INSERT INTO kk_misc_item (kk_misc_item_id, kk_obj_id, kk_obj_type_id, kk_misc_item_type_id, item_value, custom1) VALUES (kk_misc_item_seq.nextval,  1, 2, 7, 'banners/computer-peripherals/logitech-small.png', 'SelectProd.action?prodId=31' );

INSERT INTO kk_misc_item (kk_misc_item_id, kk_obj_id, kk_obj_type_id, kk_misc_item_type_id, item_value, custom1) VALUES (kk_misc_item_seq.nextval,  1, 2, 2, 'banners/computer-peripherals/hp-photosmart.png','SelectProd.action?prodId=27' );
INSERT INTO kk_misc_item (kk_misc_item_id, kk_obj_id, kk_obj_type_id, kk_misc_item_type_id, item_value, custom1) VALUES (kk_misc_item_seq.nextval,  1, 2, 5, 'banners/computer-peripherals/hp-photosmart-medium.png','SelectProd.action?prodId=27' );
INSERT INTO kk_misc_item (kk_misc_item_id, kk_obj_id, kk_obj_type_id, kk_misc_item_type_id, item_value, custom1) VALUES (kk_misc_item_seq.nextval,  1, 2, 8, 'banners/computer-peripherals/hp-photosmart-small.png','SelectProd.action?prodId=27' );

INSERT INTO kk_misc_item (kk_misc_item_id, kk_obj_id, kk_obj_type_id, kk_misc_item_type_id, item_value, custom1) VALUES (kk_misc_item_seq.nextval,  1, 2, 3, 'banners/computer-peripherals/deals-of-the-week.png', '' );
INSERT INTO kk_misc_item (kk_misc_item_id, kk_obj_id, kk_obj_type_id, kk_misc_item_type_id, item_value, custom1) VALUES (kk_misc_item_seq.nextval,  1, 2, 6, 'banners/computer-peripherals/deals-of-the-week-medium.png', '' );
INSERT INTO kk_misc_item (kk_misc_item_id, kk_obj_id, kk_obj_type_id, kk_misc_item_type_id, item_value, custom1) VALUES (kk_misc_item_seq.nextval,  1, 2, 9, 'banners/computer-peripherals/deals-of-the-week-small.png', '' );

--cat 2 Games
INSERT INTO kk_misc_item (kk_misc_item_id, kk_obj_id, kk_obj_type_id, kk_misc_item_type_id, item_value, custom1) VALUES (kk_misc_item_seq.nextval,  2, 2, 1, 'banners/games/black-ops-2.png', 'SelectProd.action?prodId=63' );
INSERT INTO kk_misc_item (kk_misc_item_id, kk_obj_id, kk_obj_type_id, kk_misc_item_type_id, item_value, custom1) VALUES (kk_misc_item_seq.nextval,  2, 2, 4, 'banners/games/black-ops-2-medium.png', 'SelectProd.action?prodId=63' );
INSERT INTO kk_misc_item (kk_misc_item_id, kk_obj_id, kk_obj_type_id, kk_misc_item_type_id, item_value, custom1) VALUES (kk_misc_item_seq.nextval,  2, 2, 7, 'banners/games/black-ops-2-small.png', 'SelectProd.action?prodId=63' );

INSERT INTO kk_misc_item (kk_misc_item_id, kk_obj_id, kk_obj_type_id, kk_misc_item_type_id, item_value, custom1) VALUES (kk_misc_item_seq.nextval,  2, 2, 2, 'banners/games/swat-3.png','SelectProd.action?prodId=21' );
INSERT INTO kk_misc_item (kk_misc_item_id, kk_obj_id, kk_obj_type_id, kk_misc_item_type_id, item_value, custom1) VALUES (kk_misc_item_seq.nextval,  2, 2, 5, 'banners/games/swat-3-medium.png','SelectProd.action?prodId=21' );
INSERT INTO kk_misc_item (kk_misc_item_id, kk_obj_id, kk_obj_type_id, kk_misc_item_type_id, item_value, custom1) VALUES (kk_misc_item_seq.nextval,  2, 2, 8, 'banners/games/swat-3-small.png','SelectProd.action?prodId=21' );

INSERT INTO kk_misc_item (kk_misc_item_id, kk_obj_id, kk_obj_type_id, kk_misc_item_type_id, item_value, custom1) VALUES (kk_misc_item_seq.nextval,  2, 2, 3, 'banners/games/winter-deals.png', '' );
INSERT INTO kk_misc_item (kk_misc_item_id, kk_obj_id, kk_obj_type_id, kk_misc_item_type_id, item_value, custom1) VALUES (kk_misc_item_seq.nextval,  2, 2, 6, 'banners/games/winter-deals-medium.png', '' );
INSERT INTO kk_misc_item (kk_misc_item_id, kk_obj_id, kk_obj_type_id, kk_misc_item_type_id, item_value, custom1) VALUES (kk_misc_item_seq.nextval,  2, 2, 9, 'banners/games/winter-deals-small.png', '' );

--cat 3 DVD Movies
INSERT INTO kk_misc_item (kk_misc_item_id, kk_obj_id, kk_obj_type_id, kk_misc_item_type_id, item_value, custom1) VALUES (kk_misc_item_seq.nextval,  3, 2, 1, 'banners/movies/dark-knight.png', 'SelectProd.action?prodId=20' );
INSERT INTO kk_misc_item (kk_misc_item_id, kk_obj_id, kk_obj_type_id, kk_misc_item_type_id, item_value, custom1) VALUES (kk_misc_item_seq.nextval,  3, 2, 4, 'banners/movies/dark-knight-medium.png', 'SelectProd.action?prodId=20' );
INSERT INTO kk_misc_item (kk_misc_item_id, kk_obj_id, kk_obj_type_id, kk_misc_item_type_id, item_value, custom1) VALUES (kk_misc_item_seq.nextval,  3, 2, 7, 'banners/movies/dark-knight-small.png', 'SelectProd.action?prodId=20' );

INSERT INTO kk_misc_item (kk_misc_item_id, kk_obj_id, kk_obj_type_id, kk_misc_item_type_id, item_value, custom1) VALUES (kk_misc_item_seq.nextval,  3, 2, 2, 'banners/movies/harry-potter.png','SelectProd.action?prodId=11' );
INSERT INTO kk_misc_item (kk_misc_item_id, kk_obj_id, kk_obj_type_id, kk_misc_item_type_id, item_value, custom1) VALUES (kk_misc_item_seq.nextval,  3, 2, 5, 'banners/movies/harry-potter-medium.png','SelectProd.action?prodId=11' );
INSERT INTO kk_misc_item (kk_misc_item_id, kk_obj_id, kk_obj_type_id, kk_misc_item_type_id, item_value, custom1) VALUES (kk_misc_item_seq.nextval,  3, 2, 8, 'banners/movies/harry-potter-small.png','SelectProd.action?prodId=11' );

INSERT INTO kk_misc_item (kk_misc_item_id, kk_obj_id, kk_obj_type_id, kk_misc_item_type_id, item_value, custom1) VALUES (kk_misc_item_seq.nextval,  3, 2, 3, 'banners/movies/movie-deals.png', '' );
INSERT INTO kk_misc_item (kk_misc_item_id, kk_obj_id, kk_obj_type_id, kk_misc_item_type_id, item_value, custom1) VALUES (kk_misc_item_seq.nextval,  3, 2, 6, 'banners/movies/movie-deals-medium.png', '' );
INSERT INTO kk_misc_item (kk_misc_item_id, kk_obj_id, kk_obj_type_id, kk_misc_item_type_id, item_value, custom1) VALUES (kk_misc_item_seq.nextval,  3, 2, 9, 'banners/movies/movie-deals-small.png', '' );

--cat 23 Electronics
INSERT INTO kk_misc_item (kk_misc_item_id, kk_obj_id, kk_obj_type_id, kk_misc_item_type_id, item_value, custom1) VALUES (kk_misc_item_seq.nextval,  23, 2, 1, 'banners/electronics/kindle-fire-hd.jpg', 'SelectProd.action?prodId=34' );
INSERT INTO kk_misc_item (kk_misc_item_id, kk_obj_id, kk_obj_type_id, kk_misc_item_type_id, item_value, custom1) VALUES (kk_misc_item_seq.nextval,  23, 2, 4, 'banners/electronics/kindle-fire-hd-medium.jpg', 'SelectProd.action?prodId=34' );
INSERT INTO kk_misc_item (kk_misc_item_id, kk_obj_id, kk_obj_type_id, kk_misc_item_type_id, item_value, custom1) VALUES (kk_misc_item_seq.nextval,  23, 2, 7, 'banners/electronics/kindle-fire-hd-small.jpg', 'SelectProd.action?prodId=34' );

INSERT INTO kk_misc_item (kk_misc_item_id, kk_obj_id, kk_obj_type_id, kk_misc_item_type_id, item_value, custom1) VALUES (kk_misc_item_seq.nextval,  23, 2, 2, 'banners/electronics/xbox.png','' );
INSERT INTO kk_misc_item (kk_misc_item_id, kk_obj_id, kk_obj_type_id, kk_misc_item_type_id, item_value, custom1) VALUES (kk_misc_item_seq.nextval,  23, 2, 5, 'banners/electronics/xbox-medium.png','' );
INSERT INTO kk_misc_item (kk_misc_item_id, kk_obj_id, kk_obj_type_id, kk_misc_item_type_id, item_value, custom1) VALUES (kk_misc_item_seq.nextval,  23, 2, 8, 'banners/electronics/xbox-small.png','' );

INSERT INTO kk_misc_item (kk_misc_item_id, kk_obj_id, kk_obj_type_id, kk_misc_item_type_id, item_value, custom1) VALUES (kk_misc_item_seq.nextval,  23, 2, 3, 'banners/electronics/electronics-sale.png', '' );
INSERT INTO kk_misc_item (kk_misc_item_id, kk_obj_id, kk_obj_type_id, kk_misc_item_type_id, item_value, custom1) VALUES (kk_misc_item_seq.nextval,  23, 2, 6, 'banners/electronics/electronics-sale-medium.png', '' );
INSERT INTO kk_misc_item (kk_misc_item_id, kk_obj_id, kk_obj_type_id, kk_misc_item_type_id, item_value, custom1) VALUES (kk_misc_item_seq.nextval,  23, 2, 9, 'banners/electronics/electronics-sale-small.png', '' );

--cat 24 Home and Garden
INSERT INTO kk_misc_item (kk_misc_item_id, kk_obj_id, kk_obj_type_id, kk_misc_item_type_id, item_value, custom1) VALUES (kk_misc_item_seq.nextval,  24, 2, 1, 'banners/home-and-garden/delonghi.png', 'SelectProd.action?prodId=33' );
INSERT INTO kk_misc_item (kk_misc_item_id, kk_obj_id, kk_obj_type_id, kk_misc_item_type_id, item_value, custom1) VALUES (kk_misc_item_seq.nextval,  24, 2, 4, 'banners/home-and-garden/delonghi-medium.png', 'SelectProd.action?prodId=33' );
INSERT INTO kk_misc_item (kk_misc_item_id, kk_obj_id, kk_obj_type_id, kk_misc_item_type_id, item_value, custom1) VALUES (kk_misc_item_seq.nextval,  24, 2, 7, 'banners/home-and-garden/delonghi-small.png', 'SelectProd.action?prodId=33' );

INSERT INTO kk_misc_item (kk_misc_item_id, kk_obj_id, kk_obj_type_id, kk_misc_item_type_id, item_value, custom1) VALUES (kk_misc_item_seq.nextval,  24, 2, 2, 'banners/home-and-garden/rotak-40.png','SelectProd.action?prodId=39' );
INSERT INTO kk_misc_item (kk_misc_item_id, kk_obj_id, kk_obj_type_id, kk_misc_item_type_id, item_value, custom1) VALUES (kk_misc_item_seq.nextval,  24, 2, 5, 'banners/home-and-garden/rotak-40-medium.png','SelectProd.action?prodId=39' );
INSERT INTO kk_misc_item (kk_misc_item_id, kk_obj_id, kk_obj_type_id, kk_misc_item_type_id, item_value, custom1) VALUES (kk_misc_item_seq.nextval,  24, 2, 8, 'banners/home-and-garden/rotak-40-small.png','SelectProd.action?prodId=39' );

INSERT INTO kk_misc_item (kk_misc_item_id, kk_obj_id, kk_obj_type_id, kk_misc_item_type_id, item_value, custom1) VALUES (kk_misc_item_seq.nextval,  24, 2, 3, 'banners/home-and-garden/gifts-for-the-home.png', '' );
INSERT INTO kk_misc_item (kk_misc_item_id, kk_obj_id, kk_obj_type_id, kk_misc_item_type_id, item_value, custom1) VALUES (kk_misc_item_seq.nextval,  24, 2, 6, 'banners/home-and-garden/gifts-for-the-home-medium.png', '' );
INSERT INTO kk_misc_item (kk_misc_item_id, kk_obj_id, kk_obj_type_id, kk_misc_item_type_id, item_value, custom1) VALUES (kk_misc_item_seq.nextval,  24, 2, 9, 'banners/home-and-garden/gifts-for-the-home-small.png', '' );

--Change currency labels
UPDATE currencies SET title='US $' WHERE currencies_id = 1;
UPDATE currencies SET title='EUR €' WHERE currencies_id = 2;

-- Remove config variables for mobile application
DELETE FROM configuration WHERE configuration_key = 'STORE_FRONT_SCRIPT_BASE_M';
DELETE FROM configuration WHERE configuration_key = 'STORE_FRONT_STYLE_BASE_M';

-----------------  v7.4.0.0

-- Table for Content Types
BEGIN EXECUTE IMMEDIATE 'DROP TABLE kk_content_type'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE kk_content_type (
  id NUMBER(10,0) NOT NULL,
  content_type_id NUMBER(10,0) DEFAULT 0 NOT NULL,
  custom1 VARCHAR2(32),
  custom2 VARCHAR2(32),
  date_added TIMESTAMP,
  store_id VARCHAR2(64),
  PRIMARY KEY(id)
);
BEGIN EXECUTE IMMEDIATE 'DROP SEQUENCE kk_content_type_SEQ'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE SEQUENCE kk_content_type_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

CREATE INDEX i_co_kk_content_type ON kk_content_type (content_type_id);

-- Table for Content Type Descriptions
BEGIN EXECUTE IMMEDIATE 'DROP TABLE kk_content_type_desc'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE kk_content_type_desc (
  id NUMBER(10,0) NOT NULL,
  content_type_id NUMBER(10,0) NOT NULL,
  language_id NUMBER(10,0) NOT NULL,
  content_type_name VARCHAR2(32),
  description VARCHAR2(256),
  custom1 VARCHAR2(32),
  custom2 VARCHAR2(32),
  date_added TIMESTAMP,
  store_id VARCHAR2(64),
  PRIMARY KEY(id)
);
BEGIN EXECUTE IMMEDIATE 'DROP SEQUENCE kk_content_type_desc_SEQ'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE SEQUENCE kk_content_type_desc_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

CREATE INDEX i_co_kk_content_type_desc ON kk_content_type_desc (content_type_id);

-- Table for Content
BEGIN EXECUTE IMMEDIATE 'DROP TABLE kk_content'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE kk_content (
  id NUMBER(10,0) NOT NULL,
  content_id NUMBER(10,0) DEFAULT 0 NOT NULL,
  content_type_id NUMBER(10,0) DEFAULT 0 NOT NULL,
  object_id INT,
  obj_type_id INT,
  click_url VARCHAR2(256),
  date_from TIMESTAMP,
  date_to TIMESTAMP,
  enabled NUMBER(10,0) DEFAULT 0 NOT NULL,
  expression_id NUMBER(10,0) DEFAULT 0 NOT NULL,
  search_key VARCHAR2(128),
  custom1 VARCHAR2(32),
  custom2 VARCHAR2(32),
  custom3 VARCHAR2(32),
  custom4 VARCHAR2(32),
  updated_by NUMBER(10,0) NOT NULL,
  date_updated TIMESTAMP,
  date_added TIMESTAMP,
  store_id VARCHAR2(64),
  PRIMARY KEY(id)
);
BEGIN EXECUTE IMMEDIATE 'DROP SEQUENCE kk_content_SEQ'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE SEQUENCE kk_content_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

CREATE INDEX i_content_id_kk_content ON kk_content (content_id);
CREATE INDEX i_search_key_kk_content ON kk_content (search_key);

-- Table for Content Descriptions
BEGIN EXECUTE IMMEDIATE 'DROP TABLE kk_content_desc'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE kk_content_desc (
  id NUMBER(10,0) NOT NULL,
  content_id NUMBER(10,0) NOT NULL,
  language_id NUMBER(10,0) NOT NULL,
  name1 VARCHAR2(256),
  name2 VARCHAR2(256),
  name3 VARCHAR2(256),
  name4 VARCHAR2(256),
  title VARCHAR2(256),
  content CLOB,
  custom1 VARCHAR2(32),
  custom2 VARCHAR2(32),
  custom3 VARCHAR2(32),
  custom4 VARCHAR2(32),
  date_added TIMESTAMP,
  store_id VARCHAR2(64),
  PRIMARY KEY(id)
);
BEGIN EXECUTE IMMEDIATE 'DROP SEQUENCE kk_content_desc_SEQ'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE SEQUENCE kk_content_desc_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

CREATE INDEX i_content_id_kk_content_desc ON kk_content_desc (content_id);

-- Populate the Content tables
INSERT INTO kk_content_type (id, content_type_id, date_added) VALUES (kk_content_type_seq.nextval, 1, sysdate);
INSERT INTO kk_content_type (id, content_type_id, date_added) VALUES (kk_content_type_seq.nextval, 2, sysdate);
INSERT INTO kk_content_type (id, content_type_id, date_added) VALUES (kk_content_type_seq.nextval, 3, sysdate);
INSERT INTO kk_content_type (id, content_type_id, date_added) VALUES (kk_content_type_seq.nextval, 4, sysdate);
INSERT INTO kk_content_type (id, content_type_id, date_added) VALUES (kk_content_type_seq.nextval, 5, sysdate);
INSERT INTO kk_content_type (id, content_type_id, date_added) VALUES (kk_content_type_seq.nextval, 6, sysdate);
INSERT INTO kk_content_type (id, content_type_id, date_added) VALUES (kk_content_type_seq.nextval, 7, sysdate);
INSERT INTO kk_content_type (id, content_type_id, date_added) VALUES (kk_content_type_seq.nextval, 8, sysdate);
INSERT INTO kk_content_type (id, content_type_id, date_added) VALUES (kk_content_type_seq.nextval, 9, sysdate);
INSERT INTO kk_content_type (id, content_type_id, date_added) VALUES (kk_content_type_seq.nextval, 10, sysdate);
INSERT INTO kk_content_type (id, content_type_id, date_added) VALUES (kk_content_type_seq.nextval, 11, sysdate);
INSERT INTO kk_content_type (id, content_type_id, date_added) VALUES (kk_content_type_seq.nextval, 12, sysdate);

INSERT INTO kk_content_type_desc (id, content_type_id, language_id, content_type_name, description, date_added) VALUES (kk_content_type_desc_seq.nextval, 1, 1, 'Top Banner', 'Top Banner - Top of store home page', sysdate);
INSERT INTO kk_content_type_desc (id, content_type_id, language_id, content_type_name, description, date_added) VALUES (kk_content_type_desc_seq.nextval, 1, 2, 'Top Banner', 'Top Banner - Top of store Startseite', sysdate);
INSERT INTO kk_content_type_desc (id, content_type_id, language_id, content_type_name, description, date_added) VALUES (kk_content_type_desc_seq.nextval, 1, 3, 'Top Banner', 'Top Banner - Inicio de tienda de la página principal', sysdate);
INSERT INTO kk_content_type_desc (id, content_type_id, language_id, content_type_name, description, date_added) VALUES (kk_content_type_desc_seq.nextval, 1, 4, 'Top Banner', 'Top Banner - Top of Home Page da loja', sysdate);

INSERT INTO kk_content_type_desc (id, content_type_id, language_id, content_type_name, description, date_added) VALUES (kk_content_type_desc_seq.nextval, 2, 1, 'Sub Banner', 'Sub Banner - Secondary banner', sysdate);
INSERT INTO kk_content_type_desc (id, content_type_id, language_id, content_type_name, description, date_added) VALUES (kk_content_type_desc_seq.nextval, 2, 2, 'Sub Banner', 'Sub Banner - Sekundär banner', sysdate);
INSERT INTO kk_content_type_desc (id, content_type_id, language_id, content_type_name, description, date_added) VALUES (kk_content_type_desc_seq.nextval, 2, 3, 'Sub Banner', 'Sub Banner - banner Secundaria', sysdate);
INSERT INTO kk_content_type_desc (id, content_type_id, language_id, content_type_name, description, date_added) VALUES (kk_content_type_desc_seq.nextval, 2, 4, 'Sub Banner', 'Sub Banner - bandeira Secundário', sysdate);

INSERT INTO kk_content_type_desc (id, content_type_id, language_id, content_type_name, description, date_added) VALUES (kk_content_type_desc_seq.nextval, 3, 1, 'Category Banner', 'Category Banner - Top of category pages', sysdate);
INSERT INTO kk_content_type_desc (id, content_type_id, language_id, content_type_name, description, date_added) VALUES (kk_content_type_desc_seq.nextval, 3, 2, 'Kategorie Banner', 'Kategorie Banner - Top of Kategorieseiten', sysdate);
INSERT INTO kk_content_type_desc (id, content_type_id, language_id, content_type_name, description, date_added) VALUES (kk_content_type_desc_seq.nextval, 3, 3, 'Categoria Banner', 'Categoría Banner - Inicio de las páginas de categorías', sysdate);
INSERT INTO kk_content_type_desc (id, content_type_id, language_id, content_type_name, description, date_added) VALUES (kk_content_type_desc_seq.nextval, 3, 4, 'Categoria Banner', 'Categoria Banner - Top de páginas da categoria', sysdate);

INSERT INTO kk_content_type_desc (id, content_type_id, language_id, content_type_name, description, date_added) VALUES (kk_content_type_desc_seq.nextval, 4, 1, 'Category Sub Banner', 'Category Sub Banner - Secondary Category Banner', sysdate);
INSERT INTO kk_content_type_desc (id, content_type_id, language_id, content_type_name, description, date_added) VALUES (kk_content_type_desc_seq.nextval, 4, 2, 'Kategorie Unter Banner', 'Kategorie Unter Banner - Sekundäre Kategorie Banner', sysdate);
INSERT INTO kk_content_type_desc (id, content_type_id, language_id, content_type_name, description, date_added) VALUES (kk_content_type_desc_seq.nextval, 4, 3, 'Categoría Sub Banner', 'Categoría Sub Banner - Categoría Secundaria Banner', sysdate);
INSERT INTO kk_content_type_desc (id, content_type_id, language_id, content_type_name, description, date_added) VALUES (kk_content_type_desc_seq.nextval, 4, 4, 'Categoría Sub Banner', 'Categoria Sub Banner - Categoria Secundária Bandeira', sysdate);

INSERT INTO kk_content_type_desc (id, content_type_id, language_id, content_type_name, description, date_added) VALUES (kk_content_type_desc_seq.nextval, 5, 1, 'About Us', 'About Us Text', sysdate);
INSERT INTO kk_content_type_desc (id, content_type_id, language_id, content_type_name, description, date_added) VALUES (kk_content_type_desc_seq.nextval, 5, 2, 'über uns', 'über uns', sysdate);
INSERT INTO kk_content_type_desc (id, content_type_id, language_id, content_type_name, description, date_added) VALUES (kk_content_type_desc_seq.nextval, 5, 3, 'sobre nosotros', 'sobre nosotros', sysdate);
INSERT INTO kk_content_type_desc (id, content_type_id, language_id, content_type_name, description, date_added) VALUES (kk_content_type_desc_seq.nextval, 5, 4, 'sobre nós', 'sobre nós', sysdate);

INSERT INTO kk_content_type_desc (id, content_type_id, language_id, content_type_name, description, date_added) VALUES (kk_content_type_desc_seq.nextval, 6, 1, 'Shipping and Handling', 'Shipping and Handling Text', sysdate);
INSERT INTO kk_content_type_desc (id, content_type_id, language_id, content_type_name, description, date_added) VALUES (kk_content_type_desc_seq.nextval, 6, 2, 'Versand-und Bearbeitungs', 'Versand-und Bearbeitungs', sysdate);
INSERT INTO kk_content_type_desc (id, content_type_id, language_id, content_type_name, description, date_added) VALUES (kk_content_type_desc_seq.nextval, 6, 3, 'Envío y manipulación', 'Envío y manipulación', sysdate);
INSERT INTO kk_content_type_desc (id, content_type_id, language_id, content_type_name, description, date_added) VALUES (kk_content_type_desc_seq.nextval, 6, 4, 'Envio e manipulação', 'Envio e manipulação', sysdate);

INSERT INTO kk_content_type_desc (id, content_type_id, language_id, content_type_name, description, date_added) VALUES (kk_content_type_desc_seq.nextval, 7, 1, 'Product Returns', 'Product Returns Text', sysdate);
INSERT INTO kk_content_type_desc (id, content_type_id, language_id, content_type_name, description, date_added) VALUES (kk_content_type_desc_seq.nextval, 7, 2, 'Produktrückgabe', 'Produktrückgabe', sysdate);
INSERT INTO kk_content_type_desc (id, content_type_id, language_id, content_type_name, description, date_added) VALUES (kk_content_type_desc_seq.nextval, 7, 3, 'Devolución de productos', 'Devolución de productos', sysdate);
INSERT INTO kk_content_type_desc (id, content_type_id, language_id, content_type_name, description, date_added) VALUES (kk_content_type_desc_seq.nextval, 7, 4, 'Devoluções de produtos', 'Devoluções de produtos', sysdate);

INSERT INTO kk_content_type_desc (id, content_type_id, language_id, content_type_name, description, date_added) VALUES (kk_content_type_desc_seq.nextval, 8, 1, 'International Orders', 'International Orders Text', sysdate);
INSERT INTO kk_content_type_desc (id, content_type_id, language_id, content_type_name, description, date_added) VALUES (kk_content_type_desc_seq.nextval, 8, 2, 'International Orders', 'International Orders Text', sysdate);
INSERT INTO kk_content_type_desc (id, content_type_id, language_id, content_type_name, description, date_added) VALUES (kk_content_type_desc_seq.nextval, 8, 3, 'Pedidos internacionales', 'Pedidos internacionales', sysdate);
INSERT INTO kk_content_type_desc (id, content_type_id, language_id, content_type_name, description, date_added) VALUES (kk_content_type_desc_seq.nextval, 8, 4, 'Encomendas internacionais', 'Encomendas internacionais', sysdate);

INSERT INTO kk_content_type_desc (id, content_type_id, language_id, content_type_name, description, date_added) VALUES (kk_content_type_desc_seq.nextval, 9, 1, 'Privacy Policy', 'Privacy Policy Text', sysdate);
INSERT INTO kk_content_type_desc (id, content_type_id, language_id, content_type_name, description, date_added) VALUES (kk_content_type_desc_seq.nextval, 9, 2, 'Datenschutz-Bestimmungen', 'Datenschutz-Bestimmungen', sysdate);
INSERT INTO kk_content_type_desc (id, content_type_id, language_id, content_type_name, description, date_added) VALUES (kk_content_type_desc_seq.nextval, 9, 3, 'Política de privacidad', 'política de privacidad', sysdate);
INSERT INTO kk_content_type_desc (id, content_type_id, language_id, content_type_name, description, date_added) VALUES (kk_content_type_desc_seq.nextval, 9, 4, 'Política De Privacidade', 'Política De Privacidade', sysdate);

INSERT INTO kk_content_type_desc (id, content_type_id, language_id, content_type_name, description, date_added) VALUES (kk_content_type_desc_seq.nextval, 10, 1, 'Terms of use', 'Terms of use Text', sysdate);
INSERT INTO kk_content_type_desc (id, content_type_id, language_id, content_type_name, description, date_added) VALUES (kk_content_type_desc_seq.nextval, 10, 2, 'Nutzungsbedingungen', 'Nutzungsbedingungen', sysdate);
INSERT INTO kk_content_type_desc (id, content_type_id, language_id, content_type_name, description, date_added) VALUES (kk_content_type_desc_seq.nextval, 10, 3, 'Condiciones de uso', 'Condiciones de uso', sysdate);
INSERT INTO kk_content_type_desc (id, content_type_id, language_id, content_type_name, description, date_added) VALUES (kk_content_type_desc_seq.nextval, 10, 4, 'Termos de uso', 'Termos de uso', sysdate);

INSERT INTO kk_content_type_desc (id, content_type_id, language_id, content_type_name, description, date_added) VALUES (kk_content_type_desc_seq.nextval, 11, 1, 'Help', 'Help Text', sysdate);
INSERT INTO kk_content_type_desc (id, content_type_id, language_id, content_type_name, description, date_added) VALUES (kk_content_type_desc_seq.nextval, 11, 2, 'Hilfe', 'Hilfe', sysdate);
INSERT INTO kk_content_type_desc (id, content_type_id, language_id, content_type_name, description, date_added) VALUES (kk_content_type_desc_seq.nextval, 11, 3, '¡Ayuda', '¡Ayuda', sysdate);
INSERT INTO kk_content_type_desc (id, content_type_id, language_id, content_type_name, description, date_added) VALUES (kk_content_type_desc_seq.nextval, 11, 4, 'Socorro', 'Socorro', sysdate);

INSERT INTO kk_content_type_desc (id, content_type_id, language_id, content_type_name, description, date_added) VALUES (kk_content_type_desc_seq.nextval, 12, 1, 'Contact Us', 'Contact Us Text', sysdate);
INSERT INTO kk_content_type_desc (id, content_type_id, language_id, content_type_name, description, date_added) VALUES (kk_content_type_desc_seq.nextval, 12, 2, 'Kontaktdetails', 'Kontaktdetails', sysdate);
INSERT INTO kk_content_type_desc (id, content_type_id, language_id, content_type_name, description, date_added) VALUES (kk_content_type_desc_seq.nextval, 12, 3, 'Detalles de contacto', 'Detalles de contacto', sysdate);
INSERT INTO kk_content_type_desc (id, content_type_id, language_id, content_type_name, description, date_added) VALUES (kk_content_type_desc_seq.nextval, 12, 4, 'Detalhes de Contato', 'Detalhes de Contato', sysdate);

-- Category Banners

INSERT INTO kk_content (id, content_id, content_type_id, click_url, search_key, object_id, obj_type_id, enabled, updated_by, date_updated, date_added) VALUES (kk_content_seq.nextval, 1, 3, 'SelectProd.action?prodId={OBJ_ID}', 'Computer Peripherals', 31, 1, 1, 2, sysdate, sysdate);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (kk_content_desc_seq.nextval, 1, 1, 'logitech.png', 'logitech-medium.png', 'logitech-small.png', 'Logitech Keyboard', sysdate);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (kk_content_desc_seq.nextval, 1, 2, 'logitech.png', 'logitech-medium.png', 'logitech-small.png', 'Logitech Keyboard', sysdate);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (kk_content_desc_seq.nextval, 1, 3, 'logitech.png', 'logitech-medium.png', 'logitech-small.png', 'Logitech Keyboard', sysdate);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (kk_content_desc_seq.nextval, 1, 4, 'logitech.png', 'logitech-medium.png', 'logitech-small.png', 'Logitech Keyboard', sysdate);

INSERT INTO kk_content (id, content_id, content_type_id, click_url, search_key, object_id, obj_type_id, enabled, updated_by, date_updated, date_added) VALUES (kk_content_seq.nextval, 2, 4, 'SelectProd.action?prodId={OBJ_ID}', 'Computer Peripherals', 27, 1, 1, 2, sysdate, sysdate);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (kk_content_desc_seq.nextval, 2, 1, 'hp-photosmart.png', 'hp-photosmart-medium.png', 'hp-photosmart-small.png', 'HP Photosmart 5510', sysdate);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (kk_content_desc_seq.nextval, 2, 2, 'hp-photosmart.png', 'hp-photosmart-medium.png', 'hp-photosmart-small.png', 'HP Photosmart 5510', sysdate);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (kk_content_desc_seq.nextval, 2, 3, 'hp-photosmart.png', 'hp-photosmart-medium.png', 'hp-photosmart-small.png', 'HP Photosmart 5510', sysdate);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (kk_content_desc_seq.nextval, 2, 4, 'hp-photosmart.png', 'hp-photosmart-medium.png', 'hp-photosmart-small.png', 'HP Photosmart 5510', sysdate);

INSERT INTO kk_content (id, content_id, content_type_id, click_url, search_key, object_id, obj_type_id, enabled, updated_by, date_updated, date_added) VALUES (kk_content_seq.nextval, 3, 4, '', 'Computer Peripherals', 0, 0, 1, 2, sysdate, sysdate);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (kk_content_desc_seq.nextval, 3, 1, 'deals-of-the-week.png', 'deals-of-the-week-medium.png', 'deals-of-the-week-small.png', 'Deals of the Week', sysdate);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (kk_content_desc_seq.nextval, 3, 2, 'deals-of-the-week.png', 'deals-of-the-week-medium.png', 'deals-of-the-week-small.png', 'Deals of the Week', sysdate);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (kk_content_desc_seq.nextval, 3, 3, 'deals-of-the-week.png', 'deals-of-the-week-medium.png', 'deals-of-the-week-small.png', 'Deals of the Week', sysdate);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (kk_content_desc_seq.nextval, 3, 4, 'deals-of-the-week.png', 'deals-of-the-week-medium.png', 'deals-of-the-week-small.png', 'Deals of the Week', sysdate);

INSERT INTO kk_content (id, content_id, content_type_id, click_url, search_key, object_id, obj_type_id, enabled, updated_by, date_updated, date_added) VALUES (kk_content_seq.nextval, 4, 3, 'SelectProd.action?prodId={OBJ_ID}', 'Games', 63, 1, 1, 2, sysdate, sysdate);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (kk_content_desc_seq.nextval, 4, 1, 'black-ops-2.png', 'black-ops-2-medium.png', 'black-ops-2-small.png', 'Black Ops 2', sysdate);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (kk_content_desc_seq.nextval, 4, 2, 'black-ops-2.png', 'black-ops-2-medium.png', 'black-ops-2-small.png', 'Black Ops 2', sysdate);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (kk_content_desc_seq.nextval, 4, 3, 'black-ops-2.png', 'black-ops-2-medium.png', 'black-ops-2-small.png', 'Black Ops 2', sysdate);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (kk_content_desc_seq.nextval, 4, 4, 'black-ops-2.png', 'black-ops-2-medium.png', 'black-ops-2-small.png', 'Black Ops 2', sysdate);

INSERT INTO kk_content (id, content_id, content_type_id, click_url, search_key, object_id, obj_type_id, enabled, updated_by, date_updated, date_added) VALUES (kk_content_seq.nextval, 5, 4, 'SelectProd.action?prodId={OBJ_ID}', 'Games', 21, 1, 1, 2, sysdate, sysdate);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (kk_content_desc_seq.nextval, 5, 1, 'swat-3.png', 'swat-3-medium.png', 'swat-3-small.png', 'Swat-3', sysdate);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (kk_content_desc_seq.nextval, 5, 2, 'swat-3.png', 'swat-3-medium.png', 'swat-3-small.png', 'Swat-3', sysdate);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (kk_content_desc_seq.nextval, 5, 3, 'swat-3.png', 'swat-3-medium.png', 'swat-3-small.png', 'Swat-3', sysdate);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (kk_content_desc_seq.nextval, 5, 4, 'swat-3.png', 'swat-3-medium.png', 'swat-3-small.png', 'Swat-3', sysdate);

INSERT INTO kk_content (id, content_id, content_type_id, click_url, search_key, object_id, obj_type_id, enabled, updated_by, date_updated, date_added) VALUES (kk_content_seq.nextval, 6, 4, '', 'Games', 0, 0, 1, 2, sysdate, sysdate);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (kk_content_desc_seq.nextval, 6, 1, 'winter-deals.png', 'winter-deals-medium.png', 'winter-deals-small.png', 'Winter Deals', sysdate);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (kk_content_desc_seq.nextval, 6, 2, 'winter-deals.png', 'winter-deals-medium.png', 'winter-deals-small.png', 'Winter Deals', sysdate);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (kk_content_desc_seq.nextval, 6, 3, 'winter-deals.png', 'winter-deals-medium.png', 'winter-deals-small.png', 'Winter Deals', sysdate);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (kk_content_desc_seq.nextval, 6, 4, 'winter-deals.png', 'winter-deals-medium.png', 'winter-deals-small.png', 'Winter Deals', sysdate);

INSERT INTO kk_content (id, content_id, content_type_id, click_url, search_key, object_id, obj_type_id, enabled, updated_by, date_updated, date_added) VALUES (kk_content_seq.nextval, 7, 3, 'SelectProd.action?prodId={OBJ_ID}', 'DVD Movies', 20, 1, 1, 2, sysdate, sysdate);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (kk_content_desc_seq.nextval, 7, 1, 'dark-knight.png', 'dark-knight-medium.png', 'dark-knight-small.png', 'Dark Night', sysdate);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (kk_content_desc_seq.nextval, 7, 2, 'dark-knight.png', 'dark-knight-medium.png', 'dark-knight-small.png', 'Dark Night', sysdate);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (kk_content_desc_seq.nextval, 7, 3, 'dark-knight.png', 'dark-knight-medium.png', 'dark-knight-small.png', 'Dark Night', sysdate);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (kk_content_desc_seq.nextval, 7, 4, 'dark-knight.png', 'dark-knight-medium.png', 'dark-knight-small.png', 'Dark Night', sysdate);

INSERT INTO kk_content (id, content_id, content_type_id, click_url, search_key, object_id, obj_type_id, enabled, updated_by, date_updated, date_added) VALUES (kk_content_seq.nextval, 8, 4, 'SelectProd.action?prodId={OBJ_ID}', 'DVD Movies', 11, 1, 1, 2, sysdate, sysdate);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (kk_content_desc_seq.nextval, 8, 1, 'harry-potter.png', 'harry-potter-medium.png', 'harry-potter-small.png', 'Harry Potter', sysdate);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (kk_content_desc_seq.nextval, 8, 2, 'harry-potter.png', 'harry-potter-medium.png', 'harry-potter-small.png', 'Harry Potter', sysdate);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (kk_content_desc_seq.nextval, 8, 3, 'harry-potter.png', 'harry-potter-medium.png', 'harry-potter-small.png', 'Harry Potter', sysdate);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (kk_content_desc_seq.nextval, 8, 4, 'harry-potter.png', 'harry-potter-medium.png', 'harry-potter-small.png', 'Harry Potter', sysdate);

INSERT INTO kk_content (id, content_id, content_type_id, click_url, search_key, object_id, obj_type_id, enabled, updated_by, date_updated, date_added) VALUES (kk_content_seq.nextval, 9, 4, '', 'DVD Movies', 0, 0, 1, 2, sysdate, sysdate);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (kk_content_desc_seq.nextval, 9, 1, 'movie-deals.png', 'movie-deals-medium.png', 'movie-deals-small.png', 'Movie Deals', sysdate);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (kk_content_desc_seq.nextval, 9, 2, 'movie-deals.png', 'movie-deals-medium.png', 'movie-deals-small.png', 'Movie Deals', sysdate);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (kk_content_desc_seq.nextval, 9, 3, 'movie-deals.png', 'movie-deals-medium.png', 'movie-deals-small.png', 'Movie Deals', sysdate);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (kk_content_desc_seq.nextval, 9, 4, 'movie-deals.png', 'movie-deals-medium.png', 'movie-deals-small.png', 'Movie Deals', sysdate);

INSERT INTO kk_content (id, content_id, content_type_id, click_url, search_key, object_id, obj_type_id, enabled, updated_by, date_updated, date_added) VALUES (kk_content_seq.nextval, 10, 3, 'SelectProd.action?prodId={OBJ_ID}', 'Electronics', 34, 1, 1, 2, sysdate, sysdate);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (kk_content_desc_seq.nextval, 10, 1, 'kindle-fire-hd.jpg', 'kindle-fire-hd-medium.jpg', 'kindle-fire-hd-small.jpg', 'Kindle Fire', sysdate);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (kk_content_desc_seq.nextval, 10, 2, 'kindle-fire-hd.jpg', 'kindle-fire-hd-medium.jpg', 'kindle-fire-hd-small.jpg', 'Kindle Fire', sysdate);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (kk_content_desc_seq.nextval, 10, 3, 'kindle-fire-hd.jpg', 'kindle-fire-hd-medium.jpg', 'kindle-fire-hd-small.jpg', 'Kindle Fire', sysdate);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (kk_content_desc_seq.nextval, 10, 4, 'kindle-fire-hd.jpg', 'kindle-fire-hd-medium.jpg', 'kindle-fire-hd-small.jpg', 'Kindle Fire', sysdate);

INSERT INTO kk_content (id, content_id, content_type_id, click_url, search_key, object_id, obj_type_id, enabled, updated_by, date_updated, date_added) VALUES (kk_content_seq.nextval, 11, 4, '', 'Electronics', 0, 0, 1, 2, sysdate, sysdate);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (kk_content_desc_seq.nextval, 11, 1, 'xbox.png', 'xbox-medium.png', 'xbox-small.png', 'Xbox', sysdate);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (kk_content_desc_seq.nextval, 11, 2, 'xbox.png', 'xbox-medium.png', 'xbox-small.png', 'Xbox', sysdate);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (kk_content_desc_seq.nextval, 11, 3, 'xbox.png', 'xbox-medium.png', 'xbox-small.png', 'Xbox', sysdate);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (kk_content_desc_seq.nextval, 11, 4, 'xbox.png', 'xbox-medium.png', 'xbox-small.png', 'Xbox', sysdate);

INSERT INTO kk_content (id, content_id, content_type_id, click_url, search_key, object_id, obj_type_id, enabled, updated_by, date_updated, date_added) VALUES (kk_content_seq.nextval, 12, 4, '', 'Electronics', 0, 0, 1, 2, sysdate, sysdate);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (kk_content_desc_seq.nextval, 12, 1, 'electronics-sale.png', 'electronics-sale-medium.png', 'electronics-sale-small.png', 'Electronics Sale', sysdate);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (kk_content_desc_seq.nextval, 12, 2, 'electronics-sale.png', 'electronics-sale-medium.png', 'electronics-sale-small.png', 'Electronics Sale', sysdate);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (kk_content_desc_seq.nextval, 12, 3, 'electronics-sale.png', 'electronics-sale-medium.png', 'electronics-sale-small.png', 'Electronics Sale', sysdate);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (kk_content_desc_seq.nextval, 12, 4, 'electronics-sale.png', 'electronics-sale-medium.png', 'electronics-sale-small.png', 'Electronics Sale', sysdate);

INSERT INTO kk_content (id, content_id, content_type_id, click_url, search_key, object_id, obj_type_id, enabled, updated_by, date_updated, date_added) VALUES (kk_content_seq.nextval, 13, 3, 'SelectProd.action?prodId={OBJ_ID}', 'Home ' || chr(38) || ' Garden', 33, 1, 1, 2, sysdate, sysdate);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (kk_content_desc_seq.nextval, 13, 1, 'delonghi.png', 'delonghi-medium.png', 'delonghi-small.png', 'DeLonghi Coffee Maker', sysdate);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (kk_content_desc_seq.nextval, 13, 2, 'delonghi.png', 'delonghi-medium.png', 'delonghi-small.png', 'DeLonghi Coffee Maker', sysdate);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (kk_content_desc_seq.nextval, 13, 3, 'delonghi.png', 'delonghi-medium.png', 'delonghi-small.png', 'DeLonghi Coffee Maker', sysdate);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (kk_content_desc_seq.nextval, 13, 4, 'delonghi.png', 'delonghi-medium.png', 'delonghi-small.png', 'DeLonghi Coffee Maker', sysdate);

INSERT INTO kk_content (id, content_id, content_type_id, click_url, search_key, object_id, obj_type_id, enabled, updated_by, date_updated, date_added) VALUES (kk_content_seq.nextval, 14, 4, 'SelectProd.action?prodId={OBJ_ID}', 'Home ' || chr(38) || ' Garden', 39, 1, 1, 2, sysdate, sysdate);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (kk_content_desc_seq.nextval, 14, 1, 'rotak-40.png', 'rotak-40-medium.png', 'rotak-40-small.png', 'Rotak 40', sysdate);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (kk_content_desc_seq.nextval, 14, 2, 'rotak-40.png', 'rotak-40-medium.png', 'rotak-40-small.png', 'Rotak 40', sysdate);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (kk_content_desc_seq.nextval, 14, 3, 'rotak-40.png', 'rotak-40-medium.png', 'rotak-40-small.png', 'Rotak 40', sysdate);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (kk_content_desc_seq.nextval, 14, 4, 'rotak-40.png', 'rotak-40-medium.png', 'rotak-40-small.png', 'Rotak 40', sysdate);

INSERT INTO kk_content (id, content_id, content_type_id, click_url, search_key, object_id, obj_type_id, enabled, updated_by, date_updated, date_added) VALUES (kk_content_seq.nextval, 15, 4, '', 'Home ' || chr(38) || ' Garden', 39, 1, 1, 2, sysdate, sysdate);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (kk_content_desc_seq.nextval, 15, 1, 'gifts-for-the-home.png', 'gifts-for-the-home-medium.png', 'gifts-for-the-home-small.png', 'Gifts for the home', sysdate);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (kk_content_desc_seq.nextval, 15, 2, 'gifts-for-the-home.png', 'gifts-for-the-home-medium.png', 'gifts-for-the-home-small.png', 'Gifts for the home', sysdate);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (kk_content_desc_seq.nextval, 15, 3, 'gifts-for-the-home.png', 'gifts-for-the-home-medium.png', 'gifts-for-the-home-small.png', 'Gifts for the home', sysdate);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (kk_content_desc_seq.nextval, 15, 4, 'gifts-for-the-home.png', 'gifts-for-the-home-medium.png', 'gifts-for-the-home-small.png', 'Gifts for the home', sysdate);

-- Top Banners on Home Page

INSERT INTO kk_content (id, content_id, content_type_id, click_url, object_id, obj_type_id, enabled, updated_by, date_updated, date_added) VALUES (kk_content_seq.nextval, 16, 1, 'SelectProd.action?prodId={OBJ_ID}', 34, 1, 1, 2, sysdate, sysdate);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (kk_content_desc_seq.nextval, 16, 1, 'home_kindle-fire-hd.jpg', 'home_kindle-fire-hd-medium.jpg', 'home_kindle-fire-hd-small.jpg', 'Kindle Fire', sysdate);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (kk_content_desc_seq.nextval, 16, 2, 'home_kindle-fire-hd.jpg', 'home_kindle-fire-hd-medium.jpg', 'home_kindle-fire-hd-small.jpg', 'Kindle Fire', sysdate);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (kk_content_desc_seq.nextval, 16, 3, 'home_kindle-fire-hd.jpg', 'home_kindle-fire-hd-medium.jpg', 'home_kindle-fire-hd-small.jpg', 'Kindle Fire', sysdate);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (kk_content_desc_seq.nextval, 16, 4, 'home_kindle-fire-hd.jpg', 'home_kindle-fire-hd-medium.jpg', 'home_kindle-fire-hd-small.jpg', 'Kindle Fire', sysdate);

INSERT INTO kk_content (id, content_id, content_type_id, click_url, object_id, obj_type_id, enabled, updated_by, date_updated, date_added) VALUES (kk_content_seq.nextval, 17, 1, 'SelectProd.action?prodId={OBJ_ID}', 33, 1, 1, 2, sysdate, sysdate);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (kk_content_desc_seq.nextval, 17, 1, 'home_delonghi.png', 'home_delonghi-medium.png', 'home_delonghi-small.png', 'DeLonghi Coffee Maker', sysdate);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (kk_content_desc_seq.nextval, 17, 2, 'home_delonghi.png', 'home_delonghi-medium.png', 'home_delonghi-small.png', 'DeLonghi Coffee Maker', sysdate);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (kk_content_desc_seq.nextval, 17, 3, 'home_delonghi.png', 'home_delonghi-medium.png', 'home_delonghi-small.png', 'DeLonghi Coffee Maker', sysdate);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (kk_content_desc_seq.nextval, 17, 4, 'home_delonghi.png', 'home_delonghi-medium.png', 'home_delonghi-small.png', 'DeLonghi Coffee Maker', sysdate);

-- Sub-Banners on Home Page

INSERT INTO kk_content (id, content_id, content_type_id, click_url, object_id, obj_type_id, enabled, updated_by, date_updated, date_added) VALUES (kk_content_seq.nextval, 18, 2, 'ShowSpecials.action', 0, 0, 1, 2, sysdate, sysdate);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, title, date_added) VALUES (kk_content_desc_seq.nextval, 18, 1, 'home_electronics-sale.jpg', 'Electronics Sale', sysdate);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, title, date_added) VALUES (kk_content_desc_seq.nextval, 18, 2, 'home_electronics-sale.jpg', 'Electronics Sale', sysdate);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, title, date_added) VALUES (kk_content_desc_seq.nextval, 18, 3, 'home_electronics-sale.jpg', 'Electronics Sale', sysdate);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, title, date_added) VALUES (kk_content_desc_seq.nextval, 18, 4, 'home_electronics-sale.jpg', 'Electronics Sale', sysdate);

INSERT INTO kk_content (id, content_id, content_type_id, click_url, object_id, obj_type_id, enabled, updated_by, date_updated, date_added) VALUES (kk_content_seq.nextval, 19, 2, 'SelectCat.action?catId={OBJ_ID}', 23, 2, 1, 2, sysdate, sysdate);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, title, date_added) VALUES (kk_content_desc_seq.nextval, 19, 1, 'home_electronics-sale-2.jpg', 'Electronics Sale', sysdate);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, title, date_added) VALUES (kk_content_desc_seq.nextval, 19, 2, 'home_electronics-sale-2.jpg', 'Electronics Sale', sysdate);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, title, date_added) VALUES (kk_content_desc_seq.nextval, 19, 3, 'home_electronics-sale-2.jpg', 'Electronics Sale', sysdate);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, title, date_added) VALUES (kk_content_desc_seq.nextval, 19, 4, 'home_electronics-sale-2.jpg', 'Electronics Sale', sysdate);

INSERT INTO kk_content (id, content_id, content_type_id, click_url, object_id, obj_type_id, enabled, updated_by, date_updated, date_added) VALUES (kk_content_seq.nextval, 20, 2, 'SelectCat.action?catId={OBJ_ID}', 24, 2, 1, 2, sysdate, sysdate);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, title, date_added) VALUES (kk_content_desc_seq.nextval, 20, 1, 'home_gifts-for-the-home.jpg', 'Gifts for the home', sysdate);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, title, date_added) VALUES (kk_content_desc_seq.nextval, 20, 2, 'home_gifts-for-the-home.jpg', 'Gifts for the home', sysdate);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, title, date_added) VALUES (kk_content_desc_seq.nextval, 20, 3, 'home_gifts-for-the-home.jpg', 'Gifts for the home', sysdate);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, title, date_added) VALUES (kk_content_desc_seq.nextval, 20, 4, 'home_gifts-for-the-home.jpg', 'Gifts for the home', sysdate);

INSERT INTO kk_content (id, content_id, content_type_id, click_url, object_id, obj_type_id, enabled, updated_by, date_updated, date_added) VALUES (kk_content_seq.nextval, 21, 2, 'SelectProd.action?prodId={OBJ_ID}', 32, 1, 1, 2, sysdate, sysdate);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, title, date_added) VALUES (kk_content_desc_seq.nextval, 21, 1, 'home_windows-8.jpg', 'Windows-8', sysdate);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, title, date_added) VALUES (kk_content_desc_seq.nextval, 21, 2, 'home_windows-8.jpg', 'Windows-8', sysdate);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, title, date_added) VALUES (kk_content_desc_seq.nextval, 21, 3, 'home_windows-8.jpg', 'Windows-8', sysdate);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, title, date_added) VALUES (kk_content_desc_seq.nextval, 21, 4, 'home_windows-8.jpg', 'Windows-8', sysdate);

INSERT INTO kk_content (id, content_id, content_type_id, click_url, object_id, obj_type_id, enabled, updated_by, date_updated, date_added) VALUES (kk_content_seq.nextval, 22, 2, 'SelectProd.action?prodId={OBJ_ID}', 35, 1, 1, 2, sysdate, sysdate);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, title, date_added) VALUES (kk_content_desc_seq.nextval, 22, 1, 'home_iphone-5.jpg', 'iPhone 5', sysdate);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, title, date_added) VALUES (kk_content_desc_seq.nextval, 22, 2, 'home_iphone-5.jpg', 'iPhone 5', sysdate);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, title, date_added) VALUES (kk_content_desc_seq.nextval, 22, 3, 'home_iphone-5.jpg', 'iPhone 5', sysdate);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, title, date_added) VALUES (kk_content_desc_seq.nextval, 22, 4, 'home_iphone-5.jpg', 'iPhone 5', sysdate);

INSERT INTO kk_content (id, content_id, content_type_id, click_url, object_id, obj_type_id, enabled, updated_by, date_updated, date_added) VALUES (kk_content_seq.nextval, 23, 5, '', 0, 0, 1, 2, sysdate, sysdate);
INSERT INTO kk_content_desc (id, content_id, language_id, content, date_added) VALUES (kk_content_desc_seq.nextval, 23, 1, 'Add your About Us information here.', sysdate);
INSERT INTO kk_content_desc (id, content_id, language_id, content, date_added) VALUES (kk_content_desc_seq.nextval, 23, 2, 'Fügen Sie Ihre Über uns Informationen hier', sysdate);
INSERT INTO kk_content_desc (id, content_id, language_id, content, date_added) VALUES (kk_content_desc_seq.nextval, 23, 3, 'Añade tu Quiénes somos información aquí', sysdate);
INSERT INTO kk_content_desc (id, content_id, language_id, content, date_added) VALUES (kk_content_desc_seq.nextval, 23, 4, 'Adicione a sua Quem somos informações aqui', sysdate);

INSERT INTO kk_content (id, content_id, content_type_id, click_url, object_id, obj_type_id, enabled, updated_by, date_updated, date_added) VALUES (kk_content_seq.nextval, 24, 6, '', 0, 0, 1, 2, sysdate, sysdate);
INSERT INTO kk_content_desc (id, content_id, language_id, content, date_added) VALUES (kk_content_desc_seq.nextval, 24, 1, 'Add your Shipping and Handling information here.', sysdate);
INSERT INTO kk_content_desc (id, content_id, language_id, content, date_added) VALUES (kk_content_desc_seq.nextval, 24, 2, 'Fügen Sie Ihre Versandinformationen hier', sysdate);
INSERT INTO kk_content_desc (id, content_id, language_id, content, date_added) VALUES (kk_content_desc_seq.nextval, 24, 3, 'Agregue su envío y manipulación de información aquí', sysdate);
INSERT INTO kk_content_desc (id, content_id, language_id, content, date_added) VALUES (kk_content_desc_seq.nextval, 24, 4, 'Adicione sua informação de envio aqui', sysdate);

INSERT INTO kk_content (id, content_id, content_type_id, click_url, object_id, obj_type_id, enabled, updated_by, date_updated, date_added) VALUES (kk_content_seq.nextval, 25, 7, '', 0, 0, 1, 2, sysdate, sysdate);
INSERT INTO kk_content_desc (id, content_id, language_id, content, date_added) VALUES (kk_content_desc_seq.nextval, 25, 1, 'Add your Returns information here.', sysdate);
INSERT INTO kk_content_desc (id, content_id, language_id, content, date_added) VALUES (kk_content_desc_seq.nextval, 25, 2, 'Fügen Sie Ihre Versandkosten Informationen finden Sie hier', sysdate);
INSERT INTO kk_content_desc (id, content_id, language_id, content, date_added) VALUES (kk_content_desc_seq.nextval, 25, 3, 'Añade tu información Devoluciones aquí', sysdate);
INSERT INTO kk_content_desc (id, content_id, language_id, content, date_added) VALUES (kk_content_desc_seq.nextval, 25, 4, 'Adicione sua informação Returns aqui', sysdate);

INSERT INTO kk_content (id, content_id, content_type_id, click_url, object_id, obj_type_id, enabled, updated_by, date_updated, date_added) VALUES (kk_content_seq.nextval, 26, 8, '', 0, 0, 1, 2, sysdate, sysdate);
INSERT INTO kk_content_desc (id, content_id, language_id, content, date_added) VALUES (kk_content_desc_seq.nextval, 26, 1, 'Add your International Orders information here.', sysdate);
INSERT INTO kk_content_desc (id, content_id, language_id, content, date_added) VALUES (kk_content_desc_seq.nextval, 26, 2, 'Fügen Sie hier Ihre Informationen Internationale Bestellungen.', sysdate);
INSERT INTO kk_content_desc (id, content_id, language_id, content, date_added) VALUES (kk_content_desc_seq.nextval, 26, 3, 'Añade tu información Internacional Órdenes aquí.', sysdate);
INSERT INTO kk_content_desc (id, content_id, language_id, content, date_added) VALUES (kk_content_desc_seq.nextval, 26, 4, 'Adicione sua informação Internacional Ordens aqui.', sysdate);

INSERT INTO kk_content (id, content_id, content_type_id, click_url, object_id, obj_type_id, enabled, updated_by, date_updated, date_added) VALUES (kk_content_seq.nextval, 27, 9, '', 0, 0, 1, 2, sysdate, sysdate);
INSERT INTO kk_content_desc (id, content_id, language_id, content, date_added) VALUES (kk_content_desc_seq.nextval, 27, 1, 'Add your Privacy Policy here.', sysdate);
INSERT INTO kk_content_desc (id, content_id, language_id, content, date_added) VALUES (kk_content_desc_seq.nextval, 27, 2, 'Fügen Sie Ihren Datenschutz hier.', sysdate);
INSERT INTO kk_content_desc (id, content_id, language_id, content, date_added) VALUES (kk_content_desc_seq.nextval, 27, 3, 'Agregue su política de privacidad aquí.', sysdate);
INSERT INTO kk_content_desc (id, content_id, language_id, content, date_added) VALUES (kk_content_desc_seq.nextval, 27, 4, 'Adicione a sua Política de Privacidade aqui.', sysdate);

INSERT INTO kk_content (id, content_id, content_type_id, click_url, object_id, obj_type_id, enabled, updated_by, date_updated, date_added) VALUES (kk_content_seq.nextval, 28, 10, '', 0, 0, 1, 2, sysdate, sysdate);
INSERT INTO kk_content_desc (id, content_id, language_id, content, date_added) VALUES (kk_content_desc_seq.nextval, 28, 1, 'Add your Terms of Use here.', sysdate);
INSERT INTO kk_content_desc (id, content_id, language_id, content, date_added) VALUES (kk_content_desc_seq.nextval, 28, 2, 'Fügen Sie Ihr Nutzungsbedingungen hier', sysdate);
INSERT INTO kk_content_desc (id, content_id, language_id, content, date_added) VALUES (kk_content_desc_seq.nextval, 28, 3, 'Añada sus Términos de Uso aquí', sysdate);
INSERT INTO kk_content_desc (id, content_id, language_id, content, date_added) VALUES (kk_content_desc_seq.nextval, 28, 4, 'Adicione seus Termos de Uso aqui', sysdate);

INSERT INTO kk_content (id, content_id, content_type_id, click_url, object_id, obj_type_id, enabled, updated_by, date_updated, date_added) VALUES (kk_content_seq.nextval, 29, 11, '', 0, 0, 1, 2, sysdate, sysdate);
INSERT INTO kk_content_desc (id, content_id, language_id, content, date_added) VALUES (kk_content_desc_seq.nextval, 29, 1, 'Add your Help information here.', sysdate);
INSERT INTO kk_content_desc (id, content_id, language_id, content, date_added) VALUES (kk_content_desc_seq.nextval, 29, 2, 'Fügen Sie hier Ihre Informationen Hilfe.', sysdate);
INSERT INTO kk_content_desc (id, content_id, language_id, content, date_added) VALUES (kk_content_desc_seq.nextval, 29, 3, 'Añade tu información de ayuda aquí.', sysdate);
INSERT INTO kk_content_desc (id, content_id, language_id, content, date_added) VALUES (kk_content_desc_seq.nextval, 29, 4, 'Adicione sua informação ajuda aqui.', sysdate);

INSERT INTO kk_content (id, content_id, content_type_id, click_url, object_id, obj_type_id, enabled, updated_by, date_updated, date_added) VALUES (kk_content_seq.nextval, 30, 12, '', 0, 0, 1, 2, sysdate, sysdate);
INSERT INTO kk_content_desc (id, content_id, language_id, content, date_added) VALUES (kk_content_desc_seq.nextval, 30, 1, 'Add your Contact information here.', sysdate);
INSERT INTO kk_content_desc (id, content_id, language_id, content, date_added) VALUES (kk_content_desc_seq.nextval, 30, 2, 'Fügen Sie Ihre Kontaktinformationen hier', sysdate);
INSERT INTO kk_content_desc (id, content_id, language_id, content, date_added) VALUES (kk_content_desc_seq.nextval, 30, 3, 'Añadir su información de contacto aquí', sysdate);
INSERT INTO kk_content_desc (id, content_id, language_id, content, date_added) VALUES (kk_content_desc_seq.nextval, 30, 4, 'Adicione sua informação de contato aqui', sysdate);

-- New API calls for Content
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'getContents', '', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'getContent', '', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'insertContent', '', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'deleteContent', '', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'updateContent', '', sysdate);

INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'getContentTypes', '', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'getContentType', '', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'insertContentType', '', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'deleteContentType', '', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'updateContentType', '', sysdate);

-- New Admin App Panels for Content

INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval, 'kk_panel_contentTypes','Content Types', sysdate);

-- Add Content Type Panel access to all roles that can access the 'kk_panel_storeConfiguration' panel
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, sysdate, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_storeConfiguration' and p2.code='kk_panel_contentTypes';

INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval, 'kk_panel_content','Content', sysdate);

-- Add Content Panel access to all roles that can access the 'kk_panel_storeConfiguration' panel
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, sysdate, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_storeConfiguration' and p2.code='kk_panel_content';

INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval, 'kk_panel_editContent','Edit Content', sysdate);

-- Add Content Panel access to all roles that can access the 'kk_panel_storeConfiguration' panel
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, sysdate, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_storeConfiguration' and p2.code='kk_panel_editContent';

-- Add a search key to categories
ALTER TABLE categories ADD search_key varchar(128);
UPDATE categories C SET search_key = (SELECT categories_name FROM categories_description CD WHERE C.categories_id = CD.categories_id AND CD.language_id IN (SELECT languages_id FROM languages L, configuration CON WHERE code=configuration_value AND configuration_key='DEFAULT_LANGUAGE'));

DELETE FROM configuration WHERE configuration_key = 'ENABLE_KONAKART_CONTENT';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api, store_id) SELECT configuration_seq.nextval, 'Enable KonaKart Content', 'ENABLE_KONAKART_CONTENT', 'false', 'When set to true, KonaKart Content is enabled', '1', '10', 'choice(''true''=''true'',''false''=''false'')', sysdate, 1, store_id FROM configuration WHERE configuration_key = 'STORE_COUNTRY';

-- Add iso_numeric and custom1 columns to countries
ALTER TABLE countries ADD iso_numeric VARCHAR(10);
ALTER TABLE countries ADD custom1 VARCHAR(10);

DELETE FROM countries WHERE countries_iso_code_3 = 'FXX';
UPDATE countries SET iso_numeric = '004' WHERE countries_iso_code_3 = 'AFG';
UPDATE countries SET iso_numeric = '248' WHERE countries_iso_code_3 = 'ALA';
UPDATE countries SET iso_numeric = '008' WHERE countries_iso_code_3 = 'ALB';
UPDATE countries SET iso_numeric = '012' WHERE countries_iso_code_3 = 'DZA';
UPDATE countries SET iso_numeric = '016' WHERE countries_iso_code_3 = 'ASM';
UPDATE countries SET iso_numeric = '020' WHERE countries_iso_code_3 = 'AND';
UPDATE countries SET iso_numeric = '024' WHERE countries_iso_code_3 = 'AGO';
UPDATE countries SET iso_numeric = '660' WHERE countries_iso_code_3 = 'AIA';
UPDATE countries SET iso_numeric = '010' WHERE countries_iso_code_3 = 'ATA';
UPDATE countries SET iso_numeric = '028' WHERE countries_iso_code_3 = 'ATG';
UPDATE countries SET iso_numeric = '032' WHERE countries_iso_code_3 = 'ARG';
UPDATE countries SET iso_numeric = '051' WHERE countries_iso_code_3 = 'ARM';
UPDATE countries SET iso_numeric = '533' WHERE countries_iso_code_3 = 'ABW';
UPDATE countries SET iso_numeric = '036' WHERE countries_iso_code_3 = 'AUS';
UPDATE countries SET iso_numeric = '040' WHERE countries_iso_code_3 = 'AUT';
UPDATE countries SET iso_numeric = '031' WHERE countries_iso_code_3 = 'AZE';
UPDATE countries SET iso_numeric = '044' WHERE countries_iso_code_3 = 'BHS';
UPDATE countries SET iso_numeric = '048' WHERE countries_iso_code_3 = 'BHR';
UPDATE countries SET iso_numeric = '050' WHERE countries_iso_code_3 = 'BGD';
UPDATE countries SET iso_numeric = '052' WHERE countries_iso_code_3 = 'BRB';
UPDATE countries SET iso_numeric = '112' WHERE countries_iso_code_3 = 'BLR';
UPDATE countries SET iso_numeric = '056' WHERE countries_iso_code_3 = 'BEL';
UPDATE countries SET iso_numeric = '084' WHERE countries_iso_code_3 = 'BLZ';
UPDATE countries SET iso_numeric = '204' WHERE countries_iso_code_3 = 'BEN';
UPDATE countries SET iso_numeric = '060' WHERE countries_iso_code_3 = 'BMU';
UPDATE countries SET iso_numeric = '064' WHERE countries_iso_code_3 = 'BTN';
UPDATE countries SET iso_numeric = '068' WHERE countries_iso_code_3 = 'BOL';
UPDATE countries SET iso_numeric = '070' WHERE countries_iso_code_3 = 'BIH';
UPDATE countries SET iso_numeric = '072' WHERE countries_iso_code_3 = 'BWA';
UPDATE countries SET iso_numeric = '074' WHERE countries_iso_code_3 = 'BVT';
UPDATE countries SET iso_numeric = '076' WHERE countries_iso_code_3 = 'BRA';
UPDATE countries SET iso_numeric = '092' WHERE countries_iso_code_3 = 'VGB';
UPDATE countries SET iso_numeric = '086' WHERE countries_iso_code_3 = 'IOT';
UPDATE countries SET iso_numeric = '096' WHERE countries_iso_code_3 = 'BRN';
UPDATE countries SET iso_numeric = '100' WHERE countries_iso_code_3 = 'BGR';
UPDATE countries SET iso_numeric = '854' WHERE countries_iso_code_3 = 'BFA';
UPDATE countries SET iso_numeric = '108' WHERE countries_iso_code_3 = 'BDI';
UPDATE countries SET iso_numeric = '116' WHERE countries_iso_code_3 = 'KHM';
UPDATE countries SET iso_numeric = '120' WHERE countries_iso_code_3 = 'CMR';
UPDATE countries SET iso_numeric = '124' WHERE countries_iso_code_3 = 'CAN';
UPDATE countries SET iso_numeric = '132' WHERE countries_iso_code_3 = 'CPV';
UPDATE countries SET iso_numeric = '136' WHERE countries_iso_code_3 = 'CYM';
UPDATE countries SET iso_numeric = '140' WHERE countries_iso_code_3 = 'CAF';
UPDATE countries SET iso_numeric = '148' WHERE countries_iso_code_3 = 'TCD';
UPDATE countries SET iso_numeric = '152' WHERE countries_iso_code_3 = 'CHL';
UPDATE countries SET iso_numeric = '156' WHERE countries_iso_code_3 = 'CHN';
UPDATE countries SET iso_numeric = '344' WHERE countries_iso_code_3 = 'HKG';
UPDATE countries SET iso_numeric = '446' WHERE countries_iso_code_3 = 'MAC';
UPDATE countries SET iso_numeric = '162' WHERE countries_iso_code_3 = 'CXR';
UPDATE countries SET iso_numeric = '166' WHERE countries_iso_code_3 = 'CCK';
UPDATE countries SET iso_numeric = '170' WHERE countries_iso_code_3 = 'COL';
UPDATE countries SET iso_numeric = '174' WHERE countries_iso_code_3 = 'COM';
UPDATE countries SET iso_numeric = '178' WHERE countries_iso_code_3 = 'COG';
UPDATE countries SET iso_numeric = '180' WHERE countries_iso_code_3 = 'COD';
UPDATE countries SET iso_numeric = '184' WHERE countries_iso_code_3 = 'COK';
UPDATE countries SET iso_numeric = '188' WHERE countries_iso_code_3 = 'CRI';
UPDATE countries SET iso_numeric = '384' WHERE countries_iso_code_3 = 'CIV';
UPDATE countries SET iso_numeric = '191' WHERE countries_iso_code_3 = 'HRV';
UPDATE countries SET iso_numeric = '192' WHERE countries_iso_code_3 = 'CUB';
UPDATE countries SET iso_numeric = '196' WHERE countries_iso_code_3 = 'CYP';
UPDATE countries SET iso_numeric = '203' WHERE countries_iso_code_3 = 'CZE';
UPDATE countries SET iso_numeric = '208' WHERE countries_iso_code_3 = 'DNK';
UPDATE countries SET iso_numeric = '262' WHERE countries_iso_code_3 = 'DJI';
UPDATE countries SET iso_numeric = '212' WHERE countries_iso_code_3 = 'DMA';
UPDATE countries SET iso_numeric = '214' WHERE countries_iso_code_3 = 'DOM';
UPDATE countries SET iso_numeric = '218' WHERE countries_iso_code_3 = 'ECU';
UPDATE countries SET iso_numeric = '818' WHERE countries_iso_code_3 = 'EGY';
UPDATE countries SET iso_numeric = '222' WHERE countries_iso_code_3 = 'SLV';
UPDATE countries SET iso_numeric = '226' WHERE countries_iso_code_3 = 'GNQ';
UPDATE countries SET iso_numeric = '232' WHERE countries_iso_code_3 = 'ERI';
UPDATE countries SET iso_numeric = '233' WHERE countries_iso_code_3 = 'EST';
UPDATE countries SET iso_numeric = '231' WHERE countries_iso_code_3 = 'ETH';
UPDATE countries SET iso_numeric = '238' WHERE countries_iso_code_3 = 'FLK';
UPDATE countries SET iso_numeric = '234' WHERE countries_iso_code_3 = 'FRO';
UPDATE countries SET iso_numeric = '242' WHERE countries_iso_code_3 = 'FJI';
UPDATE countries SET iso_numeric = '246' WHERE countries_iso_code_3 = 'FIN';
UPDATE countries SET iso_numeric = '250' WHERE countries_iso_code_3 = 'FRA';
UPDATE countries SET iso_numeric = '254' WHERE countries_iso_code_3 = 'GUF';
UPDATE countries SET iso_numeric = '258' WHERE countries_iso_code_3 = 'PYF';
UPDATE countries SET iso_numeric = '260' WHERE countries_iso_code_3 = 'ATF';
UPDATE countries SET iso_numeric = '266' WHERE countries_iso_code_3 = 'GAB';
UPDATE countries SET iso_numeric = '270' WHERE countries_iso_code_3 = 'GMB';
UPDATE countries SET iso_numeric = '268' WHERE countries_iso_code_3 = 'GEO';
UPDATE countries SET iso_numeric = '276' WHERE countries_iso_code_3 = 'DEU';
UPDATE countries SET iso_numeric = '288' WHERE countries_iso_code_3 = 'GHA';
UPDATE countries SET iso_numeric = '292' WHERE countries_iso_code_3 = 'GIB';
UPDATE countries SET iso_numeric = '300' WHERE countries_iso_code_3 = 'GRC';
UPDATE countries SET iso_numeric = '304' WHERE countries_iso_code_3 = 'GRL';
UPDATE countries SET iso_numeric = '308' WHERE countries_iso_code_3 = 'GRD';
UPDATE countries SET iso_numeric = '312' WHERE countries_iso_code_3 = 'GLP';
UPDATE countries SET iso_numeric = '316' WHERE countries_iso_code_3 = 'GUM';
UPDATE countries SET iso_numeric = '320' WHERE countries_iso_code_3 = 'GTM';
UPDATE countries SET iso_numeric = '831' WHERE countries_iso_code_3 = 'GGY';
UPDATE countries SET iso_numeric = '324' WHERE countries_iso_code_3 = 'GIN';
UPDATE countries SET iso_numeric = '624' WHERE countries_iso_code_3 = 'GNB';
UPDATE countries SET iso_numeric = '328' WHERE countries_iso_code_3 = 'GUY';
UPDATE countries SET iso_numeric = '332' WHERE countries_iso_code_3 = 'HTI';
UPDATE countries SET iso_numeric = '334' WHERE countries_iso_code_3 = 'HMD';
UPDATE countries SET iso_numeric = '336' WHERE countries_iso_code_3 = 'VAT';
UPDATE countries SET iso_numeric = '340' WHERE countries_iso_code_3 = 'HND';
UPDATE countries SET iso_numeric = '348' WHERE countries_iso_code_3 = 'HUN';
UPDATE countries SET iso_numeric = '352' WHERE countries_iso_code_3 = 'ISL';
UPDATE countries SET iso_numeric = '356' WHERE countries_iso_code_3 = 'IND';
UPDATE countries SET iso_numeric = '360' WHERE countries_iso_code_3 = 'IDN';
UPDATE countries SET iso_numeric = '364' WHERE countries_iso_code_3 = 'IRN';
UPDATE countries SET iso_numeric = '368' WHERE countries_iso_code_3 = 'IRQ';
UPDATE countries SET iso_numeric = '372' WHERE countries_iso_code_3 = 'IRL';
UPDATE countries SET iso_numeric = '833' WHERE countries_iso_code_3 = 'IMN';
UPDATE countries SET iso_numeric = '376' WHERE countries_iso_code_3 = 'ISR';
UPDATE countries SET iso_numeric = '380' WHERE countries_iso_code_3 = 'ITA';
UPDATE countries SET iso_numeric = '388' WHERE countries_iso_code_3 = 'JAM';
UPDATE countries SET iso_numeric = '392' WHERE countries_iso_code_3 = 'JPN';
UPDATE countries SET iso_numeric = '832' WHERE countries_iso_code_3 = 'JEY';
UPDATE countries SET iso_numeric = '400' WHERE countries_iso_code_3 = 'JOR';
UPDATE countries SET iso_numeric = '398' WHERE countries_iso_code_3 = 'KAZ';
UPDATE countries SET iso_numeric = '404' WHERE countries_iso_code_3 = 'KEN';
UPDATE countries SET iso_numeric = '296' WHERE countries_iso_code_3 = 'KIR';
UPDATE countries SET iso_numeric = '408' WHERE countries_iso_code_3 = 'PRK';
UPDATE countries SET iso_numeric = '410' WHERE countries_iso_code_3 = 'KOR';
UPDATE countries SET iso_numeric = '414' WHERE countries_iso_code_3 = 'KWT';
UPDATE countries SET iso_numeric = '417' WHERE countries_iso_code_3 = 'KGZ';
UPDATE countries SET iso_numeric = '418' WHERE countries_iso_code_3 = 'LAO';
UPDATE countries SET iso_numeric = '428' WHERE countries_iso_code_3 = 'LVA';
UPDATE countries SET iso_numeric = '422' WHERE countries_iso_code_3 = 'LBN';
UPDATE countries SET iso_numeric = '426' WHERE countries_iso_code_3 = 'LSO';
UPDATE countries SET iso_numeric = '430' WHERE countries_iso_code_3 = 'LBR';
UPDATE countries SET iso_numeric = '434' WHERE countries_iso_code_3 = 'LBY';
UPDATE countries SET iso_numeric = '438' WHERE countries_iso_code_3 = 'LIE';
UPDATE countries SET iso_numeric = '440' WHERE countries_iso_code_3 = 'LTU';
UPDATE countries SET iso_numeric = '442' WHERE countries_iso_code_3 = 'LUX';
UPDATE countries SET iso_numeric = '807' WHERE countries_iso_code_3 = 'MKD';
UPDATE countries SET iso_numeric = '450' WHERE countries_iso_code_3 = 'MDG';
UPDATE countries SET iso_numeric = '454' WHERE countries_iso_code_3 = 'MWI';
UPDATE countries SET iso_numeric = '458' WHERE countries_iso_code_3 = 'MYS';
UPDATE countries SET iso_numeric = '462' WHERE countries_iso_code_3 = 'MDV';
UPDATE countries SET iso_numeric = '466' WHERE countries_iso_code_3 = 'MLI';
UPDATE countries SET iso_numeric = '470' WHERE countries_iso_code_3 = 'MLT';
UPDATE countries SET iso_numeric = '584' WHERE countries_iso_code_3 = 'MHL';
UPDATE countries SET iso_numeric = '474' WHERE countries_iso_code_3 = 'MTQ';
UPDATE countries SET iso_numeric = '478' WHERE countries_iso_code_3 = 'MRT';
UPDATE countries SET iso_numeric = '480' WHERE countries_iso_code_3 = 'MUS';
UPDATE countries SET iso_numeric = '175' WHERE countries_iso_code_3 = 'MYT';
UPDATE countries SET iso_numeric = '484' WHERE countries_iso_code_3 = 'MEX';
UPDATE countries SET iso_numeric = '583' WHERE countries_iso_code_3 = 'FSM';
UPDATE countries SET iso_numeric = '498' WHERE countries_iso_code_3 = 'MDA';
UPDATE countries SET iso_numeric = '492' WHERE countries_iso_code_3 = 'MCO';
UPDATE countries SET iso_numeric = '496' WHERE countries_iso_code_3 = 'MNG';
UPDATE countries SET iso_numeric = '499' WHERE countries_iso_code_3 = 'MNE';
UPDATE countries SET iso_numeric = '500' WHERE countries_iso_code_3 = 'MSR';
UPDATE countries SET iso_numeric = '504' WHERE countries_iso_code_3 = 'MAR';
UPDATE countries SET iso_numeric = '508' WHERE countries_iso_code_3 = 'MOZ';
UPDATE countries SET iso_numeric = '104' WHERE countries_iso_code_3 = 'MMR';
UPDATE countries SET iso_numeric = '516' WHERE countries_iso_code_3 = 'NAM';
UPDATE countries SET iso_numeric = '520' WHERE countries_iso_code_3 = 'NRU';
UPDATE countries SET iso_numeric = '524' WHERE countries_iso_code_3 = 'NPL';
UPDATE countries SET iso_numeric = '528' WHERE countries_iso_code_3 = 'NLD';
UPDATE countries SET iso_numeric = '530' WHERE countries_iso_code_3 = 'ANT';
UPDATE countries SET iso_numeric = '540' WHERE countries_iso_code_3 = 'NCL';
UPDATE countries SET iso_numeric = '554' WHERE countries_iso_code_3 = 'NZL';
UPDATE countries SET iso_numeric = '558' WHERE countries_iso_code_3 = 'NIC';
UPDATE countries SET iso_numeric = '562' WHERE countries_iso_code_3 = 'NER';
UPDATE countries SET iso_numeric = '566' WHERE countries_iso_code_3 = 'NGA';
UPDATE countries SET iso_numeric = '570' WHERE countries_iso_code_3 = 'NIU';
UPDATE countries SET iso_numeric = '574' WHERE countries_iso_code_3 = 'NFK';
UPDATE countries SET iso_numeric = '580' WHERE countries_iso_code_3 = 'MNP';
UPDATE countries SET iso_numeric = '578' WHERE countries_iso_code_3 = 'NOR';
UPDATE countries SET iso_numeric = '512' WHERE countries_iso_code_3 = 'OMN';
UPDATE countries SET iso_numeric = '586' WHERE countries_iso_code_3 = 'PAK';
UPDATE countries SET iso_numeric = '585' WHERE countries_iso_code_3 = 'PLW';
UPDATE countries SET iso_numeric = '275' WHERE countries_iso_code_3 = 'PSE';
UPDATE countries SET iso_numeric = '591' WHERE countries_iso_code_3 = 'PAN';
UPDATE countries SET iso_numeric = '598' WHERE countries_iso_code_3 = 'PNG';
UPDATE countries SET iso_numeric = '600' WHERE countries_iso_code_3 = 'PRY';
UPDATE countries SET iso_numeric = '604' WHERE countries_iso_code_3 = 'PER';
UPDATE countries SET iso_numeric = '608' WHERE countries_iso_code_3 = 'PHL';
UPDATE countries SET iso_numeric = '612' WHERE countries_iso_code_3 = 'PCN';
UPDATE countries SET iso_numeric = '616' WHERE countries_iso_code_3 = 'POL';
UPDATE countries SET iso_numeric = '620' WHERE countries_iso_code_3 = 'PRT';
UPDATE countries SET iso_numeric = '630' WHERE countries_iso_code_3 = 'PRI';
UPDATE countries SET iso_numeric = '634' WHERE countries_iso_code_3 = 'QAT';
UPDATE countries SET iso_numeric = '638' WHERE countries_iso_code_3 = 'REU';
UPDATE countries SET iso_numeric = '642' WHERE countries_iso_code_3 = 'ROM';
UPDATE countries SET iso_numeric = '642' WHERE countries_iso_code_3 = 'ROU';
UPDATE countries SET iso_numeric = '643' WHERE countries_iso_code_3 = 'RUS';
UPDATE countries SET iso_numeric = '646' WHERE countries_iso_code_3 = 'RWA';
UPDATE countries SET iso_numeric = '652' WHERE countries_iso_code_3 = 'BLM';
UPDATE countries SET iso_numeric = '654' WHERE countries_iso_code_3 = 'SHN';
UPDATE countries SET iso_numeric = '659' WHERE countries_iso_code_3 = 'KNA';
UPDATE countries SET iso_numeric = '662' WHERE countries_iso_code_3 = 'LCA';
UPDATE countries SET iso_numeric = '663' WHERE countries_iso_code_3 = 'MAF';
UPDATE countries SET iso_numeric = '666' WHERE countries_iso_code_3 = 'SPM';
UPDATE countries SET iso_numeric = '670' WHERE countries_iso_code_3 = 'VCT';
UPDATE countries SET iso_numeric = '882' WHERE countries_iso_code_3 = 'WSM';
UPDATE countries SET iso_numeric = '674' WHERE countries_iso_code_3 = 'SMR';
UPDATE countries SET iso_numeric = '678' WHERE countries_iso_code_3 = 'STP';
UPDATE countries SET iso_numeric = '682' WHERE countries_iso_code_3 = 'SAU';
UPDATE countries SET iso_numeric = '686' WHERE countries_iso_code_3 = 'SEN';
UPDATE countries SET iso_numeric = '688' WHERE countries_iso_code_3 = 'SRB';
UPDATE countries SET iso_numeric = '690' WHERE countries_iso_code_3 = 'SYC';
UPDATE countries SET iso_numeric = '694' WHERE countries_iso_code_3 = 'SLE';
UPDATE countries SET iso_numeric = '702' WHERE countries_iso_code_3 = 'SGP';
UPDATE countries SET iso_numeric = '703' WHERE countries_iso_code_3 = 'SVK';
UPDATE countries SET iso_numeric = '705' WHERE countries_iso_code_3 = 'SVN';
UPDATE countries SET iso_numeric = '090' WHERE countries_iso_code_3 = 'SLB';
UPDATE countries SET iso_numeric = '706' WHERE countries_iso_code_3 = 'SOM';
UPDATE countries SET iso_numeric = '710' WHERE countries_iso_code_3 = 'ZAF';
UPDATE countries SET iso_numeric = '239' WHERE countries_iso_code_3 = 'SGS';
UPDATE countries SET iso_numeric = '728' WHERE countries_iso_code_3 = 'SSD';
UPDATE countries SET iso_numeric = '724' WHERE countries_iso_code_3 = 'ESP';
UPDATE countries SET iso_numeric = '144' WHERE countries_iso_code_3 = 'LKA';
UPDATE countries SET iso_numeric = '736' WHERE countries_iso_code_3 = 'SDN';
UPDATE countries SET iso_numeric = '740' WHERE countries_iso_code_3 = 'SUR';
UPDATE countries SET iso_numeric = '744' WHERE countries_iso_code_3 = 'SJM';
UPDATE countries SET iso_numeric = '748' WHERE countries_iso_code_3 = 'SWZ';
UPDATE countries SET iso_numeric = '752' WHERE countries_iso_code_3 = 'SWE';
UPDATE countries SET iso_numeric = '756' WHERE countries_iso_code_3 = 'CHE';
UPDATE countries SET iso_numeric = '760' WHERE countries_iso_code_3 = 'SYR';
UPDATE countries SET iso_numeric = '626' WHERE countries_iso_code_3 = 'TMP';
UPDATE countries SET iso_numeric = '158' WHERE countries_iso_code_3 = 'TWN';
UPDATE countries SET iso_numeric = '762' WHERE countries_iso_code_3 = 'TJK';
UPDATE countries SET iso_numeric = '834' WHERE countries_iso_code_3 = 'TZA';
UPDATE countries SET iso_numeric = '764' WHERE countries_iso_code_3 = 'THA';
UPDATE countries SET iso_numeric = '626' WHERE countries_iso_code_3 = 'TLS';
UPDATE countries SET iso_numeric = '768' WHERE countries_iso_code_3 = 'TGO';
UPDATE countries SET iso_numeric = '772' WHERE countries_iso_code_3 = 'TKL';
UPDATE countries SET iso_numeric = '776' WHERE countries_iso_code_3 = 'TON';
UPDATE countries SET iso_numeric = '780' WHERE countries_iso_code_3 = 'TTO';
UPDATE countries SET iso_numeric = '788' WHERE countries_iso_code_3 = 'TUN';
UPDATE countries SET iso_numeric = '792' WHERE countries_iso_code_3 = 'TUR';
UPDATE countries SET iso_numeric = '795' WHERE countries_iso_code_3 = 'TKM';
UPDATE countries SET iso_numeric = '796' WHERE countries_iso_code_3 = 'TCA';
UPDATE countries SET iso_numeric = '798' WHERE countries_iso_code_3 = 'TUV';
UPDATE countries SET iso_numeric = '800' WHERE countries_iso_code_3 = 'UGA';
UPDATE countries SET iso_numeric = '804' WHERE countries_iso_code_3 = 'UKR';
UPDATE countries SET iso_numeric = '784' WHERE countries_iso_code_3 = 'ARE';
UPDATE countries SET iso_numeric = '826' WHERE countries_iso_code_3 = 'GBR';
UPDATE countries SET iso_numeric = '840' WHERE countries_iso_code_3 = 'USA';
UPDATE countries SET iso_numeric = '581' WHERE countries_iso_code_3 = 'UMI';
UPDATE countries SET iso_numeric = '858' WHERE countries_iso_code_3 = 'URY';
UPDATE countries SET iso_numeric = '860' WHERE countries_iso_code_3 = 'UZB';
UPDATE countries SET iso_numeric = '548' WHERE countries_iso_code_3 = 'VUT';
UPDATE countries SET iso_numeric = '862' WHERE countries_iso_code_3 = 'VEN';
UPDATE countries SET iso_numeric = '704' WHERE countries_iso_code_3 = 'VNM';
UPDATE countries SET iso_numeric = '850' WHERE countries_iso_code_3 = 'VIR';
UPDATE countries SET iso_numeric = '876' WHERE countries_iso_code_3 = 'WLF';
UPDATE countries SET iso_numeric = '732' WHERE countries_iso_code_3 = 'ESH';
UPDATE countries SET iso_numeric = '887' WHERE countries_iso_code_3 = 'YEM';
UPDATE countries SET iso_numeric = '891' WHERE countries_iso_code_3 = 'YUG';
UPDATE countries SET iso_numeric = '180' WHERE countries_iso_code_3 = 'ZAR';
UPDATE countries SET iso_numeric = '894' WHERE countries_iso_code_3 = 'ZMB';
UPDATE countries SET iso_numeric = '716' WHERE countries_iso_code_3 = 'ZWE';


-----------------  v8.0.0.0

-- Panels No Longer Used:
DELETE FROM kk_role_to_panel WHERE panel_id = (SELECT panel_id FROM kk_panel WHERE code = 'kk_panel_subZones');
DELETE FROM kk_panel WHERE code = 'kk_panel_subZones';
DELETE FROM kk_role_to_panel WHERE panel_id = (SELECT panel_id FROM kk_panel WHERE code = 'kk_panel_geoZones');
DELETE FROM kk_panel WHERE code = 'kk_panel_geoZones';

-- Make the panel name more obvious
UPDATE kk_panel SET description = 'Tax Areas / Geo Zones' WHERE code = 'kk_panel_taxAreas';

-- Fix API definitions
DELETE FROM kk_role_to_api_call WHERE api_call_id = (SELECT api_call_id FROM kk_api_call WHERE name = 'getOrderRefund');
DELETE FROM kk_api_call WHERE name = 'getOrderRefund';
DELETE FROM kk_role_to_api_call WHERE api_call_id = (SELECT api_call_id FROM kk_api_call WHERE name = 'importCustomer');
DELETE FROM kk_api_call WHERE name = 'importCustomer';
DELETE FROM kk_role_to_api_call WHERE api_call_id = (SELECT api_call_id FROM kk_api_call WHERE name = 'insertGroup');
DELETE FROM kk_api_call WHERE name = 'insertGroup';
DELETE FROM kk_role_to_api_call WHERE api_call_id = (SELECT api_call_id FROM kk_api_call WHERE name = 'insertGroups');
DELETE FROM kk_api_call WHERE name = 'insertGroups';
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'addPoints', '', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'cloneStore', '', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'custom', '', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'deleteBooking', '', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'deleteCatalog', '', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'deletePaymentSchedule', '', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'deleteSubscription', '', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'doesMallStoreExist', '', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'execute', '', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'getAddressFormats', '', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'getAllAddressFormats', '', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'getAllCountriesFull', '', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'getAllGeoZones', '', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'getAllLanguages', '', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'getAllManufacturers', '', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'getAllOrderStatuses', '', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'getAllProductOptions', '', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'getAllTaxClassesFull', '', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'getAllTaxRates', '', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'getBookings', '', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'getCatalogById', '', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'getCatalogs', '', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'getCategory', '', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'getCategoryTree', '', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'getCountries', '', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'getCouponCode', '', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'getCurrencies', '', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'getCurrency', '', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'getCustomValidatorSet', '', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'getDefaultCurrency', '', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'getDefaultLanguage', '', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'getEngConf', '', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'getFiles', '', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'getGeoZones', '', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'getHelpMsg', '', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'getKonakartAdminPropsFilePath', '', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'getLanguageByCode', '', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'getLanguages', '', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'getManufacturer', '', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'getMsgs', '', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'getOrderRefunds', '', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'getOrderStatusNames', '', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'getPaymentSchedule', '', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'getPaymentSchedules', '', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'getProdAttrDescsForTemplates', '', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'getProductAvailabilityWithOptions', '', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'getProductCountPerTemplate', '', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'getProductOptionValuesPerOption', '', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'getProductQuantityWithOptions', '', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'getProductWithOptions', '', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'getRelatedProductsWithOptions', '', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'getSearchRules', '', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'getStores', '', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'getSubZones', '', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'getSubscription', '', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'getSubscriptions', '', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'getTaxClasses', '', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'getTaxRates', '', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'getTopLevelCategories', '', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'getZones', '', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'getZonesById', '', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'insertBooking', '', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'insertCatalog', '', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'insertCustomerGroups', '', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'insertPaymentSchedule', '', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'insertSubscription', '', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'insertTagGroup', '', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'insertTagGroups', '', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'logMsg', '', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'login', '', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'logout', '', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'resetCustomerPasswordSpecifyingEmail', '', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'searchForProductsWithOptions', '', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'sendTemplateEmailToCustomers', '', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'sendTemplateEmailToCustomers1WithOptions', '', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'sendTemplateEmailToCustomersWithOptions', '', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'setConfigurationValue', '', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'setCreditCardDetailsOnOrder', '', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'setCustomerPassword', '', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'setEndpoint', '', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'setProductAvailabilityWithOptions', '', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'setProductQuantityWithOptions', '', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'testDB', '', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'updateBooking', '', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'updateCatalog', '', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'updatePaymentSchedule', '', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'updateSubscription', '', sysdate);

-- New Custom fields:
ALTER TABLE orders ADD custom6 varchar(16);
ALTER TABLE orders ADD custom7 varchar(16);
ALTER TABLE orders ADD custom8 varchar(16);
ALTER TABLE orders ADD custom9 varchar(16);
ALTER TABLE orders ADD custom10 varchar(16);

ALTER TABLE orders_products ADD custom6 varchar(16);
ALTER TABLE orders_products ADD custom7 varchar(16);
ALTER TABLE orders_products ADD custom8 varchar(16);
ALTER TABLE orders_products ADD custom9 varchar(16);
ALTER TABLE orders_products ADD custom10 varchar(16);

ALTER TABLE customers_basket ADD custom6 varchar(16);
ALTER TABLE customers_basket ADD custom7 varchar(16);
ALTER TABLE customers_basket ADD custom8 varchar(16);
ALTER TABLE customers_basket ADD custom9 varchar(16);
ALTER TABLE customers_basket ADD custom10 varchar(16);

-- New logo content type
INSERT INTO kk_content_type (id, content_type_id, date_added) VALUES (kk_content_type_seq.nextval, 13, sysdate);

INSERT INTO kk_content_type_desc (id, content_type_id, language_id, content_type_name, description, date_added) VALUES (kk_content_type_desc_seq.nextval, 13, 1, 'Logo', 'Logo Image', sysdate);
INSERT INTO kk_content_type_desc (id, content_type_id, language_id, content_type_name, description, date_added) VALUES (kk_content_type_desc_seq.nextval, 13, 2, 'Logo', 'Logo Image', sysdate);
INSERT INTO kk_content_type_desc (id, content_type_id, language_id, content_type_name, description, date_added) VALUES (kk_content_type_desc_seq.nextval, 13, 3, 'Logo', 'Imagen del logotipo', sysdate);
INSERT INTO kk_content_type_desc (id, content_type_id, language_id, content_type_name, description, date_added) VALUES (kk_content_type_desc_seq.nextval, 13, 4, 'Logotipo', 'Imagem do logotipo', sysdate);

-- Logo Image
INSERT INTO kk_content (id, content_id, content_type_id, click_url, object_id, obj_type_id, enabled, updated_by, date_updated, date_added) VALUES (kk_content_seq.nextval, 31, 13, 'Welcome.action', -1, -1, 1, 2, sysdate, sysdate);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (kk_content_desc_seq.nextval, 31, 1, 'logo.png', '', '', 'KonaKart Logo', sysdate);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (kk_content_desc_seq.nextval, 31, 2, 'logo.png', '', '', 'KonaKart Logo', sysdate);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (kk_content_desc_seq.nextval, 31, 3, 'logo.png', '', '', 'KonaKart Logo', sysdate);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (kk_content_desc_seq.nextval, 31, 4, 'logo.png', '', '', 'KonaKart Logo', sysdate);

-- Configuration variable to enable/disable Content Caching
DELETE FROM configuration WHERE configuration_key = 'CACHE_CONTENT';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api) VALUES (configuration_seq.nextval, 'Cache Content','CACHE_CONTENT','true','Set to true to Cache KonaKart Content in memory.','11', '28', 'choice(''true''=''true'',''false''=''false'')', sysdate, '1');

-- Config variable to define the location of the exported Mailing Lists
DELETE FROM configuration where configuration_key = 'MAILLISTS_BASE_DIRECTORY';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (configuration_seq.nextval, 'Exported Mailing List Directory', 'MAILLISTS_BASE_DIRECTORY', 'C:/KonaKart/mailLists', 'Defines the root directory where the Mailing Lists are exported to', '12', '9', sysdate);

-- New createMailingList API call
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'createMailingList','', sysdate);

-- New View Mailing Lists panel
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval, 'kk_panel_viewMailingLists','View Mailing Lists', sysdate);

-- Add View Mailing Lists Panel access to all roles that can access the 'kk_panel_storeConfiguration' panel
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, '1', '1', '1', sysdate, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_storeConfiguration' and p2.code='kk_panel_viewMailingLists';

-- New Create Mailing Lists panel
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval, 'kk_panel_createMailingLists','Create Mailing Lists', sysdate);

-- Add Create Mailing Lists Panel access to all roles that can access the 'kk_panel_storeConfiguration' panel
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, '1', '1', '1', sysdate, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_storeConfiguration' and p2.code='kk_panel_createMailingLists';

-- Email output location
DELETE FROM configuration WHERE configuration_key = 'EMAIL_OUTPUT_DIRECTORY';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, return_by_api) VALUES (configuration_seq.nextval, 'Email Output Directory', 'EMAIL_OUTPUT_DIRECTORY', 'C:/KonaKart/logs', 'The location where KonaKart will write email output files', '20', '2', sysdate, '1');

-- Add extra field to products table to ignore quantity defined in array of productQuantity objects
ALTER TABLE products ADD ignore_prod_qty_stock NUMBER(10,0) DEFAULT 0 NOT NULL;

-- Suggested search list for each catalog id
DELETE FROM configuration WHERE configuration_key = 'SOLR_ADD_TERM_FOR_CATALOG';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api) VALUES (configuration_seq.nextval, 'Add suggested search for catalog','SOLR_ADD_TERM_FOR_CATALOG','false','Adds a suggested search list for each catalog id since the catalog may contain only a subset of products','24', '30', 'choice(''true''=''true'',''false''=''false'')', sysdate, '1');

DELETE FROM configuration WHERE configuration_key = 'SOLR_ADD_SPELLING_FOR_CATALOG';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api) VALUES (configuration_seq.nextval, 'Add spelling suggestions for catalog','SOLR_ADD_SPELLING_FOR_CATALOG','false','Adds spelling suggestions for each catalog id since the catalog may contain only a subset of products','24', '32', 'choice(''true''=''true'',''false''=''false'')', sysdate, '1');

DELETE FROM configuration WHERE configuration_key = 'SOLR_CATALOG_USED_FOR_PRICE';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api) VALUES (configuration_seq.nextval, 'Catalogs used for product prices','SOLR_CATALOG_USED_FOR_PRICE','false','Set to true if catalogs are used to determine product prices','24', '34', 'choice(''true''=''true'',''false''=''false'')', sysdate, '0');

DELETE FROM configuration WHERE configuration_key = 'SOLR_CATALOG_USED_FOR_QTY';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api) VALUES (configuration_seq.nextval, 'Catalogs used for product quantities','SOLR_CATALOG_USED_FOR_QTY','false','Set to true if catalogs are used to determine product quantities','24', '36', 'choice(''true''=''true'',''false''=''false'')', sysdate, '0');

-- Email Verified flag for Customers
ALTER TABLE customers ADD email_verified NUMBER(10,0) DEFAULT 0 NOT NULL;

-- Catalog to Category table
BEGIN EXECUTE IMMEDIATE 'DROP TABLE kk_catalog_to_category'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE kk_catalog_to_category (
  catalog_key VARCHAR2(32) NOT NULL,
  categories_id NUMBER(10,0) NOT NULL,
  price_adjustment NUMBER(15,4),
  fixed_price NUMBER(15,4),
  exclude NUMBER(10,0) DEFAULT 0,
  store_id VARCHAR2(64),
  PRIMARY KEY(catalog_key,categories_id)
);

-- Record time catalog is created
ALTER TABLE kk_catalog ADD last_creation_date TIMESTAMP;

-- New Admin App Panel for generating catalog prices
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval, 'kk_panel_catalog_prices','Catalog Price Generation', sysdate);

-- Add Catalog Prices Panel access to all roles that can access the 'kk_panel_catalogs' panel
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, sysdate, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_catalogs' and p2.code='kk_panel_catalog_prices';

INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'addCatalogRules', '', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'createCatalogPricesFromRules', '', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'getCatalogRules', '', sysdate);

-- Custom Filters for Orders
ALTER TABLE orders ADD filter1 VARCHAR(32);
ALTER TABLE orders ADD filter2 VARCHAR(32);
ALTER TABLE orders ADD filterDecimal1 NUMBER(15,4);

-- Table for Custom Filters
BEGIN EXECUTE IMMEDIATE 'DROP TABLE kk_filter'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE kk_filter (
  id NUMBER(10,0) NOT NULL,
  user_id NUMBER(10,0) NOT NULL,
  filter_table VARCHAR2(64),
  filter_column VARCHAR2(64),
  filter_constraint VARCHAR2(256),
  custom1 VARCHAR2(32),
  custom2 VARCHAR2(32),
  date_added TIMESTAMP,
  date_updated TIMESTAMP,
  store_id VARCHAR2(64),
  PRIMARY KEY(id)
);
BEGIN EXECUTE IMMEDIATE 'DROP SEQUENCE kk_filter_SEQ'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE SEQUENCE kk_filter_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

CREATE INDEX i_user_id_kk_filter ON kk_filter (user_id);

-- New Admin App Panel for maintaining the filters
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval, 'kk_panel_filters','Filters', sysdate);

-- Add Filter Panel access to all roles that can access the 'kk_panel_storeConfiguration' panel
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, sysdate, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_storeConfiguration' and p2.code='kk_panel_filters';

-- New Filter APIs
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'getFilters', '', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'getFiltersForCustomer', '', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'getFilter', '', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'insertFilter', '', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'updateFilter', '', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'deleteFilter', '', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'deleteFiltersForCustomer', '', sysdate);

-- As an exmaple of using Filters we set up an Admin User who can just see Orders in a certain state (for following up incomplete orders)
-- Default order follow-up user = "order.followup@konakart.com" password = "princess"
DELETE FROM customers WHERE customers_email_address = 'order.followup@konakart.com' and customers_telephone='019084';
DELETE FROM address_book WHERE entry_street_address='4 Way Street' and entry_postcode='PostCode4';
INSERT INTO address_book (address_book_id, customers_id, entry_gender, entry_company, entry_firstname, entry_lastname, entry_street_address, entry_suburb, entry_postcode, entry_city, entry_state, entry_country_id, entry_zone_id) VALUES (address_book_seq.nextval,-1, 'm', 'KonaKart Ltd.', 'Order', 'Followup', '4 Way Street', '', 'PostCode4', 'NeverNever', '', 223, 12);
INSERT INTO customers (customers_id, customers_gender, customers_firstname, customers_lastname,customers_dob, customers_email_address, customers_default_address_id, customers_telephone, customers_fax, customers_password, customers_newsletter, customers_type) VALUES (customers_seq.nextval, 'm', 'Order', 'Followup', to_date('1977/01/01', 'yyyy/mm/dd'), 'order.followup@konakart.com', -1, '019084', '', 'f5147fc3f6eb46e234c01db939bdb581:08', '0', 1);
INSERT INTO customers_info SELECT customers_id , sysdate, 0, sysdate, sysdate, 0, 'store1' FROM customers WHERE customers_email_address = 'order.followup@konakart.com' AND customers_telephone='019084';
UPDATE address_book SET customers_id = (SELECT customers_id FROM customers WHERE customers_email_address = 'order.followup@konakart.com' AND customers_telephone='019084') WHERE customers_id=-1;
UPDATE customers SET customers_default_address_id = (SELECT address_book_id FROM address_book WHERE entry_street_address='4 Way Street' AND entry_postcode='PostCode4') WHERE customers_default_address_id=-1;

-- Grant the new follow-up order user the Order Maintenance role
INSERT INTO kk_customers_to_role (ctor_id, role_id, customers_id, date_added) SELECT kk_customers_to_role_seq.nextval, 3, customers_id, sysdate FROM customers WHERE customers_email_address = 'order.followup@konakart.com' AND customers_telephone='019084';
INSERT INTO kk_customers_to_role (ctor_id, role_id, customers_id, date_added) SELECT kk_customers_to_role_seq.nextval, 4, customers_id, sysdate FROM customers WHERE customers_email_address = 'order.followup@konakart.com' AND customers_telephone='019084';

-- Set a filter for the follow-up order user to view only orders in these states: "Processing" (id 2) or "Waiting For Payment" (id 4)
INSERT INTO kk_filter (id, user_id, filter_table, filter_column, filter_constraint, date_added, date_updated) SELECT kk_filter_seq.nextval, customers_id, 'orders', 'orders_status', 'in (2,4)', sysdate, sysdate FROM customers WHERE customers_email_address = 'order.followup@konakart.com' AND customers_telephone='019084';

-- New API call for deleting promotions
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'deletePromotionWithOptions', '', sysdate);

-- Set up Custom Panels F as an example
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, sysdate, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_products' and p2.code='kk_panel_customF';

-- Update Paths for new default home directory
UPDATE configuration SET configuration_value = 'C:/KonaKart/webapps/birtviewer/reports/stores/store1/' WHERE configuration_key = 'REPORTS_DEFN_PATH';
UPDATE configuration SET configuration_value = 'C:/KonaKart/webapps/konakart/images' WHERE configuration_key = 'IMG_BASE_PATH';
UPDATE configuration SET configuration_value = 'C:/KonaKart/conf/konakart_mail.properties' WHERE configuration_key = 'KONAKART_MAIL_PROPERTIES_FILE';
UPDATE configuration SET configuration_value = 'C:/KonaKart/logs' WHERE configuration_key = 'KONAKART_LOG_FILE_DIRECTORY';
UPDATE configuration SET configuration_value = 'C:/KonaKart/database/Oracle/konakart_new_store.sql' WHERE configuration_key = 'KK_NEW_STORE_SQL_FILENAME';
UPDATE configuration SET configuration_value = 'C:/KonaKart/database/Oracle/konakart_user_new_store.sql' WHERE configuration_key = 'USER_NEW_STORE_SQL_FILENAME';
UPDATE configuration SET configuration_value = 'C:/KonaKart/' WHERE configuration_key = 'INSTALLATION_HOME';
UPDATE configuration SET configuration_value = 'C:/KonaKart/pdf/' WHERE configuration_key = 'PDF_BASE_DIRECTORY';
UPDATE configuration SET configuration_value = 'C:/KonaKart/templates/' WHERE configuration_key = 'TEMPLATE_BASE_DIRECTORY';
UPDATE configuration SET configuration_value = 'C:/KonaKart/orders' WHERE configuration_key = 'EXPORT_ORDERS_BASE_DIRECTORY';
UPDATE configuration SET configuration_value = 'C:/KonaKart/batchlogs/' WHERE configuration_key = 'BATCH_LOG_FILE_DIRECTORY';
UPDATE configuration SET configuration_value = 'C:/KonaKart/batchlogs/' WHERE configuration_key = 'SITEMAP_FILE_DIRECTORY';
UPDATE configuration SET configuration_value = 'C:/KonaKart/importerlogs/' WHERE configuration_key = 'IMPORTER_LOG_FILE_DIRECTORY';
UPDATE configuration SET configuration_value = 'C:/KonaKart/data/' WHERE configuration_key = 'IMPORT_FILES_PATH';


-----------------  v8.1.0.0

-- Add codes to product options and product option values for image names
ALTER TABLE products_options ADD code varchar(32);
ALTER TABLE products_options_values ADD code varchar(32);

-- Add some color product option values
INSERT INTO products_options_values (products_options_values_id, language_id, products_options_values_name, code) VALUES (13,1,'Red','RED');
INSERT INTO products_options_values (products_options_values_id, language_id, products_options_values_name, code) VALUES (13,2,'Rote','RED');
INSERT INTO products_options_values (products_options_values_id, language_id, products_options_values_name, code) VALUES (13,3,'Rojo','RED');
INSERT INTO products_options_values (products_options_values_id, language_id, products_options_values_name, code) VALUES (13,4,'Vermelho','RED');
INSERT INTO products_options_values (products_options_values_id, language_id, products_options_values_name, code) VALUES (14,1,'Orange','ORAN');
INSERT INTO products_options_values (products_options_values_id, language_id, products_options_values_name, code) VALUES (14,2,'Orange','ORAN');
INSERT INTO products_options_values (products_options_values_id, language_id, products_options_values_name, code) VALUES (14,3,'Naranja','ORAN');
INSERT INTO products_options_values (products_options_values_id, language_id, products_options_values_name, code) VALUES (14,4,'laranja','ORAN');
INSERT INTO products_options_values (products_options_values_id, language_id, products_options_values_name, code) VALUES (15,1,'Yellow','YEL');
INSERT INTO products_options_values (products_options_values_id, language_id, products_options_values_name, code) VALUES (15,2,'Gelb','YEL');
INSERT INTO products_options_values (products_options_values_id, language_id, products_options_values_name, code) VALUES (15,3,'Amarillo','YEL');
INSERT INTO products_options_values (products_options_values_id, language_id, products_options_values_name, code) VALUES (15,4,'Amarelo','YEL');

INSERT INTO prod_opt_vals_to_prod_opt (prod_opt_vals_to_prod_opt_id, products_options_id, products_options_values_id) VALUES (prod_opt_vals_to_prod_opt_seq.nextval, 1, 13);
INSERT INTO prod_opt_vals_to_prod_opt (prod_opt_vals_to_prod_opt_id, products_options_id, products_options_values_id) VALUES (prod_opt_vals_to_prod_opt_seq.nextval, 1, 14);
INSERT INTO prod_opt_vals_to_prod_opt (prod_opt_vals_to_prod_opt_id, products_options_id, products_options_values_id) VALUES (prod_opt_vals_to_prod_opt_seq.nextval, 1, 15);

UPDATE products_options SET code = 'COL' WHERE products_options_id = '1';

-- Add color attributes to Brabantia Bin product
INSERT INTO products_attributes (products_attributes_id, products_id, options_id, options_values_id, options_values_price, price_prefix, sort_order) VALUES (products_attributes_seq.nextval,44,1,13,0.00,'+',1);
INSERT INTO products_attributes (products_attributes_id, products_id, options_id, options_values_id, options_values_price, price_prefix, sort_order) VALUES (products_attributes_seq.nextval,44,1,14,0.00,'+',0);
INSERT INTO products_attributes (products_attributes_id, products_id, options_id, options_values_id, options_values_price, price_prefix, sort_order) VALUES (products_attributes_seq.nextval,44,1,15,0.00,'+',2);

-- Add role for custom panel G
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, sysdate, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_customers' and p2.code='kk_panel_customG';

-- lock table
BEGIN EXECUTE IMMEDIATE 'DROP TABLE kk_lock'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE kk_lock (
  lock_name VARCHAR2(32) NOT NULL,
  lock_timestamp TIMESTAMP NOT NULL,
  PRIMARY KEY(lock_name)
);

-- Update Country data

INSERT INTO countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id, iso_numeric) VALUES (countries_seq.nextval,'Åland Islands','AX','ALA',1, '248');
INSERT INTO countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id, iso_numeric) VALUES (countries_seq.nextval,'Guernsey','GG','GGY',1, '831');
INSERT INTO countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id, iso_numeric) VALUES (countries_seq.nextval,'Montenegro','ME','MNE',1, '499');
INSERT INTO countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id, iso_numeric) VALUES (countries_seq.nextval,'Palestine','PS','PSE',1, '275');
INSERT INTO countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id, iso_numeric) VALUES (countries_seq.nextval,'Saint Barthélemy','BL','BLM',1, '652');
INSERT INTO countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id, iso_numeric) VALUES (countries_seq.nextval,'Saint Helena, Ascension and Tristan da Cunha','SH','SHN',1, '654');
INSERT INTO countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id, iso_numeric) VALUES (countries_seq.nextval,'Saint Martin (French part)','MF','MAF',1, '663');
INSERT INTO countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id, iso_numeric) VALUES (countries_seq.nextval,'Saint Pierre and Miquelon','PM','SPM',1, '666');
INSERT INTO countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id, iso_numeric) VALUES (countries_seq.nextval,'Sint Maarten (Dutch part)','SX','SXM',1, '534');
INSERT INTO countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id, iso_numeric) VALUES (countries_seq.nextval,'South Sudan','SS','SSD',1, '728');
INSERT INTO countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id, iso_numeric) VALUES (countries_seq.nextval,'Timor-Leste','TL','TLS',1, '626');

DELETE FROM countries WHERE countries_name = 'East Timor';
DELETE FROM countries WHERE countries_name = 'Netherlands Antilles';
DELETE FROM countries WHERE countries_name = 'St. Helena';
DELETE FROM countries WHERE countries_name = 'St. Pierre and Miquelon';
DELETE FROM countries WHERE countries_name = 'Yugoslavia';

UPDATE countries set msgCatKey = CONCAT('CTRY.',countries_iso_code_3);

-- Reserved stock table
BEGIN EXECUTE IMMEDIATE 'DROP TABLE kk_reserved_stock'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE kk_reserved_stock (
  kk_reserved_stock_id NUMBER(10,0) NOT NULL,
  store_id VARCHAR2(64),
  customers_id NUMBER(10,0) DEFAULT 0 NOT NULL,
  catalog_id VARCHAR2(32),
  products_id NUMBER(10,0) NOT NULL,
  products_options VARCHAR2(128) NOT NULL,
  quantity NUMBER(10,0) DEFAULT 0 NOT NULL,
  reserve_start_time TIMESTAMP NOT NULL,
  reserve_end_time TIMESTAMP NOT NULL,
  PRIMARY KEY(kk_reserved_stock_id)
);
BEGIN EXECUTE IMMEDIATE 'DROP SEQUENCE kk_reserved_stock_SEQ'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE SEQUENCE kk_reserved_stock_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

-- Stock reservation attributes for basket and order product
ALTER TABLE customers_basket ADD reservation_id int DEFAULT '-1' NOT NULL;
ALTER TABLE orders_products ADD reservation_id int DEFAULT '-1' NOT NULL;
ALTER TABLE orders_products ADD qty_reserved_for_id int DEFAULT 0 NOT NULL;

-- Enables / Disables stock reservation
DELETE FROM configuration WHERE configuration_key = 'STOCK_RESERVATION_ENABLE';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api) VALUES (configuration_seq.nextval, 'Enable stock reservation','STOCK_RESERVATION_ENABLE','false','Set to true if you want to reserve stock during checkout','9', '40', 'choice(''true''=''true'',''false''=''false'')', sysdate, '1');

-- Defines global stock reservation time
DELETE FROM configuration WHERE configuration_key = 'STOCK_RESERVATION_TIME_SECS';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api) VALUES (configuration_seq.nextval, 'Stock Reservation time in secs','STOCK_RESERVATION_TIME_SECS','0','Number of seconds stock will be reserved for','9', '45', 'integer(0,null)', sysdate, '1');

-- Add custom privileges for the Products panel - default to allow access to Remove From Cat button
UPDATE kk_role_to_panel SET custom3=0, custom3_desc='If set remove from cat button not shown' WHERE panel_id IN (SELECT panel_id FROM kk_panel where code='kk_panel_products');

-- New API call
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'addRelatedProductsWithOptions', '', sysdate);

-- Modify config variable text
UPDATE configuration SET configuration_title = 'Show Stock Levels', configuration_description='Displays the product stock levels in the storefront application. Set to false if products are virtual.' WHERE configuration_key = 'STOCK_CHECK';
UPDATE configuration SET configuration_title = 'Do Not Automatically Disable Product', configuration_description='If false, a product is automatically disabled when it goes out of stock.' WHERE configuration_key = 'STOCK_ALLOW_CHECKOUT';
UPDATE configuration SET sort_order = '3' WHERE configuration_key = 'STOCK_ENABLE_PRODUCT';

-- Used in storefront to allow checkout when stock isn't available
DELETE FROM configuration WHERE configuration_key = 'STORE_FRONT_STOCK_ALLOW_CHECKOUT';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api) VALUES (configuration_seq.nextval, 'Allow Checkout When Stock Not Available','STORE_FRONT_STOCK_ALLOW_CHECKOUT','true','When true, the storefront allows checkout even when stock is not available','9', '2', 'choice(''true''=''true'',''false''=''false'')', sysdate, '1');

-- New Order Total Custom fields:
ALTER TABLE orders_total ADD custom4 varchar(128);
ALTER TABLE orders_total ADD custom5 varchar(128);

-- Change currency value to decimal
-- For Oracle Only - Convert value column to NUMBER
ALTER TABLE currencies ADD tempcol NUMBER(15,6);
UPDATE currencies SET tempcol = value;
ALTER TABLE currencies DROP COLUMN value;
ALTER TABLE currencies RENAME COLUMN tempcol to value;


-----------------  v8.3.0.0

-- Add parent id to customers
ALTER TABLE customers ADD parent_id int DEFAULT '0' NOT NULL;

-- New API calls
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'addChildrenToCustomer', '', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'getCustomerForEmailWithOptions', '', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'getCustomerForIdWithOptions', '', sysdate);

--B2B Customer tag examples
DELETE FROM kk_customer_tag WHERE name ='B2B_CAN_CHANGE_ADDRESS';
INSERT INTO kk_customer_tag (kk_customer_tag_id, name, description, validation, tag_type, max_ints, date_added) VALUES (kk_customer_tag_seq.nextval,'B2B_CAN_CHANGE_ADDRESS', 'Customer can modify / add the destination addresses of an order', 'true|false', 5, 1, sysdate);
DELETE FROM kk_customer_tag WHERE name ='B2B_CAN_APPROVE_ORDERS';
INSERT INTO kk_customer_tag (kk_customer_tag_id, name, description, validation, tag_type, max_ints, date_added) VALUES (kk_customer_tag_seq.nextval,'B2B_CAN_APPROVE_ORDERS', 'Customer can approve orders of child customers', 'true|false', 5, 1, sysdate);
DELETE FROM kk_customer_tag WHERE name ='B2B_VIEW_PARENT_ORDERS';
INSERT INTO kk_customer_tag (kk_customer_tag_id, name, description, validation, tag_type, max_ints, date_added) VALUES (kk_customer_tag_seq.nextval,'B2B_VIEW_PARENT_ORDERS', 'Customer can view orders of parent customer', 'true|false', 5, 1, sysdate);
DELETE FROM kk_customer_tag WHERE name ='B2B_VIEW_CHILD_ORDERS';
INSERT INTO kk_customer_tag (kk_customer_tag_id, name, description, validation, tag_type, max_ints, date_added) VALUES (kk_customer_tag_seq.nextval,'B2B_VIEW_CHILD_ORDERS', 'Customer can view orders of child customers', 'true|false', 5, 1, sysdate);
DELETE FROM kk_customer_tag WHERE name ='B2B_VIEW_SIBLING_ORDERS';
INSERT INTO kk_customer_tag (kk_customer_tag_id, name, description, validation, tag_type, max_ints, date_added) VALUES (kk_customer_tag_seq.nextval,'B2B_VIEW_SIBLING_ORDERS', 'Customer can view orders of sibling customers', 'true|false', 5, 1, sysdate);
DELETE FROM kk_customer_tag WHERE name ='B2B_ORDERS_NEED_APPROVAL';
INSERT INTO kk_customer_tag (kk_customer_tag_id, name, description, validation, tag_type, max_ints, date_added) VALUES (kk_customer_tag_seq.nextval,'B2B_ORDERS_NEED_APPROVAL', 'Order needs to be approved by a parent customer', 'true|false', 5, 1, sysdate);
DELETE FROM kk_customer_tag WHERE name ='B2B_ORDER_LIMIT';
INSERT INTO kk_customer_tag (kk_customer_tag_id, name, description, validation, tag_type, max_ints, date_added) VALUES (kk_customer_tag_seq.nextval,'B2B_ORDER_LIMIT', 'Maximum order value that can be submitted by this customer', '', 3, 1, sysdate);
DELETE FROM kk_customer_tag WHERE name ='B2B_CATALOG_KEY';
INSERT INTO kk_customer_tag (kk_customer_tag_id, name, description, validation, tag_type, max_ints, date_added) VALUES (kk_customer_tag_seq.nextval,'B2B_CATALOG_KEY', 'Catalog Key used for this customer', '', 0, 1, sysdate);

-- New Order Total fields
ALTER TABLE orders_total ADD promotion_id int DEFAULT '0' NOT NULL;
ALTER TABLE orders_total ADD discount_amount decimal(15,4);
ALTER TABLE orders_total ADD discount_percent decimal(15,4);

-- New order state - Waiting for Approval
INSERT INTO orders_status (orders_status_pk, orders_status_id, language_id, orders_status_name) VALUES (orders_status_seq.nextval,11,(SELECT languages_id FROM languages WHERE code = 'en'),'Waiting for Approval');
INSERT INTO orders_status (orders_status_pk, orders_status_id, language_id, orders_status_name) VALUES (orders_status_seq.nextval,11,(SELECT languages_id FROM languages WHERE code = 'de'),'Warten auf die Bestätigung');
INSERT INTO orders_status (orders_status_pk, orders_status_id, language_id, orders_status_name) VALUES (orders_status_seq.nextval,11,(SELECT languages_id FROM languages WHERE code = 'es'),'A la espera de la aprobación');
INSERT INTO orders_status (orders_status_pk, orders_status_id, language_id, orders_status_name) VALUES (orders_status_seq.nextval,11,(SELECT languages_id FROM languages WHERE code = 'pt'),'Esperando aprovação');

-- New order state - Approved
INSERT INTO orders_status (orders_status_pk, orders_status_id, language_id, orders_status_name) VALUES (orders_status_seq.nextval,12,(SELECT languages_id FROM languages WHERE code = 'en'),'Approved');
INSERT INTO orders_status (orders_status_pk, orders_status_id, language_id, orders_status_name) VALUES (orders_status_seq.nextval,12,(SELECT languages_id FROM languages WHERE code = 'de'),'Genehmigt');
INSERT INTO orders_status (orders_status_pk, orders_status_id, language_id, orders_status_name) VALUES (orders_status_seq.nextval,12,(SELECT languages_id FROM languages WHERE code = 'es'),'Aprobado');
INSERT INTO orders_status (orders_status_pk, orders_status_id, language_id, orders_status_name) VALUES (orders_status_seq.nextval,12,(SELECT languages_id FROM languages WHERE code = 'pt'),'Aprovado');

-- New order state - Approval Declined
INSERT INTO orders_status (orders_status_pk, orders_status_id, language_id, orders_status_name) VALUES (orders_status_seq.nextval,13,(SELECT languages_id FROM languages WHERE code = 'en'),'Approval Declined');
INSERT INTO orders_status (orders_status_pk, orders_status_id, language_id, orders_status_name) VALUES (orders_status_seq.nextval,13,(SELECT languages_id FROM languages WHERE code = 'de'),'Approval Abgelehnt');
INSERT INTO orders_status (orders_status_pk, orders_status_id, language_id, orders_status_name) VALUES (orders_status_seq.nextval,13,(SELECT languages_id FROM languages WHERE code = 'es'),'Se rechaza la aprobación');
INSERT INTO orders_status (orders_status_pk, orders_status_id, language_id, orders_status_name) VALUES (orders_status_seq.nextval,13,(SELECT languages_id FROM languages WHERE code = 'pt'),'Aprovação Recusado');

-- Name Format
ALTER TABLE address_format ADD name_format varchar(255);
UPDATE address_format SET name_format = '$firstname $lastname';

-- For Setting the default customer name format template
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, return_by_api) VALUES (configuration_seq.nextval, 'Name format template', 'NAME_FORMAT_TEMPLATE', '$firstname $lastname', 'The default template used for formatting a customer name', '5', '20', sysdate, '1');

------------------------------------------------------------------
-- ERP XML Interface

INSERT INTO configuration_group VALUES (configuration_group_seq.nextval, 'User Defined', 'User Defined Configuration', 31, 1, null);
INSERT INTO configuration_group VALUES (configuration_group_seq.nextval, 'ERP Integration', 'ERP Integration Configuration', 32, 1, null);

-- Configuration variable for log directories
DELETE FROM configuration where configuration_key = 'ERP_INT_LOG_BASE_PATH_OK';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order,  date_added, return_by_api, store_id) SELECT configuration_seq.nextval, 'Msg Log Directory Good', 'ERP_INT_LOG_BASE_PATH_OK', CONCAT(configuration_value, '/mq_logs/success'), 'Defines the directory where the log file is written for messages that are processed correctly', '32', '12', sysdate, '1', store_id FROM configuration WHERE configuration_key = 'INSTALLATION_HOME';

DELETE FROM configuration where configuration_key = 'ERP_INT_INTEGRATION_ENABLED';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api, store_id) SELECT configuration_seq.nextval, 'ERP Integration Enabled?', 'ERP_INT_INTEGRATION_ENABLED', CONCAT(configuration_value, 'false'), 'Set to true to enable ERP Integration', '32', '5', 'choice(''true''=''true'',''false''=''false'')', sysdate, '1', store_id FROM configuration WHERE configuration_key = 'INSTALLATION_HOME';

DELETE FROM configuration where configuration_key = 'ERP_INT_LOG_BASE_PATH_KO';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order,  date_added, return_by_api, store_id) SELECT configuration_seq.nextval, 'Msg Log Directory Failed', 'ERP_INT_LOG_BASE_PATH_KO', CONCAT(configuration_value, '/mq_logs/failure'), 'Defines the directory where the log file is written for messages that cannot be processed', '32', '20', sysdate, '1', store_id FROM configuration WHERE configuration_key = 'INSTALLATION_HOME';

-- Configuration variables for sending log if a message fails
DELETE FROM configuration where configuration_key = 'ERP_INT_LOG_KO_EMAIL_ADDR';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order,  date_added, return_by_api) VALUES (configuration_seq.nextval, 'Email Address for Failed messages', 'ERP_INT_LOG_KO_EMAIL_ADDR', 'admin@konakart.com', 'Defines the email address where logs are sent when a message fails', '32', '30', sysdate, '1');

DELETE FROM configuration where configuration_key = 'ERP_INT_LOG_KO_EMAIL_TEMPLATE';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order,  date_added, return_by_api) VALUES (configuration_seq.nextval, 'Template for failed msg email', 'ERP_INT_LOG_KO_EMAIL_TEMPLATE', 'ERPIntegrationErrorNotification_en.vm', 'The velocity email template for failed messages. Template name includes country code.', '32', '31', sysdate, '1');

-- Configuration variable for ERP Invoice directory
DELETE FROM configuration where configuration_key = 'ERP_INT_INVOICE_PATH';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order,  date_added, return_by_api) VALUES (configuration_seq.nextval, 'ERP Invoice Path', 'ERP_INT_INVOICE_PATH', '', 'Defines the directory where the ERP invoices can be found. Ignored if the path is included in the message', '32', '40', sysdate, '1');

-- Configuration variable for ERP Invoice Email Velocity template
DELETE FROM configuration where configuration_key = 'ERP_INT_INVOICE_EMAIL_TEMPLATE';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order,  date_added, return_by_api) VALUES (configuration_seq.nextval, 'ERP Invoice template', 'ERP_INT_INVOICE_EMAIL_TEMPLATE', 'ERPIntegrationOrderInvoice_en.vm', 'Defines the velocity template for the email sent to the customer. Ignored if the template is included in the message. Country code is determined from the locale of the order if left out.', '32', '50', sysdate, '1');

-- New Admin App Panel for ERP Integration Configuration
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval, 'kk_panel_erpConfig','ERP Integration Configuration', sysdate);

-- Add ERP Integration Config Panel access to all roles that can access the 'kk_panel_storeConfiguration' panel
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, sysdate, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_storeConfiguration' and p2.code='kk_panel_erpConfig';

-- Password expiry
ALTER TABLE customers ADD password_change NUMBER(10,0) DEFAULT '0' NOT NULL;
ALTER TABLE customers ADD password_expiry TIMESTAMP;

-- Define how long a new temporary password is valid when sent out to customer who has forgotten his password
DELETE FROM configuration where configuration_key = 'TEMP_PASSWORD_VALID_TIME_MINS';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (configuration_seq.nextval, 'Valid time (mins) for temp password', 'TEMP_PASSWORD_VALID_TIME_MINS', '30', 'Defines the number of minutes a temporary password sent out in an email is valid for', '18', '20', 'integer(null,null)', sysdate);

-- Add attributes to promotions
ALTER TABLE promotion ADD total_max_use int DEFAULT '-1' NOT NULL;
ALTER TABLE promotion ADD times_used int DEFAULT 0 NOT NULL;

-- Defines order states to include for displaying customer orders
DELETE FROM configuration WHERE configuration_key = 'ORDER_DISPLAY_STATUS_IDS';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, return_by_api) VALUES (configuration_seq.nextval, 'Status Ids of orders to display','ORDER_DISPLAY_STATUS_IDS','','Comma separated list of order status ids that will be displayed to customers. All orders displayed if empty.','9', '50', sysdate, '1');

-- Add some new indexes for improved read performance
CREATE INDEX i_products_id_specials ON specials (products_id);
CREATE INDEX i_co_configuration ON configuration (configuration_key);
CREATE INDEX i_cu_kk_customers_to_tag ON kk_customers_to_tag (customers_id);

-- New order attributes
ALTER TABLE orders ADD admin_discount decimal(15,4);
ALTER TABLE orders ADD archive_id VARCHAR(128);

-- New order state - Archived
INSERT INTO orders_status (orders_status_pk, orders_status_id, language_id, orders_status_name) VALUES (orders_status_seq.nextval,14,(SELECT languages_id FROM languages WHERE code = 'en'),'Archived');
INSERT INTO orders_status (orders_status_pk, orders_status_id, language_id, orders_status_name) VALUES (orders_status_seq.nextval,14,(SELECT languages_id FROM languages WHERE code = 'de'),'Archivierte');
INSERT INTO orders_status (orders_status_pk, orders_status_id, language_id, orders_status_name) VALUES (orders_status_seq.nextval,14,(SELECT languages_id FROM languages WHERE code = 'es'),'Archivado');
INSERT INTO orders_status (orders_status_pk, orders_status_id, language_id, orders_status_name) VALUES (orders_status_seq.nextval,14,(SELECT languages_id FROM languages WHERE code = 'pt'),'Arquivado');

-- Defines order states to exclude for displaying customer orders
DELETE FROM configuration WHERE configuration_key = 'ORDER_DISPLAY_EXCLUDE_STATUS_IDS';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, return_by_api) VALUES (configuration_seq.nextval, 'Status Ids of orders to not display','ORDER_DISPLAY_EXCLUDE_STATUS_IDS','14','Comma separated list of order status ids that will not be displayed to customers. All orders displayed if empty.','9', '55', sysdate, '1');

-- Used in storefront to allow an administrator to edit an order
DELETE FROM configuration WHERE configuration_key = 'ALLOW_EDIT_ORDER';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api) VALUES (configuration_seq.nextval, 'Allow admin to edit customer order','ALLOW_EDIT_ORDER','false','When true, an administrator logging in as a customer can edit a customer order','1', '45', 'choice(''true''=''true'',''false''=''false'')', sysdate, '1');

-- Used in storefront to allow an administrator to introduce a discount
DELETE FROM configuration WHERE configuration_key = 'ALLOW_ADMIN_ORDER_DISCOUNT';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api) VALUES (configuration_seq.nextval, 'Allow admin to discount customer order','ALLOW_ADMIN_ORDER_DISCOUNT','false','When true, an administrator logging in as a customer can add a discount to a customer order','1', '50', 'choice(''true''=''true'',''false''=''false'')', sysdate, '1');

-- Allow NULLs in tag_value
ALTER TABLE kk_expression_variable MODIFY tag_value VARCHAR(255) NULL;



-----------------  v8.5.0.0

-- Set database version information
INSERT INTO kk_config (kk_config_id, kk_config_key, kk_config_value, date_added) VALUES (kk_config_seq.nextval, 'HISTORY', '8.5.0.0 I', sysdate);
INSERT INTO kk_config (kk_config_id, kk_config_key, kk_config_value, date_added) VALUES (kk_config_seq.nextval, 'VERSION', '8.5.0.0 Oracle', sysdate);

-- Used in storefront to decide whether to update the product viewed count every time a product is viewed
DELETE FROM configuration WHERE configuration_key = 'UPDATE_PRODUCT_VIEWED_COUNT';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api) VALUES (configuration_seq.nextval, 'Update product viewed count','UPDATE_PRODUCT_VIEWED_COUNT','false','When true, the product viewed count is incremented every time a product is viewed',1, 55, 'choice(''true''=''true'',''false''=''false'')', sysdate, '1');

-- Add reservation_id to kk_reserved_stock
ALTER TABLE kk_reserved_stock ADD reservation_id int DEFAULT 0 NOT NULL;
CREATE INDEX i_re_kk_reserved_stock ON kk_reserved_stock (reservation_id);

-- For specifying whether or not customer tags can be set using KKEngIf API calls
ALTER TABLE kk_customer_tag ADD set_by_api NUMBER(10,0) DEFAULT 0 NOT NULL;
-- Do not allow the B2B_ tags to be set
UPDATE kk_customer_tag set set_by_api = 1 WHERE NOT name LIKE 'B2B_%';

-- Addition of custom fields
ALTER TABLE products_quantity ADD custom1 varchar(128);
ALTER TABLE products_quantity ADD custom2 varchar(128);

-- New API call
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'deleteProdAttrDescWithOptions', '', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'deleteProducts', '', sysdate);

--Promotion tester customer tag
DELETE FROM kk_customer_tag WHERE name ='PROMOTION_TESTER';
INSERT INTO kk_customer_tag (kk_customer_tag_id, name, description, validation, tag_type, max_ints, date_added) VALUES (kk_customer_tag_seq.nextval,'PROMOTION_TESTER', 'Promotion Tester', 'true|false', 5, 1, sysdate);

--Promotion tester expression
DELETE FROM kk_expression WHERE name ='PromotionTester';
INSERT INTO kk_expression (kk_expression_id, name, description, num_variables, date_added) VALUES (kk_expression_seq.nextval,'PromotionTester', 'Determines whether user is a promotion tester',1,sysdate);

-- Promotion tester expression variable
DELETE FROM kk_expression_variable WHERE kk_customer_tag_id = (select kk_customer_tag_id from kk_customer_tag where name ='PROMOTION_TESTER');
INSERT INTO kk_expression_variable (kk_expression_variable_id, kk_customer_tag_id, kk_expression_id, tag_type, tag_value, date_added) VALUES (kk_expression_variable_seq.nextval,(select kk_customer_tag_id from kk_customer_tag where name ='PROMOTION_TESTER'),(select kk_expression_id from kk_expression where name ='PromotionTester'),5,'true',sysdate);

-- For Setting the default expression for promotion testers
DELETE FROM configuration WHERE configuration_key = 'PROMOTION_TESTER_EXPRESSION';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, return_by_api) VALUES (configuration_seq.nextval, 'Promotion Tester Expression', 'PROMOTION_TESTER_EXPRESSION', 'PromotionTester', 'The expression used for determining promotion testers', '5', '25', sysdate, '1');

BEGIN EXECUTE IMMEDIATE 'DROP TABLE kk_credit_card'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE kk_credit_card (
  kk_credit_card_id NUMBER(10,0) NOT NULL,
  store_id VARCHAR2(64),
  customers_id NUMBER(10,0) NOT NULL,
  address_id int,
  ccType VARCHAR2(32),
  ccOwner VARCHAR2(32),
  ccNumber VARCHAR2(32),
  ccToken VARCHAR2(32),
  ccExpires VARCHAR2(16),
  ccExpiryMonth int,
  ccExpiryYear int,
  ccImage VARCHAR2(32),
  custom1 VARCHAR2(128),
  custom2 VARCHAR2(128),
  custom3 VARCHAR2(128),
  custom4 VARCHAR2(128),
  custom5 VARCHAR2(128),
  PRIMARY KEY(kk_credit_card_id)
);
CREATE INDEX idx_credit_card_customers_id ON kk_credit_card (customers_id);
BEGIN EXECUTE IMMEDIATE 'DROP SEQUENCE kk_credit_card_SEQ'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE SEQUENCE kk_credit_card_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

-- For Setting the tz database time zone for the store
DELETE FROM configuration WHERE configuration_key = 'TZ_DB_TIME_ZONE';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, return_by_api) VALUES (configuration_seq.nextval, 'TZ DB Time Zone', 'TZ_DB_TIME_ZONE', '', 'The tz database time zone for the store. e.g. US/Pacific', '1', '7', sysdate, '1');

-- New API call
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'getStoreTime', '', sysdate);

-- B2B Customer tags for monthly order limit
DELETE FROM kk_customer_tag WHERE name ='B2B_AGGREGATE_ORDER_LIMIT';
INSERT INTO kk_customer_tag (kk_customer_tag_id, name, description, validation, tag_type, max_ints, date_added) VALUES (kk_customer_tag_seq.nextval,'B2B_AGGREGATE_ORDER_LIMIT', 'Maximum total order value that can be submitted in a period of time', '', 3, 1, sysdate);
DELETE FROM kk_customer_tag WHERE name ='B2B_AGGREGATE_ORDER_TOTAL';
INSERT INTO kk_customer_tag (kk_customer_tag_id, name, description, validation, tag_type, max_ints, date_added) VALUES (kk_customer_tag_seq.nextval,'B2B_AGGREGATE_ORDER_TOTAL', 'The current order value total for a period of time', '', 3, 1, sysdate);

-- Admin Caches
DELETE FROM configuration WHERE configuration_key = 'ADMIN_CONFIG_CACHE_CHECK_SECS';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, return_by_api) VALUES (configuration_seq.nextval, 'Admin caches refresh check interval', 'ADMIN_CONFIG_CACHE_CHECK_SECS', '30', 'Interval in seconds for checking to see whether to refresh the KonaKartAdmin caches', '11', '10', sysdate, '1');

DELETE FROM configuration WHERE configuration_key = 'ADMIN_CONFIG_CACHE_CHECK_FLAG';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, return_by_api) VALUES (configuration_seq.nextval, 'Admin caches refresh flag','ADMIN_CONFIG_CACHE_CHECK_FLAG','false','Boolean to determine whether to refresh the admin config caches','100','1', sysdate, '1');




-- Create a KK_IF function for compatibility with mySQL
CREATE OR REPLACE FUNCTION KK_IF(test in integer, a in number, b in number) return number as  begin    if test > 0 then return a; end if;    return b;  end;
/

exit;
