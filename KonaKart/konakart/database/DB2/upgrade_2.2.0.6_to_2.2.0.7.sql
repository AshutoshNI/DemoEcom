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
-- From version 2.2.0.6 to version 2.2.0.7
-- -----------------------------------------------------------
-- In order to upgrade from versions prior to 2.2.0.6, the upgrade
-- scripts must be run sequentially.
-- 

delete from configuration where configuration_key = 'READ_AUDIT';
set echo on
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'Auditing for Reads', 'READ_AUDIT', '0', 'Enable / Disable auditing for reads', 18, 1,'tep_cfg_pull_down_audit_list(', current timestamp);
delete from configuration where configuration_key = 'EDIT_AUDIT';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'Auditing for Edits', 'EDIT_AUDIT', '0', 'Enable / Disable auditing for edits', 18, 2,'tep_cfg_pull_down_audit_list(', current timestamp);
delete from configuration where configuration_key = 'INSERT_AUDIT';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'Auditing for Inserts', 'INSERT_AUDIT', '0', 'Enable / Disable auditing for inserts', 18, 3,'tep_cfg_pull_down_audit_list(', current timestamp);
delete from configuration where configuration_key = 'DELETE_AUDIT';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'Auditing for Deletes', 'DELETE_AUDIT', '0', 'Enable / Disable auditing for deletes', 18, 4,'tep_cfg_pull_down_audit_list(', current timestamp);

-- Audit table
DROP TABLE kk_audit;
CREATE TABLE kk_audit (
  audit_id INTEGER NOT NULL,
  customers_id INTEGER NOT NULL,
  audit_action INTEGER NOT NULL,
  api_method_name VARCHAR(128) NOT NULL,
  object_id int,
  object_to_string VARCHAR(4000),
  date_added TIMESTAMP NOT NULL,
  PRIMARY KEY(audit_id)
);
DROP SEQUENCE kk_audit_SEQ;
CREATE SEQUENCE kk_audit_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

-- Add extra fields to the customers table
ALTER TABLE customers add customers_type int;
ALTER TABLE customers add customers_enabled int DEFAULT 1;

-- Role table
DROP TABLE kk_role;
CREATE TABLE kk_role (
  role_id INTEGER NOT NULL,
  name VARCHAR(128) NOT NULL,
  description VARCHAR(255),
  date_added TIMESTAMP,
  last_modified TIMESTAMP,
  PRIMARY KEY(role_id)
);
DROP SEQUENCE kk_role_SEQ;
CREATE SEQUENCE kk_role_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

-- Customers_to_role table
DROP TABLE kk_customers_to_role;
CREATE TABLE kk_customers_to_role (
  role_id INTEGER DEFAULT 0 NOT NULL,
  customers_id INTEGER DEFAULT 0 NOT NULL,
  date_added TIMESTAMP,
  PRIMARY KEY(role_id, customers_id)
);

-- Panel table
DROP TABLE kk_panel;
CREATE TABLE kk_panel (
  panel_id INTEGER NOT NULL,
  code VARCHAR(128) NOT NULL,
  description VARCHAR(255),
  date_added TIMESTAMP,
  last_modified TIMESTAMP,
  PRIMARY KEY(panel_id)
);
DROP SEQUENCE kk_panel_SEQ;
CREATE SEQUENCE kk_panel_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

-- Role to Panel table
DROP TABLE kk_role_to_panel;
CREATE TABLE kk_role_to_panel (
  role_id INTEGER DEFAULT 0 NOT NULL,
  panel_id INTEGER DEFAULT 0 NOT NULL,
  can_edit INTEGER DEFAULT 0,
  can_insert INTEGER DEFAULT 0,
  can_delete INTEGER DEFAULT 0,
  custom1 INTEGER DEFAULT 0,
  custom1_desc VARCHAR(128),
  custom2 INTEGER DEFAULT 0,
  custom2_desc VARCHAR(128),
  custom3 INTEGER DEFAULT 0,
  custom3_desc VARCHAR(128),
  custom4 INTEGER DEFAULT 0,
  custom4_desc VARCHAR(128),
  custom5 INTEGER DEFAULT 0,
  custom5_desc VARCHAR(128),
  date_added TIMESTAMP,
  last_modified TIMESTAMP,
  PRIMARY KEY(role_id, panel_id)
);

-- Default super-administrator user = "admin@konakart.com" password = "princess"
delete from customers where customers_email_address = 'admin@konakart.com' and customers_telephone='019081';
delete from address_book where entry_street_address='1 Way Street' and entry_postcode='PostCode1';
INSERT INTO address_book (address_book_id, customers_id, entry_gender, entry_company, entry_firstname, entry_lastname, entry_street_address, entry_suburb, entry_postcode, entry_city, entry_state, entry_country_id, entry_zone_id) VALUES (nextval for address_book_seq, -1, 'm', 'ACME Inc.', 'Andy', 'Admin', '1 Way Street', '', 'PostCode1', 'NeverNever', '', 223, 12);
INSERT INTO customers (customers_id, customers_gender, customers_firstname, customers_lastname,customers_dob, customers_email_address, customers_default_address_id, customers_telephone, customers_fax, customers_password, customers_newsletter, customers_type) VALUES (nextval for customers_seq,'m', 'Andy', 'Admin', to_date('1977-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'admin@konakart.com', -1, '019081', '', 'f5147fc3f6eb46e234c01db939bdb581:08', '0', 1);
INSERT INTO customers_info select customers_id , current timestamp, 0, current timestamp, current timestamp, 0 from customers where customers_email_address = 'admin@konakart.com' and customers_telephone='019081';
UPDATE address_book set customers_id = (select customers_id from customers where customers_email_address = 'admin@konakart.com' and customers_telephone='019081') where customers_id=-1;
UPDATE customers set customers_default_address_id = (select address_book_id from address_book where entry_street_address='1 Way Street' and entry_postcode='PostCode1') where customers_default_address_id=-1;

-- Default catalog maintainer user = "cat@konakart.com" password = "princess"
delete from customers where customers_email_address = 'cat@konakart.com' and customers_telephone='019082';
delete from address_book where entry_street_address='2 Way Street' and entry_postcode='PostCode2';
INSERT INTO address_book (address_book_id, customers_id, entry_gender, entry_company, entry_firstname, entry_lastname, entry_street_address, entry_suburb, entry_postcode, entry_city, entry_state, entry_country_id, entry_zone_id) VALUES (nextval for address_book_seq, -1, 'm', 'ACME Inc.', 'Caty', 'Catalog', '2 Way Street', '', 'PostCode2', 'NeverNever', '', 223, 12);
INSERT INTO customers (customers_id, customers_gender, customers_firstname, customers_lastname,customers_dob, customers_email_address, customers_default_address_id, customers_telephone, customers_fax, customers_password, customers_newsletter, customers_type) VALUES (nextval for customers_seq,'m', 'Caty', 'Catalog', to_date('1977-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'cat@konakart.com', -1, '019082', '', 'f5147fc3f6eb46e234c01db939bdb581:08', '0', 1);
INSERT INTO customers_info select customers_id , current timestamp, 0, current timestamp, current timestamp, 0 from customers where customers_email_address = 'cat@konakart.com' and customers_telephone='019082';
UPDATE address_book set customers_id = (select customers_id from customers where customers_email_address = 'cat@konakart.com' and customers_telephone='019082') where customers_id=-1;
UPDATE customers set customers_default_address_id = (select address_book_id from address_book where entry_street_address='2 Way Street' and entry_postcode='PostCode2') where customers_default_address_id=-1;


-- Default order maintainer user = "order@konakart.com" password = "princess"
delete from customers where customers_email_address = 'order@konakart.com' and customers_telephone='019083';
delete from address_book where entry_street_address='3 Way Street' and entry_postcode='PostCode3';
INSERT INTO address_book (address_book_id, customers_id, entry_gender, entry_company, entry_firstname, entry_lastname, entry_street_address, entry_suburb, entry_postcode, entry_city, entry_state, entry_country_id, entry_zone_id) VALUES (nextval for address_book_seq, -1, 'm', 'ACME Inc.', 'Olly', 'Order', '3 Way Street', '', 'PostCode3', 'NeverNever', '', 223, 12);
INSERT INTO customers (customers_id, customers_gender, customers_firstname, customers_lastname,customers_dob, customers_email_address, customers_default_address_id, customers_telephone, customers_fax, customers_password, customers_newsletter, customers_type) VALUES (nextval for customers_seq,'m', 'Olly', 'Order', to_date('1977-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'order@konakart.com', -1, '019083', '', 'f5147fc3f6eb46e234c01db939bdb581:08', '0', 1);
INSERT INTO customers_info select customers_id , current timestamp, 0, current timestamp, current timestamp, 0 from customers where customers_email_address = 'order@konakart.com' and customers_telephone='019083';
UPDATE address_book set customers_id = (select customers_id from customers where customers_email_address = 'order@konakart.com' and customers_telephone='019083') where customers_id=-1;
UPDATE customers set customers_default_address_id = (select address_book_id from address_book where entry_street_address='3 Way Street' and entry_postcode='PostCode3') where customers_default_address_id=-1;

-- Panels
delete from kk_panel;
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_addressFormats','Address Formats', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_audit','Audit', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_auditConfig','AuditConfig', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_cache','Cache', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_categories','Categories', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_configFiles','Configuration Files', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_digitalDownloadConfig','Digital Downloads', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_countries','Countries', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_coupons','Coupons', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_couponsFromProm','Coupons For Promotions', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_currencies','Currencies', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_customerDetails','Customer Details', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_customerOrders','Customer Orders', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_customers','Customers', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_deleteSessions','Delete Expired Sessions', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_editCustomer','Edit Customer', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_editOrderPanel','Edit Order', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_editProduct','Edit Product', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_emailOptions','Email Options', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_geoZones','Geo-Zones', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_httpHttps','HTTP / HTTPS', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_images','Images', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_insertCustomer','Insert Customer', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_ipnhistory','Payment Gateway Callbacks', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_ipnhistoryFromOrders','Payment Status For Order', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_languages','Languages', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_logging','Logging', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_roleToPanels','Maintain Roles', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_manufacturers','Manufacturers', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_maximumValues','Maximum Values', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_minimumValues','Minimum Values', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_userToRoles','Map Users to Roles', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_orders','Orders', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_orderStatuses','Order Statuses', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_orderTotalModules','Order Total', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_paymentModules','Payment', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_prodsFromCat','Products for Categories', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_prodsFromManu','Products for Manufacturer', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_productOptions','Product Options', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_products','Products', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_promotions','Promotions', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_promRules','Promotion Rules', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_refreshCache','Refresh Config Cache', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_reports','Reports', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_reportsConfig','Reports Configuration', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_returns','Product Returns', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_returnsFromOrders','Product Returns For Order', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_rss','Latest News', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_shippingModules','Shipping', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_shippingPacking','Shipping / Packing', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_status','Status', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_stockAndOrders','Stock and Orders', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_storeConfiguration','My Store', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_subZones','Sub-Zones', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_taxAreaMapping','Tax Area Mapping', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_taxAreas','Tax Areas', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_taxAreaToZoneMapping','Tax Area to Zone Mapping', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_taxClasses','Tax Classes', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_taxRates','Tax Rates', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_zones','Zones', current timestamp);

-- Roles
delete from kk_role;
INSERT INTO kk_role (role_id, name, description, date_added) VALUES (nextval for kk_role_seq,  'Super User','Permission to do everything', current timestamp);
INSERT INTO kk_role (role_id, name, description, date_added) VALUES (nextval for kk_role_seq,  'Catalog Maintenance','Permission to maintain the catalog of products', current timestamp);
INSERT INTO kk_role (role_id, name, description, date_added) VALUES (nextval for kk_role_seq,  'Order Maintenance','Permission to maintain the orders', current timestamp);
INSERT INTO kk_role (role_id, name, description, date_added) VALUES (nextval for kk_role_seq,  'Customer Maintenance','Permission to maintain the customers', current timestamp);

-- Associate roles to panels
delete from kk_role_to_panel;

-- Super User Role
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1,  1, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1,  2, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1,  3, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1,  4, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1,  5, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1,  6, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1,  7, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1,  8, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1,  9, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1,  10, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1,  11, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1,  12, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1,  13, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, custom1, custom1_desc, custom2, custom2_desc) VALUES (1,  14, 1,1,1,current timestamp, 0, 'If set email is disabled', 0, 'If set cannot reset password');
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1,  15, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1,  16, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1,  17, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1,  18, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1,  19, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1,  20, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1,  21, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1,  22, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1,  23, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1,  24, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1,  25, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1,  26, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1,  27, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1,  28, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1,  29, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1,  30, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1,  31, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1,  32, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1,  33, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1,  34, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1,  35, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1,  36, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1,  37, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1,  38, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1,  39, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1,  40, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1,  41, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1,  42, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1,  43, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, custom1, custom1_desc) VALUES (1,  44, 1,1,1,current timestamp, 0, 'If set reports cannot be run');
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1,  45, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1,  46, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1,  47, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1,  48, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1,  49, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1,  50, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1,  51, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1,  52, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1,  53, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1,  54, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1,  55, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1,  56, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1,  57, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1,  58, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1,  59, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1,  60, 1,1,1,current timestamp);

-- Catalog maintenance Role
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (2,  5, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (2,  9, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (2,  10, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (2,  18, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (2,  29, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (2,  37, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (2,  38, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (2,  39, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (2,  40, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (2,  41, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (2,  42, 1,1,1,current timestamp);

-- Order Maintenance Role
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (3,  17, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (3,  24, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (3,  25, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (3,  33, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (3,  46, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (3,  47, 1,1,1,current timestamp);

-- Customer Maintenance Role
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (4,  13, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, custom1, custom1_desc, custom2, custom2_desc) VALUES (4,  14, 1,1,1,current timestamp, 0, 'If set email is disabled', 0, 'If set cannot reset password');
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (4,  16, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (4,  23, 1,1,1,current timestamp);

-- Associate customers to roles
delete from kk_customers_to_role;

-- Super User
INSERT INTO kk_customers_to_role (role_id, customers_id, date_added) select 1, customers_id, current timestamp from customers where customers_email_address = 'admin@konakart.com' and customers_telephone='019081';

-- Catalog maintainer
INSERT INTO kk_customers_to_role (role_id, customers_id, date_added) select 2, customers_id, current timestamp from customers where customers_email_address = 'cat@konakart.com' and customers_telephone='019082';

-- Order \& Customer Manager
INSERT INTO kk_customers_to_role (role_id, customers_id, date_added) select 3, customers_id, current timestamp from customers where customers_email_address = 'order@konakart.com' and customers_telephone='019083';
INSERT INTO kk_customers_to_role (role_id, customers_id, date_added) select 4, customers_id, current timestamp from customers where customers_email_address = 'order@konakart.com' and customers_telephone='019083';

-- Digital Download table
DROP TABLE kk_digital_download;
CREATE TABLE kk_digital_download(
  products_id INTEGER DEFAULT 0 NOT NULL,
  customers_id INTEGER DEFAULT 0 NOT NULL,
  max_downloads INTEGER DEFAULT -1,
  times_downloaded INTEGER DEFAULT 0,
  expiration_date TIMESTAMP,
  date_added TIMESTAMP,
  last_modified TIMESTAMP,
  PRIMARY KEY(products_id, customers_id)
);

-- Add extra fields to the products table
ALTER TABLE products add products_type int DEFAULT 0;
ALTER TABLE products add products_file_path varchar(255);
ALTER TABLE products add products_content_type varchar(128);

-- Add extra field to the orders_products
ALTER TABLE orders_products add products_type int DEFAULT 0;

-- Configuration variables for digital downloads
delete from configuration where configuration_key = 'DD_BASE_PATH';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (nextval for configuration_seq, 'Digital Download Base Path', 'DD_BASE_PATH', '', 'Base path for digital download files', 19, 0, current timestamp);
delete from configuration where configuration_key = 'DD_MAX_DOWNLOADS';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (nextval for configuration_seq, 'Max Number of Downloads', 'DD_MAX_DOWNLOADS', '-1', 'Maximum number of downloads allowed from link. -1 for unlimited number.', 19, 1, current timestamp);
delete from configuration where configuration_key = 'DD_MAX_DOWNLOAD_DAYS';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (nextval for configuration_seq, 'Number of days link is valid', 'DD_MAX_DOWNLOAD_DAYS', '-1', 'The download link remains valid for this number of days. -1 for unlimited number of days', 19, 2, current timestamp);
delete from configuration where configuration_key = 'DD_DELETE_ON_EXPIRATION';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'Delete record on expiration', 'DD_DELETE_ON_EXPIRATION', 'true', 'When the download link expires, delete the database table record', 19, 3, 'tep_cfg_select_option(array(''true'', ''false''), ',current timestamp);
delete from configuration where configuration_key = 'DD_DOWNLOAD_AS_ATTACHMENT';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'Download as an attachment', 'DD_DOWNLOAD_AS_ATTACHMENT', 'true', 'Download the file as an attachment rather than viewing in the browser', 19, 4, 'tep_cfg_select_option(array(''true'', ''false''), ',current timestamp);

-- Add a new order status
delete from orders_status where orders_status_id = 7;
INSERT INTO orders_status(orders_status_id, language_id, orders_status_name) VALUES (7,1,'Partially Delivered');
INSERT INTO orders_status(orders_status_id, language_id, orders_status_name) VALUES (7,2,'Teilweise geliefert');
INSERT INTO orders_status(orders_status_id, language_id, orders_status_name) VALUES (7,3,'Entregado parcialmente');

-- Configuration variable for enabling/disabling access to Invisible Products in the Admin App
delete from configuration where configuration_key = 'SHOW_INVISIBLE_PRODUCTS_IN_ADM';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'Show Invisible Products', 'SHOW_INVISIBLE_PRODUCTS_IN_ADM', 'true', 'Show invisible products in the Admin App', 9, 4, 'tep_cfg_select_option(array(''true'', ''false''), ', current timestamp);

-- Add a primary key to the counter table
DROP TABLE counter;
CREATE TABLE counter (
  counter_id INTEGER NOT NULL,
  startdate char(8),
  counter INTEGER,
  PRIMARY KEY(counter_id)
);
DROP SEQUENCE counter_SEQ;
CREATE SEQUENCE counter_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;


-- Logging configuration
INSERT INTO configuration_group VALUES (nextval for configuration_group_seq, 'Logging', 'Logging configuration options', 20, 1);
delete from configuration where configuration_key = 'ADMIN_APP_LOGGING_LEVEL';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'Admin App logging level', 'ADMIN_APP_LOGGING_LEVEL', '4', 'Set the logging level for the KonaKart Admin App', 20, 1, 'option(0=OFF,1=SEVERE,2=ERROR,4=WARNING,6=INFO,8=DEBUG)', current timestamp);

-- Detailed eMail configurations
delete from configuration where configuration_key = 'SEND_ORDER_CONF_EMAIL';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'Send Order Confirmation E-Mails', 'SEND_ORDER_CONF_EMAIL', 'true', 'Send out an e-mail when an order is saved or state changes', 12, 8, 'tep_cfg_select_option(array(''true'', ''false''), ', current timestamp);
delete from configuration where configuration_key = 'SEND_STOCK_REORDER_EMAIL';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'Send Stock Reorder E-Mails', 'SEND_STOCK_REORDER_EMAIL', 'true', 'Send out an e-mail when the stock level of a product falls below a certain value', 12, 9, 'tep_cfg_select_option(array(''true'', ''false''), ', current timestamp);
delete from configuration where configuration_key = 'SEND_WELCOME_EMAIL';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'Send Welcome E-Mails', 'SEND_WELCOME_EMAIL', 'true', 'Send out a welcome e-mail when a customer registers to use the cart', 12, 10, 'tep_cfg_select_option(array(''true'', ''false''), ', current timestamp);
delete from configuration where configuration_key = 'SEND_NEW_PASSWORD_EMAIL';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'Send New Password E-Mails', 'SEND_NEW_PASSWORD_EMAIL', 'true', 'Send out an e-mail containing a new password when requested by a customer', 12, 11, 'tep_cfg_select_option(array(''true'', ''false''), ', current timestamp);

-- Add extra image fields to product 
ALTER TABLE products add products_image2 varchar(64);
ALTER TABLE products add products_image3 varchar(64);
ALTER TABLE products add products_image4 varchar(64);

-- Add field for comparison data to products_description
ALTER TABLE products_description add products_comparison VARCHAR(3000);

-- Initial configuration for the Order Total Shipping Module
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'Allow Free Shipping', 'MODULE_ORDER_TOTAL_SHIPPING_FREE_SHIPPING', 'false', 'Do you want to allow free shipping?', 6, 3,'tep_cfg_select_option(array(''true'', ''false''), ', current timestamp);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, use_function, date_added) VALUES (nextval for configuration_seq, 'Free Shipping For Orders Over', 'MODULE_ORDER_TOTAL_SHIPPING_FREE_SHIPPING_OVER', '50', 'Provide free shipping for orders over the set amount.', 6, 4, 'currencies->format',current timestamp);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'Provide Free Shipping For Orders Made', 'MODULE_ORDER_TOTAL_SHIPPING_DESTINATION', 'national', 'Provide free shipping for orders sent to the set destination.', 6, 5, 'tep_cfg_select_option(array(''national'', ''international'', ''both''), ', current timestamp);

  

exit;
