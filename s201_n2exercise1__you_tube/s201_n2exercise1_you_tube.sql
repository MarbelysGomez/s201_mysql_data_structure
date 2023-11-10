-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema s201_n2exercise_you_tube
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema s201_n2exercise_you_tube
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `s201_n2exercise_you_tube` DEFAULT CHARACTER SET utf8 ;
USE `s201_n2exercise_you_tube` ;

-- -----------------------------------------------------
-- Table `s201_n2exercise_you_tube`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `s201_n2exercise_you_tube`.`user` (
  `user_id` INT(10) NOT NULL AUTO_INCREMENT,
  `user_email` VARCHAR(255) NOT NULL,
  `user_password` VARCHAR(255) NOT NULL,
  `user_name` VARCHAR(45) NOT NULL,
  `user_birth_date` DATE NOT NULL,
  `user_sex` ENUM('female', 'male', 'other') NOT NULL,
  `user_country` VARCHAR(45) NOT NULL,
  `user_postal_code` INT(5) NULL,
  `user_postage_collection` INT NULL,
  PRIMARY KEY (`user_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `s201_n2exercise_you_tube`.`channel`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `s201_n2exercise_you_tube`.`channel` (
  `channel_id` INT(10) NOT NULL AUTO_INCREMENT,
  `channel_name` VARCHAR(45) NOT NULL,
  `channel_description` VARCHAR(45) NOT NULL,
  `channel_creation_date` TIMESTAMP NOT NULL,
  PRIMARY KEY (`channel_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `s201_n2exercise_you_tube`.`video`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `s201_n2exercise_you_tube`.`video` (
  `video_id` INT(10) NOT NULL AUTO_INCREMENT,
  `video_title` VARCHAR(255) NOT NULL,
  `video_description` TEXT NOT NULL,
  `video_size` INT NOT NULL,
  `video_file_name` VARCHAR(45) NOT NULL,
  `video_length` TIME NOT NULL,
  `video_thumbnail` VARCHAR(45) NOT NULL,
  `video_number_of_reproductions` INT NOT NULL,
  `video_number_of_likes` INT NOT NULL,
  `video_number_of_dislikes` INT NOT NULL,
  `video_status` ENUM('public', 'hide', 'private') NOT NULL,
  `video_release` DATETIME NOT NULL,
  `channel_channel_id` INT(10) NOT NULL,
  PRIMARY KEY (`video_id`),
  INDEX `fk_video_channel_idx` (`channel_channel_id` ASC) ,
  CONSTRAINT `fk_video_channel`
    FOREIGN KEY (`channel_channel_id`)
    REFERENCES `s201_n2exercise_you_tube`.`channel` (`channel_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `s201_n2exercise_you_tube`.`tag`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `s201_n2exercise_you_tube`.`tag` (
  `tag_id` INT(10) NOT NULL AUTO_INCREMENT,
  `tag_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`tag_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `s201_n2exercise_you_tube`.`video_tag`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `s201_n2exercise_you_tube`.`video_tag` (
  `video_tag_id` INT(10) NOT NULL AUTO_INCREMENT,
  `tag_tag_id` INT(10) NOT NULL,
  `video_video_id` INT(10) NOT NULL,
  PRIMARY KEY (`video_tag_id`, `tag_tag_id`, `video_video_id`),
  INDEX `fk_video_tag_tag1_idx` (`tag_tag_id` ASC) ,
  INDEX `fk_video_tag_video1_idx` (`video_video_id` ASC) ,
  CONSTRAINT `fk_video_tag_tag1`
    FOREIGN KEY (`tag_tag_id`)
    REFERENCES `s201_n2exercise_you_tube`.`tag` (`tag_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_video_tag_video1`
    FOREIGN KEY (`video_video_id`)
    REFERENCES `s201_n2exercise_you_tube`.`video` (`video_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `s201_n2exercise_you_tube`.`like_dislike`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `s201_n2exercise_you_tube`.`like_dislike` (
  `like_dislike_id` INT NOT NULL AUTO_INCREMENT,
  `like_dislike_like` TINYINT(1) NOT NULL,
  `like_dislike_dislike` TINYINT(1) NOT NULL,
  `like_dislike_date_time` DATETIME NOT NULL,
  `video_video_id` INT(10) NOT NULL,
  `user_user_id` INT(10) NOT NULL,
  PRIMARY KEY (`like_dislike_id`),
  INDEX `fk_like_dislike_video1_idx` (`video_video_id` ASC) ,
  INDEX `fk_like_dislike_user1_idx` (`user_user_id` ASC) ,
  CONSTRAINT `fk_like_dislike_video1`
    FOREIGN KEY (`video_video_id`)
    REFERENCES `s201_n2exercise_you_tube`.`video` (`video_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_like_dislike_user1`
    FOREIGN KEY (`user_user_id`)
    REFERENCES `s201_n2exercise_you_tube`.`user` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `s201_n2exercise_you_tube`.`playlist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `s201_n2exercise_you_tube`.`playlist` (
  `playlist_id` INT(10) NOT NULL,
  `playlist_name` VARCHAR(45) NOT NULL,
  `playlis_creation_date` TIMESTAMP NOT NULL,
  `playlist_status` ENUM('public', 'private') NOT NULL,
  PRIMARY KEY (`playlist_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `s201_n2exercise_you_tube`.`comments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `s201_n2exercise_you_tube`.`comments` (
  `comments_id` INT(10) NOT NULL,
  `comments_text` TEXT NOT NULL,
  `comments_date_time` DATETIME NOT NULL,
  `user_user_id` INT(10) NOT NULL,
  PRIMARY KEY (`comments_id`),
  INDEX `fk_comments_user1_idx` (`user_user_id` ASC) ,
  CONSTRAINT `fk_comments_user1`
    FOREIGN KEY (`user_user_id`)
    REFERENCES `s201_n2exercise_you_tube`.`user` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `s201_n2exercise_you_tube`.`user_video`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `s201_n2exercise_you_tube`.`user_video` (
  `user_video_id` INT(10) NOT NULL,
  `user_video_like_date_time` TIMESTAMP NOT NULL,
  `playlist_playlist_id` INT(10) NOT NULL,
  `user_user_id` INT(10) NOT NULL,
  PRIMARY KEY (`user_video_id`, `playlist_playlist_id`, `user_user_id`),
  INDEX `fk_user_video_playlist1_idx` (`playlist_playlist_id` ASC) ,
  INDEX `fk_user_video_user1_idx` (`user_user_id` ASC) ,
  CONSTRAINT `fk_user_video_playlist1`
    FOREIGN KEY (`playlist_playlist_id`)
    REFERENCES `s201_n2exercise_you_tube`.`playlist` (`playlist_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_user_video_user1`
    FOREIGN KEY (`user_user_id`)
    REFERENCES `s201_n2exercise_you_tube`.`user` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `s201_n2exercise_you_tube`.`channel_subscriptions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `s201_n2exercise_you_tube`.`channel_subscriptions` (
  `channel_subscriptions_id` INT(10) NOT NULL AUTO_INCREMENT,
  `channel_channel_id` INT(10) NOT NULL,
  `user_user_id` INT(10) NOT NULL,
  PRIMARY KEY (`channel_subscriptions_id`),
  INDEX `fk_channel_subscriptions_channel1_idx` (`channel_channel_id` ASC) ,
  INDEX `fk_channel_subscriptions_user1_idx` (`user_user_id` ASC) ,
  CONSTRAINT `fk_channel_subscriptions_channel1`
    FOREIGN KEY (`channel_channel_id`)
    REFERENCES `s201_n2exercise_you_tube`.`channel` (`channel_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_channel_subscriptions_user1`
    FOREIGN KEY (`user_user_id`)
    REFERENCES `s201_n2exercise_you_tube`.`user` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `s201_n2exercise_you_tube`.`video_playlist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `s201_n2exercise_you_tube`.`video_playlist` (
  `video_playlist_id` INT(10) NOT NULL,
  `playlist_playlist_id` INT(10) NOT NULL,
  `video_video_id` INT(10) NOT NULL,
  PRIMARY KEY (`video_playlist_id`, `playlist_playlist_id`, `video_video_id`),
  INDEX `fk_video_playlist_playlist1_idx` (`playlist_playlist_id` ASC) ,
  INDEX `fk_video_playlist_video1_idx` (`video_video_id` ASC) ,
  CONSTRAINT `fk_video_playlist_playlist1`
    FOREIGN KEY (`playlist_playlist_id`)
    REFERENCES `s201_n2exercise_you_tube`.`playlist` (`playlist_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_video_playlist_video1`
    FOREIGN KEY (`video_video_id`)
    REFERENCES `s201_n2exercise_you_tube`.`video` (`video_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
