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
-- From version 7.3.0.0 to version 7.4.0.0
-- -----------------------------------------------------------
-- In order to upgrade from versions prior to 7.3.0.0, the upgrade
-- scripts must be run sequentially.
-- 


-- Set database version information
INSERT INTO kk_config (kk_config_key, kk_config_value, date_added) VALUES ('HISTORY', '7.4.0.0 U', getdate());
UPDATE kk_config SET kk_config_value='7.4.0.0 SQLServer', date_added=getdate() WHERE kk_config_key='VERSION';

-- Table for Content Types
-- Table for Content Types
DROP TABLE kk_content_type;
CREATE TABLE kk_content_type (
  id INT NOT NULL identity(1,1),
  content_type_id INT DEFAULT 0 NOT NULL,
  custom1 VARCHAR(32),
  custom2 VARCHAR(32),
  date_added DATETIME,
  store_id VARCHAR(64),
  PRIMARY KEY(id)
);

CREATE INDEX i_content_type_id_kk_content_type ON kk_content_type (content_type_id);

-- Table for Content Type Descriptions
DROP TABLE kk_content_type_desc;
CREATE TABLE kk_content_type_desc (
  id INT NOT NULL identity(1,1),
  content_type_id INT NOT NULL,
  language_id INT NOT NULL,
  content_type_name VARCHAR(32),
  description VARCHAR(256),
  custom1 VARCHAR(32),
  custom2 VARCHAR(32),
  date_added DATETIME,
  store_id VARCHAR(64),
  PRIMARY KEY(id)
);

CREATE INDEX i_content_type_id_kk_content_type_desc ON kk_content_type_desc (content_type_id);

-- Table for Content
DROP TABLE kk_content;
CREATE TABLE kk_content (
  id INT NOT NULL identity(1,1),
  content_id INT DEFAULT 0 NOT NULL,
  content_type_id INT DEFAULT 0 NOT NULL,
  object_id INT,
  obj_type_id INT,
  click_url VARCHAR(256),
  date_from DATETIME,
  date_to DATETIME,
  enabled smallint DEFAULT 0 NOT NULL,
  expression_id INT DEFAULT 0 NOT NULL,
  search_key VARCHAR(128),
  custom1 VARCHAR(32),
  custom2 VARCHAR(32),
  custom3 VARCHAR(32),
  custom4 VARCHAR(32),
  updated_by INT NOT NULL,
  date_updated DATETIME,
  date_added DATETIME,
  store_id VARCHAR(64),
  PRIMARY KEY(id)
);

CREATE INDEX i_content_id_kk_content ON kk_content (content_id);
CREATE INDEX i_search_key_kk_content ON kk_content (search_key);

-- Table for Content Descriptions
DROP TABLE kk_content_desc;
CREATE TABLE kk_content_desc (
  id INT NOT NULL identity(1,1),
  content_id INT NOT NULL,
  language_id INT NOT NULL,
  name1 VARCHAR(256),
  name2 VARCHAR(256),
  name3 VARCHAR(256),
  name4 VARCHAR(256),
  title VARCHAR(256),
  content NVARCHAR(MAX),
  custom1 VARCHAR(32),
  custom2 VARCHAR(32),
  custom3 VARCHAR(32),
  custom4 VARCHAR(32),
  date_added DATETIME,
  store_id VARCHAR(64),
  PRIMARY KEY(id)
);

CREATE INDEX i_content_id_kk_content_desc ON kk_content_desc (content_id);

-- Populate the Content tables
INSERT INTO kk_content_type (content_type_id, date_added, store_id) SELECT 1, getdate(), store_id FROM kk_store;
INSERT INTO kk_content_type (content_type_id, date_added, store_id) SELECT 2, getdate(), store_id FROM kk_store;
INSERT INTO kk_content_type (content_type_id, date_added, store_id) SELECT 3, getdate(), store_id FROM kk_store;
INSERT INTO kk_content_type (content_type_id, date_added, store_id) SELECT 4, getdate(), store_id FROM kk_store;
INSERT INTO kk_content_type (content_type_id, date_added, store_id) SELECT 5, getdate(), store_id FROM kk_store;

INSERT INTO kk_content_type_desc (content_type_id, language_id, content_type_name, description, date_added, store_id) SELECT 1, languages_id, 'Top Banner', 'Top Banner - Top of store home page', getdate(), KKS.store_id FROM kk_store KKS, languages L WHERE KKS.store_id=L.store_id OR L.store_id is null OR L.store_id='';
UPDATE kk_content_type_desc SET content_type_name='Top Banner', description='Top Banner - Top of store Startseite' WHERE content_type_id = 1 AND language_id IN (SELECT languages_id FROM languages WHERE code = 'de');
UPDATE kk_content_type_desc SET content_type_name='Top Banner', description='Top Banner - Inicio de tienda de la página principal' WHERE content_type_id = 1 AND language_id IN (SELECT languages_id FROM languages WHERE code = 'es');
UPDATE kk_content_type_desc SET content_type_name='Top Banner', description='Top Banner - Top of Home Page da loja' WHERE content_type_id = 1 AND language_id in (SELECT languages_id FROM languages WHERE code = 'pt');

INSERT INTO kk_content_type_desc (content_type_id, language_id, content_type_name, description, date_added, store_id) SELECT 2, languages_id, 'Sub Banner', 'Sub Banner - Secondary banner', getdate(), KKS.store_id FROM kk_store KKS, languages L WHERE KKS.store_id=L.store_id OR L.store_id is null OR L.store_id='';
UPDATE kk_content_type_desc SET content_type_name='Sub Banner', description='Sub Banner - Sekundär banner' WHERE content_type_id = 2 AND language_id IN (SELECT languages_id FROM languages WHERE code = 'de');
UPDATE kk_content_type_desc SET content_type_name='Sub Banner', description='Sub Banner - banner Secundaria' WHERE content_type_id = 2 AND language_id IN (SELECT languages_id FROM languages WHERE code = 'es');
UPDATE kk_content_type_desc SET content_type_name='Sub Banner', description='Sub Banner - bandeira Secundário' WHERE content_type_id = 2 AND language_id IN (SELECT languages_id FROM languages WHERE code = 'pt');

INSERT INTO kk_content_type_desc (content_type_id, language_id, content_type_name, description, date_added, store_id) SELECT 3, languages_id, 'Category Banner', 'Category Banner - Top of category pages', getdate(), KKS.store_id FROM kk_store KKS, languages L WHERE KKS.store_id=L.store_id OR L.store_id is null OR L.store_id='';
UPDATE kk_content_type_desc SET content_type_name='Kategorie Banner', description='Kategorie Banner - Top of Kategorieseiten' WHERE content_type_id = 3 AND language_id IN (SELECT languages_id FROM languages WHERE code = 'de');
UPDATE kk_content_type_desc SET content_type_name='Categoria Banner', description='Categoría Banner - Inicio de las páginas de categorías' WHERE content_type_id = 3 AND language_id IN (SELECT languages_id FROM languages WHERE code = 'es');
UPDATE kk_content_type_desc SET content_type_name='Categoria Banner', description='Categoria Banner - Top de páginas da categoria' WHERE content_type_id = 3 AND language_id IN (SELECT languages_id FROM languages WHERE code = 'pt');

INSERT INTO kk_content_type_desc (content_type_id, language_id, content_type_name, description, date_added, store_id) SELECT 4, languages_id, 'Category Sub Banner', 'Category Sub Banner - Secondary Category Banner', getdate(), KKS.store_id FROM kk_store KKS, languages L WHERE KKS.store_id=L.store_id OR L.store_id is null OR L.store_id='';
UPDATE kk_content_type_desc SET content_type_name='Kategorie Unter Banner', description='Kategorie Unter Banner - Sekundäre Kategorie Banner' WHERE content_type_id = 4 AND language_id IN (SELECT languages_id FROM languages WHERE code = 'de');
UPDATE kk_content_type_desc SET content_type_name='Categoría Sub Banner', description='Categoría Sub Banner - Categoría Secundaria Banner' WHERE content_type_id = 4 AND language_id IN (SELECT languages_id FROM languages WHERE code = 'es');
UPDATE kk_content_type_desc SET content_type_name='Categoria Sub Banner', description='Categoria Sub Banner - Categoria Secundária Bandeira' WHERE content_type_id = 4 AND language_id IN (SELECT languages_id FROM languages WHERE code = 'pt');

-- New API calls for Content
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getContents', '', getdate());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getContent', '', getdate());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('insertContent', '', getdate());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('deleteContent', '', getdate());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('updateContent', '', getdate());

INSERT INTO kk_api_call (name, description, date_added) VALUES ('getContentTypes', '', getdate());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getContentType', '', getdate());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('insertContentType', '', getdate());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('deleteContentType', '', getdate());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('updateContentType', '', getdate());

-- New Admin App Panels for Content

INSERT INTO kk_panel (code, description, date_added) VALUES ('kk_panel_contentTypes','Content Types', getdate());

-- Add Content Type Panel access to all roles that can access the 'kk_panel_storeConfiguration' panel
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, getdate(), store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_storeConfiguration' and p2.code='kk_panel_contentTypes';

INSERT INTO kk_panel (code, description, date_added) VALUES ('kk_panel_content','Content', getdate());

-- Add Content Panel access to all roles that can access the 'kk_panel_storeConfiguration' panel
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, getdate(), store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_storeConfiguration' and p2.code='kk_panel_content';

INSERT INTO kk_panel (code, description, date_added) VALUES ('kk_panel_editContent','Edit Content', getdate());

-- Add Content Panel access to all roles that can access the 'kk_panel_storeConfiguration' panel
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, getdate(), store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_storeConfiguration' and p2.code='kk_panel_editContent';

-- Add a search key to categories
ALTER TABLE categories ADD search_key varchar(128);
UPDATE categories SET search_key = categories_name FROM categories_description CD, categories C WHERE C.categories_id = CD.categories_id AND CD.language_id IN (SELECT languages_id FROM languages L, configuration CON WHERE code=configuration_value AND configuration_key='DEFAULT_LANGUAGE');

DELETE FROM configuration WHERE configuration_key = 'ENABLE_KONAKART_CONTENT';
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api, store_id) SELECT 'Enable KonaKart Content', 'ENABLE_KONAKART_CONTENT', 'false', 'When set to true, KonaKart Content is enabled', '1', '10', 'choice(''true'', ''false'')', getdate(), 1, store_id FROM configuration WHERE configuration_key = 'STORE_COUNTRY';

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

exit;
