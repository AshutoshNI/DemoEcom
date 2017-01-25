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
-- From version 7.4.0.0 to version 8.0.0.0
-- -----------------------------------------------------------
-- In order to upgrade from versions prior to 7.4.0.0, the upgrade
-- scripts must be run sequentially.
-- 


-- Set database version information
INSERT INTO kk_config (kk_config_key, kk_config_value, date_added) VALUES ('HISTORY', '8.0.0.0 U', getdate());
UPDATE kk_config SET kk_config_value='8.0.0.0 SQLServer', date_added=getdate() WHERE kk_config_key='VERSION';

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
INSERT INTO kk_api_call (name, description, date_added) VALUES ('addPoints', '', getdate());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('cloneStore', '', getdate());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('custom', '', getdate());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('deleteBooking', '', getdate());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('deleteCatalog', '', getdate());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('deletePaymentSchedule', '', getdate());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('deleteSubscription', '', getdate());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('doesMallStoreExist', '', getdate());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('execute', '', getdate());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getAddressFormats', '', getdate());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getAllAddressFormats', '', getdate());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getAllCountriesFull', '', getdate());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getAllGeoZones', '', getdate());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getAllLanguages', '', getdate());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getAllManufacturers', '', getdate());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getAllOrderStatuses', '', getdate());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getAllProductOptions', '', getdate());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getAllTaxClassesFull', '', getdate());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getAllTaxRates', '', getdate());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getBookings', '', getdate());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getCatalogById', '', getdate());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getCatalogs', '', getdate());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getCategory', '', getdate());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getCategoryTree', '', getdate());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getCountries', '', getdate());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getCouponCode', '', getdate());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getCurrencies', '', getdate());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getCurrency', '', getdate());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getCustomValidatorSet', '', getdate());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getDefaultCurrency', '', getdate());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getDefaultLanguage', '', getdate());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getEngConf', '', getdate());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getFiles', '', getdate());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getGeoZones', '', getdate());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getHelpMsg', '', getdate());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getKonakartAdminPropsFilePath', '', getdate());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getLanguageByCode', '', getdate());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getLanguages', '', getdate());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getManufacturer', '', getdate());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getMsgs', '', getdate());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getOrderRefunds', '', getdate());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getOrderStatusNames', '', getdate());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getPaymentSchedule', '', getdate());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getPaymentSchedules', '', getdate());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getProdAttrDescsForTemplates', '', getdate());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getProductAvailabilityWithOptions', '', getdate());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getProductCountPerTemplate', '', getdate());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getProductOptionValuesPerOption', '', getdate());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getProductQuantityWithOptions', '', getdate());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getProductWithOptions', '', getdate());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getRelatedProductsWithOptions', '', getdate());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getSearchRules', '', getdate());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getStores', '', getdate());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getSubZones', '', getdate());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getSubscription', '', getdate());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getSubscriptions', '', getdate());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getTaxClasses', '', getdate());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getTaxRates', '', getdate());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getTopLevelCategories', '', getdate());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getZones', '', getdate());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getZonesById', '', getdate());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('insertBooking', '', getdate());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('insertCatalog', '', getdate());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('insertCustomerGroups', '', getdate());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('insertPaymentSchedule', '', getdate());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('insertSubscription', '', getdate());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('insertTagGroup', '', getdate());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('insertTagGroups', '', getdate());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('logMsg', '', getdate());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('login', '', getdate());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('logout', '', getdate());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('resetCustomerPasswordSpecifyingEmail', '', getdate());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('searchForProductsWithOptions', '', getdate());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('sendTemplateEmailToCustomers', '', getdate());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('sendTemplateEmailToCustomers1WithOptions', '', getdate());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('sendTemplateEmailToCustomersWithOptions', '', getdate());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('setConfigurationValue', '', getdate());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('setCreditCardDetailsOnOrder', '', getdate());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('setCustomerPassword', '', getdate());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('setEndpoint', '', getdate());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('setProductAvailabilityWithOptions', '', getdate());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('setProductQuantityWithOptions', '', getdate());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('testDB', '', getdate());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('updateBooking', '', getdate());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('updateCatalog', '', getdate());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('updatePaymentSchedule', '', getdate());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('updateSubscription', '', getdate());

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
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api, store_id) SELECT 'Cache Content', 'CACHE_CONTENT', 'true', 'Set to true to Cache KonaKart Content in memory.', '11', '28', 'choice(''true'', ''false'')', getdate(), '1', store_id FROM configuration WHERE configuration_key = 'STORE_COUNTRY';

-- Config variable to define the location of the exported Mailing Lists
DELETE FROM configuration where configuration_key = 'MAILLISTS_BASE_DIRECTORY';
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order,  date_added, return_by_api, store_id) SELECT 'Exported Mailing List Directory', 'MAILLISTS_BASE_DIRECTORY', 'C:/KonaKart/mailLists', 'Defines the root directory where the Mailing Lists are exported to', '12', '9', getdate(), '1', store_id FROM configuration WHERE configuration_key = 'STORE_COUNTRY';

-- New createMailingList API call
INSERT INTO kk_api_call (name, description, date_added) VALUES ('createMailingList','', getdate());

-- New View Mailing Lists panel
INSERT INTO kk_panel (code, description, date_added) VALUES ('kk_panel_viewMailingLists','View Mailing Lists', getdate());

-- Add View Mailing Lists Panel access to all roles that can access the 'kk_panel_storeConfiguration' panel
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, '1', '1', '1', getdate(), store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_storeConfiguration' and p2.code='kk_panel_viewMailingLists';

-- New Create Mailing Lists panel
INSERT INTO kk_panel (code, description, date_added) VALUES ('kk_panel_createMailingLists','Create Mailing Lists', getdate());

-- Add Create Mailing Lists Panel access to all roles that can access the 'kk_panel_storeConfiguration' panel
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, '1', '1', '1', getdate(), store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_storeConfiguration' and p2.code='kk_panel_createMailingLists';

-- Email output location
DELETE FROM configuration WHERE configuration_key = 'EMAIL_OUTPUT_DIRECTORY';
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, return_by_api, store_id) SELECT 'Email Output Directory', 'EMAIL_OUTPUT_DIRECTORY', 'C:/KonaKart/logs', 'The location where KonaKart will write email output files', '20', '2', getdate(), '1', store_id FROM configuration WHERE configuration_key = 'STORE_COUNTRY';

-- Add extra field to products table to ignore quantity defined in array of productQuantity objects
ALTER TABLE products ADD ignore_prod_qty_stock smallint NOT NULL DEFAULT '0';

-- Suggested search list for each catalog id
DELETE FROM configuration WHERE configuration_key = 'SOLR_ADD_TERM_FOR_CATALOG';
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api, store_id) SELECT 'Add suggested search for catalog','SOLR_ADD_TERM_FOR_CATALOG','false','Adds a suggested search list for each catalog id since the catalog may contain only a subset of products','24', '30', 'choice(''true'', ''false'')', getdate(), '1', store_id FROM configuration WHERE configuration_key = 'STORE_COUNTRY';

DELETE FROM configuration WHERE configuration_key = 'SOLR_ADD_SPELLING_FOR_CATALOG';
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api, store_id) SELECT 'Add spelling suggestions for catalog','SOLR_ADD_SPELLING_FOR_CATALOG','false','Adds spelling suggestions for each catalog id since the catalog may contain only a subset of products','24', '32', 'choice(''true'', ''false'')', getdate(), '1', store_id FROM configuration WHERE configuration_key = 'STORE_COUNTRY';

DELETE FROM configuration WHERE configuration_key = 'SOLR_CATALOG_USED_FOR_PRICE';
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api, store_id) SELECT 'Catalogs used for product prices','SOLR_CATALOG_USED_FOR_PRICE','false','Set to true if catalogs are used to determine product prices','24', '34', 'choice(''true'', ''false'')', getdate(), '0', store_id FROM configuration WHERE configuration_key = 'STORE_COUNTRY';

DELETE FROM configuration WHERE configuration_key = 'SOLR_CATALOG_USED_FOR_QTY';
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api, store_id) SELECT 'Catalogs used for product quantities','SOLR_CATALOG_USED_FOR_QTY','false','Set to true if catalogs are used to determine product quantities','24', '36', 'choice(''true'', ''false'')', getdate(), '0', store_id FROM configuration WHERE configuration_key = 'STORE_COUNTRY';

-- Email Verified flag for Customers
ALTER TABLE customers ADD email_verified smallint NOT NULL DEFAULT 0;

-- Catalog to Category table
DROP TABLE kk_catalog_to_category;
CREATE TABLE kk_catalog_to_category (
  catalog_key varchar(32) NOT NULL,
  categories_id int NOT NULL,
  price_adjustment decimal(15,4),
  fixed_price decimal(15,4),
  exclude smallint DEFAULT 0,
  store_id VARCHAR(64),
  PRIMARY KEY(catalog_key,categories_id)
);

-- Record time catalog is created
ALTER TABLE kk_catalog ADD last_creation_date datetime;

-- New Admin App Panel for generating catalog prices
INSERT INTO kk_panel (code, description, date_added) VALUES ('kk_panel_catalog_prices','Catalog Price Generation', getdate());

-- Add Catalog Prices Panel access to all roles that can access the 'kk_panel_catalogs' panel
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, getdate(), store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_catalogs' and p2.code='kk_panel_catalog_prices';

INSERT INTO kk_api_call (name, description, date_added) VALUES ('addCatalogRules', '', getdate());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('createCatalogPricesFromRules', '', getdate());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getCatalogRules', '', getdate());

-- Custom Filters for Orders
ALTER TABLE orders ADD filter1 VARCHAR(32);
ALTER TABLE orders ADD filter2 VARCHAR(32);
ALTER TABLE orders ADD filterDecimal1 DECIMAL(15,4);

-- Table for Custom Filters
DROP TABLE kk_filter;
CREATE TABLE kk_filter (
  id INT NOT NULL identity(1,1),
  user_id INT NOT NULL,
  filter_table VARCHAR(64),
  filter_column VARCHAR(64),
  filter_constraint VARCHAR(256),
  custom1 VARCHAR(32),
  custom2 VARCHAR(32),
  date_added DATETIME,
  date_updated DATETIME,
  store_id VARCHAR(64),
  PRIMARY KEY(id)
);

CREATE INDEX i_user_id_kk_filter ON kk_filter (user_id);

-- New Admin App Panel for maintaining the filters
INSERT INTO kk_panel (code, description, date_added) VALUES ('kk_panel_filters','Filters', getdate());

-- Add Filter Panel access to all roles that can access the 'kk_panel_storeConfiguration' panel
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, getdate(), store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_storeConfiguration' and p2.code='kk_panel_filters';

-- New Filter APIs
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getFilters', '', getdate());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getFiltersForCustomer', '', getdate());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getFilter', '', getdate());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('insertFilter', '', getdate());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('updateFilter', '', getdate());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('deleteFilter', '', getdate());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('deleteFiltersForCustomer', '', getdate());

-- New API call for deleting promotions
INSERT INTO kk_api_call (name, description, date_added) VALUES ('deletePromotionWithOptions', '', getdate());

-- Set up Custom Panels F as an example
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, getdate(), store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_products' and p2.code='kk_panel_customF';
exit;
