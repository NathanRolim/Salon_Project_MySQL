-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `mydb` ;

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`city_state`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`city_state` ;

CREATE TABLE IF NOT EXISTS `mydb`.`city_state` (
  `state_id` INT NOT NULL,
  `city_id` INT NOT NULL,
  `state_name` VARCHAR(2) NOT NULL,
  `city_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`state_id`, `city_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`student`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`student` ;

CREATE TABLE IF NOT EXISTS `mydb`.`student` (
  `student_id` INT NOT NULL,
  `student_name` VARCHAR(45) NOT NULL,
  `student_gender` VARCHAR(1) NOT NULL,
  `student_dob` DATE NOT NULL,
  `city_state_state_id` INT NOT NULL,
  `city_state_city_id` INT NOT NULL,
  PRIMARY KEY (`student_id`),
  INDEX `fk_student_city_state_idx` (`city_state_state_id` ASC, `city_state_city_id` ASC) VISIBLE,
  CONSTRAINT `fk_student_city_state`
    FOREIGN KEY (`city_state_state_id` , `city_state_city_id`)
    REFERENCES `mydb`.`city_state` (`state_id` , `city_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`course`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`course` ;

CREATE TABLE IF NOT EXISTS `mydb`.`course` (
  `course_id` INT NOT NULL,
  `course_name` VARCHAR(45) NOT NULL,
  `course_number` VARCHAR(45) NOT NULL,
  `course_credits` INT NOT NULL,
  `professor_name` VARCHAR(45) NOT NULL,
  `course_year` VARCHAR(45) NOT NULL,
  `course_term` VARCHAR(45) NOT NULL,
  `couser_section` INT NOT NULL,
  `course_capacity` INT NOT NULL,
  PRIMARY KEY (`course_id`, `course_number`, `course_credits`, `professor_name`, `couser_section`, `course_name`, `course_year`, `course_term`, `course_capacity`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`enrollment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`enrollment` ;

CREATE TABLE IF NOT EXISTS `mydb`.`enrollment` (
  `enrollment_id` INT NOT NULL,
  `student_student_id` INT NOT NULL,
  `course_course_number` VARCHAR(45) NOT NULL,
  `course_professor_name` VARCHAR(45) NOT NULL,
  `course_couser_section` INT NOT NULL,
  `course_course_name` VARCHAR(45) NOT NULL,
  `course_course_year` VARCHAR(45) NOT NULL,
  `course_course_term` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`enrollment_id`),
  INDEX `fk_enrollment_student1_idx` (`student_student_id` ASC) VISIBLE,
  INDEX `fk_enrollment_course1_idx` (`course_course_number` ASC, `course_professor_name` ASC, `course_couser_section` ASC, `course_course_name` ASC, `course_course_year` ASC, `course_course_term` ASC) VISIBLE,
  CONSTRAINT `fk_enrollment_student1`
    FOREIGN KEY (`student_student_id`)
    REFERENCES `mydb`.`student` (`student_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_enrollment_course1`
    FOREIGN KEY (`course_course_number` , `course_professor_name` , `course_couser_section` , `course_course_name` , `course_course_year` , `course_course_term`)
    REFERENCES `mydb`.`course` (`course_number` , `professor_name` , `couser_section` , `course_name` , `course_year` , `course_term`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`college_dept`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`college_dept` ;

CREATE TABLE IF NOT EXISTS `mydb`.`college_dept` (
  `college_id` INT NOT NULL,
  `dept_code` INT NOT NULL,
  `dept_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`college_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`catalog`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`catalog` ;

CREATE TABLE IF NOT EXISTS `mydb`.`catalog` (
  `catalog_id` INT NOT NULL,
  `catalog_course_credits` INT NOT NULL,
  `course_course_number` VARCHAR(45) NOT NULL,
  `course_course_name` VARCHAR(45) NOT NULL,
  `college_dept_college_id` INT NOT NULL,
  PRIMARY KEY (`catalog_id`),
  INDEX `fk_catalog_course1_idx` (`course_course_number` ASC, `course_course_name` ASC) VISIBLE,
  INDEX `fk_catalog_college_dept1_idx` (`college_dept_college_id` ASC) VISIBLE,
  CONSTRAINT `fk_catalog_course1`
    FOREIGN KEY (`course_course_number` , `course_course_name`)
    REFERENCES `mydb`.`course` (`course_number` , `course_name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_catalog_college_dept1`
    FOREIGN KEY (`college_dept_college_id`)
    REFERENCES `mydb`.`college_dept` (`college_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`registration`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`registration` ;

CREATE TABLE IF NOT EXISTS `mydb`.`registration` (
  `registration_id` INT NOT NULL AUTO_INCREMENT,
  `college_dept_college_id` INT NOT NULL,
  `course_course_number` VARCHAR(45) NOT NULL,
  `course_course_credits` INT NOT NULL,
  `course_professor_name` VARCHAR(45) NOT NULL,
  `course_couser_section` INT NOT NULL,
  `course_course_name` VARCHAR(45) NOT NULL,
  `course_course_year` VARCHAR(45) NOT NULL,
  `course_course_term` VARCHAR(45) NOT NULL,
  `course_course_capacity` INT NOT NULL,
  PRIMARY KEY (`registration_id`),
  INDEX `fk_registration_college_dept1_idx` (`college_dept_college_id` ASC) VISIBLE,
  INDEX `fk_registration_course1_idx` (`course_course_number` ASC, `course_course_credits` ASC, `course_professor_name` ASC, `course_couser_section` ASC, `course_course_name` ASC, `course_course_year` ASC, `course_course_term` ASC, `course_course_capacity` ASC) VISIBLE,
  CONSTRAINT `fk_registration_college_dept1`
    FOREIGN KEY (`college_dept_college_id`)
    REFERENCES `mydb`.`college_dept` (`college_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_registration_course1`
    FOREIGN KEY (`course_course_number` , `course_course_credits` , `course_professor_name` , `course_couser_section` , `course_course_name` , `course_course_year` , `course_course_term` , `course_course_capacity`)
    REFERENCES `mydb`.`course` (`course_number` , `course_credits` , `professor_name` , `couser_section` , `course_name` , `course_year` , `course_term` , `course_capacity`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
student