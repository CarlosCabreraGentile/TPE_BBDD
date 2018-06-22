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
    CONSTRAINT PK_GR04_Departamento PRIMARY KEY (id_dpto)
);

-- Table: Estado_Luego_Ocupacion_Reserva
CREATE TABLE GR04_EstadoLuegoOcupacion (
    fecha int  NOT NULL,
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
    REFERENCES GR04_Tipo_Pago (id_reserva)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: FK_Pago_Tipo_Pago (table: Pago)
ALTER TABLE GR04_Pago ADD CONSTRAINT FK_GR04_Pago_Tipo_Pago
    FOREIGN KEY (id_tipo_pago)
    REFERENCES Tipo_Pago (id_tipo_pago)  
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

