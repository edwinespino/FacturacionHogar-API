-- MySQL Script generated by MySQL Workbench
-- Thu Dec 29 16:31:03 2022
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema app-kodigo
-- -----------------------------------------------------
-- Base de datos para APP de kodigo rest-api
DROP SCHEMA IF EXISTS `app-kodigo` ;

-- -----------------------------------------------------
-- Schema app-kodigo
--
-- Base de datos para APP de kodigo rest-api
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `app-kodigo` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin ;
USE `app-kodigo` ;

-- -----------------------------------------------------
-- Table `app-kodigo`.`Cargo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `app-kodigo`.`Cargo` ;

CREATE TABLE IF NOT EXISTS `app-kodigo`.`Cargo` (
  `IdCargo` INT NOT NULL AUTO_INCREMENT,
  `NombreCargo` VARCHAR(45) NOT NULL,
  `Monto` DECIMAL NOT NULL DEFAULT 0.00,
  `Factura_idFactura` INT NOT NULL,
  PRIMARY KEY (`IdCargo`),
  INDEX `fk_Cargo_Factura1_idx` (`Factura_idFactura` ASC) ,
  CONSTRAINT `fk_Cargo_Factura1`
    FOREIGN KEY (`Factura_idFactura`)
    REFERENCES `app-kodigo`.`Factura` (`idFactura`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `app-kodigo`.`Casa`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `app-kodigo`.`Casa` ;

CREATE TABLE IF NOT EXISTS `app-kodigo`.`Casa` (
  `CodigoCasa` INT NOT NULL AUTO_INCREMENT,
  `NumeroCasa` VARCHAR(45) NOT NULL,
  `CostoMantenimiento` DECIMAL NOT NULL DEFAULT 1.00,
  `Propietario_CodigoPropietario` INT NOT NULL,
  `Departamento_CodigoDepartamento` INT NOT NULL,
  `País_CodigoPais` INT NOT NULL,
  `Municipio_CodigoMunicipio` INT NOT NULL,
  PRIMARY KEY (`CodigoCasa`),
  INDEX `fk_Casa_Propietario_idx` (`Propietario_CodigoPropietario` ASC) ,
  INDEX `fk_Casa_Departamento1_idx` (`Departamento_CodigoDepartamento` ASC) ,
  INDEX `fk_Casa_País1_idx` (`País_CodigoPais` ASC) ,
  INDEX `fk_Casa_Municipio1_idx` (`Municipio_CodigoMunicipio` ASC) ,
  CONSTRAINT `fk_Casa_Propietario`
    FOREIGN KEY (`Propietario_CodigoPropietario`)
    REFERENCES `app-kodigo`.`Propietario` (`CodigoPropietario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Casa_Departamento1`
    FOREIGN KEY (`Departamento_CodigoDepartamento`)
    REFERENCES `app-kodigo`.`Departamento` (`CodigoDepartamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Casa_País1`
    FOREIGN KEY (`País_CodigoPais`)
    REFERENCES `app-kodigo`.`País` (`CodigoPais`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Casa_Municipio1`
    FOREIGN KEY (`Municipio_CodigoMunicipio`)
    REFERENCES `app-kodigo`.`Municipio` (`CodigoMunicipio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `app-kodigo`.`Departamento`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `app-kodigo`.`Departamento` ;

CREATE TABLE IF NOT EXISTS `app-kodigo`.`Departamento` (
  `CodigoDepartamento` INT NOT NULL AUTO_INCREMENT,
  `NombreDepartamento` VARCHAR(45) NOT NULL,
  `País_CodigoPais` INT NOT NULL,
  PRIMARY KEY (`CodigoDepartamento`),
  INDEX `fk_Departamento_País1_idx` (`País_CodigoPais` ASC) ,
  CONSTRAINT `fk_Departamento_País1`
    FOREIGN KEY (`País_CodigoPais`)
    REFERENCES `app-kodigo`.`País` (`CodigoPais`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `app-kodigo`.`Factura`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `app-kodigo`.`Factura` ;

CREATE TABLE IF NOT EXISTS `app-kodigo`.`Factura` (
  `idFactura` INT NOT NULL AUTO_INCREMENT,
  `FechaExpidacion` datetime NOT NULL DEFAULT NOW(),
  `Total` DECIMAL NOT NULL DEFAULT 0.00,
  `Servicio_CodigoServicio` INT NOT NULL,
  PRIMARY KEY (`idFactura`),
  INDEX `fk_Factura_Servicio1_idx` (`Servicio_CodigoServicio` ASC) ,
  CONSTRAINT `fk_Factura_Servicio1`
    FOREIGN KEY (`Servicio_CodigoServicio`)
    REFERENCES `app-kodigo`.`Servicio` (`CodigoServicio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `app-kodigo`.`Habitante`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `app-kodigo`.`Habitante` ;

CREATE TABLE IF NOT EXISTS `app-kodigo`.`Habitante` (
  `CodigoHabitante` INT NOT NULL AUTO_INCREMENT,
  `NombreHabitante` VARCHAR(125) NOT NULL,
  `Correo` VARCHAR(45) NOT NULL,
  `Casa_CodigoCasa` INT NOT NULL,
  PRIMARY KEY (`CodigoHabitante`),
  INDEX `fk_Persona_Casa1_idx` (`Casa_CodigoCasa` ASC) ,
  UNIQUE INDEX `Correo_UNIQUE` (`Correo` ASC) ,
  CONSTRAINT `fk_Persona_Casa1`
    FOREIGN KEY (`Casa_CodigoCasa`)
    REFERENCES `app-kodigo`.`Casa` (`CodigoCasa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `app-kodigo`.`Municipio`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `app-kodigo`.`Municipio` ;

CREATE TABLE IF NOT EXISTS `app-kodigo`.`Municipio` (
  `CodigoMunicipio` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NOT NULL,
  `Departamento_CodigoDepartamento` INT NOT NULL,
  PRIMARY KEY (`CodigoMunicipio`),
  INDEX `fk_Municipio_Departamento1_idx` (`Departamento_CodigoDepartamento` ASC) ,
  CONSTRAINT `fk_Municipio_Departamento1`
    FOREIGN KEY (`Departamento_CodigoDepartamento`)
    REFERENCES `app-kodigo`.`Departamento` (`CodigoDepartamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `app-kodigo`.`País`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `app-kodigo`.`País` ;

CREATE TABLE IF NOT EXISTS `app-kodigo`.`País` (
  `CodigoPais` INT NOT NULL AUTO_INCREMENT,
  `NombrePais` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`CodigoPais`),
  UNIQUE INDEX `NombrePais_UNIQUE` (`NombrePais` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `app-kodigo`.`Propietario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `app-kodigo`.`Propietario` ;

CREATE TABLE IF NOT EXISTS `app-kodigo`.`Propietario` (
  `CodigoPropietario` INT NOT NULL AUTO_INCREMENT,
  `NombrePersona` VARCHAR(125) NOT NULL,
  `Correo` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`CodigoPropietario`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `app-kodigo`.`Proveedor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `app-kodigo`.`Proveedor` ;

CREATE TABLE IF NOT EXISTS `app-kodigo`.`Proveedor` (
  `CodigoProveedor` INT NOT NULL AUTO_INCREMENT,
  `NombreProveedor` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`CodigoProveedor`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `app-kodigo`.`Servicio`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `app-kodigo`.`Servicio` ;

CREATE TABLE IF NOT EXISTS `app-kodigo`.`Servicio` (
  `CodigoServicio` INT NOT NULL AUTO_INCREMENT,
  `NombreServicio` VARCHAR(45) NOT NULL,
  `Tarifa` DECIMAL NOT NULL DEFAULT 1.00,
  `FechaSuspencion` datetime NOT NULL,
  `Casa_CodigoCasa` INT NOT NULL,
  `Proveedor_CodigoProveedor` INT NOT NULL,
  PRIMARY KEY (`CodigoServicio`),
  INDEX `fk_Servicio_Casa1_idx` (`Casa_CodigoCasa` ASC) ,
  INDEX `fk_Servicio_Proveedor1_idx` (`Proveedor_CodigoProveedor` ASC) ,
  CONSTRAINT `fk_Servicio_Casa1`
    FOREIGN KEY (`Casa_CodigoCasa`)
    REFERENCES `app-kodigo`.`Casa` (`CodigoCasa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Servicio_Proveedor1`
    FOREIGN KEY (`Proveedor_CodigoProveedor`)
    REFERENCES `app-kodigo`.`Proveedor` (`CodigoProveedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `app-kodigo`.`Usuario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `app-kodigo`.`Usuario` ;

CREATE TABLE IF NOT EXISTS `app-kodigo`.`Usuario` (
  `idUsuario` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NOT NULL,
  `Password` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idUsuario`))
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
