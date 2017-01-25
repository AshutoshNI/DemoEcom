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
-- From version 8.1.0.0 to version 8.3.0.0
-- -----------------------------------------------------------
-- In order to upgrade from versions prior to 8.1.0.0, the upgrade
-- scripts must be run sequentially.
-- 


-- Set database version information
set echo on
INSERT INTO kk_config (kk_config_id, kk_config_key, kk_config_value, date_added) VALUES (NEXTVAL FOR kk_config_seq, 'HISTORY', '8.3.0.0 U', current timestamp);
UPDATE kk_config SET kk_config_value='8.3.0.0 DB2', date_added=current timestamp WHERE kk_config_key='VERSION';

-- Add parent id to customers
ALTER TABLE customers ADD parent_id int DEFAULT 0 NOT NULL;

-- New API calls
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'addChildrenToCustomer', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getCustomerForEmailWithOptions', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getCustomerForIdWithOptions', '', current timestamp);

-- New Order Total fields
ALTER TABLE orders_total ADD promotion_id int DEFAULT 0 NOT NULL;
ALTER TABLE orders_total ADD discount_amount decimal(15,4);
ALTER TABLE orders_total ADD discount_percent decimal(15,4);

-- Name Format
ALTER TABLE address_format ADD name_format varchar(255);
UPDATE address_format SET name_format = '$firstname $lastname';

-- For Setting the default customer name format template
DELETE FROM configuration WHERE configuration_key = 'NAME_FORMAT_TEMPLATE';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, return_by_api, store_id) SELECT nextval for configuration_seq, 'Name format template', 'NAME_FORMAT_TEMPLATE', '$firstname $lastname', 'The default template used for formatting a customer name', 5, 20, current timestamp, 1, store_id FROM configuration WHERE configuration_key = 'STORE_COUNTRY';


------------------------------------------------------------------
-- ERP XML Interface

INSERT INTO configuration_group VALUES (nextval for configuration_group_seq, 'User Defined', 'User Defined Configuration', 31, 1, null);
INSERT INTO configuration_group VALUES (nextval for configuration_group_seq, 'ERP Integration', 'ERP Integration Configuration', 32, 1, null);

-- Configuration variable for log directories
DELETE FROM configuration where configuration_key = 'ERP_INT_LOG_BASE_PATH_OK';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order,  date_added, return_by_api, store_id) SELECT nextval for configuration_seq, 'Msg Log Directory Good', 'ERP_INT_LOG_BASE_PATH_OK', CONCAT(configuration_value, '/mq_logs/success'), 'Defines the directory where the log file is written for messages that are processed correctly', 32, 12, current timestamp, 1, store_id FROM configuration WHERE configuration_key = 'INSTALLATION_HOME';

DELETE FROM configuration where configuration_key = 'ERP_INT_INTEGRATION_ENABLED';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api, store_id) SELECT nextval for configuration_seq, 'ERP Integration Enabled?', 'ERP_INT_INTEGRATION_ENABLED', CONCAT(configuration_value, 'false'), 'Set to true to enable ERP Integration', 32, 5, 'choice(''true'', ''false'')', current timestamp, 1, store_id FROM configuration WHERE configuration_key = 'INSTALLATION_HOME';

DELETE FROM configuration where configuration_key = 'ERP_INT_LOG_BASE_PATH_KO';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order,  date_added, return_by_api, store_id) SELECT nextval for configuration_seq, 'Msg Log Directory Failed', 'ERP_INT_LOG_BASE_PATH_KO', CONCAT(configuration_value, '/mq_logs/failure'), 'Defines the directory where the log file is written for messages that cannot be processed', 32, 20, current timestamp, 1, store_id FROM configuration WHERE configuration_key = 'INSTALLATION_HOME';

-- Configuration variables for sending log if a message fails
DELETE FROM configuration where configuration_key = 'ERP_INT_LOG_KO_EMAIL_ADDR';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order,  date_added, return_by_api, store_id) SELECT nextval for configuration_seq, 'Email Address for Failed messages', 'ERP_INT_LOG_KO_EMAIL_ADDR', 'admin@konakart.com', 'Defines the email address where logs are sent when a message fails', 32, 30, current timestamp, 1, store_id FROM configuration WHERE configuration_key = 'INSTALLATION_HOME';

DELETE FROM configuration where configuration_key = 'ERP_INT_LOG_KO_EMAIL_TEMPLATE';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order,  date_added, return_by_api, store_id) SELECT nextval for configuration_seq, 'Template for failed msg email', 'ERP_INT_LOG_KO_EMAIL_TEMPLATE', 'ERPIntegrationErrorNotification_en.vm', 'The velocity email template for failed messages. Template name includes country code.', 32, 31, current timestamp, 1, store_id FROM configuration WHERE configuration_key = 'INSTALLATION_HOME';

-- Configuration variable for ERP Invoice directory
DELETE FROM configuration where configuration_key = 'ERP_INT_INVOICE_PATH';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order,  date_added, return_by_api, store_id) SELECT nextval for configuration_seq, 'ERP Invoice Path', 'ERP_INT_INVOICE_PATH', '', 'Defines the directory where the ERP invoices can be found. Ignored if the path is included in the message', 32, 40, current timestamp, 1, store_id FROM configuration WHERE configuration_key = 'INSTALLATION_HOME';

-- Configuration variable for ERP Invoice Email Velocity template
DELETE FROM configuration where configuration_key = 'ERP_INT_INVOICE_EMAIL_TEMPLATE';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order,  date_added, return_by_api, store_id) SELECT nextval for configuration_seq, 'ERP Invoice template', 'ERP_INT_INVOICE_EMAIL_TEMPLATE', 'ERPIntegrationOrderInvoice_en.vm', 'Defines the velocity template for the email sent to the customer. Ignored if the template is included in the message. Country code is determined from the locale of the order if left out.', 32, 50, current timestamp, 1, store_id FROM configuration WHERE configuration_key = 'INSTALLATION_HOME';

-- New Admin App Panel for ERP Integration Configuration
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq, 'kk_panel_erpConfig','ERP Integration Configuration', current timestamp);

-- Add ERP Integration Config Panel access to all roles that can access the 'kk_panel_storeConfiguration' panel
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, current timestamp, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_storeConfiguration' and p2.code='kk_panel_erpConfig';

-- Password expiry
ALTER TABLE customers ADD password_change INTEGER DEFAULT 0 NOT NULL;
ALTER TABLE customers ADD password_expiry TIMESTAMP;

-- Define how long a new temporary password is valid when sent out to customer who has forgotten his password
DELETE FROM configuration where configuration_key = 'TEMP_PASSWORD_VALID_TIME_MINS';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, store_id) SELECT nextval for configuration_seq, 'Valid time (mins) for temp password', 'TEMP_PASSWORD_VALID_TIME_MINS', '30', 'Defines the number of minutes a temporary password sent out in an email is valid for', 18, 20, 'integer(null,null)', current timestamp, store_id FROM configuration WHERE configuration_key = 'STORE_COUNTRY';

-- Add attributes to promotions
ALTER TABLE promotion ADD total_max_use int NOT NULL DEFAULT -1;
ALTER TABLE promotion ADD times_used int NOT NULL DEFAULT 0;

-- Defines order states to include for displaying customer orders
DELETE FROM configuration WHERE configuration_key = 'ORDER_DISPLAY_STATUS_IDS';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, return_by_api, store_id) SELECT nextval for configuration_seq, 'Status Ids of orders to display','ORDER_DISPLAY_STATUS_IDS','','Comma separated list of order status ids that will be displayed to customers. All orders displayed if empty.',9, 50, current timestamp, 1, store_id FROM configuration WHERE configuration_key = 'STORE_COUNTRY';

-- Add an index for the products_id column on the specials table
CREATE INDEX i_pr_1ae78b3d943fb ON specials (products_id);

-- Add an index for the customers_id column on the kk_customers_to_tag table
CREATE INDEX i_cu_3cde8a250bb43 ON kk_customers_to_tag (customers_id);

-- New order attributes
ALTER TABLE orders ADD admin_discount decimal(15,4);
ALTER TABLE orders ADD archive_id VARCHAR(128);

-- Defines order states to exclude for displaying customer orders
DELETE FROM configuration WHERE configuration_key = 'ORDER_DISPLAY_EXCLUDE_STATUS_IDS';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, return_by_api, store_id) SELECT nextval for configuration_seq, 'Status Ids of orders to not display','ORDER_DISPLAY_EXCLUDE_STATUS_IDS','','Comma separated list of order status ids that will not be displayed to customers. All orders displayed if empty.',9, 55, current timestamp, 1, store_id FROM configuration WHERE configuration_key = 'STORE_COUNTRY';


-- Used in storefront to allow an administrator to edit an order
DELETE FROM configuration WHERE configuration_key = 'ALLOW_EDIT_ORDER';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api, store_id) SELECT nextval for configuration_seq, 'Allow admin to edit customer order','ALLOW_EDIT_ORDER','false','When true, an administrator logging in as a customer can edit a customer order',1, 45, 'choice(''true'', ''false'')', current timestamp, 1, store_id FROM configuration WHERE configuration_key = 'STORE_COUNTRY';

-- Used in storefront to allow an administrator to introduce a discount
DELETE FROM configuration WHERE configuration_key = 'ALLOW_ADMIN_ORDER_DISCOUNT';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api, store_id) SELECT nextval for configuration_seq, 'Allow admin to discount customer order','ALLOW_ADMIN_ORDER_DISCOUNT','false','When true, an administrator logging in as a customer can add a discount to a customer order',1, 50, 'choice(''true'', ''false'')', current timestamp, 1, store_id FROM configuration WHERE configuration_key = 'STORE_COUNTRY';

-- Allow NULLs in tag_value
ALTER TABLE kk_expression_variable ALTER COLUMN tag_value DROP NOT NULL;

-- For DB2 Only - Required after setting field to nullable
call SYSPROC.ADMIN_CMD ('REORG TABLE kk_expression_variable');


exit;
