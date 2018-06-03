SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema TPC_FinancialDM
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema TPC_FinancialDM
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `TPC_FinancialDM` DEFAULT CHARACTER SET latin1 ;
USE `TPC_FinancialDM` ;

-- -----------------------------------------------------
-- Table `TPC_FinancialDM`.`customer_dim`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TPC_FinancialDM`.`customer_dim` (
  `customer_SK` INT(11) NOT NULL,
  `customerIDTPCE_NK` INT(11) NULL DEFAULT NULL,
  `name` VARCHAR(50) NULL DEFAULT NULL,
  `addr1` VARCHAR(50) NULL DEFAULT NULL,
  `addr2` VARCHAR(50) NULL DEFAULT NULL,
  `city` VARCHAR(50) NULL DEFAULT NULL,
  `state` VARCHAR(50) NULL DEFAULT NULL,
  `zip` CHAR(5) NULL DEFAULT NULL,
  `typeName` VARCHAR(50) NULL DEFAULT NULL,
  `customerIDTPCW_NK` INT(11) NULL DEFAULT NULL,
  `customerIDPEC_NK` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`customer_SK`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `TPC_FinancialDM`.`orderDate_dim`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TPC_FinancialDM`.`orderDate_dim` (
  `orderDate_SK` INT(11) NOT NULL,
  `order_calendarYear` INT(11) NULL DEFAULT NULL,
  `order_calendarQuarter` INT(11) NULL DEFAULT NULL,
  `order_calendarMonth` INT(11) NULL DEFAULT NULL,
  `order_calendarWeek` INT(11) NULL DEFAULT NULL,
  `order_calendarDay` INT(11) NULL DEFAULT NULL,
  `orderDate_NK` DATE NULL DEFAULT NULL,
  `order_fiscalYear` INT(11) NULL DEFAULT NULL,
  `order_fiscalQuarter` INT(11) NULL DEFAULT NULL,
  `order_fiscalMonth` INT(11) NULL DEFAULT NULL,
  `order_fiscalWeek` INT(11) NULL DEFAULT NULL,
  `order_fiscalDay` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`orderDate_SK`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `TPC_FinancialDM`.`product_dim`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TPC_FinancialDM`.`product_dim` (
  `product_SK` INT(11) NOT NULL,
  `prodIDTPCE_NK` INT(11) NULL DEFAULT NULL,
  `description` VARCHAR(50) NULL DEFAULT NULL,
  `price1` DECIMAL(10,2) NULL DEFAULT NULL,
  `price2` DECIMAL(10,2) NULL DEFAULT NULL,
  `unitCost` DECIMAL(10,2) NULL DEFAULT NULL,
  `typeDescription` VARCHAR(50) NULL DEFAULT NULL,
  `businessUnitName` VARCHAR(50) NULL DEFAULT NULL,
  `supplierName` VARCHAR(50) NULL DEFAULT NULL,
  `supplierAddr1` VARCHAR(50) NULL DEFAULT NULL,
  `supplierAddr2` VARCHAR(50) NULL DEFAULT NULL,
  `supplierCity` VARCHAR(50) NULL DEFAULT NULL,
  `supplierState` VARCHAR(50) NULL DEFAULT NULL,
  `supplierZip` CHAR(5) NULL DEFAULT NULL,
  `prodIDTPCW_NK` INT(11) NULL DEFAULT NULL,
  `prodIDPEC_NK` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`product_SK`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `TPC_FinancialDM`.`saleDate_dim`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TPC_FinancialDM`.`saleDate_dim` (
  `saleDate_SK` INT(11) NOT NULL,
  `sale_calendarYear` INT(11) NULL DEFAULT NULL,
  `sale_calendarQuarter` INT(11) NULL DEFAULT NULL,
  `sale_calendarMonth` INT(11) NULL DEFAULT NULL,
  `sale_calendarWeek` INT(11) NULL DEFAULT NULL,
  `sale_calendarDay` INT(11) NULL DEFAULT NULL,
  `saleDate_NK` DATE NULL DEFAULT NULL,
  `sale_fiscalYear` INT(11) NULL DEFAULT NULL,
  `sale_fiscalQuarter` INT(11) NULL DEFAULT NULL,
  `sale_fiscalMonth` INT(11) NULL DEFAULT NULL,
  `sale_fiscalWeek` INT(11) NULL DEFAULT NULL,
  `sale_fiscalDay` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`saleDate_SK`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `TPC_FinancialDM`.`saleOrderAttributes_dim`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TPC_FinancialDM`.`saleOrderAttributes_dim` (
  `saleOrderAttributes_SK` INT(11) NOT NULL,
  `shippingMethod_NK` VARCHAR(45) NULL DEFAULT NULL,
  `orderMethod_NK` VARCHAR(45) NULL DEFAULT NULL,
  `paymentMethod_NK` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`saleOrderAttributes_SK`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `TPC_FinancialDM`.`saleDetails_fact`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TPC_FinancialDM`.`saleDetails_fact` (
  `customer_SK` INT(11) NOT NULL,
  `product_SK` INT(11) NOT NULL,
  `saleDate_SK` INT(11) NOT NULL,
  `orderDate_SK` INT(11) NOT NULL,
  `saleOrderAttributes_SK` INT(11) NOT NULL,
  `invoiceID(DD)` INT(11) NOT NULL,
  `amt` DECIMAL(10,2) NULL DEFAULT NULL,
  `qty` DECIMAL(8,2) NULL DEFAULT NULL,
  `discounted` TINYINT(4) NULL DEFAULT NULL,
  `division` VARCHAR(4) NULL DEFAULT NULL,
  PRIMARY KEY (`customer_SK`,`product_SK`,`saleDate_SK`,`orderDate_SK`,`saleOrderAttributes_SK`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
