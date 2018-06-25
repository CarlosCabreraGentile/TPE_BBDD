--B ELABORACION DE RESTRICCIONES

--A Que las fechas de las reservas sean consistentes, es decir que la fecha de inicio de la reserva 
--sea menor que la fecha de finalización.
ALTER TABLE gr04_reserva
ADD CONSTRAINT fechas_reserva
CHECK(fecha_hasta>fecha_desde);

--INSERT EN RESERVA QUE ROMPE LA RESTRICCION
--INSERT INTO GR04_Reserva(id_reserva,fecha_reserva,fecha_desde,fecha_hasta,tipo,id_dpto,valor_noche,usa_limpieza,tipo_doc,nro_doc)
--VALUES (8,'03-05-2018', '10-05-2018', '06-05-2018', 'Inmediata', 1, 1500, 15, 1, '12');

--B Que el detalle de las habitaciones sea consistente con el tipo de departamento, 
--es decir que si el tipo de departamento es de 2 habitaciones, en el detalle se consideren como máximo 2 habitaciones.
--FORMA DECLARATIVA
--ALTER TABLE id_tipo_depto
--ADD CONSTRAINT
--CREATE ASSERTION CHECK(NOT EXISTS(select td.*
--from gr04_tipo_dpto td
--join gr04_departamento d on(d.id_tipo_depto=td.id_tipo_depto)
--where td.cant_habitaciones!=(select count(*)
--from gr04_habitacion h
--group by id_dpto
--having id_dpto=d.id_dpto))
CREATE OR REPLACE FUNCTION TRFN_GR04_Control_Cant_Habitaciones_Departamento()
RETURNS trigger AS $$
BEGIN
  IF(EXISTS (SELECT td.*
  FROM gr04_tipo_dpto td
  JOIN gr04_departamento d ON(d.id_tipo_depto=td.id_tipo_depto)
  WHERE td.cant_habitaciones!=(SELECT count(*)
  FROM gr04_habitacion h
  GROUP BY id_dpto
  HAVING id_dpto=d.id_dpto)))
THEN
RAISE EXCEPTION 'No se puede las cantidad de habitaciones no coincide ';
END IF;
RETURN NEW;
END;

$$ language plpgsql;

CREATE TRIGGER TR_GR04_Tipo_Depto_Habitacion
AFTER INSERT OR UPDATE of id_tipo_depto ON GR04_departamento
FOR EACH ROW
EXECUTE PROCEDURE TRFN_GR04_Control_Cant_Habitaciones_Departamento();

--INSERT HABITACIONES EN UN DEPARTAMENTO QUE ROMPE LA RESTRICCION
--SE AGREGA UNA TERCERA HABITACIONES(SE ROMPE)
--INSERT INTO GR04_habitacion(id_dpto,id_habitacion,posib_camas_simples,posib_camas_dobles,posib_camas_kind,tv,sillon,frigobar,mesa,sillas,cocina)
--VALUES(1,3,1,2,0,true,2,true,true,4,true);

--C Que tanto la persona que realiza la reserva como los huéspedes no sea el propietario del departamento
--FORMA DECLARATIVA
--ALTER TABLE gr04_huesped_reserva
--ADD CONSTRAINT
--CREATE ASSERTION CHECK(NOT EXISTS(select 1
--from gr04_departamento d
--join gr04_reserva r on (r.id_dpto=d.id_dpto)
--join gr04_huesped_reserva hr on (hr.id_reserva=r.id_reserva)
--where d.tipo_doc=hr.tipo_doc and d.nro_doc=hr.nro_doc))

--ALTER TABLE gr04_reserva
--ADD CONSTRAINT
--CREATE ASSERTION CHECK(NOT EXISTS(select 1
--from gr04_departamento d
--join gr04_reserva r on (r.id_dpto=d.id_dpto)
--where d.tipo_doc=r.tipo_doc and d.nro_doc=r.nro_doc))
CREATE OR REPLACE FUNCTION TRFN_GR04_Control_Dueño_No_Reserva()
RETURNS trigger AS $$
BEGIN
  IF(EXISTS (SELECT 1
  FROM gr04_departamento d
  JOIN gr04_reserva r ON (r.id_dpto=d.id_dpto)
  WHERE d.tipo_doc=new.tipo_doc AND d.nro_doc=new.nro_doc))
THEN
RAISE EXCEPTION 'No se puede ,el dueño no puede reservar';
END IF;
RETURN NEW;
END;

$$ language plpgsql;

CREATE TRIGGER TR_GR04_Reserva_no_dueño
AFTER INSERT OR UPDATE ON GR04_reserva
FOR EACH ROW
EXECUTE PROCEDURE TRFN_GR04_Control_Dueño_No_Reserva();

--INSERT DE UNA RESERVA POR PARTE DE UN DUEÑO DE DEPARTAMENTO
--INSERT INTO GR04_Reserva(id_reserva,fecha_reserva,fecha_desde,fecha_hasta,tipo,id_dpto,valor_noche,usa_limpieza,tipo_doc,nro_doc)
--VALUES (1,'03-05-2018', '03-05-2018', '10-05-2018', 'Inmediata', 1, 1500, 15, 1, '12');
CREATE OR REPLACE FUNCTION TRFN_GR04_Control_Huesped_Dueño_No_Reserva()
RETURNS trigger AS $$
BEGIN
  IF(EXISTS (SELECT 1
  FROM gr04_departamento d
  JOIN gr04_reserva r ON (r.id_dpto=d.id_dpto)
  JOIN gr04_huesped_reserva hr ON (hr.id_reserva=r.id_reserva)
  WHERE d.tipo_doc=new.tipo_doc AND d.nro_doc=new.nro_doc))
THEN
RAISE EXCEPTION 'No se puede, el dueño no puede reservar';
END IF;
RETURN NEW;
END;

$$ language plpgsql;

CREATE TRIGGER TR_GR04_Huesped_Reserva_no_dueño
AFTER INSERT OR UPDATE ON GR04_reserva
FOR EACH ROW
EXECUTE PROCEDURE TRFN_GR04_Control_Huesped_Dueño_No_Reserva();

--INSERT DE UN HUESPED RESERVA DUEÑO A UNA RESERVA, SE ROMPE PORQUE EL HUESPED RESERVA ES DUEÑO
--INSERT INTO GR04_Huesped_Reserva(tipo_doc,nro_doc,id_reserva) VALUES (1, '12', 1);

--D Que la cantidad de huéspedes no supere la cantidad máxima de personas permitidas para una reserva
--FORMA DECLARATIVA
--ALTER TABLE gr04_huesped_reserva
--ADD CONSTRAINT
--CREATE ASSERTION CHECK(NOT EXISTS(select 1
--from gr04_departamento d
--join gr04_tipo_dpto td on (td.id_tipo_depto=d.id_tipo_depto)
--where td.cant_max_huespedes>=(
--select count(*)as "cant huespedes"
--from gr04_reserva r
--join gr04_huesped_reserva hr on (hr.id_reserva=r.id_reserva)
--group by r.id_reserva
--having id_dpto=d.id_dpto)
CREATE OR REPLACE FUNCTION TRFN_GR04_No_Superar_Cant_Huespedes()
RETURNS trigger AS $$
BEGIN
  IF(EXISTS (SELECT 1
  FROM gr04_departamento d
  JOIN gr04_tipo_dpto td ON (td.id_tipo_depto=d.id_tipo_depto)
  WHERE td.cant_max_huespedes < (
  SELECT count(*)AS "cant huespedes"
  FROM gr04_reserva r
  JOIN gr04_huesped_reserva hr ON (hr.id_reserva=r.id_reserva)
  GROUP BY r.id_reserva
  HAVING id_dpto = d.id_dpto)))
THEN
RAISE EXCEPTION 'No se puede, el dueño no puede reservar';
END IF;
RETURN NEW;
END;

$$ language plpgsql;

CREATE OR REPLACE FUNCTION TRFN_GR04_Disponibilidad_Dpto(date)
RETURNS TABLE (id_dpto int, Disponibilidad VARCHAR)  AS
$$
DECLARE
    mi_consulta RECORD;
BEGIN
    FOR mi_consulta IN SELECT * FROM GR04_departamento d
                       JOIN GR04_reserva r ON (r.id_dpto = d.id_dpto)

        LOOP
        if $1>=mi_consulta.fecha_desde AND $1<=mi_consulta.fecha_hasta THEN

               id_dpto:= mi_consulta.id_dpto;
               Disponibilidad:='Ocupado';

               ELSE
               id_dpto:= mi_consulta.id_dpto;
               Disponibilidad:='Libre';
               END if;
 RETURN next;
   END LOOP;

END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER TR_GR04_Huesped_Reserva_no_superar_cant_huespedes
AFTER INSERT OR UPDATE ON gr04_huesped_reserva
FOR EACH ROW
EXECUTE PROCEDURE TRFN_GR04_No_Superar_Cant_Huespedes();

--INSERT DE UN HUESPED RESERVA A UNA RESERVA, SE ROMPE PORQUE EXCEDE EL NUMERO DE HUESPEDES POR RESERVA
--INSERT INTO GR04_Huesped_Reserva(tipo_doc,nro_doc,id_reserva) VALUES (1, '125', 2);

--C SERVICIOS

--1 Por cada departamento en el sistema, de el estado en una fecha determinada, esto es si el mismo está Ocupado o Libre.


--2 Dado una rango de fechas y una ciudad, devuelva una lista de departamentos disponibles.
CREATE OR REPLACE FUNCTION TRFN_GR04_Disponibilidad_Dpto_En_Rango_Fechas(fecha1 date,fecha2 date,city varchar(50))
RETURNS TABLE (id_dpto int, Disponibilidad VARCHAR)  AS
$$
DECLARE
    mi_consulta RECORD;
BEGIN
    FOR mi_consulta IN SELECT * FROM GR04_departamento d
                       JOIN GR04_reserva r ON (r.id_dpto = d.id_dpto)
                       WHERE ciudad=city

        LOOP
        IF (((fecha1 >= mi_consulta.fecha_desde AND fecha1 <= mi_consulta.fecha_hasta) OR 
        	(fecha2 >= mi_consulta.fecha_desde AND fecha2 <= mi_consulta.fecha_hasta)) AND city = mi_consulta.ciudad) 
        	THEN
               id_dpto:= mi_consulta.id_dpto;
               Disponibilidad:='Ocupado';
               ELSE
               id_dpto:= mi_consulta.id_dpto;
               Disponibilidad:='Libre';
               END if;
 RETURN next;
   END LOOP;
END;
$$
LANGUAGE plpgsql;

--INCISO D DEFINICION DE VISTAS

--1 Devuelva un listado de todos los departamentos del sistema junto con la recaudación de los mismos en los últimos 6 meses.
CREATE VIEW GR04_Departamentos_Recaudacion_Ultimos_6_Meses AS
SELECT d.id_dpto, COALESCE(SUM(p.importe), 0)
FROM gr04_departamento d
JOIN gr04_reserva r ON (d.id_dpto = r.id_dpto)
JOIN gr04_pago p ON (p.id_reserva = r.id_reserva)
WHERE r.fecha_desde > current_Date - 180
GROUP BY d.id_dpto;

--2 Devuelva un listado con los departamentos ordenados por ciudad y por mejor rating (estrellas).
CREATE VIEW GR04_Listado_Ciudad_Por_Nombre_Y_Rating AS
SELECT d.id_dpto, COALESCE(AVG(CAST(c.estrellas AS FLOAT)), 0) AS rating
	FROM gr04_departamento d
	LEFT JOIN gr04_reserva r ON d.id_dpto = r.id_dpto
	LEFT JOIN gr04_comentario c ON r.id_reserva = c.id_reserva
		GROUP BY d.id_dpto
		ORDER BY
		d.ciudad,
		AVG(c.estrellas);