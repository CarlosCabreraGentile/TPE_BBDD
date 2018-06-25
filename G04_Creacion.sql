-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2018-06-22 15:18:52.855

-- tables
-- Table: Comentario
CREATE TABLE GR04_Comentario (
    tipo_doc int  NOT NULL,
    nro_doc decimal(11,0)  NOT NULL,
    id_reserva bigint  NOT NULL,
    fecha_hora_comentario date  NOT NULL,
    comentario varchar(2048)  NOT NULL,
    estrellas int  NOT NULL,
    CONSTRAINT PK_GR04_Comentario PRIMARY KEY (tipo_doc,nro_doc,id_reserva,fecha_hora_comentario)
);

-- Table: Costo_Depto
CREATE TABLE GR04_CostoDepto (
    id_dpto int  NOT NULL,
    fecha_desde date  NOT NULL,
    fecha_hasta date  NOT NULL,
    precio_noche decimal(10,2)  NOT NULL,
    CONSTRAINT PK_GR04_CostoDepto PRIMARY KEY (id_dpto,fecha_desde)
);

-- Table: Departamento
CREATE TABLE GR04_Departamento (
    id_dpto int  NOT NULL,
    descripcion varchar(80)  NOT NULL,
    superficie decimal(10,2)  NOT NULL,
    id_tipo_depto int  NOT NULL,
    tipo_doc int  NOT NULL,
    nro_doc decimal(11,0)  NOT NULL,
    precio_noche decimal(10,2)  NOT NULL,
    costo_limpieza decimal(10,2)  NOT NULL,
    ciudad varchar(50)  NOT NULL,
    CONSTRAINT PK_GR04_Departamento PRIMARY KEY (id_dpto)
);

-- Table: Estado_Luego_Ocupacion_Reserva
CREATE TABLE GR04_EstadoLuegoOcupacion (
    fecha date  NOT NULL,
    id_reserva bigint  NOT NULL,
    comentario varchar(2048)  NOT NULL,
    CONSTRAINT PK_GR04_EstadoLuegoOcupacion PRIMARY KEY (fecha,id_reserva)
);

-- Table: Habitacion
CREATE TABLE GR04_Habitacion (
    id_dpto int  NOT NULL,
    id_habitacion int  NOT NULL,
    posib_camas_simples int  NOT NULL,
    posib_camas_dobles int  NOT NULL,
    posib_camas_kind int  NOT NULL,
    tv boolean  NOT NULL,
    sillon int  NOT NULL,
    frigobar boolean  NOT NULL,
    mesa boolean  NOT NULL,
    sillas int  NOT NULL,
    cocina boolean  NOT NULL,
    CONSTRAINT PK_GR04_Habitacion PRIMARY KEY (id_dpto,id_habitacion)
);

-- Table: Huesped
CREATE TABLE GR04_Huesped (
    tipo_doc int  NOT NULL,
    nro_doc decimal(11,0)  NOT NULL,
    CONSTRAINT PK_GR04_Huesped PRIMARY KEY (tipo_doc,nro_doc)
);

-- Table: Huesped_Reserva
CREATE TABLE GR04_Huesped_Reserva (
    tipo_doc int  NOT NULL,
    nro_doc decimal(11,0)  NOT NULL,
    id_reserva bigint  NOT NULL,
    CONSTRAINT PK_GR04_Huesped_Reserva PRIMARY KEY (tipo_doc,nro_doc,id_reserva)
);

-- Table: Pago
CREATE TABLE GR04_Pago (
    fecha_pago timestamp  NOT NULL,
    id_reserva bigint  NOT NULL,
    id_tipo_pago int  NOT NULL,
    comentario varchar(80)  NULL,
    importe decimal(10,2)  NOT NULL,
    CONSTRAINT PK_GR04_Pago PRIMARY KEY (fecha_pago,id_reserva,id_tipo_pago)
);

-- Table: Persona
CREATE TABLE GR04_Persona (
    tipo_doc int  NOT NULL,
    nro_doc decimal(11,0)  NOT NULL,
    apellido varchar(80)  NOT NULL,
    nombre varchar(80)  NOT NULL,
    fecha_nac date  NOT NULL,
    e_mail varchar(80)  NOT NULL,
    CONSTRAINT PK_GR04Persona PRIMARY KEY (tipo_doc,nro_doc)
);

-- Table: Reserva
CREATE TABLE GR04_Reserva (
    id_reserva bigint  NOT NULL,
    fecha_reserva date  NOT NULL,
    fecha_desde date  NOT NULL,
    fecha_hasta date  NOT NULL,
    tipo varchar(15)  NOT NULL,
    id_dpto int  NOT NULL,
    valor_noche decimal(10,2)  NOT NULL,
    usa_limpieza smallint  NOT NULL,
    tipo_doc int  NOT NULL,
    nro_doc decimal(11,0)  NOT NULL,
    CONSTRAINT PK_GR04_Reserva PRIMARY KEY (id_reserva)
);

-- Table: Tipo_Dpto
CREATE TABLE GR04_Tipo_Dpto (
    id_tipo_depto int  NOT NULL,
    cant_habitaciones int  NOT NULL,
    cant_banios int  NOT NULL,
    cant_max_huespedes int  NOT NULL,
    CONSTRAINT PK_GR04_Tipo_Dpto PRIMARY KEY (id_tipo_depto)
);

-- Table: Tipo_Pago
CREATE TABLE GR04_Tipo_Pago (
    id_tipo_pago int  NOT NULL,
    nombre varchar(80)  NOT NULL,
    CONSTRAINT PK_GR04_Tipo_Pago PRIMARY KEY (id_tipo_pago)
);

-- foreign keys
-- Reference: FK_Comentario_Huesped_Reserva (table: Comentario)
ALTER TABLE GR04_Comentario ADD CONSTRAINT FK_GR04_Comentario_Huesped_Reserva
    FOREIGN KEY (tipo_doc, nro_doc, id_reserva)
    REFERENCES GR04_Huesped_Reserva (tipo_doc, nro_doc, id_reserva)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: FK_CostoDepto_Departamento (table: Costo_Depto)
ALTER TABLE GR04_CostoDepto ADD CONSTRAINT FK_GR04_CostoDepto_Departamento
    FOREIGN KEY (id_dpto)
    REFERENCES GR04_Departamento (id_dpto)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: FK_Departamento_Persona (table: Departamento)
ALTER TABLE GR04_Departamento ADD CONSTRAINT FK_GR04_Departamento_Persona
    FOREIGN KEY (tipo_doc, nro_doc)
    REFERENCES GR04_Persona (tipo_doc, nro_doc)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: FK_Departamento_Tipo_Dpto (table: Departamento)
ALTER TABLE GR04_Departamento ADD CONSTRAINT FK_GR04_Departamento_Tipo_Dpto
    FOREIGN KEY (id_tipo_depto)
    REFERENCES GR04_Tipo_Dpto (id_tipo_depto)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: FK_Estado_Luego_Ocupacion_Reserva (table: Estado_Luego_Ocupacion_Reserva)
ALTER TABLE GR04_EstadoLuegoOcupacion ADD CONSTRAINT FK_GR04_EstadoLuegoOcupacion_Reserva
    FOREIGN KEY (id_reserva)
    REFERENCES GR04_Reserva (id_reserva)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: FK_Habitacion_Departamento (table: Habitacion)
ALTER TABLE GR04_Habitacion ADD CONSTRAINT FK_GR04_Habitacion_Departamento
    FOREIGN KEY (id_dpto)
    REFERENCES GR04_Departamento (id_dpto)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: FK_Huesped_Persona (table: Huesped)
ALTER TABLE GR04_Huesped ADD CONSTRAINT FK_GR04_Huesped_Persona
    FOREIGN KEY (tipo_doc, nro_doc)
    REFERENCES GR04_Persona (tipo_doc, nro_doc)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: FK_Huesped_Reserva_Huesped (table: Huesped_Reserva)
ALTER TABLE GR04_Huesped_Reserva ADD CONSTRAINT FK_GR04_Huesped_Reserva_Huesped
    FOREIGN KEY (tipo_doc, nro_doc)
    REFERENCES GR04_Huesped (tipo_doc, nro_doc)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: FK_Huesped_Reserva_Reserva (table: Huesped_Reserva)
ALTER TABLE GR04_Huesped_Reserva ADD CONSTRAINT FK_GR04_Huesped_Reserva_Reserva
    FOREIGN KEY (id_reserva)
    REFERENCES GR04_Reserva (id_reserva)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: FK_Pago_Reserva (table: Pago)
ALTER TABLE GR04_Pago ADD CONSTRAINT FK_GR04_Pago_Reserva
    FOREIGN KEY (id_reserva)
    REFERENCES GR04_Reserva (id_reserva)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: FK_Pago_Tipo_Pago (table: Pago)
ALTER TABLE GR04_Pago ADD CONSTRAINT FK_GR04_Pago_Tipo_Pago
    FOREIGN KEY (id_tipo_pago)
    REFERENCES GR04_Tipo_Pago (id_tipo_pago)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: FK_Reserva_Departamento (table: Reserva)
ALTER TABLE GR04_Reserva ADD CONSTRAINT FK_GR04_Reserva_Departamento
    FOREIGN KEY (id_dpto)
    REFERENCES GR04_Departamento (id_dpto)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: FK_Reserva_Huesped (table: Reserva)
ALTER TABLE GR04_Reserva ADD CONSTRAINT FK_GR04_Reserva_Huesped
    FOREIGN KEY (tipo_doc, nro_doc)
    REFERENCES GR04_Huesped (tipo_doc, nro_doc)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- End of file.

--/*insert a la tabla persona*/
INSERT INTO GR04_persona(tipo_doc,nro_doc,apellido,nombre,fecha_nac,e_mail) VALUES(1,'12','guerra','maxi','1985-9-27','guerramdg@gmail.com');
INSERT INTO GR04_persona(tipo_doc,nro_doc,apellido,nombre,fecha_nac,e_mail) VALUES(1,'123','perez','carlos','1985-9-27','perez@gmail.com');
INSERT INTO GR04_persona(tipo_doc,nro_doc,apellido,nombre,fecha_nac,e_mail) VALUES(1,'124','garcia','marcos','1985-9-27','garcia@gmail.com');
INSERT INTO GR04_persona(tipo_doc,nro_doc,apellido,nombre,fecha_nac,e_mail) VALUES(1,'125','alonso','silvina','1985-9-27','alonso@gmail.com');
INSERT INTO GR04_persona(tipo_doc,nro_doc,apellido,nombre,fecha_nac,e_mail) VALUES(1,'126','piagentini','morena','1985-9-27','piagentini@gmail.com');
INSERT INTO GR04_persona(tipo_doc,nro_doc,apellido,nombre,fecha_nac,e_mail) VALUES(1,'222','lopez','juan','1985-9-27','lopez@gmail.com');
INSERT INTO GR04_persona(tipo_doc,nro_doc,apellido,nombre,fecha_nac,e_mail) VALUES(1,'223','gonzalez','pedro','1985-9-27','gonzalez@gmail.com');
INSERT INTO GR04_persona(tipo_doc,nro_doc,apellido,nombre,fecha_nac,e_mail) VALUES(1,'224','fernandez','maria','1985-9-27','fernandez@gmail.com');
--/*insert a la tabla Huesped*/
INSERT INTO GR04_huesped(tipo_doc,nro_doc) VALUES(1,'12');
INSERT INTO GR04_huesped(tipo_doc,nro_doc) VALUES(1,'123');
INSERT INTO GR04_huesped(tipo_doc,nro_doc) VALUES(1,'124');
INSERT INTO GR04_huesped(tipo_doc,nro_doc) VALUES(1,'125');
INSERT INTO GR04_huesped(tipo_doc,nro_doc) VALUES(1,'126');
INSERT INTO GR04_huesped(tipo_doc,nro_doc) VALUES(1,'222');
INSERT INTO GR04_huesped(tipo_doc,nro_doc) VALUES(1,'223');
INSERT INTO GR04_huesped(tipo_doc,nro_doc) VALUES(1,'224');
--/*insert a la tabla Tipo_Depto*/
INSERT INTO GR04_Tipo_Dpto(id_tipo_depto,cant_habitaciones,cant_banios,cant_max_huespedes) VALUES (1, 2, 1, 4);
INSERT INTO GR04_Tipo_Dpto(id_tipo_depto,cant_habitaciones,cant_banios,cant_max_huespedes) VALUES (2, 1, 2, 1);
INSERT INTO GR04_Tipo_Dpto(id_tipo_depto,cant_habitaciones,cant_banios,cant_max_huespedes) VALUES (3, 3, 2, 6);
INSERT INTO GR04_Tipo_Dpto(id_tipo_depto,cant_habitaciones,cant_banios,cant_max_huespedes) VALUES (4, 2, 3, 5);
INSERT INTO GR04_Tipo_Dpto(id_tipo_depto,cant_habitaciones,cant_banios,cant_max_huespedes) VALUES (5, 3, 3, 9);
INSERT INTO GR04_Tipo_Dpto(id_tipo_depto,cant_habitaciones,cant_banios,cant_max_huespedes) VALUES (6, 1, 1, 2);
--/*insert a la tabla departamento*/
INSERT INTO GR04_departamento(id_dpto,descripcion,superficie,id_tipo_depto,tipo_doc,nro_doc,precio_noche,costo_limpieza, ciudad) VALUES (1,'muy feo',114,1,1,'12',24.5,20,'San Francisco');
INSERT INTO GR04_departamento(id_dpto,descripcion,superficie,id_tipo_depto,tipo_doc,nro_doc,precio_noche,costo_limpieza, ciudad) VALUES (2,'muy lindo',120,2,1,'123',24.5,20,'New York');
INSERT INTO GR04_departamento(id_dpto,descripcion,superficie,id_tipo_depto,tipo_doc,nro_doc,precio_noche,costo_limpieza, ciudad) VALUES (3,'muy feo',130,3,1,'123',24.5,20,'Los Angeles');
INSERT INTO GR04_departamento(id_dpto,descripcion,superficie,id_tipo_depto,tipo_doc,nro_doc,precio_noche,costo_limpieza, ciudad) VALUES (4,'muy chico',90,4,1,'125',24.5,10,'Miami');
INSERT INTO GR04_departamento(id_dpto,descripcion,superficie,id_tipo_depto,tipo_doc,nro_doc,precio_noche,costo_limpieza, ciudad) VALUES (5,'muy grande',140,5,1,'125',24.5,30,'Las Vegas');
INSERT INTO GR04_departamento(id_dpto,descripcion,superficie,id_tipo_depto,tipo_doc,nro_doc,precio_noche,costo_limpieza, ciudad) VALUES (6,'hermoso',140,6,1,'125',24.5,40,'San Diego');
--/*insert a la tabla tipo_pago*/
INSERT INTO GR04_Tipo_Pago(id_tipo_pago,nombre) VALUES (1, 'Visa');
INSERT INTO GR04_Tipo_Pago(id_tipo_pago,nombre) VALUES (2, 'Mastercard');
INSERT INTO GR04_Tipo_Pago(id_tipo_pago,nombre) VALUES (3, 'American Express');
INSERT INTO GR04_Tipo_Pago(id_tipo_pago,nombre) VALUES (4, 'Pago Facil');
INSERT INTO GR04_Tipo_Pago(id_tipo_pago,nombre) VALUES (5, 'Rapipago');
INSERT INTO GR04_Tipo_Pago(id_tipo_pago,nombre) VALUES (6, 'Interbank');
--/*insert a la tabla habitacion*/
INSERT INTO GR04_habitacion(id_dpto,id_habitacion,posib_camas_simples,posib_camas_dobles,posib_camas_kind,tv,sillon,frigobar,mesa,sillas,cocina)
VALUES(1,1,2,1,0,true,1,true,true,6,false);/*depto 1*/
INSERT INTO GR04_habitacion(id_dpto,id_habitacion,posib_camas_simples,posib_camas_dobles,posib_camas_kind,tv,sillon,frigobar,mesa,sillas,cocina)
VALUES(1,2,2,1,0,true,1,true,true,6,false);/*depto 1*/
INSERT INTO GR04_habitacion(id_dpto,id_habitacion,posib_camas_simples,posib_camas_dobles,posib_camas_kind,tv,sillon,frigobar,mesa,sillas,cocina)
VALUES(2,3,2,1,1,true,1,true,true,6,false);/*depto 2*/
INSERT INTO GR04_habitacion(id_dpto,id_habitacion,posib_camas_simples,posib_camas_dobles,posib_camas_kind,tv,sillon,frigobar,mesa,sillas,cocina)
VALUES(3,4,2,1,0,true,1,true,true,6,false);/*depto 3*/
INSERT INTO GR04_habitacion(id_dpto,id_habitacion,posib_camas_simples,posib_camas_dobles,posib_camas_kind,tv,sillon,frigobar,mesa,sillas,cocina)
VALUES(3,5,2,1,0,true,1,true,true,6,false);/*depto 3*/
INSERT INTO GR04_habitacion(id_dpto,id_habitacion,posib_camas_simples,posib_camas_dobles,posib_camas_kind,tv,sillon,frigobar,mesa,sillas,cocina)
VALUES(3,6,2,1,0,true,1,true,true,6,false);/*depto 3*/
INSERT INTO GR04_habitacion(id_dpto,id_habitacion,posib_camas_simples,posib_camas_dobles,posib_camas_kind,tv,sillon,frigobar,mesa,sillas,cocina)
VALUES(4,7,2,1,0,true,1,true,true,6,false);/*depto 4*/
INSERT INTO GR04_habitacion(id_dpto,id_habitacion,posib_camas_simples,posib_camas_dobles,posib_camas_kind,tv,sillon,frigobar,mesa,sillas,cocina)
VALUES(4,8,2,1,0,true,2,true,true,6,false);/*depto 4*/
INSERT INTO GR04_habitacion(id_dpto,id_habitacion,posib_camas_simples,posib_camas_dobles,posib_camas_kind,tv,sillon,frigobar,mesa,sillas,cocina)
VALUES(5,9,2,1,0,true,1,true,true,2,false);/*depto 5*/
INSERT INTO GR04_habitacion(id_dpto,id_habitacion,posib_camas_simples,posib_camas_dobles,posib_camas_kind,tv,sillon,frigobar,mesa,sillas,cocina)
VALUES(5,10,2,1,0,true,1,true,true,3,false);/*depto 5*/
INSERT INTO GR04_habitacion(id_dpto,id_habitacion,posib_camas_simples,posib_camas_dobles,posib_camas_kind,tv,sillon,frigobar,mesa,sillas,cocina)
VALUES(5,11,2,1,0,true,1,true,true,2,false);/*depto 5*/
INSERT INTO GR04_habitacion(id_dpto,id_habitacion,posib_camas_simples,posib_camas_dobles,posib_camas_kind,tv,sillon,frigobar,mesa,sillas,cocina)
VALUES(6,12,2,1,0,true,1,true,true,3,false);/*depto 6*/
/*insert a la reserva*/
INSERT INTO GR04_Reserva(id_reserva,fecha_reserva,fecha_desde,fecha_hasta,tipo,id_dpto,valor_noche,usa_limpieza,tipo_doc,nro_doc)
VALUES (1,'2018-05-03', '2018-05-03', '2018-05-10', 'Inmediata', 1, 1500, 15, 1, '12');
INSERT INTO GR04_Reserva(id_reserva,fecha_reserva,fecha_desde,fecha_hasta,tipo,id_dpto,valor_noche,usa_limpieza,tipo_doc,nro_doc)
VALUES (2,'2017-08-12', '2017-08-10', '2017-08-10', '', 2, 2500, 20, 1, '123');
INSERT INTO GR04_Reserva(id_reserva,fecha_reserva,fecha_desde,fecha_hasta,tipo,id_dpto,valor_noche,usa_limpieza,tipo_doc,nro_doc)
VALUES (3,'2017-01-18', '2017-01-25', '2017-02-10', 'Tranferencia', 3, 1500, 20, 1, '124');
INSERT INTO GR04_Reserva(id_reserva,fecha_reserva,fecha_desde,fecha_hasta,tipo,id_dpto,valor_noche,usa_limpieza,tipo_doc,nro_doc)
VALUES (4,'2016-10-25', '2016-10-26', '2016-10-30', '', 4, 1100, 15, 1, '125');
INSERT INTO GR04_Reserva(id_reserva,fecha_reserva,fecha_desde,fecha_hasta,tipo,id_dpto,valor_noche,usa_limpieza,tipo_doc,nro_doc)
VALUES (5,'2018-07-18', '2018-07-18', '2018-07-24', 'Deposito', 5, 800, 20, 1, '126');
INSERT INTO GR04_Reserva(id_reserva,fecha_reserva,fecha_desde,fecha_hasta,tipo,id_dpto,valor_noche,usa_limpieza,tipo_doc,nro_doc)
VALUES (6,'2018-06-09', '2018-06-12', '2018-06-25', '', 6, 720, 15, 1, '12');
--/*insert a la tabla pago*/
INSERT INTO GR04_Pago(fecha_pago,id_reserva,id_tipo_pago,comentario,importe)
VALUES ('2017-01-18', 1, 1, 'Pago por tarjeta',25);
INSERT INTO GR04_Pago(fecha_pago,id_reserva,id_tipo_pago,comentario,importe)
VALUES ('2018-10-23', 2, 2, 'Pago por tarjeta',100);
INSERT INTO GR04_Pago(fecha_pago,id_reserva,id_tipo_pago,comentario,importe)
VALUES ('2018-05-08', 3, 3, 'Pago por tarjeta',100);
INSERT INTO GR04_Pago(fecha_pago,id_reserva,id_tipo_pago,comentario,importe)
VALUES ('2018-04-12', 4, 4, 'Pago por tarjeta',150);
INSERT INTO GR04_Pago(fecha_pago,id_reserva,id_tipo_pago,comentario,importe)
VALUES ('2017-08-05', 5, 5, 'Pago por tarjeta',200);
INSERT INTO GR04_Pago(fecha_pago,id_reserva,id_tipo_pago,comentario,importe)
VALUES ('2016-07-16', 6, 6, 'Pago por tarjeta',1500);
--/*insert a la tabla costo dpto*/
INSERT INTO GR04_costodepto(id_dpto,fecha_desde,fecha_hasta,precio_noche) VALUES(1,'2018-06-01','2018-06-02',24.5);
INSERT INTO GR04_costodepto(id_dpto,fecha_desde,fecha_hasta,precio_noche) VALUES(2,'2018-05-28','2018-06-03',24.5);
INSERT INTO GR04_costodepto(id_dpto,fecha_desde,fecha_hasta,precio_noche) VALUES(3,'2018-05-02','2018-06-04',24.5);
INSERT INTO GR04_costodepto(id_dpto,fecha_desde,fecha_hasta,precio_noche) VALUES(4,'2018-05-15','2018-06-05',24.5);
INSERT INTO GR04_costodepto(id_dpto,fecha_desde,fecha_hasta,precio_noche) VALUES(5,'2018-05-20','2018-06-06',24.5);
INSERT INTO GR04_costodepto(id_dpto,fecha_desde,fecha_hasta,precio_noche) VALUES(6,'2018-05-10','2018-06-07',24.5);
/*insert a la tabla estado luego de ocupacion*/
INSERT INTO GR04_estadoluegoocupacion(fecha,id_reserva,comentario) VALUES('2018-06-02',1,'muy sucio');
INSERT INTO GR04_estadoluegoocupacion(fecha,id_reserva,comentario) VALUES('2018-06-03',2,'muy sucio');
INSERT INTO GR04_estadoluegoocupacion(fecha,id_reserva,comentario) VALUES('2018-06-04',3,'muy sucio');
INSERT INTO GR04_estadoluegoocupacion(fecha,id_reserva,comentario) VALUES('2018-06-05',4,'muy sucio');
INSERT INTO GR04_estadoluegoocupacion(fecha,id_reserva,comentario) VALUES('2018-06-06',5,'muy sucio');
INSERT INTO GR04_estadoluegoocupacion(fecha,id_reserva,comentario) VALUES('2018-06-07',6,'muy sucio');
--/*sinsert a la tabla huesped reserva*/--
INSERT INTO GR04_Huesped_Reserva(tipo_doc,nro_doc,id_reserva) VALUES (1, '12', 1);
INSERT INTO GR04_Huesped_Reserva(tipo_doc,nro_doc,id_reserva) VALUES (1, '123', 2);
INSERT INTO GR04_Huesped_Reserva(tipo_doc,nro_doc,id_reserva) VALUES (1, '124', 3);
INSERT INTO GR04_Huesped_Reserva(tipo_doc,nro_doc,id_reserva) VALUES (1, '125', 4);
INSERT INTO GR04_Huesped_Reserva(tipo_doc,nro_doc,id_reserva) VALUES (1, '126', 5);
INSERT INTO GR04_Huesped_Reserva(tipo_doc,nro_doc,id_reserva) VALUES (1, '12', 6);
--/*insert a la tabla comentario*/
INSERT INTO GR04_Comentario(tipo_doc,nro_doc,id_reserva, fecha_hora_comentario, comentario, estrellas)
VALUES (1, '12', 1, '2018-06-10','sucio',2);
INSERT INTO GR04_Comentario(tipo_doc,nro_doc,id_reserva, fecha_hora_comentario, comentario, estrellas)
VALUES (1, '123', 2, '2017-10-25','feo',3);
INSERT INTO GR04_Comentario(tipo_doc,nro_doc,id_reserva, fecha_hora_comentario, comentario, estrellas)
VALUES (1, '124', 3, '2017-02-17','lindo',1);
INSERT INTO GR04_Comentario(tipo_doc,nro_doc,id_reserva, fecha_hora_comentario, comentario, estrellas)
VALUES (1, '125', 4, '2017-01-10','confortable',5);
INSERT INTO GR04_Comentario(tipo_doc,nro_doc,id_reserva, fecha_hora_comentario, comentario, estrellas)
VALUES (1, '126', 5, '2018-09-20','agradable',4);
INSERT INTO GR04_Comentario(tipo_doc,nro_doc,id_reserva, fecha_hora_comentario, comentario, estrellas)
VALUES (1, '12', 6, '2018-07-03','comodo',3);