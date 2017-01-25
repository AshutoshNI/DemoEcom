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
-- From version 7.4.0.0 to version 8.0.0.0
-- -----------------------------------------------------------
-- In order to upgrade from versions prior to 7.4.0.0, the upgrade
-- scripts must be run sequentially.
-- 

-- Set database version information
INSERT INTO kk_config (kk_config_key, kk_config_value, date_added) VALUES ('HISTORY', '8.0.0.0 U', now());
UPDATE kk_config SET kk_config_value='8.0.0.0 PostgreSQL', date_added=now() WHERE kk_config_key='VERSION';

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
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (DEFAULT,'addPoints', '', now());
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (DEFAULT,'cloneStore', '', now());
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (DEFAULT,'custom', '', now());
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (DEFAULT,'deleteBooking', '', now());
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (DEFAULT,'deleteCatalog', '', now());
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (DEFAULT,'deletePaymentSchedule', '', now());
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (DEFAULT,'deleteSubscription', '', now());
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (DEFAULT,'doesMallStoreExist', '', now());
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (DEFAULT,'execute', '', now());
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (DEFAULT,'getAddressFormats', '', now());
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (DEFAULT,'getAllAddressFormats', '', now());
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (DEFAULT,'getAllCountriesFull', '', now());
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (DEFAULT,'getAllGeoZones', '', now());
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (DEFAULT,'getAllLanguages', '', now());
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (DEFAULT,'getAllManufacturers', '', now());
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (DEFAULT,'getAllOrderStatuses', '', now());
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (DEFAULT,'getAllProductOptions', '', now());
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (DEFAULT,'getAllTaxClassesFull', '', now());
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (DEFAULT,'getAllTaxRates', '', now());
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (DEFAULT,'getBookings', '', now());
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (DEFAULT,'getCatalogById', '', now());
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (DEFAULT,'getCatalogs', '', now());
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (DEFAULT,'getCategory', '', now());
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (DEFAULT,'getCategoryTree', '', now());
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (DEFAULT,'getCountries', '', now());
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (DEFAULT,'getCouponCode', '', now());
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (DEFAULT,'getCurrencies', '', now());
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (DEFAULT,'getCurrency', '', now());
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (DEFAULT,'getCustomValidatorSet', '', now());
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (DEFAULT,'getDefaultCurrency', '', now());
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (DEFAULT,'getDefaultLanguage', '', now());
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (DEFAULT,'getEngConf', '', now());
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (DEFAULT,'getFiles', '', now());
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (DEFAULT,'getGeoZones', '', now());
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (DEFAULT,'getHelpMsg', '', now());
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (DEFAULT,'getKonakartAdminPropsFilePath', '', now());
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (DEFAULT,'getLanguageByCode', '', now());
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (DEFAULT,'getLanguages', '', now());
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (DEFAULT,'getManufacturer', '', now());
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (DEFAULT,'getMsgs', '', now());
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (DEFAULT,'getOrderRefunds', '', now());
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (DEFAULT,'getOrderStatusNames', '', now());
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (DEFAULT,'getPaymentSchedule', '', now());
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (DEFAULT,'getPaymentSchedules', '', now());
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (DEFAULT,'getProdAttrDescsForTemplates', '', now());
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (DEFAULT,'getProductAvailabilityWithOptions', '', now());
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (DEFAULT,'getProductCountPerTemplate', '', now());
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (DEFAULT,'getProductOptionValuesPerOption', '', now());
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (DEFAULT,'getProductQuantityWithOptions', '', now());
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (DEFAULT,'getProductWithOptions', '', now());
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (DEFAULT,'getRelatedProductsWithOptions', '', now());
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (DEFAULT,'getSearchRules', '', now());
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (DEFAULT,'getStores', '', now());
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (DEFAULT,'getSubZones', '', now());
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (DEFAULT,'getSubscription', '', now());
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (DEFAULT,'getSubscriptions', '', now());
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (DEFAULT,'getTaxClasses', '', now());
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (DEFAULT,'getTaxRates', '', now());
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (DEFAULT,'getTopLevelCategories', '', now());
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (DEFAULT,'getZones', '', now());
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (DEFAULT,'getZonesById', '', now());
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (DEFAULT,'insertBooking', '', now());
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (DEFAULT,'insertCatalog', '', now());
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (DEFAULT,'insertCustomerGroups', '', now());
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (DEFAULT,'insertPaymentSchedule', '', now());
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (DEFAULT,'insertSubscription', '', now());
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (DEFAULT,'insertTagGroup', '', now());
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (DEFAULT,'insertTagGroups', '', now());
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (DEFAULT,'logMsg', '', now());
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (DEFAULT,'login', '', now());
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (DEFAULT,'logout', '', now());
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (DEFAULT,'resetCustomerPasswordSpecifyingEmail', '', now());
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (DEFAULT,'searchForProductsWithOptions', '', now());
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (DEFAULT,'sendTemplateEmailToCustomers', '', now());
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (DEFAULT,'sendTemplateEmailToCustomers1WithOptions', '', now());
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (DEFAULT,'sendTemplateEmailToCustomersWithOptions', '', now());
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (DEFAULT,'setConfigurationValue', '', now());
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (DEFAULT,'setCreditCardDetailsOnOrder', '', now());
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (DEFAULT,'setCustomerPassword', '', now());
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (DEFAULT,'setEndpoint', '', now());
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (DEFAULT,'setProductAvailabilityWithOptions', '', now());
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (DEFAULT,'setProductQuantityWithOptions', '', now());
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (DEFAULT,'testDB', '', now());
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (DEFAULT,'updateBooking', '', now());
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (DEFAULT,'updateCatalog', '', now());
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (DEFAULT,'updatePaymentSchedule', '', now());
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (DEFAULT,'updateSubscription', '', now());

-- New Custom fields:
ALTER TABLE orders ADD COLUMN custom6 varchar(16);
ALTER TABLE orders ADD COLUMN custom7 varchar(16);
ALTER TABLE orders ADD COLUMN custom8 varchar(16);
ALTER TABLE orders ADD COLUMN custom9 varchar(16);
ALTER TABLE orders ADD COLUMN custom10 varchar(16);

ALTER TABLE orders_products ADD COLUMN custom6 varchar(16);
ALTER TABLE orders_products ADD COLUMN custom7 varchar(16);
ALTER TABLE orders_products ADD COLUMN custom8 varchar(16);
ALTER TABLE orders_products ADD COLUMN custom9 varchar(16);
ALTER TABLE orders_products ADD COLUMN custom10 varchar(16);

ALTER TABLE customers_basket ADD COLUMN custom6 varchar(16);
ALTER TABLE customers_basket ADD COLUMN custom7 varchar(16);
ALTER TABLE customers_basket ADD COLUMN custom8 varchar(16);
ALTER TABLE customers_basket ADD COLUMN custom9 varchar(16);
ALTER TABLE customers_basket ADD COLUMN custom10 varchar(16);

-- Configuration variable to enable/disable Content Caching
DELETE FROM configuration WHERE configuration_key = 'CACHE_CONTENT';
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api, store_id) SELECT 'Cache Content', 'CACHE_CONTENT', 'true', 'Set to true to Cache KonaKart Content in memory.', '11', '28', 'choice(''true'', ''false'')', now(), '1', store_id FROM configuration WHERE configuration_key = 'STORE_COUNTRY';

-- Config variable to define the location of the exported Mailing Lists
DELETE FROM configuration where configuration_key = 'MAILLISTS_BASE_DIRECTORY';
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order,  date_added, return_by_api, store_id) SELECT 'Exported Mailing List Directory', 'MAILLISTS_BASE_DIRECTORY', 'C:/KonaKart/mailLists', 'Defines the root directory where the Mailing Lists are exported to', '12', '9', now(), '1', store_id FROM configuration WHERE configuration_key = 'STORE_COUNTRY';

-- New createMailingList API call
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (DEFAULT,'createMailingList','', now());

-- New View Mailing Lists panel
INSERT INTO kk_panel (code, description, date_added) VALUES ('kk_panel_viewMailingLists','View Mailing Lists', now());

-- Add View Mailing Lists Panel access to all roles that can access the 'kk_panel_storeConfiguration' panel
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, '1', '1', '1', now(), store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_storeConfiguration' and p2.code='kk_panel_viewMailingLists';

-- New Create Mailing Lists panel
INSERT INTO kk_panel (code, description, date_added) VALUES ('kk_panel_createMailingLists','Create Mailing Lists', now());

-- Add Create Mailing Lists Panel access to all roles that can access the 'kk_panel_storeConfiguration' panel
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, '1', '1', '1', now(), store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_storeConfiguration' and p2.code='kk_panel_createMailingLists';

-- Email output location
DELETE FROM configuration WHERE configuration_key = 'EMAIL_OUTPUT_DIRECTORY';
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, return_by_api, store_id) SELECT 'Email Output Directory', 'EMAIL_OUTPUT_DIRECTORY', 'C:/KonaKart/logs', 'The location where KonaKart will write email output files', '20', '2', now(), '1', store_id FROM configuration WHERE configuration_key = 'STORE_COUNTRY';

-- Add extra field to products table to ignore quantity defined in array of productQuantity objects
ALTER TABLE products ADD ignore_prod_qty_stock INTEGER NOT NULL DEFAULT '0';

-- Suggested search list for each catalog id
DELETE FROM configuration WHERE configuration_key = 'SOLR_ADD_TERM_FOR_CATALOG';
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api, store_id) SELECT 'Add suggested search for catalog','SOLR_ADD_TERM_FOR_CATALOG','false','Adds a suggested search list for each catalog id since the catalog may contain only a subset of products','24', '30', 'choice(''true'', ''false'')', now(), '1', store_id FROM configuration WHERE configuration_key = 'STORE_COUNTRY';

DELETE FROM configuration WHERE configuration_key = 'SOLR_ADD_SPELLING_FOR_CATALOG';
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api, store_id) SELECT 'Add spelling suggestions for catalog','SOLR_ADD_SPELLING_FOR_CATALOG','false','Adds spelling suggestions for each catalog id since the catalog may contain only a subset of products','24', '32', 'choice(''true'', ''false'')', now(), '1', store_id FROM configuration WHERE configuration_key = 'STORE_COUNTRY';

DELETE FROM configuration WHERE configuration_key = 'SOLR_CATALOG_USED_FOR_PRICE';
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api, store_id) SELECT 'Catalogs used for product prices','SOLR_CATALOG_USED_FOR_PRICE','false','Set to true if catalogs are used to determine product prices','24', '34', 'choice(''true'', ''false'')', now(), '0', store_id FROM configuration WHERE configuration_key = 'STORE_COUNTRY';

DELETE FROM configuration WHERE configuration_key = 'SOLR_CATALOG_USED_FOR_QTY';
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api, store_id) SELECT 'Catalogs used for product quantities','SOLR_CATALOG_USED_FOR_QTY','false','Set to true if catalogs are used to determine product quantities','24', '36', 'choice(''true'', ''false'')', now(), '0', store_id FROM configuration WHERE configuration_key = 'STORE_COUNTRY';

-- Email Verified flag for Customers
ALTER TABLE customers ADD COLUMN email_verified INTEGER NOT NULL DEFAULT 0;

-- Catalog to Category table
DROP TABLE IF EXISTS kk_catalog_to_category;
CREATE TABLE kk_catalog_to_category (
  catalog_key VARCHAR(32) NOT NULL,
  categories_id INTEGER NOT NULL,
  price_adjustment decimal(15,4),
  fixed_price decimal(15,4),
  exclude INTEGER DEFAULT '0',
  store_id VARCHAR(64),
  PRIMARY KEY (catalog_key,categories_id)
);

-- Record time catalog is created
ALTER TABLE kk_catalog ADD COLUMN last_creation_date TIMESTAMP;

-- New Admin App Panel for generating catalog prices
INSERT INTO kk_panel (code, description, date_added) VALUES ('kk_panel_catalog_prices','Catalog Price Generation', now());

-- Add Catalog Prices Panel access to all roles that can access the 'kk_panel_catalogs' panel
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, now(), store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_catalogs' and p2.code='kk_panel_catalog_prices';

INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (DEFAULT,'addCatalogRules', '', now());
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (DEFAULT,'createCatalogPricesFromRules', '', now());
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (DEFAULT,'getCatalogRules', '', now());

-- Custom Filters for Orders
ALTER TABLE orders ADD COLUMN filter1 VARCHAR(32);
ALTER TABLE orders ADD COLUMN filter2 VARCHAR(32);
ALTER TABLE orders ADD COLUMN filterDecimal1 DECIMAL(15,4);

-- Table for Custom Filters
DROP TABLE IF EXISTS kk_filter;
CREATE TABLE kk_filter (
   id SERIAL,
   user_id INTEGER NOT NULL,
   filter_table VARCHAR(64),
   filter_column VARCHAR(64),
   filter_constraint VARCHAR(256),
   custom1 VARCHAR(32),
   custom2 VARCHAR(32),
   date_added TIMESTAMP,
   date_updated TIMESTAMP,
   store_id VARCHAR(64),
   PRIMARY KEY (id)
);

CREATE INDEX idxkk_filter_user_id ON kk_filter (user_id);

-- New Admin App Panel for maintaining the filters
INSERT INTO kk_panel (code, description, date_added) VALUES ('kk_panel_filters','Filters', now());

-- Add Filter Panel access to all roles that can access the 'kk_panel_storeConfiguration' panel
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, now(), store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_storeConfiguration' and p2.code='kk_panel_filters';

-- New Filter APIs
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (DEFAULT,'getFilters', '', now());
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (DEFAULT,'getFiltersForCustomer', '', now());
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (DEFAULT,'getFilter', '', now());
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (DEFAULT,'insertFilter', '', now());
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (DEFAULT,'updateFilter', '', now());
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (DEFAULT,'deleteFilter', '', now());
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (DEFAULT,'deleteFiltersForCustomer', '', now());

-- New API call for deleting promotions
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (DEFAULT,'deletePromotionWithOptions', '', now());

-- Set up Custom Panels F as an example
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, now(), store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_products' and p2.code='kk_panel_customF';
