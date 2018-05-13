ALTER TABLE %PREFIX%trades
ADD COLUMN `planet_id` INT(11) NULL DEFAULT NULL AFTER `ex_resource_amount`;

ALTER TABLE %PREFIX%trades
ADD COLUMN `trade_fleet_array` TEXT NULL DEFAULT NULL ;

ALTER TABLE %PREFIX%trades
CHANGE COLUMN `seller_fleet_id` `seller_fleet_id` BIGINT(11) UNSIGNED NULL DEFAULT '0' ,
DROP PRIMARY KEY,
ADD PRIMARY KEY (`trade_id`);


ALTER TABLE %PREFIX%trades
ADD COLUMN `trade_id` INT NOT NULL AUTO_INCREMENT AFTER `trade_fleet_array`,
DROP PRIMARY KEY,
ADD PRIMARY KEY (`seller_fleet_id`, `trade_id`),
ADD UNIQUE INDEX `trade_id_UNIQUE` (`trade_id` ASC);


ALTER TABLE %PREFIX%trades
ADD COLUMN `resource_metal` DOUBLE(50,0) NULL AFTER `trade_id`,
ADD COLUMN `resource_crystal` DOUBLE(50,0) NULL AFTER `resource_metal`,
ADD COLUMN `resource_deuterium` DOUBLE(50,0) NULL AFTER `resource_crystal`;
