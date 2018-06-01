-- tables
-- Table: Comentario
CREATE TABLE GRXX_Comentario (
    tipo_doc int  NOT NULL,
    nro_doc char(8)  NOT NULL,
    id_reserva int  NOT NULL,
    fecha_hora_comentario date  NOT NULL,
    comentario varchar(512)  NOT NULL,
    estrellas int  NOT NULL,
    CONSTRAINT PK_GRXX_Comentario PRIMARY KEY (tipo_doc,nro_doc,id_reserva,fecha_hora_comentario)
);

-- Table: CostoDepto
CREATE TABLE GRXX_CostoDepto (
    id_dpto int  NOT NULL,
    fecha_desde date  NOT NULL,
    fecha_hasta date  NOT NULL,
    precio_noche decimal(10,2)  NOT NULL,
    CONSTRAINT PK_GRXX_CostoDepto PRIMARY KEY (id_dpto,fecha_desde)
);
  
-- Table: Departamento
CREATE TABLE GRXX_Departamento ( 
    id_dpto int  NOT NULL,
    descripcion varchar(80)  NOT NULL,
    superficie decimal(10,2)  NOT NULL,
    id_tipo_depto int  NOT NULL,
    tipo_doc int  NOT NULL, 
    nro_doc char(8)  NOT NULL,
    precio_noche decimal(10,2)  NOT NULL,
    CONSTRAINT PK_GRXX_Departamento PRIMARY KEY (id_dpto)
);

-- Table: EstadoLuegoOcupacion
CREATE TABLE GRXX_EstadoLuegoOcupacion (
    id_reserva int  NOT NULL,
    fecha int  NOT NULL,
    comentario varchar(2048)  NOT NULL,
    CONSTRAINT PK_GRXX_EstadoLuegoOcupacion PRIMARY KEY (id_reserva,fecha)
);

-- Table: Habitacion
CREATE TABLE GRXX_Habitacion (
    id_dpto int  NOT NULL,
    id_habitacion int  NOT NULL,
    posib_camas_simples int  NOT NULL,
    posib_camas_dobles int  NOT NULL,
    posib_camas_kind int  NOT NULL,
    tv boolean  NOT NULL,
    sillon boolean  NOT NULL, 
    frigobar boolean  NOT NULL,
    mesa boolean  NOT NULL,
    sillas boolean  NOT NULL,
    cocina boolean  NOT NULL,
    CONSTRAINT PK_GRXX_Habitacion PRIMARY KEY (id_dpto,id_habitacion)
);

-- Table: Huesped_Reserva
CREATE TABLE GRXX_Huesped_Reserva (
    tipo_doc int  NOT NULL,
    nro_doc char(8)  NOT NULL,
    id_reserva int  NOT NULL,
    CONSTRAINT PK_GRXX_Huesped_Reserva PRIMARY KEY (tipo_doc,nro_doc,id_reserva)
);

-- Table: Pago
CREATE TABLE GRXX_Pago (
    fecha_pago timestamp  NOT NULL,
    id_reserva int  NOT NULL,
    id_tipo_pago int  NOT NULL,
    comentario varchar(256)  NULL,
    importe decimal(8,2)  NOT NULL,
    CONSTRAINT PK_GRXX_Pago PRIMARY KEY (fecha_pago,id_reserva,id_tipo_pago)
);

-- Table: Persona 
CREATE TABLE GRXX_Persona ( 
    tipo_doc int  NOT NULL, 
    nro_doc char(8)  NOT NULL, 
    apellido varchar(20)  NOT NULL,
    nombre varchar(20)  NOT NULL,
    fecha_nac date  NOT NULL,
    e_mail varchar(20)  NOT NULL,
    CONSTRAINT PK_GRXXPersona PRIMARY KEY (tipo_doc,nro_doc)
);



CREATE Table GRXX_TipoDocumento(
    idTipoDocumento int NOT NULL,
    tipo_doc varchar(3) NOT NULL,
    CONSTRAINT PK_GRXX_TipoDocumento PRIMARY KEY (idTipoDocumento)
);

-- Table: Reserva
CREATE TABLE GRXX_Reserva (
    id_reserva int  NOT NULL,
    fecha_reserva date  NOT NULL,
    fecha_desde date  NOT NULL,
    fecha_hasta date  NOT NULL,
    tipo varchar(15)  NOT NULL,
    id_dpto int  NOT NULL,
    valor_noche decimal(8,2)  NOT NULL,
    limpieza boolean  NOT NULL,
    tipo_doc integer  NOT NULL,
    nro_doc char(8)  NOT NULL,
    CONSTRAINT PK_GRXX_Reserva PRIMARY KEY (id_reserva)
);

-- Table: Tipo_Dpto
CREATE TABLE GRXX_Tipo_Dpto ( 
    id_tipo_depto int  NOT NULL,
    cant_habitaciones int  NOT NULL,
    cant_banios int  NOT NULL,
    cant_max_huespedes int  NOT NULL,
    CONSTRAINT PK_GRXX_Tipo_Dpto PRIMARY KEY (id_tipo_depto)
);

-- Table: Tipo_Pago
CREATE TABLE GRXX_Tipo_Pago (
    id_tipo_pago int  NOT NULL,
    empresa varchar(20)  NOT NULL,
    CONSTRAINT PK_GRXX_Tipo_Pago PRIMARY KEY (id_tipo_pago)
);

-- foreign keys
-- Reference: FK_Comentario_Huesped_Reserva (table: Comentario)
ALTER TABLE GRXX_Comentario ADD CONSTRAINT FK_GRXX_Comentario_Huesped_Reserva
    FOREIGN KEY (tipo_doc, nro_doc, id_reserva)
    REFERENCES GRXX_Huesped_Reserva (tipo_doc, nro_doc, id_reserva)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: FK_CostoDepto_Departamento (table: CostoDepto)
ALTER TABLE GRXX_CostoDepto ADD CONSTRAINT FK_GRXX_CostoDepto_Departamento
    FOREIGN KEY (id_dpto)
    REFERENCES GRXX_Departamento (id_dpto)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: FK_Departamento_Persona (table: Departamento)
ALTER TABLE GRXX_Departamento ADD CONSTRAINT FK_GRXX_Departamento_Persona
    FOREIGN KEY (tipo_doc, nro_doc)
    REFERENCES GRXX_Persona (tipo_doc, nro_doc)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: FK_Departamento_Tipo_Dpto (table: Departamento)
ALTER TABLE GRXX_Departamento ADD CONSTRAINT FK_GRXX_Departamento_Tipo_Dpto
    FOREIGN KEY (id_tipo_depto)
    REFERENCES GRXX_Tipo_Dpto (id_tipo_depto)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: FK_EstadoLuegoOcupacion_Reserva (table: EstadoLuegoOcupacion)
ALTER TABLE GRXX_EstadoLuegoOcupacion ADD CONSTRAINT FK_GRXX_EstadoLuegoOcupacion_Reserva
    FOREIGN KEY (id_reserva) 
    REFERENCES GRXX_Reserva (id_reserva)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: FK_Habitacion_Departamento (table: Habitacion)
ALTER TABLE GRXX_Habitacion ADD CONSTRAINT FK_GRXX_Habitacion_Departamento
    FOREIGN KEY (id_dpto)
    REFERENCES GRXX_Departamento (id_dpto)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: FK_Huesped_Reserva_Huesped (table: Huesped_Reserva)
ALTER TABLE GRXX_Huesped_Reserva ADD CONSTRAINT FK_GRXX_Huesped_Reserva_Persona
    FOREIGN KEY (tipo_doc, nro_doc)
    REFERENCES GRXX_Persona (tipo_doc, nro_doc)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: FK_Huesped_Reserva_Reserva (table: Huesped_Reserva)
ALTER TABLE GRXX_Huesped_Reserva ADD CONSTRAINT FK_GRXX_Huesped_Reserva_Reserva
    FOREIGN KEY (id_reserva)
    REFERENCES GRXX_Reserva (id_reserva)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: FK_Pago_Reserva (table: Pago)
ALTER TABLE GRXX_Pago ADD CONSTRAINT FK_GRXX_Pago_Reserva
    FOREIGN KEY (id_reserva)
    REFERENCES GRXX_Reserva (id_reserva)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: FK_Pago_Tipo_Pago (table: Pago)
ALTER TABLE GRXX_Pago ADD CONSTRAINT FK_GRXX_Pago_Tipo_Pago
    FOREIGN KEY (id_tipo_pago)
    REFERENCES GRXX_Tipo_Pago (id_tipo_pago)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: FK_Pago_Tipo_Pago (table: Pago)
ALTER TABLE GRXX_Persona ADD CONSTRAINT FK_GRXX_Persona 
    FOREIGN KEY (tipo_doc) REFERENCES GRXX_TipoDocumento (idTipoDocumento);

-- Reference: FK_Reserva_Departamento (table: Reserva)
ALTER TABLE GRXX_Reserva ADD CONSTRAINT FK_GRXX_Reserva_Departamento
    FOREIGN KEY (id_dpto)
    REFERENCES GRXX_Departamento (id_dpto)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: FK_Reserva_Persona (table: Reserva)
ALTER TABLE GRXX_Reserva ADD CONSTRAINT FK_GRXX_Reserva_Persona
    FOREIGN KEY (tipo_doc, nro_doc)
    REFERENCES GRXX_Persona (tipo_doc, nro_doc)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- End of file.

