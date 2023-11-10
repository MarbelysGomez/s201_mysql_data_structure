-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema s201_n1exercise2_pizza_shop
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema s201_n1exercise2_pizza_shop
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `s201_n1exercise2_pizza_shop` DEFAULT CHARACTER SET utf8 ;
USE `s201_n1exercise2_pizza_shop` ;

-- -----------------------------------------------------
-- Table `s201_n1exercise2_pizza_shop`.`province`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `s201_n1exercise2_pizza_shop`.`province` (
  `province_id` INT(10) NOT NULL,
  `province_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`province_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `s201_n1exercise2_pizza_shop`.`location`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `s201_n1exercise2_pizza_shop`.`location` (
  `location_id` INT(10) NOT NULL AUTO_INCREMENT,
  `location_name` VARCHAR(45) NOT NULL,
  `province_province_id` INT(10) NOT NULL,
  PRIMARY KEY (`location_id`),
  INDEX `fk_location_province_idx` (`province_province_id` ASC) ,
  CONSTRAINT `fk_location_province`
    FOREIGN KEY (`province_province_id`)
    REFERENCES `s201_n1exercise2_pizza_shop`.`province` (`province_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `s201_n1exercise2_pizza_shop`.`customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `s201_n1exercise2_pizza_shop`.`customer` (
  `customer_id` INT(10) NOT NULL,
  `customer_name` VARCHAR(45) NOT NULL,
  `customer_last_name` VARCHAR(45) NOT NULL,
  `customer_address` VARCHAR(45) NOT NULL,
  `customer_postal_code` VARCHAR(15) NOT NULL,
  `customer_phone_number` VARCHAR(15) NOT NULL,
  `location_location_id` INT(10) NOT NULL,
  PRIMARY KEY (`customer_id`, `location_location_id`),
  INDEX `fk_customer_location1_idx` (`location_location_id` ASC) ,
  CONSTRAINT `fk_customer_location1`
    FOREIGN KEY (`location_location_id`)
    REFERENCES `s201_n1exercise2_pizza_shop`.`location` (`location_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `s201_n1exercise2_pizza_shop`.`location`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `s201_n1exercise2_pizza_shop`.`location` (
  `location_id` INT(10) NOT NULL AUTO_INCREMENT,
  `location_name` VARCHAR(45) NOT NULL,
  `province_province_id` INT(10) NOT NULL,
  PRIMARY KEY (`location_id`),
  INDEX `fk_location_province_idx` (`province_province_id` ASC) ,
  CONSTRAINT `fk_location_province`
    FOREIGN KEY (`province_province_id`)
    REFERENCES `s201_n1exercise2_pizza_shop`.`province` (`province_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `s201_n1exercise2_pizza_shop`.`delivery_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `s201_n1exercise2_pizza_shop`.`delivery_type` (
  `delivery_type_id` INT(10) NOT NULL AUTO_INCREMENT,
  `delivery_type_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`delivery_type_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `s201_n1exercise2_pizza_shop`.`store`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `s201_n1exercise2_pizza_shop`.`store` (
  `store_id` INT(10) NOT NULL AUTO_INCREMENT,
  `store_address` VARCHAR(45) NOT NULL,
  `store_postal_code` VARCHAR(15) NOT NULL,
  `location_location_id` INT(10) NOT NULL,
  PRIMARY KEY (`store_id`),
  INDEX `fk_store_location1_idx` (`location_location_id` ASC) ,
  CONSTRAINT `fk_store_location1`
    FOREIGN KEY (`location_location_id`)
    REFERENCES `s201_n1exercise2_pizza_shop`.`location` (`location_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `s201_n1exercise2_pizza_shop`.`product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `s201_n1exercise2_pizza_shop`.`product` (
  `product_id` INT(10) NOT NULL AUTO_INCREMENT,
  `product_selection` ENUM('hamburger', 'pizza', 'drink') NOT NULL,
  `product_last_name` VARCHAR(45) NOT NULL,
  `product_description` VARCHAR(255) NOT NULL,
  `product_image` VARCHAR(255) NOT NULL,
  `product_price` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`product_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `s201_n1exercise2_pizza_shop`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `s201_n1exercise2_pizza_shop`.`orders` (
  `orders_id` INT(10) NOT NULL AUTO_INCREMENT,
  `orders_date_time` DATETIME NOT NULL,
  `orders_delivery_type` ENUM('home', 'store') NOT NULL,
  `orders_quantity` INT NOT NULL,
  `orders_price` DECIMAL(10,2) NOT NULL,
  `customer_customer_id` INT(10) NOT NULL,
  `customer_location_location_id` INT(10) NOT NULL,
  `delivery_type_delivery_type_id` INT(10) NOT NULL,
  `store_store_id` INT(10) NOT NULL,
  `product_product_id` INT(10) NOT NULL,
  PRIMARY KEY (`orders_id`, `customer_customer_id`, `customer_location_location_id`, `delivery_type_delivery_type_id`, `store_store_id`),
  INDEX `fk_orders_customer1_idx` (`customer_customer_id` ASC, `customer_location_location_id` ASC) ,
  INDEX `fk_orders_delivery_type1_idx` (`delivery_type_delivery_type_id` ASC) ,
  INDEX `fk_orders_store1_idx` (`store_store_id` ASC) ,
  INDEX `fk_orders_product1_idx` (`product_product_id` ASC) ,
  CONSTRAINT `fk_orders_customer1`
    FOREIGN KEY (`customer_customer_id` , `customer_location_location_id`)
    REFERENCES `s201_n1exercise2_pizza_shop`.`customer` (`customer_id` , `location_location_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_orders_delivery_type1`
    FOREIGN KEY (`delivery_type_delivery_type_id`)
    REFERENCES `s201_n1exercise2_pizza_shop`.`delivery_type` (`delivery_type_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_orders_store1`
    FOREIGN KEY (`store_store_id`)
    REFERENCES `s201_n1exercise2_pizza_shop`.`store` (`store_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_orders_product1`
    FOREIGN KEY (`product_product_id`)
    REFERENCES `s201_n1exercise2_pizza_shop`.`product` (`product_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `s201_n1exercise2_pizza_shop`.`product_category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `s201_n1exercise2_pizza_shop`.`product_category` (
  `product_category_id` INT(10) NOT NULL AUTO_INCREMENT,
  `product_category_name` VARCHAR(45) NULL,
  `product_product_id` INT(10) NOT NULL,
  PRIMARY KEY (`product_category_id`),
  INDEX `fk_product_category_product1_idx` (`product_product_id` ASC) ,
  CONSTRAINT `fk_product_category_product1`
    FOREIGN KEY (`product_product_id`)
    REFERENCES `s201_n1exercise2_pizza_shop`.`product` (`product_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `s201_n1exercise2_pizza_shop`.`pizza_category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `s201_n1exercise2_pizza_shop`.`pizza_category` (
  `pizza_category_id` INT(10) NOT NULL AUTO_INCREMENT,
  `pizza_category_name` VARCHAR(45) NOT NULL,
  `product_category_product_category_id` INT(10) NOT NULL,
  PRIMARY KEY (`pizza_category_id`),
  INDEX `fk_pizza_category_product_category1_idx` (`product_category_product_category_id` ASC) ,
  CONSTRAINT `fk_pizza_category_product_category1`
    FOREIGN KEY (`product_category_product_category_id`)
    REFERENCES `s201_n1exercise2_pizza_shop`.`product_category` (`product_category_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `s201_n1exercise2_pizza_shop`.`employee_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `s201_n1exercise2_pizza_shop`.`employee_type` (
  `employee_type_id` INT(10) NOT NULL,
  `employee_type_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`employee_type_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `s201_n1exercise2_pizza_shop`.`employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `s201_n1exercise2_pizza_shop`.`employee` (
  `employee_id` INT(10) NOT NULL AUTO_INCREMENT,
  `employee_name` VARCHAR(45) NOT NULL,
  `employee_last_name` VARCHAR(45) NOT NULL,
  `employee_nif` VARCHAR(20) NOT NULL,
  `employee_phone_number` VARCHAR(20) NOT NULL,
  `employee_type_employee_type_id` INT(10) NOT NULL,
  `store_store_id` INT(10) NOT NULL,
  PRIMARY KEY (`employee_id`),
  INDEX `fk_employee_employee_type1_idx` (`employee_type_employee_type_id` ASC) ,
  INDEX `fk_employee_store1_idx` (`store_store_id` ASC) ,
  CONSTRAINT `fk_employee_employee_type1`
    FOREIGN KEY (`employee_type_employee_type_id`)
    REFERENCES `s201_n1exercise2_pizza_shop`.`employee_type` (`employee_type_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_employee_store1`
    FOREIGN KEY (`store_store_id`)
    REFERENCES `s201_n1exercise2_pizza_shop`.`store` (`store_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `s201_n1exercise2_pizza_shop`.`delivery`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `s201_n1exercise2_pizza_shop`.`delivery` (
  `delivery_id` INT(10) NOT NULL,
  `delivery_name` VARCHAR(45) NOT NULL,
  `delivery_order` INT(10) NOT NULL,
  `delivery_date_time` DATETIME NOT NULL,
  `orders_orders_id` INT(10) NOT NULL,
  `orders_customer_customer_id` INT(10) NOT NULL,
  `orders_customer_location_location_id` INT(10) NOT NULL,
  `orders_delivery_type_delivery_type_id` INT(10) NOT NULL,
  PRIMARY KEY (`delivery_id`),
  INDEX `fk_delivery_orders1_idx` (`orders_orders_id` ASC, `orders_customer_customer_id` ASC, `orders_customer_location_location_id` ASC, `orders_delivery_type_delivery_type_id` ASC) ,
  CONSTRAINT `fk_delivery_orders1`
    FOREIGN KEY (`orders_orders_id` , `orders_customer_customer_id` , `orders_customer_location_location_id` , `orders_delivery_type_delivery_type_id`)
    REFERENCES `s201_n1exercise2_pizza_shop`.`orders` (`orders_id` , `customer_customer_id` , `customer_location_location_id` , `delivery_type_delivery_type_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
