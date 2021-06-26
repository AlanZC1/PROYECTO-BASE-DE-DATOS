/*==============================================================*/
/* Table: AREA_DE_TRABAJO                                       */
/*==============================================================*/
create table AREA_DE_TRABAJO (
   AREA_ID              INT4                 not null,
   AREA_NOMBRE          VARCHAR(30)          not null,
   constraint PK_AREA_DE_TRABAJO primary key (AREA_ID)
);



/*==============================================================*/
/* Table: CATEGORIA                                             */
/*==============================================================*/
create table CATEGORIA (
   CATEGORIA_ID         INT4                 not null,
   CATEGORIA_DESCRIPCION VARCHAR(30)          not null,
   constraint PK_CATEGORIA primary key (CATEGORIA_ID)
);



/*==============================================================*/
/* Table: CLIENTE                                               */
/*==============================================================*/
create table CLIENTE (
   CLIENTE_CODIGO       INT4                 not null,
   CLIENTE_NOMBRE       VARCHAR(30)          not null,
   CLIENTE_APELLIDOS    VARCHAR(30)          not null,
   CLIENTE_DIRECCION    VARCHAR(30)          not null,
   CLIENTE_TELEFONO     INT4                 not null,
   CLIENTE_FECHANACIMIENTO INT4                 not null,
   CLIENTE_GENERO       VARCHAR(30)          not null,
   CLIENTE_CORREO       VARCHAR(30)          not null,
   constraint PK_CLIENTE primary key (CLIENTE_CODIGO)
);



/*==============================================================*/
/* Table: DETALLES_VENTA                                        */
/*==============================================================*/
create table DETALLES_VENTA (
   DETALLES_ID          INT4                 not null,
   VENTA_ID             INT4                 null,
   PRODUCTO_CODIGO      INT4                 null,
   DETALLES_CANTIDAD_PRODUCTO INT4                 not null,
   DETALLES_PRECIO_PRODUCTO DECIMAL              not null,
   DETALLES_TOTAL       DECIMAL              not null,
   FECHA_VENTA          DATE                 not null,
   constraint PK_DETALLES_VENTA primary key (DETALLES_ID)
);

/*==============================================================*/
/* Table: DEVOLUCIONES                                          */
/*==============================================================*/
create table DEVOLUCIONES (
   DEVOLUCIONES_ID      INT4                 not null,
   VENTA_ID             INT4                 null,
   DEVOLUCION_DESCRIPCION VARCHAR(30)          null,
   constraint PK_DEVOLUCIONES primary key (DEVOLUCIONES_ID)
);


/*==============================================================*/
/* Table: EMPLEADO                                              */
/*==============================================================*/
create table EMPLEADO (
   EMPLEADO_CODIGO      INT4                 not null,
   SUCURSAL_CODIGO      INT4                 null,
   AREA_ID              INT4                 null,
   EMPLEADO_APELLIDO    VARCHAR(30)          not null,
   EMPLEADO_F_NACIMIENTO DATE                 not null,
   EMPLEADO_TELEFONO    INT4                 not null,
   EMPLEADO_CORREO      VARCHAR(30)          not null,
   EMPLEADO_GENERO      VARCHAR(30)          not null,
   EMPLEADO_NOMBRE      VARCHAR(30)          not null,
   constraint PK_EMPLEADO primary key (EMPLEADO_CODIGO)
);



/*==============================================================*/
/* Table: EMPRESA                                               */
/*==============================================================*/
create table EMPRESA (
   EMPRESA_NOMBRE       VARCHAR(30)          not null,
   EMPRESA_RUC          INT4                 not null,
   EMPRESA_DIRECCION    VARCHAR(30)          not null,
   EMPRESA_TELEFONO     NUMERIC(15)          not null,
   constraint PK_EMPRESA primary key (EMPRESA_RUC)
);


/*==============================================================*/
/* Table: PRODUCTO                                              */
/*==============================================================*/
create table PRODUCTO (
   PRODUCTO_CODIGO      INT4                 not null,
   CATEGORIA_ID         INT4                 null,
   PROVEEDOR_CODIGO     INT4                 null,
   PRODUCTO_NOMBRE      VARCHAR(30)          not null,
   PRODUCTO_COSTO       DECIMAL              not null,
   PRODUCTO_PRECIO      DECIMAL              not null,
   PRODUCTO_STOCK       INT4                 not null,
   constraint PK_PRODUCTO primary key (PRODUCTO_CODIGO)
);

/*==============================================================*/
/* Table: PROVEEDOR                                             */
/*==============================================================*/
create table PROVEEDOR (
   PROVEEDOR_CODIGO     INT4                 not null,
   PROVEEDOR_NOMBRE     VARCHAR(30)          not null,
   PROVEEDOR_DIRECCION  VARCHAR(30)          not null,
   PROVEEDOR_TELEFONO   INT4                 not null,
   PROVEEDOR_CORREO     VARCHAR(30)          not null,
   PROVEEDOR_FECHA_ENTREGA DATE                 not null,
   constraint PK_PROVEEDOR primary key (PROVEEDOR_CODIGO)
);

/*==============================================================*/
/* Table: SUCURSAL                                              */
/*==============================================================*/
create table SUCURSAL (
   SUCURSAL_CODIGO      INT4                 not null,
   EMPRESA_RUC          INT4                 null,
   SUCURSAL_DIRECCION   VARCHAR(30)          not null,
   SUCURSAL_TELEFONO    INT4                 not null,
   constraint PK_SUCURSAL primary key (SUCURSAL_CODIGO)
);


/*==============================================================*/
/* Table: SUCURSAL_PROVEEDORES                                  */
/*==============================================================*/
create table SUCURSAL_PROVEEDORES (
   ID                   INT4                 not null,
   SUCURSAL_CODIGO      INT4                 null,
   PROVEEDOR_CODIGO     INT4                 null,
   constraint PK_SUCURSAL_PROVEEDORES primary key (ID)
);


/*==============================================================*/
/* Table: VENTA                                                 */
/*==============================================================*/
create table VENTA (
   VENTA_ID             INT4                 not null,
   CLIENTE_CODIGO       INT4                 null,
   EMPLEADO_CODIGO      INT4                 null,
   FECHA_VENTA          DATE                 not null,
   constraint PK_VENTA primary key (VENTA_ID)
);


alter table DETALLES_VENTA
   add constraint FK_DETALLES_RELATIONS_PRODUCTO foreign key (PRODUCTO_CODIGO)
      references PRODUCTO (PRODUCTO_CODIGO)
      on delete restrict on update restrict;

alter table DETALLES_VENTA
   add constraint FK_DETALLES_RELATIONS_VENTA foreign key (VENTA_ID)
      references VENTA (VENTA_ID)
      on delete restrict on update restrict;

alter table DEVOLUCIONES
   add constraint FK_DEVOLUCI_RELATIONS_VENTA foreign key (VENTA_ID)
      references VENTA (VENTA_ID)
      on delete restrict on update restrict;

alter table EMPLEADO
   add constraint FK_EMPLEADO_RELATIONS_AREA_DE_ foreign key (AREA_ID)
      references AREA_DE_TRABAJO (AREA_ID)
      on delete restrict on update restrict;

alter table EMPLEADO
   add constraint FK_EMPLEADO_RELATIONS_SUCURSAL foreign key (SUCURSAL_CODIGO)
      references SUCURSAL (SUCURSAL_CODIGO)
      on delete restrict on update restrict;

alter table PRODUCTO
   add constraint FK_PRODUCTO_RELATIONS_PROVEEDO foreign key (PROVEEDOR_CODIGO)
      references PROVEEDOR (PROVEEDOR_CODIGO)
      on delete restrict on update restrict;

alter table PRODUCTO
   add constraint FK_PRODUCTO_RELATIONS_CATEGORI foreign key (CATEGORIA_ID)
      references CATEGORIA (CATEGORIA_ID)
      on delete restrict on update restrict;

alter table SUCURSAL
   add constraint FK_SUCURSAL_RELATIONS_EMPRESA foreign key (EMPRESA_RUC)
      references EMPRESA (EMPRESA_RUC)
      on delete restrict on update restrict;

alter table SUCURSAL_PROVEEDORES
   add constraint FK_SUCURSAL_RELATIONS_SUCURSAL foreign key (SUCURSAL_CODIGO)
      references SUCURSAL (SUCURSAL_CODIGO)
      on delete restrict on update restrict;

alter table SUCURSAL_PROVEEDORES
   add constraint FK_SUCURSAL_RELATIONS_PROVEEDO foreign key (PROVEEDOR_CODIGO)
      references PROVEEDOR (PROVEEDOR_CODIGO)
      on delete restrict on update restrict;

alter table VENTA
   add constraint FK_VENTA_RELATIONS_CLIENTE foreign key (CLIENTE_CODIGO)
      references CLIENTE (CLIENTE_CODIGO)
      on delete restrict on update restrict;

alter table VENTA
   add constraint FK_VENTA_RELATIONS_EMPLEADO foreign key (EMPLEADO_CODIGO)
      references EMPLEADO (EMPLEADO_CODIGO)
      on delete restrict on update restrict;

