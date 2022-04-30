CREATE SCHEMA `dbpuntoventa` ;
CREATE TABLE `dbpuntoventa`.`clientes` (
  `idCliente` INT NOT NULL AUTO_INCREMENT,
  `nombres` VARCHAR(60) NULL,
  `apellidos` VARCHAR(60) NULL,
  `NIT` VARCHAR(12) NULL,
  `genero` BIT NULL,
  `telefono` VARCHAR(25) NULL,
  `correo_electronico` VARCHAR(45) NULL,
  `fechaingreso` DATETIME NULL,
  PRIMARY KEY (`idCliente`));
  
  CREATE TABLE `dbpuntoventa`.`ventas` (
  `idVenta` INT NOT NULL AUTO_INCREMENT,
  `nofactura` INT NULL,
  `serie` CHAR(1) NULL,
  `fechafactura` DATE NULL,
  `idcliente` INT NULL,
  `idempleado` INT NULL,
  `fechaingreso` DATETIME NULL,
  PRIMARY KEY (`idVenta`));
  
  CREATE TABLE `dbpuntoventa`.`puestos` (
  `idPuesto` SMALLINT NOT NULL AUTO_INCREMENT,
  `puesto` VARCHAR(50) NULL,
  PRIMARY KEY (`idPuesto`));
  
  CREATE TABLE `dbpuntoventa`.`empleados` (
  `idEmpleado` INT NOT NULL AUTO_INCREMENT,
  `nombres` VARCHAR(60) NULL,
  `apellidos` VARCHAR(60) NULL,
  `direccion` VARCHAR(80) NULL,
  `telefono` VARCHAR(25) NULL,
  `DPI` VARCHAR(15) NULL,
  `genero` BIT NULL,
  `fecha_nacimiento` DATE NULL,
  `idPuesto` SMALLINT NULL,
  `fecha_inicio_labores` DATE NULL,
  `fechaingreso` DATETIME NULL,
  PRIMARY KEY (`idEmpleado`));
  
  CREATE TABLE `dbpuntoventa`.`ventas_detalle` (
  `idventa_detalle` BIGINT NOT NULL AUTO_INCREMENT,
  `idVenta` INT NULL,
  `idProducto` INT NULL,
  `cantidad` VARCHAR(45) NULL,
  `precio_unitario` DECIMAL(8,2) NULL,
  PRIMARY KEY (`idventa_detalle`));
  
  CREATE TABLE `dbpuntoventa`.`marcas` (
  `idmarca` SMALLINT NOT NULL AUTO_INCREMENT,
  `marca` VARCHAR(50) NULL,
  PRIMARY KEY (`idmarca`));
  
  CREATE TABLE `dbpuntoventa`.`productos` (
  `idProducto` INT NOT NULL AUTO_INCREMENT,
  `producto` VARCHAR(50) NULL,
  `idMarca` SMALLINT NULL,
  `Descripcion` VARCHAR(100) NULL,
  `Imagen` VARCHAR(30) NULL,
  `precio_costo` DECIMAL(8,2) NULL,
  `precio_venta` DECIMAL(8,2) NULL,
  `existencia` INT NULL,
  `fecha_ingreso` DATETIME NULL,
  PRIMARY KEY (`idProducto`));
  
  CREATE TABLE `dbpuntoventa`.`compras_detalle` (
  `idcompra_detalle` BIGINT NOT NULL AUTO_INCREMENT,
  `idcompra` INT NULL,
  `idproducto` INT NULL,
  `cantidad` INT NULL,
  `precio_costo_unitario` DECIMAL(8,2) NULL,
  PRIMARY KEY (`idcompra_detalle`));

CREATE TABLE `dbpuntoventa`.`compras` (
  `idcompra` INT NOT NULL AUTO_INCREMENT,
  `no_orden_compra` INT NULL,
  `idproveedor` INT NULL,
  `fecha_orden` DATE NULL,
  `fechaingreso` DATETIME NULL,
  PRIMARY KEY (`idcompra`));

CREATE TABLE `dbpuntoventa`.`proveedores` (
  `idProveedor` INT NOT NULL AUTO_INCREMENT,
  `proveedor` VARCHAR(60) NULL,
  `nit` VARCHAR(12) NULL,
  `direccion` VARCHAR(80) NULL,
  `telefono` VARCHAR(25) NULL,
  PRIMARY KEY (`idProveedor`));

ALTER TABLE `dbpuntoventa`.`empleados` 
ADD INDEX `idPuesto_puestos_empleados_idx` (`idPuesto` ASC) VISIBLE;
;
ALTER TABLE `dbpuntoventa`.`empleados` 
ADD CONSTRAINT `idPuesto_puestos_empleados`
  FOREIGN KEY (`idPuesto`)
  REFERENCES `dbpuntoventa`.`puestos` (`idPuesto`)
  ON DELETE NO ACTION
  ON UPDATE CASCADE;


ALTER TABLE `dbpuntoventa`.`ventas` 
ADD CONSTRAINT `idCliente_Clientes_Ventas`
  FOREIGN KEY (`idcliente`)
  REFERENCES `dbpuntoventa`.`clientes` (`idCliente`)
  ON DELETE NO ACTION
  ON UPDATE CASCADE;
ALTER TABLE `dbpuntoventa`.`ventas` 
ADD INDEX `idEmpleado_Empleados_Ventas_idx` (`idempleado` ASC) VISIBLE;
;
ALTER TABLE `dbpuntoventa`.`ventas` 
ADD CONSTRAINT `idEmpleado_Empleados_Ventas`
  FOREIGN KEY (`idempleado`)
  REFERENCES `dbpuntoventa`.`empleados` (`idEmpleado`)
  ON DELETE NO ACTION
  ON UPDATE CASCADE;

ALTER TABLE `dbpuntoventa`.`ventas_detalle` 
ADD INDEX `idVenta_Ventas_Ventas_detalle_idx` (`idVenta` ASC) VISIBLE;
;
ALTER TABLE `dbpuntoventa`.`ventas_detalle` 
ADD CONSTRAINT `idVenta_Ventas_Ventas_detalle`
  FOREIGN KEY (`idVenta`)
  REFERENCES `dbpuntoventa`.`ventas` (`idVenta`)
  ON DELETE NO ACTION
  ON UPDATE CASCADE;
ALTER TABLE `dbpuntoventa`.`ventas_detalle` 
ADD INDEX `idProducto_Productos_Ventas_detalle_idx` (`idProducto` ASC) VISIBLE;
;
ALTER TABLE `dbpuntoventa`.`ventas_detalle` 
ADD CONSTRAINT `idProducto_Productos_Ventas_detalle`
  FOREIGN KEY (`idProducto`)
  REFERENCES `dbpuntoventa`.`productos` (`idProducto`)
  ON DELETE NO ACTION
  ON UPDATE CASCADE;
ALTER TABLE `dbpuntoventa`.`productos` 
ADD INDEX `idMarca_Marcas_Productos_idx` (`idMarca` ASC) VISIBLE;
;
ALTER TABLE `dbpuntoventa`.`productos` 
ADD CONSTRAINT `idMarca_Marcas_Productos`
  FOREIGN KEY (`idMarca`)
  REFERENCES `dbpuntoventa`.`marcas` (`idmarca`)
  ON DELETE NO ACTION
  ON UPDATE CASCADE;
ALTER TABLE `dbpuntoventa`.`compras_detalle` 
ADD INDEX `idProducto_Productos_Compras_detalle_idx` (`idcompra` ASC) VISIBLE;
;
ALTER TABLE `dbpuntoventa`.`compras_detalle` 
ADD CONSTRAINT `idProducto_Productos_Compras_detalle`
  FOREIGN KEY (`idcompra`)
  REFERENCES `dbpuntoventa`.`productos` (`idProducto`)
  ON DELETE NO ACTION
  ON UPDATE CASCADE;
ALTER TABLE `dbpuntoventa`.`compras_detalle` 
ADD CONSTRAINT `idCompra_Compras_Compras_Detalle`
  FOREIGN KEY (`idcompra`)
  REFERENCES `dbpuntoventa`.`compras` (`idcompra`)
  ON DELETE NO ACTION
  ON UPDATE CASCADE;
ALTER TABLE `dbpuntoventa`.`compras` 
ADD INDEX `IdProveedores_Proveedores_Compras_idx` (`idproveedor` ASC) VISIBLE;
;
ALTER TABLE `dbpuntoventa`.`compras` 
ADD CONSTRAINT `IdProveedores_Proveedores_Compras`
  FOREIGN KEY (`idproveedor`)
  REFERENCES `dbpuntoventa`.`proveedores` (`idProveedor`)
  ON DELETE NO ACTION
  ON UPDATE CASCADE;
  
INSERT INTO `dbpuntoventa`.`puestos` (`puesto`) VALUES ('Administrador');
INSERT INTO `dbpuntoventa`.`puestos` (`puesto`) VALUES ('Gerente');
INSERT INTO `dbpuntoventa`.`puestos` (`puesto`) VALUES ('Sub Gerente');
INSERT INTO `dbpuntoventa`.`puestos` (`puesto`) VALUES ('Supervisor');
INSERT INTO `dbpuntoventa`.`puestos` (`puesto`) VALUES ('Secretario');

INSERT INTO `dbpuntoventa`.`empleados` (`nombres`, `apellidos`, `direccion`, `telefono`, `DPI`, `genero`, `fecha_nacimiento`, `idPuesto`, `fecha_inicio_labores`, `fechaingreso`) VALUES ('Juan Alberto', 'Gomez Herrarte', 'Zona 12, Guatemala', '45612354', '12356489712', 1 , '1989-05-01', '2', '2015-08-03', '2015-08-01 12:08:40');
INSERT INTO `dbpuntoventa`.`empleados` (`nombres`, `apellidos`, `direccion`, `telefono`, `DPI`, `genero`, `fecha_nacimiento`, `idPuesto`, `fecha_inicio_labores`, `fechaingreso`) VALUES ('Miguel Angel', 'Artemizo Estrada', 'Zona 5, Guatemala', '89754654', '23654657894', 1 , '1970-08-15', '3', '2016-02-03', '2016-08-10 10:40:00');
INSERT INTO `dbpuntoventa`.`empleados` (`nombres`, `apellidos`, `direccion`, `telefono`, `DPI`, `genero`, `fecha_nacimiento`, `idPuesto`, `fecha_inicio_labores`, `fechaingreso`) VALUES ('Jaime Humberto', 'Aceituno Ramirez', 'Zona 6, Guatemala', '23546584', '65498235641', 1 , '1988-06-10', '1', '2017-01-03', '2017-01-05 13:50:54');
INSERT INTO `dbpuntoventa`.`empleados` (`nombres`, `apellidos`, `direccion`, `telefono`, `DPI`, `genero`, `fecha_nacimiento`, `idPuesto`, `fecha_inicio_labores`, `fechaingreso`) VALUES ('Raul Rodrigo', 'Fernandez Boche', 'Zona 1, Guatemala', '79536546', '57465234591', 1 , '1990-02-01', '4', '2014-04-03', '2014-01-028 11:08:30');
INSERT INTO `dbpuntoventa`.`empleados` (`nombres`, `apellidos`, `direccion`, `telefono`, `DPI`, `genero`, `fecha_nacimiento`, `idPuesto`, `fecha_inicio_labores`, `fechaingreso`) VALUES ('Estuardo Mauricio', 'Pérez Paz', 'Zona 8, Guatemala', '45612387', '98546235461', 1 , '1972-01-10', '5', '2015-01-12', '2015-01-01 19:08:59');

INSERT INTO `dbpuntoventa`.`clientes` (`nombres`, `apellidos`, `NIT`, `genero`, `telefono`, `correo_electronico`, `fechaingreso`) VALUES ('Miguel Angel ', 'Julian Albarado', '123654852312', 1, '45612879', 'Mjuliana@gmail.com', '2019-08-12 10:08:54');
INSERT INTO `dbpuntoventa`.`clientes` (`nombres`, `apellidos`, `NIT`, `genero`, `telefono`, `correo_electronico`, `fechaingreso`) VALUES ('Lisa Andrea', 'Uribe Salazar', '254612365478', 0,'78945236', 'LisaSalazar@yahoo.com', '2018-09-15 15:35:05');
INSERT INTO `dbpuntoventa`.`clientes` (`nombres`, `apellidos`, `NIT`, `genero`, `telefono`, `correo_electronico`, `fechaingreso`) VALUES ('Mishel Uribe', 'Palacios Urizar', '561235465215', 0,'226543254', 'Muribep@miumg.edu.gt', '2020-08-12 14:22:39');
INSERT INTO `dbpuntoventa`.`clientes` (`nombres`, `apellidos`, `NIT`, `genero`, `telefono`, `correo_electronico`, `fechaingreso`) VALUES ('Amilcar Rubén', 'Jimenez Mota', '898715623124', 1,'45682136', 'Amilcar78875@gmail.com', '2020-05-01 12:30:06');
INSERT INTO `dbpuntoventa`.`clientes` (`nombres`, `apellidos`, `NIT`, `genero`, `telefono`, `correo_electronico`, `fechaingreso`) VALUES ('Pedro Pablo', 'Ulbin Dario', '446213254879', 1,'465284652', 'Pedrito87@gmail.com', '2019-12-10 10:21:00');

INSERT INTO `dbpuntoventa`.`ventas` (`nofactura`, `serie`, `fechafactura`, `idcliente`, `idempleado`, `fechaingreso`) VALUES ('10', 'A', '2022-05-01', '1', '3', '2022-05-01 15:08:20');
INSERT INTO `dbpuntoventa`.`ventas` (`nofactura`, `serie`, `fechafactura`, `idcliente`, `idempleado`, `fechaingreso`) VALUES ('09', 'B', '2022-04-25', '5', '5', '2022-04-29 10:30:55');
INSERT INTO `dbpuntoventa`.`ventas` (`nofactura`, `serie`, `fechafactura`, `idcliente`, `idempleado`, `fechaingreso`) VALUES ('08', 'A', '2022-03-15', '4', '2', '2022-03-15 23:15:10');
INSERT INTO `dbpuntoventa`.`ventas` (`nofactura`, `serie`, `fechafactura`, `idcliente`, `idempleado`, `fechaingreso`) VALUES ('11', 'A', '2022-05-05', '2', '2', '2022-05-05 20:15:52');
INSERT INTO `dbpuntoventa`.`ventas` (`nofactura`, `serie`, `fechafactura`, `idcliente`, `idempleado`, `fechaingreso`) VALUES ('07', 'B', '2022-01-01', '3', '5', '2022-01-01 08:50:26');

INSERT INTO `dbpuntoventa`.`marcas` (`marca`) VALUES ('Nike');
INSERT INTO `dbpuntoventa`.`marcas` (`marca`) VALUES ('Jordan');
INSERT INTO `dbpuntoventa`.`marcas` (`marca`) VALUES ('Adidas');
INSERT INTO `dbpuntoventa`.`marcas` (`marca`) VALUES ('Gucci');
INSERT INTO `dbpuntoventa`.`marcas` (`marca`) VALUES ('Crocs');

INSERT INTO `dbpuntoventa`.`productos` (`producto`, `idMarca`, `Descripcion`, `Imagen`, `precio_costo`, `precio_venta`, `existencia`, `fecha_ingreso`) VALUES ('Tenis', '1', 'Tenis talla 8', 'tenis_8.jpg', '1000', '1500', '50', '2022-04-12 20:30:05');
INSERT INTO `dbpuntoventa`.`productos` (`producto`, `idMarca`, `Descripcion`, `Imagen`, `precio_costo`, `precio_venta`, `existencia`, `fecha_ingreso`) VALUES ('Tenis', '1', 'Tenis talla 9', 'tenis_9.jpg', '900', '1450', '55', '2022-03-10 05:00:06');
INSERT INTO `dbpuntoventa`.`productos` (`producto`, `idMarca`, `Descripcion`, `Imagen`, `precio_costo`, `precio_venta`, `existencia`, `fecha_ingreso`) VALUES ('Zapatos', '2', 'Zapato de vestir talla 8 negros', 'zapatos_8.jpg', '800', '1000', '100', '2022-01-05 06:30:00');
INSERT INTO `dbpuntoventa`.`productos` (`producto`, `idMarca`, `Descripcion`, `Imagen`, `precio_costo`, `precio_venta`, `existencia`, `fecha_ingreso`) VALUES ('Pantuflas', '5', 'Pantuflas forro de felpa talla 9', 'pantufla_8.jpg', '950', '1050', '20', '2022-01-05 23:00:35');
INSERT INTO `dbpuntoventa`.`productos` (`producto`, `idMarca`, `Descripcion`, `Imagen`, `precio_costo`, `precio_venta`, `existencia`, `fecha_ingreso`) VALUES ('Tacones', '2', 'Tacones aguja negros talla 7', 'tacones_8.jpg', '1200', '1350', '5', '2022-02-20 14:00:55');

INSERT INTO `dbpuntoventa`.`ventas_detalle` (`idVenta`, `idProducto`, `cantidad`, `precio_unitario`) VALUES ('1', '5', '2', '1350');
INSERT INTO `dbpuntoventa`.`ventas_detalle` (`idVenta`, `idProducto`, `cantidad`, `precio_unitario`) VALUES ('2', '2', '2', '1450');
INSERT INTO `dbpuntoventa`.`ventas_detalle` (`idVenta`, `idProducto`, `cantidad`, `precio_unitario`) VALUES ('3', '3', '2', '1000');
INSERT INTO `dbpuntoventa`.`ventas_detalle` (`idVenta`, `idProducto`, `cantidad`, `precio_unitario`) VALUES ('4', '2', '1', '1450');
INSERT INTO `dbpuntoventa`.`ventas_detalle` (`idVenta`, `idProducto`, `cantidad`, `precio_unitario`) VALUES ('5', '5', '2', '1350');

INSERT INTO `dbpuntoventa`.`proveedores` (`proveedor`, `nit`, `direccion`, `telefono`) VALUES ('Distribuidora tu zapato', '456452315498', 'Zona 1, Guatemala', '45654523');
INSERT INTO `dbpuntoventa`.`proveedores` (`proveedor`, `nit`, `direccion`, `telefono`) VALUES ('El Zapatero', '546892109-1', 'Zona 10, Guatemala', '65208463201');
INSERT INTO `dbpuntoventa`.`proveedores` (`proveedor`, `nit`, `direccion`, `telefono`) VALUES ('Nike Guatemala', '65425652891', 'Zona 12, Guatemala', '6505235489');
INSERT INTO `dbpuntoventa`.`proveedores` (`proveedor`, `nit`, `direccion`, `telefono`) VALUES ('Zapatos OH', '65200456813', 'zona 6, Guatemala', '6552846521');
INSERT INTO `dbpuntoventa`.`proveedores` (`proveedor`, `nit`, `direccion`, `telefono`) VALUES ('Adidas Gt', '2325132658', 'Zona 7, Guatemala', '23564879');

INSERT INTO `dbpuntoventa`.`compras` (`no_orden_compra`, `idproveedor`, `fecha_orden`, `fechaingreso`) VALUES ('110', '2', '2022-01-03', '2022-01-10 05:08:12');
INSERT INTO `dbpuntoventa`.`compras` (`no_orden_compra`, `idproveedor`, `fecha_orden`, `fechaingreso`) VALUES ('111', '3', '2022-01-03', '2022-01-07 22:05:12');
INSERT INTO `dbpuntoventa`.`compras` (`no_orden_compra`, `idproveedor`, `fecha_orden`, `fechaingreso`) VALUES ('112', '1', '2022-02-01', '2022-02-11');
INSERT INTO `dbpuntoventa`.`compras` (`no_orden_compra`, `idproveedor`, `fecha_orden`, `fechaingreso`) VALUES ('113', '5', '2022-02-05', '2022-02-10');
INSERT INTO `dbpuntoventa`.`compras` (`no_orden_compra`, `idproveedor`, `fecha_orden`, `fechaingreso`) VALUES ('114', '4', '2022-03-05', '2022-03-15');

INSERT INTO `dbpuntoventa`.`compras_detalle` (`idcompra`, `idproducto`, `cantidad`, `precio_costo_unitario`) VALUES ('1', '2', '70', '1000');
INSERT INTO `dbpuntoventa`.`compras_detalle` (`idcompra`, `idproducto`, `cantidad`, `precio_costo_unitario`) VALUES ('5', '1', '40', '800');
INSERT INTO `dbpuntoventa`.`compras_detalle` (`idcompra`, `idproducto`, `cantidad`, `precio_costo_unitario`) VALUES ('4', '3', '50', '1200');
INSERT INTO `dbpuntoventa`.`compras_detalle` (`idcompra`, `idproducto`, `cantidad`, `precio_costo_unitario`) VALUES ('3', '4', '50', '900');
INSERT INTO `dbpuntoventa`.`compras_detalle` (`idcompra`, `idproducto`, `cantidad`, `precio_costo_unitario`) VALUES ('2', '5', '25', '1200');

