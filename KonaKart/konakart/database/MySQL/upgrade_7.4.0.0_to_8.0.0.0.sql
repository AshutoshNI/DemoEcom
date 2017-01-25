#----------------------------------------------------------------
# KonaKart upgrade script from version 7.4.0.0 to version 8.0.0.0
#----------------------------------------------------------------
#
# In order to upgrade from earlier versions the upgrade scripts
# must be run sequentially
#

#MySQL -- For MySQL Only - Diaable Safe Updates Mode
SET SQL_SAFE_UPDATES=0;

# Set database version information
INSERT INTO kk_config (kk_config_key, kk_config_value, date_added) VALUES ('HISTORY', '8.0.0.0 U', now());
UPDATE kk_config SET kk_config_value='8.0.0.0 MySQL', date_added=now() WHERE kk_config_key='VERSION';

# Panels No Longer Used:
DELETE FROM kk_role_to_panel WHERE panel_id = (SELECT panel_id FROM kk_panel WHERE code = 'kk_panel_subZones');
DELETE FROM kk_panel WHERE code = 'kk_panel_subZones';
DELETE FROM kk_role_to_panel WHERE panel_id = (SELECT panel_id FROM kk_panel WHERE code = 'kk_panel_geoZones');
DELETE FROM kk_panel WHERE code = 'kk_panel_geoZones';

# Make the panel name more obvious
UPDATE kk_panel SET description = 'Tax Areas / Geo Zones' WHERE code = 'kk_panel_taxAreas'; 

# Fix API definitions
DELETE FROM kk_role_to_api_call WHERE api_call_id = (SELECT api_call_id FROM kk_api_call WHERE name = 'getOrderRefund');
DELETE FROM kk_api_call WHERE name = 'getOrderRefund';
DELETE FROM kk_role_to_api_call WHERE api_call_id = (SELECT api_call_id FROM kk_api_call WHERE name = 'importCustomer');
DELETE FROM kk_api_call WHERE name = 'importCustomer';
DELETE FROM kk_role_to_api_call WHERE api_call_id = (SELECT api_call_id FROM kk_api_call WHERE name = 'insertGroup');
DELETE FROM kk_api_call WHERE name = 'insertGroup';
DELETE FROM kk_role_to_api_call WHERE api_call_id = (SELECT api_call_id FROM kk_api_call WHERE name = 'insertGroups');
DELETE FROM kk_api_call WHERE name = 'insertGroups';
INSERT INTO kk_api_call (name, description, date_added) VALUES ('addPoints', '', now());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('cloneStore', '', now());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('custom', '', now());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('deleteBooking', '', now());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('deleteCatalog', '', now());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('deletePaymentSchedule', '', now());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('deleteSubscription', '', now());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('doesMallStoreExist', '', now());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('execute', '', now());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getAddressFormats', '', now());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getAllAddressFormats', '', now());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getAllCountriesFull', '', now());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getAllGeoZones', '', now());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getAllLanguages', '', now());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getAllManufacturers', '', now());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getAllOrderStatuses', '', now());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getAllProductOptions', '', now());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getAllTaxClassesFull', '', now());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getAllTaxRates', '', now());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getBookings', '', now());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getCatalogById', '', now());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getCatalogs', '', now());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getCategory', '', now());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getCategoryTree', '', now());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getCountries', '', now());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getCouponCode', '', now());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getCurrencies', '', now());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getCurrency', '', now());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getCustomValidatorSet', '', now());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getDefaultCurrency', '', now());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getDefaultLanguage', '', now());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getEngConf', '', now());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getFiles', '', now());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getGeoZones', '', now());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getHelpMsg', '', now());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getKonakartAdminPropsFilePath', '', now());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getLanguageByCode', '', now());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getLanguages', '', now());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getManufacturer', '', now());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getMsgs', '', now());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getOrderRefunds', '', now());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getOrderStatusNames', '', now());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getPaymentSchedule', '', now());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getPaymentSchedules', '', now());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getProdAttrDescsForTemplates', '', now());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getProductAvailabilityWithOptions', '', now());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getProductCountPerTemplate', '', now());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getProductOptionValuesPerOption', '', now());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getProductQuantityWithOptions', '', now());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getProductWithOptions', '', now());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getRelatedProductsWithOptions', '', now());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getSearchRules', '', now());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getStores', '', now());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getSubZones', '', now());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getSubscription', '', now());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getSubscriptions', '', now());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getTaxClasses', '', now());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getTaxRates', '', now());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getTopLevelCategories', '', now());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getZones', '', now());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getZonesById', '', now());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('insertBooking', '', now());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('insertCatalog', '', now());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('insertCustomerGroups', '', now());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('insertPaymentSchedule', '', now());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('insertSubscription', '', now());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('insertTagGroup', '', now());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('insertTagGroups', '', now());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('logMsg', '', now());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('login', '', now());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('logout', '', now());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('resetCustomerPasswordSpecifyingEmail', '', now());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('searchForProductsWithOptions', '', now());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('sendTemplateEmailToCustomers', '', now());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('sendTemplateEmailToCustomers1WithOptions', '', now());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('sendTemplateEmailToCustomersWithOptions', '', now());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('setConfigurationValue', '', now());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('setCreditCardDetailsOnOrder', '', now());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('setCustomerPassword', '', now());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('setEndpoint', '', now());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('setProductAvailabilityWithOptions', '', now());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('setProductQuantityWithOptions', '', now());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('testDB', '', now());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('updateBooking', '', now());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('updateCatalog', '', now());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('updatePaymentSchedule', '', now());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('updateSubscription', '', now());

# New Custom fields:
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

# Configuration variable to enable/disable Content Caching
DELETE FROM configuration WHERE configuration_key = 'CACHE_CONTENT';
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api, store_id) SELECT 'Cache Content', 'CACHE_CONTENT', 'true', 'Set to true to Cache KonaKart Content in memory.', '11', '28', 'choice(\'true\', \'false\')', now(), '1', store_id FROM configuration WHERE configuration_key = 'STORE_COUNTRY';

# Config variable to define the location of the exported Mailing Lists
DELETE FROM configuration where configuration_key = 'MAILLISTS_BASE_DIRECTORY';
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order,  date_added, return_by_api, store_id) SELECT 'Exported Mailing List Directory', 'MAILLISTS_BASE_DIRECTORY', 'C:/KonaKart/mailLists', 'Defines the root directory where the Mailing Lists are exported to', '12', '9', now(), '1', store_id FROM configuration WHERE configuration_key = 'STORE_COUNTRY';

# New createMailingList API call
INSERT INTO kk_api_call (name, description, date_added) VALUES ('createMailingList','', now());

# New View Mailing Lists panel
INSERT INTO kk_panel (code, description, date_added) VALUES ('kk_panel_viewMailingLists','View Mailing Lists', now());

# Add View Mailing Lists Panel access to all roles that can access the 'kk_panel_storeConfiguration' panel
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, '1', '1', '1', now(), store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_storeConfiguration' and p2.code='kk_panel_viewMailingLists';

# New Create Mailing Lists panel
INSERT INTO kk_panel (code, description, date_added) VALUES ('kk_panel_createMailingLists','Create Mailing Lists', now());

# Add Create Mailing Lists Panel access to all roles that can access the 'kk_panel_storeConfiguration' panel
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, '1', '1', '1', now(), store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_storeConfiguration' and p2.code='kk_panel_createMailingLists';

# Email output location
DELETE FROM configuration WHERE configuration_key = 'EMAIL_OUTPUT_DIRECTORY';
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, return_by_api, store_id) SELECT 'Email Output Directory', 'EMAIL_OUTPUT_DIRECTORY', 'C:/KonaKart/logs', 'The location where KonaKart will write email output files', '20', '2', now(), '1', store_id FROM configuration WHERE configuration_key = 'STORE_COUNTRY';

# Add extra field to products table to ignore quantity defined in array of productQuantity objects  
ALTER TABLE products ADD ignore_prod_qty_stock int(1) NOT NULL DEFAULT '0';

# Suggested search list for each catalog id
DELETE FROM configuration WHERE configuration_key = 'SOLR_ADD_TERM_FOR_CATALOG';
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api, store_id) SELECT 'Add suggested search for catalog','SOLR_ADD_TERM_FOR_CATALOG','false','Adds a suggested search list for each catalog id since the catalog may contain only a subset of products','24', '30', 'choice(\'true\', \'false\')', now(), '1', store_id FROM configuration WHERE configuration_key = 'STORE_COUNTRY';

DELETE FROM configuration WHERE configuration_key = 'SOLR_ADD_SPELLING_FOR_CATALOG';
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api, store_id) SELECT 'Add spelling suggestions for catalog','SOLR_ADD_SPELLING_FOR_CATALOG','false','Adds spelling suggestions for each catalog id since the catalog may contain only a subset of products','24', '32', 'choice(\'true\', \'false\')', now(), '1', store_id FROM configuration WHERE configuration_key = 'STORE_COUNTRY';

DELETE FROM configuration WHERE configuration_key = 'SOLR_CATALOG_USED_FOR_PRICE';
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api, store_id) SELECT 'Catalogs used for product prices','SOLR_CATALOG_USED_FOR_PRICE','false','Set to true if catalogs are used to determine product prices','24', '34', 'choice(\'true\', \'false\')', now(), '0', store_id FROM configuration WHERE configuration_key = 'STORE_COUNTRY';

DELETE FROM configuration WHERE configuration_key = 'SOLR_CATALOG_USED_FOR_QTY';
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api, store_id) SELECT 'Catalogs used for product quantities','SOLR_CATALOG_USED_FOR_QTY','false','Set to true if catalogs are used to determine product quantities','24', '36', 'choice(\'true\', \'false\')', now(), '0', store_id FROM configuration WHERE configuration_key = 'STORE_COUNTRY';

# Email Verified flag for Customers
ALTER TABLE customers ADD COLUMN email_verified INT(1) NOT NULL DEFAULT 0;

# Catalog to Category table
DROP TABLE IF EXISTS kk_catalog_to_category;
CREATE TABLE kk_catalog_to_category (
  catalog_key varchar(32) NOT NULL,
  categories_id int NOT NULL,
  price_adjustment decimal(15,4),
  fixed_price decimal(15,4),
  exclude int(1) DEFAULT '0',
  store_id VARCHAR(64),
  PRIMARY KEY (catalog_key,categories_id)
);

# Record time catalog is created
ALTER TABLE kk_catalog ADD COLUMN last_creation_date datetime;

# New Admin App Panel for generating catalog prices
INSERT INTO kk_panel (code, description, date_added) VALUES ('kk_panel_catalog_prices','Catalog Price Generation', now());

# Add Catalog Prices Panel access to all roles that can access the 'kk_panel_catalogs' panel
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, now(), store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_catalogs' and p2.code='kk_panel_catalog_prices';

INSERT INTO kk_api_call (name, description, date_added) VALUES ('addCatalogRules', '', now());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('createCatalogPricesFromRules', '', now());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getCatalogRules', '', now());

# Custom Filters for Orders
ALTER TABLE orders ADD COLUMN filter1 VARCHAR(32);
ALTER TABLE orders ADD COLUMN filter2 VARCHAR(32);
ALTER TABLE orders ADD COLUMN filterDecimal1 DECIMAL(15,4);

# Table for Custom Filters
DROP TABLE IF EXISTS kk_filter;
CREATE TABLE kk_filter (
   id INT NOT NULL auto_increment,
   user_id INT NOT NULL,
   filter_table VARCHAR(64),
   filter_column VARCHAR(64),
   filter_constraint VARCHAR(256),
   custom1 VARCHAR(32),
   custom2 VARCHAR(32),
   date_added DATETIME,
   date_updated DATETIME,
   store_id VARCHAR(64),
   PRIMARY KEY (id)
);

ALTER TABLE kk_filter ADD KEY idx_user_id (user_id);

# New Admin App Panel for maintaining the filters
INSERT INTO kk_panel (code, description, date_added) VALUES ('kk_panel_filters','Filters', now());

# Add Filter Panel access to all roles that can access the 'kk_panel_storeConfiguration' panel
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, now(), store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_storeConfiguration' and p2.code='kk_panel_filters';

# New Filter APIs
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getFilters', '', now());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getFiltersForCustomer', '', now());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getFilter', '', now());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('insertFilter', '', now());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('updateFilter', '', now());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('deleteFilter', '', now());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('deleteFiltersForCustomer', '', now());

# New API call for deleting promotions
INSERT INTO kk_api_call (name, description, date_added) VALUES ('deletePromotionWithOptions', '', now());

# Set up Custom Panels F as an example
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, now(), store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_products' and p2.code='kk_panel_customF';
