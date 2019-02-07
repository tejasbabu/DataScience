create database hcad;
use hcad;

CREATE TABLE `hcad`.`real_acct` (
  `Account` INT NOT NULL,
  `TaxYear` INT NULL,
  `Mailto` VARCHAR(450) NULL,
  `MailAddr` VARCHAR(450) NULL,
  `City` VARCHAR(100) NULL,
  `State` VARCHAR(100) NULL,
  `zipcode` VARCHAR(45) NULL,
  `Neighbourhood` VARCHAR(45) NULL,
  `Total_land` INT NULL,
  `LandValue` FLOAT NULL,
  `Assessed_value` FLOAT NULL,
  PRIMARY KEY (`Account`));


use hcad;
ALTER TABLE real_Acct MODIFY COLUMN Account BIGINT ;	

CREATE TABLE `hcad`.`owner` (
  `Account` INT NOT NULL,
  `Name` VARCHAR(450) NULL,
  PRIMARY KEY (`Account`));

use hcad;
ALTER TABLE owner MODIFY COLUMN Account BIGINT ;


CREATE TABLE `hcad`.`deeds` (
  `Account` INT NOT NULL,
  `DateOfSale` VARCHAR(15) NULL,
  `Clerk_id` VARCHAR(45) NULL,
  `deed_id` VARCHAR(2) NULL,
  PRIMARY KEY (`Account`));

use hcad;
ALTER TABLE deeds MODIFY COLUMN Account BIGINT ;


CREATE TABLE `hcad`.`neighbourhood` (
  `neighbourhood_cd` DECIMAL(8,2) NOT NULL,
  `group_cd` INT(11) NULL,
  `description` VARCHAR(300) NULL,
  PRIMARY KEY (`neighbourhood_cd`));

###Once you load data using Jupyter notebook then run below sql statement.
Use hcad;
delete from neighbourhood where description = ' ';
commit;

CREATE TABLE `hcad`.`business_acct` (
  `ACCOUNT` BIGINT(32) NOT NULL,
  `TAX_YEAR` INT NULL,
  `O_NAME` VARCHAR(400) NULL,
  `OWNER` VARCHAR(400) NULL,
  `SITE_ADDRESS` VARCHAR(400) NULL,
  `SITE_CITY` VARCHAR(400) NULL,
  `SITE_STATE` VARCHAR(400) NULL,
  `APPRAISED_VALUE` VARCHAR(100) NULL,
  `PRIOR_APPRAISED_VALUE` VARCHAR(100) NULL,
  PRIMARY KEY (`ACCOUNT`));

###Once you load data clean up APPRAISED_VALUE using below statement

SET SQL_SAFE_UPDATES = 0;
delete  FROM hcad.business_acct where Appraised_value like 'Y%';
delete   FROM hcad.business_acct  where appraised_value = ' ';
delete   FROM hcad.business_acct  where appraised_value like  'L%';
delete   FROM hcad.business_acct  where appraised_value like  'I%';
delete from hcad.real_acct where zipcode like '-%';
delete from hcad.real_acct where zipcode = ' ';
commit;

ALTER TABLE `hcad`.`business_acct` 
CHANGE COLUMN `APPRAISED_VALUE` `APPRAISED_VALUE` INT(11) NULL DEFAULT NULL ;

ALTER TABLE `hcad`.`business_acct` 
CHANGE COLUMN `PRIOR_APPRAISED_VALUE` `PRIOR_APPRAISED_VALUE` INT(11) NULL DEFAULT NULL ;

CREATE TABLE `hcad`
.`business_detail` (
  `Account` INT(11) NOT NULL,
  `Dept_code` VARCHAR(15) NULL,
  `Dept_code_de` VARCHAR(150) NULL,
  PRIMARY KEY (`Account`));

CREATE TABLE `hcad`.`exempt_data` (
  `Account` INT(11) NOT NULL,
  `Tax_dist` INT(11) NULL,
  `Tax_dist_name` VARCHAR(400) NULL,
  `Exempt_cat` VARCHAR(45) NULL,
  `Exempt_dsc` VARCHAR(45) NULL,
  PRIMARY KEY (`Account`));
  
  CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `hcad`.`investment` AS
    SELECT 
        (SUM(`hcad`.`real_acct`.`LandValue`) / 100000) AS `Value`,
        `hcad`.`real_acct`.`City` AS `city`
    FROM
        `hcad`.`real_acct`
    WHERE
        (`hcad`.`real_acct`.`City` <> 'HOUSTON')
    GROUP BY `hcad`.`real_acct`.`City`
    HAVING ((SUM(`hcad`.`real_acct`.`LandValue`) / 100000) > 100);
	
	USE `hcad`;
CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `hcad`.`assesssedvalue` AS
    SELECT 
        (SUM(`hcad`.`real_acct`.`Assessed_value`) / 100000) AS `sum(Assessed_value)/100000`,
        `hcad`.`real_acct`.`zipcode` AS `zipcode`
    FROM
        `hcad`.`real_acct`
    GROUP BY `hcad`.`real_acct`.`zipcode`
    HAVING ((SUM(`hcad`.`real_acct`.`Assessed_value`) / 100000) > 1000
	
CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `hcad`.`appraisedvalue` AS
    SELECT 
        (SUM(`hcad`.`business_acct`.`APPRAISED_VALUE`) / 100000) AS `sum(APPRAISED_VALUE)`,
        `hcad`.`business_acct`.`SITE_CITY` AS `city`
    FROM
        `hcad`.`business_acct`
    WHERE
        ((`hcad`.`business_acct`.`SITE_CITY` <> ' ')
            AND (`hcad`.`business_acct`.`SITE_CITY` <> 'HOUSTON'))
    GROUP BY `hcad`.`business_acct`.`SITE_CITY`
    HAVING ((SUM(`hcad`.`business_acct`.`APPRAISED_VALUE`) / 100000) > 1000);