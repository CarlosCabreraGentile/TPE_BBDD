--1) Escriba la restricción de la manera que considere más apropiada en SQL estándar declarativo,
--indicando su tipo y características correspondientes. NO se tendrán en cuenta las tipificaciones
--correctas pero con implementaciones inadecuadas.(incluya el desarrollo en el informe)
--2) Impleméntela en PostgreSQL de la forma más adecuada, según las posibilidades que ofrece el DBMS (incorpore la solución al script GXX_Cambios.sql )
--3) Provea una sentencia de modificación, borrado y/o inserción según corresponda, de modo que promueva la activación de la restricción
--(incorpórela comentada al script GXX_Cambios.sql de modo que la ejecución del mismo no de error). Explique brevemente la respuesta por parte del DBMS (en el informe).
--Se deben realizar los siguientes controles en el esquema de datos:
--a.	Que las fechas de las reservas sean consistentes, es decir que la fecha de inicio de la reserva sea menor que la fecha de finalización.
--b.	Que el detalle de las habitaciones sea consistente con el tipo de departamento, es decir que si el tipo de departamento es de 2 habitaciones,
--en el detalle se consideren como máximo 2 habitaciones.
--c.	Que tanto la persona que realiza la reserva como los huéspedes no sea el propietario del departamento
--d.	Que la cantidad de huéspedes no supere la cantidad máxima de personas permitidas para una reserva
--parte b
--a)
ALTER TABLE gr04_reserva
ADD CONSTRAINT fechas_reserva
CHECK(fecha_hasta>fecha_desde)

--b)
ALTER TABLE id_tipo_depto
ADD CONSTRAINT
CREATE ASSERTION CHECK(NOT EXISTS(select td.*
from gr04_tipo_dpto td
join gr04_departamento d on(d.id_tipo_depto=td.id_tipo_depto)
where td.cant_habitaciones!=(select count(*)
from gr04_habitacion h
group by id_dpto
having id_dpto=d.id_dpto)
)

CREATE TRIGGER Tipo_Depto_Habitacion
AFTER INSERT OR UPDATE of id_tipo_depto ON GR04_departamento
FOR EACH ROW
EXECUTE PROCEDURE control_cant_habitaciones_departamento();

CREATE OR REPLACE FUNCTION control_cant_habitaciones_departamento()
RETURNS trigger AS $$
BEGIN
  IF(EXISTS (select td.*
  from gr04_tipo_dpto td
  join gr04_departamento d on(d.id_tipo_depto=td.id_tipo_depto)
  where td.cant_habitaciones!=(select count(*)
  from gr04_habitacion h
  group by id_dpto
  having id_dpto=d.id_dpto)))
THEN
RAISE EXCEPTION 'No se puede las cantidad de habitaciones no coincide ';
END IF;
RETURN NEW;
END;

$$ language plpgsql;

--c)
ALTER TABLE gr04_huesped_reserva
ADD CONSTRAINT
CREATE ASSERTION CHECK(NOT EXISTS(select 1
from gr04_departamento d
join gr04_reserva r on (r.id_dpto=d.id_dpto)
join gr04_huesped_reserva hr on (hr.id_reserva=r.id_reserva)
where d.tipo_doc=hr.tipo_doc and d.nro_doc=hr.nro_doc))

ALTER TABLE gr04_reserva
ADD CONSTRAINT
CREATE ASSERTION CHECK(NOT EXISTS(select 1
from gr04_departamento d
join gr04_reserva r on (r.id_dpto=d.id_dpto)
where d.tipo_doc=r.tipo_doc and d.nro_doc=r.nro_doc))

CREATE TRIGGER Reserva_no_dueño
AFTER INSERT OR UPDATE ON GR04_reserva
FOR EACH ROW
EXECUTE PROCEDURE control_dueño_no_reserva();

CREATE OR REPLACE FUNCTION control_dueño_no_reserva()
RETURNS trigger AS $$
BEGIN
	IF(EXISTS (select 1
  from gr04_departamento d
  join gr04_reserva r on (r.id_dpto=d.id_dpto)
  where d.tipo_doc=new.tipo_doc and d.nro_doc=new.nro_doc))
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
	IF(EXISTS (select 1
  from gr04_departamento d
  join gr04_reserva r on (r.id_dpto=d.id_dpto)
  join gr04_huesped_reserva hr on (hr.id_reserva=r.id_reserva)
  where d.tipo_doc=new.tipo_doc and d.nro_doc=new.nro_doc))
THEN
RAISE EXCEPTION 'No se puede, el dueño no puede reservar';
END IF;
RETURN NEW;
END;

$$ language plpgsql;

--d)
ALTER TABLE gr04_huesped_reserva
ADD CONSTRAINT
CREATE ASSERTION CHECK(NOT EXISTS(select 1
from gr04_departamento d
join gr04_tipo_dpto td on (td.id_tipo_depto=d.id_tipo_depto)
where td.cant_max_huespedes>=(
select count(*)as "cant huespedes"
from gr04_reserva r
join gr04_huesped_reserva hr on (hr.id_reserva=r.id_reserva)
group by r.id_reserva
having id_dpto=d.id_dpto)

CREATE TRIGGER Huesped_Reserva_no_superar_cant_huespedes
AFTER INSERT OR UPDATE ON gr04_huesped_reserva
FOR EACH ROW
EXECUTE PROCEDURE no_superar_cant_huespedes();

CREATE OR REPLACE FUNCTION no_superar_cant_huespedes()
RETURNS trigger AS $$
BEGIN
  IF(EXISTS (select 1
  from gr04_departamento d
  join gr04_tipo_dpto td on (td.id_tipo_depto=d.id_tipo_depto)
  where td.cant_max_huespedes<(
  select count(*)as "cant huespedes"
  from gr04_reserva r
  join gr04_huesped_reserva hr on (hr.id_reserva=r.id_reserva)
  group by r.id_reserva
  having id_dpto=d.id_dpto)))
THEN
RAISE EXCEPTION 'No se puede, el dueño no puede reservar';
END IF;
RETURN NEW;
END;

$$ language plpgsql;

--PARTE C
--1)
CREATE TABLE Dpto_disponibles (
   id_dpto int not null,
   disponibilidad varchar(15) not null

);
CREATE OR REPLACE FUNCTION disponibilidad_dpto(date)
RETURNS 1 AS
$$
DECLARE
    mi_consulta RECORD;
BEGIN
    FOR mi_consulta IN SELECT * FROM GR04_departamento d
                       JOIN GR04_reserva r ON (r.id_dpto = d.id_dpto)

        LOOP
        if $1>=mi_consulta.fecha_desde and $1<=mi_consulta.fecha_hasta THEN
        INSERT INTO Dpto_disponibles VALUES (
                mi_consulta.id_dpto,
                'Ocupado'
               );
               else
               INSERT INTO Dpto_disponibles VALUES (
                       mi_consulta.id_dpto,
                       'libre'
                      );
               END if;
   END LOOP;
    RETURN 1;
END;
$$
LANGUAGE plpgsql;

v2
CREATE OR REPLACE FUNCTION disponibilidad_dpto(date)
RETURNS TABLE (id_dpto int, Disponibilidad VARCHAR)  AS
$$
DECLARE
    mi_consulta RECORD;
BEGIN
    FOR mi_consulta IN SELECT * FROM GR04_departamento d
                       JOIN GR04_reserva r ON (r.id_dpto = d.id_dpto)

        LOOP
        if $1>=mi_consulta.fecha_desde and $1<=mi_consulta.fecha_hasta THEN

               id_dpto:= mi_consulta.id_dpto;
               Disponibilidad:='Ocupado';

               else
               id_dpto:= mi_consulta.id_dpto;
               Disponibilidad:='Libre';
               END if;
 RETURN next;
   END LOOP;

END;
$$
LANGUAGE plpgsql;
--2)
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
        IF (((fecha1>=mi_consulta.fecha_desde and fecha1<=mi_consulta.fecha_hasta) or (fecha2>=mi_consulta.fecha_desde and fecha2<=mi_consulta.fecha_hasta)) and city=mi_consulta.ciudad) THEN
               id_dpto:= mi_consulta.id_dpto;
               Disponibilidad:='Ocupado';
               else
               id_dpto:= mi_consulta.id_dpto;
               Disponibilidad:='Libre';
               end if;
 RETURN next;
   END LOOP;
END;
$$
LANGUAGE plpgsql;
select *
from gr04_departamento d
join gr04_reserva r on(r.id_dpto=d.id_dpto)

--PARTE D
--Listado de todos los departamentos del sistema junto con la recaudación de los mismos en los últimos 6 meses.
create view departamentos_recaudacion_ultimos_6_meses as
select d.*, COALESCE(SUM(p.importe), 0)
from gr04_departamento d
join gr04_reserva r on (d.id_dpto = r.id_dpto)
join gr04_pago p on (p.id_reserva = r.id_reserva)
where r.fecha_desde > current_Date - 180

create view departamentos_recaudacion_ultimos_6_meses as
select d.*, COALESCE(SUM(p.importe), 0)
from gr04_departamento d
join gr04_reserva r on (d.id_dpto = r.id_dpto)
join gr04_pago p on (p.id_reserva = r.id_reserva)
where r.fecha_desde > current_Date - 180
GROUP BY d.id_dpto

create view listado_ciudad_por_nombre_y_rating as
SELECT d.*, COALESCE(AVG(CAST(c.estrellas AS FLOAT)), 0) as rating
  FROM gr04_departamento d
  LEFT JOIN gr04_reserva r ON d.id_dpto = r.id_dpto
  LEFT JOIN gr04_comentario c ON r.id_reserva = c.id_reserva
  GROUP BY d.id_dpto
  ORDER BY
    d.ciudad,
    AVG(c.estrellas);
