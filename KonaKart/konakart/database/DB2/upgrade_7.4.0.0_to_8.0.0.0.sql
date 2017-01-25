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
-- From version 7.4.0.0 to version 8.0.0.0
-- -----------------------------------------------------------
-- In order to upgrade from versions prior to 7.4.0.0, the upgrade
-- scripts must be run sequentially.
-- 


-- Set database version information
set echo on
INSERT INTO kk_config (kk_config_id, kk_config_key, kk_config_value, date_added) VALUES (NEXTVAL FOR kk_config_seq, 'HISTORY', '8.0.0.0 U', current timestamp);
UPDATE kk_config SET kk_config_value='8.0.0.0 DB2', date_added=current timestamp WHERE kk_config_key='VERSION';

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
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'addPoints', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'cloneStore', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'custom', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'deleteBooking', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'deleteCatalog', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'deletePaymentSchedule', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'deleteSubscription', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'doesMallStoreExist', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'execute', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getAddressFormats', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getAllAddressFormats', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getAllCountriesFull', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getAllGeoZones', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getAllLanguages', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getAllManufacturers', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getAllOrderStatuses', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getAllProductOptions', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getAllTaxClassesFull', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getAllTaxRates', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getBookings', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getCatalogById', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getCatalogs', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getCategory', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getCategoryTree', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getCountries', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getCouponCode', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getCurrencies', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getCurrency', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getCustomValidatorSet', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getDefaultCurrency', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getDefaultLanguage', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getEngConf', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getFiles', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getGeoZones', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getHelpMsg', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getKonakartAdminPropsFilePath', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getLanguageByCode', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getLanguages', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getManufacturer', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getMsgs', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getOrderRefunds', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getOrderStatusNames', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getPaymentSchedule', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getPaymentSchedules', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getProdAttrDescsForTemplates', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getProductAvailabilityWithOptions', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getProductCountPerTemplate', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getProductOptionValuesPerOption', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getProductQuantityWithOptions', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getProductWithOptions', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getRelatedProductsWithOptions', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getSearchRules', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getStores', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getSubZones', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getSubscription', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getSubscriptions', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getTaxClasses', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getTaxRates', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getTopLevelCategories', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getZones', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getZonesById', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'insertBooking', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'insertCatalog', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'insertCustomerGroups', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'insertPaymentSchedule', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'insertSubscription', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'insertTagGroup', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'insertTagGroups', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'logMsg', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'login', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'logout', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'resetCustomerPasswordSpecifyingEmail', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'searchForProductsWithOptions', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'sendTemplateEmailToCustomers', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'sendTemplateEmailToCustomers1WithOptions', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'sendTemplateEmailToCustomersWithOptions', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'setConfigurationValue', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'setCreditCardDetailsOnOrder', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'setCustomerPassword', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'setEndpoint', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'setProductAvailabilityWithOptions', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'setProductQuantityWithOptions', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'testDB', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'updateBooking', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'updateCatalog', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'updatePaymentSchedule', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'updateSubscription', '', current timestamp);

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

-- Configuration variable to enable/disable Content Caching
DELETE FROM configuration WHERE configuration_key = 'CACHE_CONTENT';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api, store_id) SELECT nextval for configuration_seq, 'Cache Content', 'CACHE_CONTENT', 'true', 'Set to true to Cache KonaKart Content in memory.', 11, 28, 'choice(''true'', ''false'')', current timestamp, 1, store_id FROM configuration WHERE configuration_key = 'STORE_COUNTRY';

-- Config variable to define the location of the exported Mailing Lists
DELETE FROM configuration where configuration_key = 'MAILLISTS_BASE_DIRECTORY';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order,  date_added, return_by_api, store_id) SELECT nextval for configuration_seq, 'Exported Mailing List Directory', 'MAILLISTS_BASE_DIRECTORY', 'C:/KonaKart/mailLists', 'Defines the root directory where the Mailing Lists are exported to', 12, 9, current timestamp, 1, store_id FROM configuration WHERE configuration_key = 'STORE_COUNTRY';

-- New createMailingList API call
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'createMailingList','', current timestamp);

-- New View Mailing Lists panel
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq, 'kk_panel_viewMailingLists','View Mailing Lists', current timestamp);

-- Add View Mailing Lists Panel access to all roles that can access the 'kk_panel_storeConfiguration' panel
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, '1', '1', '1', current timestamp, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_storeConfiguration' and p2.code='kk_panel_viewMailingLists';

-- New Create Mailing Lists panel
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq, 'kk_panel_createMailingLists','Create Mailing Lists', current timestamp);

-- Add Create Mailing Lists Panel access to all roles that can access the 'kk_panel_storeConfiguration' panel
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, '1', '1', '1', current timestamp, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_storeConfiguration' and p2.code='kk_panel_createMailingLists';

-- Email output location
DELETE FROM configuration WHERE configuration_key = 'EMAIL_OUTPUT_DIRECTORY';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, return_by_api, store_id) SELECT nextval for configuration_seq, 'Email Output Directory', 'EMAIL_OUTPUT_DIRECTORY', 'C:/KonaKart/logs', 'The location where KonaKart will write email output files', 20, 2, current timestamp, 1, store_id FROM configuration WHERE configuration_key = 'STORE_COUNTRY';

-- Add extra field to products table to ignore quantity defined in array of productQuantity objects
ALTER TABLE products ADD ignore_prod_qty_stock INTEGER NOT NULL DEFAULT 0;

-- Suggested search list for each catalog id
DELETE FROM configuration WHERE configuration_key = 'SOLR_ADD_TERM_FOR_CATALOG';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api, store_id) SELECT nextval for configuration_seq, 'Add suggested search for catalog','SOLR_ADD_TERM_FOR_CATALOG','false','Adds a suggested search list for each catalog id since the catalog may contain only a subset of products',24, 30, 'choice(''true'', ''false'')', current timestamp, 1, store_id FROM configuration WHERE configuration_key = 'STORE_COUNTRY';

DELETE FROM configuration WHERE configuration_key = 'SOLR_ADD_SPELLING_FOR_CATALOG';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api, store_id) SELECT nextval for configuration_seq, 'Add spelling suggestions for catalog','SOLR_ADD_SPELLING_FOR_CATALOG','false','Adds spelling suggestions for each catalog id since the catalog may contain only a subset of products',24, 32, 'choice(''true'', ''false'')', current timestamp, 1, store_id FROM configuration WHERE configuration_key = 'STORE_COUNTRY';

DELETE FROM configuration WHERE configuration_key = 'SOLR_CATALOG_USED_FOR_PRICE';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api, store_id) SELECT nextval for configuration_seq, 'Catalogs used for product prices','SOLR_CATALOG_USED_FOR_PRICE','false','Set to true if catalogs are used to determine product prices',24, 34, 'choice(''true'', ''false'')', current timestamp, 0, store_id FROM configuration WHERE configuration_key = 'STORE_COUNTRY';

DELETE FROM configuration WHERE configuration_key = 'SOLR_CATALOG_USED_FOR_QTY';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api, store_id) SELECT nextval for configuration_seq, 'Catalogs used for product quantities','SOLR_CATALOG_USED_FOR_QTY','false','Set to true if catalogs are used to determine product quantities',24, 36, 'choice(''true'', ''false'')', current timestamp, 0, store_id FROM configuration WHERE configuration_key = 'STORE_COUNTRY';

-- Email Verified flag for Customers
ALTER TABLE customers ADD email_verified INTEGER NOT NULL DEFAULT 0;

-- Catalog to Category table
DROP TABLE kk_catalog_to_category;
CREATE TABLE kk_catalog_to_category (
  catalog_key VARCHAR(32) NOT NULL,
  categories_id INTEGER NOT NULL,
  price_adjustment decimal(15,4),
  fixed_price decimal(15,4),
  exclude INTEGER DEFAULT 0,
  store_id VARCHAR(64),
  PRIMARY KEY(catalog_key,categories_id)
);

-- Record time catalog is created
ALTER TABLE kk_catalog ADD last_creation_date TIMESTAMP;

-- New Admin App Panel for generating catalog prices
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq, 'kk_panel_catalog_prices','Catalog Price Generation', current timestamp);

-- Add Catalog Prices Panel access to all roles that can access the 'kk_panel_catalogs' panel
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, current timestamp, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_catalogs' and p2.code='kk_panel_catalog_prices';

INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'addCatalogRules', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'createCatalogPricesFromRules', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getCatalogRules', '', current timestamp);

-- Custom Filters for Orders
ALTER TABLE orders ADD filter1 VARCHAR(32);
ALTER TABLE orders ADD filter2 VARCHAR(32);
ALTER TABLE orders ADD filterDecimal1 DECIMAL(15,4);

-- Table for Custom Filters
DROP TABLE kk_filter;
CREATE TABLE kk_filter (
  id INTEGER NOT NULL,
  user_id INTEGER NOT NULL,
  filter_table VARCHAR(64),
  filter_column VARCHAR(64),
  filter_constraint VARCHAR(256),
  custom1 VARCHAR(32),
  custom2 VARCHAR(32),
  date_added TIMESTAMP,
  date_updated TIMESTAMP,
  store_id VARCHAR(64),
  PRIMARY KEY(id)
);
DROP SEQUENCE kk_filter_SEQ;
CREATE SEQUENCE kk_filter_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

CREATE INDEX i_us_377ce83e817bc ON kk_filter (user_id);

-- New Admin App Panel for maintaining the filters
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq, 'kk_panel_filters','Filters', current timestamp);

-- Add Filter Panel access to all roles that can access the 'kk_panel_storeConfiguration' panel
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, current timestamp, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_storeConfiguration' and p2.code='kk_panel_filters';

-- New Filter APIs
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getFilters', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getFiltersForCustomer', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getFilter', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'insertFilter', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'updateFilter', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'deleteFilter', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'deleteFiltersForCustomer', '', current timestamp);

-- New API call for deleting promotions
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'deletePromotionWithOptions', '', current timestamp);

-- Set up Custom Panels F as an example
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, current timestamp, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_products' and p2.code='kk_panel_customF';
exit;
