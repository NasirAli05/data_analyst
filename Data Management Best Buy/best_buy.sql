-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema bestbuy
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema bestbuy
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `bestbuy` DEFAULT CHARACTER SET utf8 ;
USE `bestbuy` ;

-- -----------------------------------------------------
-- Table `bestbuy`.`Brands`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bestbuy`.`Brands` (
  `BrandID` INT NOT NULL AUTO_INCREMENT,
  `BrandName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`BrandID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bestbuy`.`Product Category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bestbuy`.`Product Category` (
  `CategoryID` INT NOT NULL AUTO_INCREMENT,
  `CategoryName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`CategoryID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bestbuy`.`Product Details`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bestbuy`.`Product Details` (
  `ProductID` INT NOT NULL AUTO_INCREMENT,
  `ProductName` VARCHAR(45) NOT NULL,
  `Price` INT NOT NULL,
  `BrandID` INT NOT NULL,
  PRIMARY KEY (`ProductID`),
  INDEX `BrandID_idx` (`BrandID` ASC) VISIBLE,
  CONSTRAINT `BrandID`
    FOREIGN KEY (`BrandID`)
    REFERENCES `bestbuy`.`Brands` (`BrandID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bestbuy`.`customer details`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bestbuy`.`customer details` (
  `TransactionID` INT NOT NULL AUTO_INCREMENT,
  `CustomerID` INT NOT NULL,
  `PurchasePrice` INT NOT NULL,
  `CustomerName` VARCHAR(45) NULL,
  `LocationName` VARCHAR(45) NULL,
  PRIMARY KEY (`TransactionID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bestbuy`.`Order Record`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bestbuy`.`Order Record` (
  `OrderID` INT NOT NULL AUTO_INCREMENT,
  `CustomerID` INT NOT NULL,
  `ProductID` INT NULL,
  `Quantity` INT NULL,
  `OrderDate` DATE NULL,
  `TotalAmount` INT NULL,
  `CategoryID` INT NOT NULL,
  PRIMARY KEY (`OrderID`),
  UNIQUE INDEX `CustomerID_UNIQUE` (`CustomerID` ASC) VISIBLE,
  INDEX `CategoryID_idx` (`CategoryID` ASC) VISIBLE,
  CONSTRAINT `CategoryID2`
    FOREIGN KEY (`CategoryID`)
    REFERENCES `bestbuy`.`Product Category` (`CategoryID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bestbuy`.`Employees Location`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bestbuy`.`Employees Location` (
  `LocationID` INT NOT NULL AUTO_INCREMENT,
  `Location` VARCHAR(45) NULL,
  PRIMARY KEY (`LocationID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bestbuy`.`Employees Record`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bestbuy`.`Employees Record` (
  `EmployeeID` INT NOT NULL,
  `FirstName` VARCHAR(45) NULL,
  `LastName` VARCHAR(45) NULL,
  `Gender` VARCHAR(45) NULL,
  `Position` VARCHAR(45) NULL,
  `Department` VARCHAR(45) NULL,
  `Salary` INT NULL,
  `LocationID` INT NOT NULL,
  PRIMARY KEY (`EmployeeID`),
  INDEX `LocationID_idx` (`LocationID` ASC) VISIBLE,
  CONSTRAINT `LocationID`
    FOREIGN KEY (`LocationID`)
    REFERENCES `bestbuy`.`Employees Location` (`LocationID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bestbuy`.`Employees Schedule`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bestbuy`.`Employees Schedule` (
  `ScheduleID` INT NOT NULL,
  `EmployeeID` INT NOT NULL,
  `StartTime` TIME NULL,
  `EndTime` TIME NULL,
  `ShiftType` VARCHAR(45) NULL,
  `LocationID` INT NULL,
  PRIMARY KEY (`ScheduleID`),
  INDEX `EmployeeID_idx` (`EmployeeID` ASC) VISIBLE,
  CONSTRAINT `EmployeeID`
    FOREIGN KEY (`EmployeeID`)
    REFERENCES `bestbuy`.`Employees Record` (`EmployeeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bestbuy`.`Social Media Presence`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bestbuy`.`Social Media Presence` (
  `SocialMediaID` INT NOT NULL,
  `Platform` VARCHAR(45) NULL,
  `Followers` INT NULL,
  PRIMARY KEY (`SocialMediaID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bestbuy`.`store table`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bestbuy`.`store table` (
  `StoreID` INT NOT NULL AUTO_INCREMENT,
  `StoreName` VARCHAR(45) NULL,
  `Location` VARCHAR(45) NULL,
  `SocialMediaID` INT NULL,
  PRIMARY KEY (`StoreID`),
  INDEX `SocialM_idx` (`SocialMediaID` ASC) VISIBLE,
  CONSTRAINT `SocialM`
    FOREIGN KEY (`SocialMediaID`)
    REFERENCES `bestbuy`.`Social Media Presence` (`SocialMediaID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bestbuy`.`Inventory product details`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bestbuy`.`Inventory product details` (
  `InventoryID` INT NOT NULL,
  `StoreID` INT NOT NULL,
  `ProductName` VARCHAR(45) NULL,
  `QuantityInStock` INT NULL,
  PRIMARY KEY (`InventoryID`),
  INDEX `StoreID_idx` (`StoreID` ASC) VISIBLE,
  CONSTRAINT `StoreID2`
    FOREIGN KEY (`StoreID`)
    REFERENCES `bestbuy`.`store table` (`StoreID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bestbuy`.`Product Rating`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bestbuy`.`Product Rating` (
  `RatingID` INT NOT NULL,
  `ProductID` INT NULL,
  `RatingValue` DECIMAL(1) NULL,
  `TransactionID` INT NOT NULL,
  PRIMARY KEY (`RatingID`),
  INDEX `TransactionID_idx` (`TransactionID` ASC) VISIBLE,
  CONSTRAINT `TransactionID`
    FOREIGN KEY (`TransactionID`)
    REFERENCES `bestbuy`.`customer details` (`TransactionID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
