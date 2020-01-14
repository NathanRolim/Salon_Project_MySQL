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
-- Table `mydb`.`location`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`location` ;

CREATE TABLE IF NOT EXISTS `mydb`.`location` (
  `location_id` INT NOT NULL AUTO_INCREMENT,
  `loaction_adress_1` VARCHAR(45) NOT NULL,
  `location_adress_2` VARCHAR(45) NOT NULL,
  `location_city` VARCHAR(45) NOT NULL,
  `location_state` VARCHAR(45) NOT NULL,
  `zip_code` INT NOT NULL,
  PRIMARY KEY (`location_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`natural_view_of_transactions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`natural_view_of_transactions` ;

CREATE TABLE IF NOT EXISTS `mydb`.`natural_view_of_transactions` (
  `transaction_date` DATE NOT NULL,
  `customer_name` VARCHAR(45) NOT NULL,
  `employee_name` VARCHAR(45) NOT NULL,
  `product` VARCHAR(45) NOT NULL,
  `amount_charged` DECIMAL(2) GENERATED ALWAYS AS () VIRTUAL,
  PRIMARY KEY (`customer_name`, `employee_name`, `product`, `transaction_date`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`customer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`customer` ;

CREATE TABLE IF NOT EXISTS `mydb`.`customer` (
  `customer_id` INT NOT NULL,
  `cus_first_name` VARCHAR(45) NOT NULL,
  `cus_last_name` VARCHAR(45) NOT NULL,
  `cus_email` VARCHAR(45) NOT NULL,
  `cus_phone` INT NOT NULL,
  PRIMARY KEY (`customer_id`),
  INDEX `fk_customer_natural_view_of_transactions1_idx` (`cus_first_name` ASC, `cus_last_name` ASC),
  CONSTRAINT `fk_customer_natural_view_of_transactions1`
    FOREIGN KEY (`cus_first_name` , `cus_last_name`)
    REFERENCES `mydb`.`natural_view_of_transactions` (`customer_name` , `customer_name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`employee`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`employee` ;

CREATE TABLE IF NOT EXISTS `mydb`.`employee` (
  `employee_id` INT NOT NULL,
  `emp_first_name` VARCHAR(45) NOT NULL,
  `emp_second_name` VARCHAR(45) NOT NULL,
  `emp_title` VARCHAR(45) NOT NULL,
  `emp_hire_date` DATE NOT NULL,
  `termination_date` VARCHAR(45) NULL,
  `emp_email` VARCHAR(45) NOT NULL,
  `emp_phone` INT(15) NOT NULL,
  `location_location_id` INT NOT NULL,
  PRIMARY KEY (`employee_id`),
  INDEX `fk_employee_location1_idx` (`location_location_id` ASC),
  INDEX `fk_employee_natural_view_of_transactions1_idx` (`emp_first_name` ASC, `emp_second_name` ASC),
  CONSTRAINT `fk_employee_location1`
    FOREIGN KEY (`location_location_id`)
    REFERENCES `mydb`.`location` (`location_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_employee_natural_view_of_transactions1`
    FOREIGN KEY (`emp_first_name` , `emp_second_name`)
    REFERENCES `mydb`.`natural_view_of_transactions` (`employee_name` , `employee_name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`product`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`product` ;

CREATE TABLE IF NOT EXISTS `mydb`.`product` (
  `product_id` INT NOT NULL AUTO_INCREMENT,
  `product_name` VARCHAR(45) NOT NULL,
  `product_type` VARCHAR(45) NOT NULL,
  `product_unit_size` VARCHAR(45) NULL,
  `product_price` DECIMAL(2) NOT NULL,
  PRIMARY KEY (`product_id`),
  INDEX `fk_product_natural_view_of_transactions1_idx` (`product_name` ASC, `product_type` ASC, `product_unit_size` ASC, `product_price` ASC),
  CONSTRAINT `fk_product_natural_view_of_transactions1`
    FOREIGN KEY (`product_name` , `product_type` , `product_unit_size` , `product_price`)
    REFERENCES `mydb`.`natural_view_of_transactions` (`product` , `product` , `product` , `product`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`transaction`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`transaction` ;

CREATE TABLE IF NOT EXISTS `mydb`.`transaction` (
  `transaction_id` INT NOT NULL AUTO_INCREMENT,
  `transaction_date` DATE NOT NULL,
  `customer_customer_id` INT NOT NULL,
  `employee_employee_id` INT NOT NULL,
  PRIMARY KEY (`transaction_id`),
  INDEX `fk_transaction_customer1_idx` (`customer_customer_id` ASC),
  INDEX `fk_transaction_employee1_idx` (`employee_employee_id` ASC),
  INDEX `fk_transaction_natural_view_of_transactions1_idx` (`transaction_date` ASC),
  CONSTRAINT `fk_transaction_customer1`
    FOREIGN KEY (`customer_customer_id`)
    REFERENCES `mydb`.`customer` (`customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_transaction_employee1`
    FOREIGN KEY (`employee_employee_id`)
    REFERENCES `mydb`.`employee` (`employee_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_transaction_natural_view_of_transactions1`
    FOREIGN KEY (`transaction_date`)
    REFERENCES `mydb`.`natural_view_of_transactions` (`transaction_date`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`transaction_detail`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`transaction_detail` ;

CREATE TABLE IF NOT EXISTS `mydb`.`transaction_detail` (
  `trasaction_detail_id` INT NOT NULL AUTO_INCREMENT,
  `transaction_detail_id_quantity` INT NOT NULL,
  `transaction_transaction_id` INT NOT NULL,
  `product_product_id` INT NOT NULL,
  PRIMARY KEY (`trasaction_detail_id`),
  INDEX `fk_transaction_detail_transaction1_idx` (`transaction_transaction_id` ASC),
  INDEX `fk_transaction_detail_product1_idx` (`product_product_id` ASC),
  CONSTRAINT `fk_transaction_detail_transaction1`
    FOREIGN KEY (`transaction_transaction_id`)
    REFERENCES `mydb`.`transaction` (`transaction_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_transaction_detail_product1`
    FOREIGN KEY (`product_product_id`)
    REFERENCES `mydb`.`product` (`product_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;