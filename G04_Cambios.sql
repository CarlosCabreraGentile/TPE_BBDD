--B ELABORACION DE RESTRICCIONES

--a Que las fechas de las reservas sean consistentes, es decir que la fecha de inicio de la reserva 
--sea menor que la fecha de finalización.
ALTER TABLE gr04_reserva
ADD CONSTRAINT fechas_reserva
CHECK(fecha_hasta>fecha_desde)

--b Que el detalle de las habitaciones sea consistente con el tipo de departamento, 
--es decir que si el tipo de departamento es de 2 habitaciones, en el detalle se consideren como máximo 2 habitaciones.
CREATE TRIGGER Tipo_Depto_Habitacion
AFTER INSERT OR UPDATE of id_tipo_depto ON GR04_departamento
FOR EACH ROW
EXECUTE PROCEDURE control_cant_habitaciones_departamento();

CREATE OR REPLACE FUNCTION control_cant_habitaciones_departamento()
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

--c Que tanto la persona que realiza la reserva como los huéspedes no sea el propietario del departamento
CREATE TRIGGER Reserva_no_dueño
AFTER INSERT OR UPDATE ON GR04_reserva
FOR EACH ROW
EXECUTE PROCEDURE control_dueño_no_reserva();

CREATE OR REPLACE FUNCTION control_dueño_no_reserva()
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

CREATE TRIGGER Huesped_Reserva_no_dueño
AFTER INSERT OR UPDATE ON GR04_reserva
FOR EACH ROW
EXECUTE PROCEDURE control_dueño_no_reserva();

CREATE OR REPLACE FUNCTION control_husped_dueño_no_reserva()
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

--d Que la cantidad de huéspedes no supere la cantidad máxima de personas permitidas para una reserva
CREATE TRIGGER Huesped_Reserva_no_superar_cant_huespedes
AFTER INSERT OR UPDATE ON gr04_huesped_reserva
FOR EACH ROW
EXECUTE PROCEDURE no_superar_cant_huespedes();

CREATE OR REPLACE FUNCTION no_superar_cant_huespedes()
RETURNS trigger AS $$
BEGIN
  IF(EXISTS (SELECT 1
  FROM gr04_departamento d
  JOIN gr04_tipo_dpto td ON (td.id_tipo_depto=d.id_tipo_depto)
  WHERE td.cant_max_huespedes<(
  SELECT count(*)AS "cant huespedes"
  FROM gr04_reserva r
  JOIN gr04_huesped_reserva hr ON (hr.id_reserva=r.id_reserva)
  GROUP BY r.id_reserva
  HAVING id_dpto=d.id_dpto)))
THEN
RAISE EXCEPTION 'No se puede, el dueño no puede reservar';
END IF;
RETURN NEW;
END;

$$ language plpgsql;

--C SERVICIOS

--1 Por cada departamento en el sistema, de el estado en una fecha determinada, esto es si el mismo está Ocupado o Libre.
CREATE OR REPLACE FUNCTION disponibilidad_dpto(date)
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

--2 Dado una rango de fechas y una ciudad, devuelva una lista de departamentos disponibles.
CREATE OR REPLACE FUNCTION disponibilidad_dpto_en_rango_fechas(fecha1 date,fecha2 date,city varchar(50))
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
CREATE VIEW departamentos_recaudacion_ultimos_6_meses AS
SELECT d.*, COALESCE(SUM(p.importe), 0)
FROM gr04_departamento d
JOIN gr04_reserva r ON (d.id_dpto = r.id_dpto)
JOIN gr04_pago p ON (p.id_reserva = r.id_reserva)
WHERE r.fecha_desde > current_Date - 180

--2 Devuelva un listado con los departamentos ordenados por ciudad y por mejor rating (estrellas).
CREATE VIEW listado_ciudad_por_nombre_y_rating AS
SELECT d.*, COALESCE(AVG(CAST(c.estrellas AS FLOAT)), 0) AS rating
	FROM gr04_departamento d
	LEFT JOIN gr04_reserva r ON d.id_dpto = r.id_dpto
	LEFT JOIN gr04_comentario c ON r.id_reserva = c.id_reserva
		GROUP BY d.id_dpto
		ORDER BY
		d.ciudad,
		AVG(c.estrellas);