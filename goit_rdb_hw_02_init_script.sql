-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`non_normalized_table`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`non_normalized_table` (
  `order_number` INT NOT NULL,
  `item_name_and_qty` VARCHAR(255) NULL,
  `client_address` VARCHAR(45) NULL,
  `order_date` DATETIME NULL,
  `client_name` VARCHAR(45) NULL,
  PRIMARY KEY (`order_number`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`first_normalized_table`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`first_normalized_table` (
  `order_number` INT NOT NULL,
  `item_name` VARCHAR(255) NULL,
  `item_qty` INT NULL,
  `client_address` VARCHAR(45) NULL,
  `order_date` DATETIME NULL,
  `client_name` VARCHAR(45) NULL,
  PRIMARY KEY (`order_number`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`second_normalized_orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`second_normalized_orders` (
  `order_number` INT NOT NULL AUTO_INCREMENT,
  `client_name` VARCHAR(45) NULL,
  `client_address` VARCHAR(45) NULL,
  `order_date` DATETIME NULL,
  PRIMARY KEY (`order_number`),
  UNIQUE INDEX `order_number_UNIQUE` (`order_number` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`second_normalized_order_details`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`second_normalized_order_details` (
  `order_number` INT NOT NULL,
  `item_name` VARCHAR(255) NULL,
  `item_qty` INT NULL,
  PRIMARY KEY (`order_number`),
  CONSTRAINT `order_number`
    FOREIGN KEY (`order_number`)
    REFERENCES `mydb`.`second_normalized_orders` (`order_number`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`third_normalized_clients`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`third_normalized_clients` (
  `client_id` INT NOT NULL AUTO_INCREMENT,
  `client_name` VARCHAR(45) NULL,
  `client_address` VARCHAR(45) NULL,
  PRIMARY KEY (`client_id`),
  UNIQUE INDEX `client_id_UNIQUE` (`client_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`third_normalized_orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`third_normalized_orders` (
  `order_number` INT NOT NULL,
  `client_id` INT NULL,
  `order_date` DATETIME NULL,
  PRIMARY KEY (`order_number`),
  INDEX `client_id_idx` (`client_id` ASC) VISIBLE,
  CONSTRAINT `clients`
    FOREIGN KEY (`client_id`)
    REFERENCES `mydb`.`third_normalized_clients` (`client_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`third_normalized_order_details`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`third_normalized_order_details` (
  `order_number` INT NOT NULL,
  `item_name` VARCHAR(255) NULL,
  `item_qty` INT NULL,
  PRIMARY KEY (`order_number`),
  CONSTRAINT `ordernum`
    FOREIGN KEY (`order_number`)
    REFERENCES `mydb`.`third_normalized_orders` (`order_number`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
