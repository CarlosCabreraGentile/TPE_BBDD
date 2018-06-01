--/*insert a la tabla tipodocumento*/
INSERT INTO GR04_tipodocumento(idtipodocumento,tipo_doc) VALUES (1,'DNI');
INSERT INTO GR04_tipodocumento(idtipodocumento,tipo_doc) VALUES (2,'LIB');
INSERT INTO GR04_tipodocumento(idtipodocumento,tipo_doc) VALUES (3,'PAS');
INSERT INTO GR04_tipodocumento(idtipodocumento,tipo_doc) VALUES (4,'CED');
--/*insert a la tabla persona*/
INSERT INTO GR04_persona(tipo_doc,nro_doc,apellido,nombre,fecha_nac,e_mail) VALUES(1,'12','guerra','maxi','27-9-1985','guerramdg@gmail.com');
INSERT INTO GR04_persona(tipo_doc,nro_doc,apellido,nombre,fecha_nac,e_mail) VALUES(1,'123','perez','carlos','27-9-1985','perez@gmail.com');
INSERT INTO GR04_persona(tipo_doc,nro_doc,apellido,nombre,fecha_nac,e_mail) VALUES(1,'124','garcia','marcos','27-9-1985','garcia@gmail.com');
INSERT INTO GR04_persona(tipo_doc,nro_doc,apellido,nombre,fecha_nac,e_mail) VALUES(1,'125','alonso','silvina','27-9-1985','alonso@gmail.com');
INSERT INTO GR04_persona(tipo_doc,nro_doc,apellido,nombre,fecha_nac,e_mail) VALUES(1,'126','piagentini','morena','27-9-1985','piagentini@gmail.com');
INSERT INTO GR04_persona(tipo_doc,nro_doc,apellido,nombre,fecha_nac,e_mail) VALUES(1,'222','lopez','juan','27-9-1995','lopez@gmail.com');
INSERT INTO GR04_persona(tipo_doc,nro_doc,apellido,nombre,fecha_nac,e_mail) VALUES(1,'223','gonzalez','pedro','17-10-1992','gonzalez@gmail.com');
INSERT INTO GR04_persona(tipo_doc,nro_doc,apellido,nombre,fecha_nac,e_mail) VALUES(1,'224','fernandez','maria','05-04-1981','fernandez@gmail.com');
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
INSERT INTO GR04_departamento(id_dpto,descripcion,superficie,id_tipo_depto,tipo_doc,nro_doc,precio_noche) VALUES (1,'muy feo',114,1,1,'12',24.5);
INSERT INTO GR04_departamento(id_dpto,descripcion,superficie,id_tipo_depto,tipo_doc,nro_doc,precio_noche) VALUES (2,'muy lindo',120,2,1,'123',24.5);
INSERT INTO GR04_departamento(id_dpto,descripcion,superficie,id_tipo_depto,tipo_doc,nro_doc,precio_noche) VALUES (3,'muy feo',130,3,1,'123',24.5);
INSERT INTO GR04_departamento(id_dpto,descripcion,superficie,id_tipo_depto,tipo_doc,nro_doc,precio_noche) VALUES (4,'muy chico',90,4,1,'125',24.5);
INSERT INTO GR04_departamento(id_dpto,descripcion,superficie,id_tipo_depto,tipo_doc,nro_doc,precio_noche) VALUES (5,'muy grande',140,5,1,'125',24.5);
INSERT INTO GR04_departamento(id_dpto,descripcion,superficie,id_tipo_depto,tipo_doc,nro_doc,precio_noche) VALUES (6,'hermoso',140,5,1,'125',24.5);
--/*insert a la tabla tipo_pago*/
INSERT INTO GR04_Tipo_Pago(id_tipo_pago,empresa) VALUES (1, 'Visa');
INSERT INTO GR04_Tipo_Pago(id_tipo_pago,empresa) VALUES (2, 'Mastercard');
INSERT INTO GR04_Tipo_Pago(id_tipo_pago,empresa) VALUES (3, 'American Express');
INSERT INTO GR04_Tipo_Pago(id_tipo_pago,empresa) VALUES (4, 'Pago Facil');
INSERT INTO GR04_Tipo_Pago(id_tipo_pago,empresa) VALUES (5, 'Rapipago');
INSERT INTO GR04_Tipo_Pago(id_tipo_pago,empresa) VALUES (6, 'Interbank');
--/*insert a la tabla habitacion*/
INSERT INTO GR04_habitacion(id_dpto,id_habitacion,posib_camas_simples,posib_camas_dobles,posib_camas_kind,tv,sillon,frigobar,mesa,sillas,cocina)
VALUES(1,1,2,1,0,true,true,true,true,false,false);
INSERT INTO GR04_habitacion(id_dpto,id_habitacion,posib_camas_simples,posib_camas_dobles,posib_camas_kind,tv,sillon,frigobar,mesa,sillas,cocina)
VALUES(2,1,2,1,1,true,true,true,true,false,false);
INSERT INTO GR04_habitacion(id_dpto,id_habitacion,posib_camas_simples,posib_camas_dobles,posib_camas_kind,tv,sillon,frigobar,mesa,sillas,cocina)
VALUES(3,1,2,1,0,true,true,true,true,false,false);
INSERT INTO GR04_habitacion(id_dpto,id_habitacion,posib_camas_simples,posib_camas_dobles,posib_camas_kind,tv,sillon,frigobar,mesa,sillas,cocina)
VALUES(4,1,2,1,0,true,true,true,true,false,false);
INSERT INTO GR04_habitacion(id_dpto,id_habitacion,posib_camas_simples,posib_camas_dobles,posib_camas_kind,tv,sillon,frigobar,mesa,sillas,cocina)
VALUES(5,1,2,1,0,true,true,true,true,false,false);
/*insert a la reserva*/
INSERT INTO GR04_Reserva(id_reserva,fecha_reserva,fecha_desde,fecha_hasta,tipo,id_dpto,valor_noche,limpieza,tipo_doc,nro_doc)
VALUES (1,'03-05-2018', '03-05-2018', '10-05-2018', 'Inmediata', 1, 1500, true, 1, '12');
INSERT INTO GR04_Reserva(id_reserva,fecha_reserva,fecha_desde,fecha_hasta,tipo,id_dpto,valor_noche,limpieza,tipo_doc,nro_doc)
VALUES (2,'12-08-2017', '10-08-2017', '18-08-2017', '', 2, 2500, true, 1, '123');
INSERT INTO GR04_Reserva(id_reserva,fecha_reserva,fecha_desde,fecha_hasta,tipo,id_dpto,valor_noche,limpieza,tipo_doc,nro_doc)
VALUES (3,'18-01-2017', '25-01-2017', '10-02-2017', 'Tranferencia', 3, 1500, false, 1, '124');
INSERT INTO GR04_Reserva(id_reserva,fecha_reserva,fecha_desde,fecha_hasta,tipo,id_dpto,valor_noche,limpieza,tipo_doc,nro_doc)
VALUES (4,'25-10-2016', '26-10-2016', '30-10-2016', '', 4, 1100, false, 1, '125');
INSERT INTO GR04_Reserva(id_reserva,fecha_reserva,fecha_desde,fecha_hasta,tipo,id_dpto,valor_noche,limpieza,tipo_doc,nro_doc)
VALUES (5,'18-07-2018', '18-07-2018', '24-07-2018', 'Deposito', 5, 800, false, 1, '126');
INSERT INTO GR04_Reserva(id_reserva,fecha_reserva,fecha_desde,fecha_hasta,tipo,id_dpto,valor_noche,limpieza,tipo_doc,nro_doc)
VALUES (6,'09-06-2018', '12-06-2018', '25-06-2018', '', 6, 720, true, 1, '12');
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
INSERT INTO GR04_costodepto(id_dpto,fecha_desde,fecha_hasta,precio_noche) VALUES(1,'01-06-2018','02-06-2018',24.5);
INSERT INTO GR04_costodepto(id_dpto,fecha_desde,fecha_hasta,precio_noche) VALUES(2,'28-05-2018','03-06-2018',24.5);
INSERT INTO GR04_costodepto(id_dpto,fecha_desde,fecha_hasta,precio_noche) VALUES(3,'02-05-2018','04-06-2018',24.5);
INSERT INTO GR04_costodepto(id_dpto,fecha_desde,fecha_hasta,precio_noche) VALUES(4,'15-05-2018','05-06-2018',24.5);
INSERT INTO GR04_costodepto(id_dpto,fecha_desde,fecha_hasta,precio_noche) VALUES(5,'20-05-2018','06-06-2018',24.5);
INSERT INTO GR04_costodepto(id_dpto,fecha_desde,fecha_hasta,precio_noche) VALUES(6,'10-05-2018','07-06-2018',24.5);
/*insert a la tabla estado luego de ocupacion*/
INSERT INTO GR04_estadoluegoocupacion(id_reserva,fecha,comentario) VALUES(1,'02-06-2018','muy sucio');
INSERT INTO GR04_estadoluegoocupacion(id_reserva,fecha,comentario) VALUES(1,'03-06-2018','muy sucio');
INSERT INTO GR04_estadoluegoocupacion(id_reserva,fecha,comentario) VALUES(1,'04-06-2018','muy sucio');
INSERT INTO GR04_estadoluegoocupacion(id_reserva,fecha,comentario) VALUES(1,'05-06-2018','muy sucio');
INSERT INTO GR04_estadoluegoocupacion(id_reserva,fecha,comentario) VALUES(1,'06-06-2018','muy sucio');
INSERT INTO GR04_estadoluegoocupacion(id_reserva,fecha,comentario) VALUES(1,'07-06-2018','muy sucio');
--/*sinsert a la tabla huesped reserva*/--
INSERT INTO GR04_Huesped_Reserva(tipo_doc,nro_doc,id_reserva) VALUES (1, '12', 1);
INSERT INTO GR04_Huesped_Reserva(tipo_doc,nro_doc,id_reserva) VALUES (1, '123', 2);
INSERT INTO GR04_Huesped_Reserva(tipo_doc,nro_doc,id_reserva) VALUES (1, '124', 3);
INSERT INTO GR04_Huesped_Reserva(tipo_doc,nro_doc,id_reserva) VALUES (1, '125', 4);
INSERT INTO GR04_Huesped_Reserva(tipo_doc,nro_doc,id_reserva) VALUES (1, '126', 5);
INSERT INTO GR04_Huesped_Reserva(tipo_doc,nro_doc,id_reserva) VALUES (1, '12', 6);
--/*insert a la tabla comentario*/
INSERT INTO GR04_Comentario(tipo_doc,nro_doc,id_reserva, fecha_hora_comentario, comentario, estrellas)
VALUES (1, '12', 1, '10-06-2018','sucio',2);
INSERT INTO GR04_Comentario(tipo_doc,nro_doc,id_reserva, fecha_hora_comentario, comentario, estrellas)
VALUES (1, '123', 2, '25-10-2017','feo',3);
INSERT INTO GR04_Comentario(tipo_doc,nro_doc,id_reserva, fecha_hora_comentario, comentario, estrellas)
VALUES (1, '124', 3, '17-02-2017','lindo',1);
INSERT INTO GR04_Comentario(tipo_doc,nro_doc,id_reserva, fecha_hora_comentario, comentario, estrellas)
VALUES (1, '125', 4, '10-1-2017','confortable',5);
INSERT INTO GR04_Comentario(tipo_doc,nro_doc,id_reserva, fecha_hora_comentario, comentario, estrellas)
VALUES (1, '126', 5, '20-09-2018','agradable',4);
INSERT INTO GR04_Comentario(tipo_doc,nro_doc,id_reserva, fecha_hora_comentario, comentario, estrellas)
VALUES (1, '12', 6, '03-07-2018','comodo',3);
