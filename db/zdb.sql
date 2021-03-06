SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [autor](
	[idautor] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](50) NOT NULL,
	[correo] [varchar](50) NULL,
	[biografia] [varchar](400) NULL,
	[foto] [varchar](50) NULL,
	[idusuario] [int] NOT NULL,
	[fecharegistro] [datetime] NOT NULL,
	[estado] [varchar](1) NOT NULL,
 CONSTRAINT [PK_autor] PRIMARY KEY CLUSTERED 
(
	[idautor] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [autor] ON
INSERT [autor] ([idautor], [nombre], [correo], [biografia], [foto], [idusuario], [fecharegistro], [estado]) VALUES (1, N'Carranza Avalos, Zalatiel', N'zcarranza@ulima.edu.pe', N'Profesor', N'', 1, CAST(0x0000A1D2015B0A31 AS DateTime), N'1')
SET IDENTITY_INSERT [autor] OFF
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [categoria](
	[idcategoria] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](50) NULL,
	[padre] [varchar](50) NULL,
	[idusuario] [int] NULL,
	[fecharegistro] [datetime] NULL,
	[estado] [varchar](1) NULL,
 CONSTRAINT [PK_categoria] PRIMARY KEY CLUSTERED 
(
	[idcategoria] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [categoria] ON
INSERT [categoria] ([idcategoria], [nombre], [padre], [idusuario], [fecharegistro], [estado]) VALUES (1, N'Diseño', N'Computación y Tecnología', 1, CAST(0x0000A1D80142E63C AS DateTime), N'1')
INSERT [categoria] ([idcategoria], [nombre], [padre], [idusuario], [fecharegistro], [estado]) VALUES (2, N'Programación', N'Computación y Tecnología', 1, CAST(0x0000A1D80141D7FA AS DateTime), N'2')
INSERT [categoria] ([idcategoria], [nombre], [padre], [idusuario], [fecharegistro], [estado]) VALUES (3, N'Analisis', N'Computación y Tecnología', 1, CAST(0x0000A1D80141F67F AS DateTime), N'1')
SET IDENTITY_INSERT [categoria] OFF
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [usuario](
	[idusuario] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](50) NULL,
	[clave] [varchar](50) NULL,
	[correo] [varchar](50) NULL,
	[rol] [varchar](1) NULL,
	[estado] [varchar](1) NULL,
	[fecharegistro] [datetime] NULL,
 CONSTRAINT [PK_usuario] PRIMARY KEY CLUSTERED 
(
	[idusuario] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [usuario] ON
INSERT [usuario] ([idusuario], [nombre], [clave], [correo], [rol], [estado], [fecharegistro]) VALUES (1, N'admin', N'admin', N'admin@upc.edu.pe', N'1', N'1', CAST(0x0000A1D201739811 AS DateTime))
INSERT [usuario] ([idusuario], [nombre], [clave], [correo], [rol], [estado], [fecharegistro]) VALUES (2, N'a', N'a', N'a@a.com', N'0', N'1', CAST(0x0000A1D8010123A4 AS DateTime))
SET IDENTITY_INSERT [usuario] OFF
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [usuariodetalle](
	[idusuario] [int] NOT NULL,
	[nombre] [varchar](50) NULL,
	[apellidos] [varchar](50) NULL,
	[telefono] [varchar](15) NULL,
	[direccion] [varchar](150) NULL,
	[distrito] [varchar](50) NULL,
	[tarjetatipo] [varchar](1) NULL,
	[tarjetanumero] [varchar](16) NULL,
	[tarjetaexpiracionmes] [varchar](2) NULL,
	[tarjetaexpiracionano] [varchar](4) NULL,
 CONSTRAINT [PK_cliente] PRIMARY KEY CLUSTERED 
(
	[idusuario] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [usuariodetalle] ([idusuario], [nombre], [apellidos], [telefono], [direccion], [distrito], [tarjetatipo], [tarjetanumero], [tarjetaexpiracionmes], [tarjetaexpiracionano]) VALUES (2, N'Edgard', N'Barrientos Salazar', N'5706201', N'vesss', N'VES', N'a', N'6546545645665545', N'9', N'2013')
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [UsuarioLogeo]
    @nombre varchar(50), 
    @clave varchar(50)
    --@mensaje varchar(1) out
AS 
begin

	



	select u.idusuario,u.rol from usuario u where u.nombre=@nombre and u.clave=@clave
	
	
	
	
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [UsuarioInsert]
    @nombre varchar(50), 
    @clave varchar(50),
    @correo varchar(50),
    @rol varchar(1),
    @estado varchar(1),
    @mensaje varchar(100) out
AS 
begin

	if ((select count(*) from usuario where nombre = @Nombre and estado in ('1','2')) > 0)
	begin
		set @mensaje = 'El usuario ya existe';
		return;
	end 
	else
	begin
		set @mensaje='';
	end
	
	INSERT INTO usuario
			   (nombre
			   ,clave
			   ,correo
			   ,rol
			   ,estado
			   ,fecharegistro)
		 VALUES
			   (@nombre
			   ,@clave
			   ,@correo
			   ,@rol
			   ,@estado
			   ,getdate());
			   
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [AutorInsert]
    @nombre varchar(50), 
    @correo varchar(50),
    @biografia varchar(400),
    @foto varchar(50),
    @idusuario int,
    @estado varchar(1)        
AS 
begin
	
	INSERT INTO autor
			   (nombre,
				correo,
				biografia,
				foto,
				idusuario,
				fecharegistro,
				estado)
		 VALUES
			   (@nombre,
				@correo,
				@biografia,
				@foto,
				@idusuario,
				GETDATE(),
				@estado)

end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [AutorGetlistById]
	@idautor int       
AS 
begin
	
	select * from autor a where a.idautor=@idautor

end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [AutorGetlist]
	@estado varchar(1)
AS 
begin


	select * from autor a where a.estado in ('1','2') order by 1


end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [AutorEdit]
	@idautor int,
    @nombre varchar(50), 
    @correo varchar(50),
    @biografia varchar(400),
    @foto varchar(50),
    @idusuario int,
    @estado varchar(1)        
AS 
begin
	update autor
	set nombre=@nombre,
		correo=@correo,
		biografia=@biografia,
		foto=@foto,
		idusuario=@idusuario,
		estado=@estado
	where idautor=@idautor
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [AutorDelete]
	@idautor int
AS 
begin

	update autor
	set estado='0'
	where idautor=@idautor

end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [producto](
	[idproducto] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](50) NULL,
	[detalle] [varchar](150) NULL,
	[foto] [varchar](50) NULL,
	[idcategoria] [int] NULL,
	[idautor] [int] NULL,
	[precio] [money] NULL,
	[stock] [nchar](10) NULL,
	[idusuario] [int] NULL,
	[fecharegistro] [datetime] NULL,
	[estado] [varchar](1) NULL,
 CONSTRAINT [PK_producto] PRIMARY KEY CLUSTERED 
(
	[idproducto] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [producto] ON
INSERT [producto] ([idproducto], [nombre], [detalle], [foto], [idcategoria], [idautor], [precio], [stock], [idusuario], [fecharegistro], [estado]) VALUES (1, N'C++', N'detalleeeeeee', N'1', 1, 1, 2.1000, N'10        ', 1, NULL, N'1')
INSERT [producto] ([idproducto], [nombre], [detalle], [foto], [idcategoria], [idautor], [precio], [stock], [idusuario], [fecharegistro], [estado]) VALUES (2, N'C#', N'...', N'2', 1, 1, 4.5000, N'10        ', 1, NULL, N'1')
SET IDENTITY_INSERT [producto] OFF
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [CategoriaInsert]
    @nombre nvarchar(50), 
    @padre nvarchar(50),
    @idusuario int,
    @estado varchar(1),
    @mensaje varchar(100) out
AS 
begin

    if ((select COUNT(1) from categoria c where c.nombre=@nombre and c.estado in ('1','2'))>0)
    begin
		set @mensaje='La Categoria ya existe';
    end
    else
    begin
		set @mensaje='';
    end
    
	INSERT INTO categoria
			   (nombre
			   ,padre
			   ,idusuario
			   ,fecharegistro
			   ,estado)
		 VALUES
			   (@nombre,
				@padre,
				@idusuario,
				GETDATE(),
				@estado)

end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [CategoriaGetlistPadre]
AS 
begin

    select distinct c.padre from categoria c where c.estado='1'

end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [CategoriaGetlistById]
	@idcategoria varchar(1)
AS 
begin

	select * from categoria c where c.idcategoria=@idcategoria

end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [CategoriaGetlist]
	@estado varchar(1)
AS 
begin

	if (@estado=3)
		select * from categoria c where estado = '1' order by 1 
	else
		select idcategoria,nombre,padre,estado,fecharegistro from categoria c where estado in ('1','2') order by 1


end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [CategoriaEdit]
	@idcategoria varchar(1),
	@nombre varchar(50),
	@padre varchar(50),
	@idusuario int,
	@estado varchar(1),
	@mensaje varchar(100) out
AS 
begin

    if ((select COUNT(1) from categoria c where c.nombre=@nombre and c.estado in ('1','2') and c.idcategoria<>@idcategoria)>0)
    begin
		set @mensaje='La Categoria ya existe';
    end
    else
    begin
		set @mensaje='';
    end

	UPDATE [zdb].[dbo].[categoria]
	   SET [nombre] = @nombre
		  ,[padre] = @padre
		  ,[idusuario] = @idusuario
		  ,[fecharegistro] = GETDATE()
		  ,[estado] = @estado
	 WHERE idcategoria=@idcategoria

end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [CategoriaDelete]
	@idcategoria int
AS 
begin

	update categoria
	set estado='0'
	where idcategoria=@idcategoria

end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [pedido](
	[idpedido] [int] IDENTITY(1,1) NOT NULL,
	[idusuario] [int] NULL,
	[fechapedido] [datetime] NULL,
	[fechaentrega] [datetime] NULL,
	[estado] [varchar](1) NULL,
 CONSTRAINT [PK_pedido] PRIMARY KEY CLUSTERED 
(
	[idpedido] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [pedido] ON
INSERT [pedido] ([idpedido], [idusuario], [fechapedido], [fechaentrega], [estado]) VALUES (9, 1, CAST(0x0000A1D800E9A17C AS DateTime), CAST(0x0000A1DA00000000 AS DateTime), N'1')
INSERT [pedido] ([idpedido], [idusuario], [fechapedido], [fechaentrega], [estado]) VALUES (10, 1, CAST(0x0000A1D800E9E449 AS DateTime), CAST(0x0000A1DA00000000 AS DateTime), N'1')
INSERT [pedido] ([idpedido], [idusuario], [fechapedido], [fechaentrega], [estado]) VALUES (11, 1, CAST(0x0000A1D800EA1251 AS DateTime), CAST(0x0000A1DA00000000 AS DateTime), N'1')
INSERT [pedido] ([idpedido], [idusuario], [fechapedido], [fechaentrega], [estado]) VALUES (12, 2, CAST(0x0000A1D801512264 AS DateTime), CAST(0x0000A1DB00000000 AS DateTime), N'1')
SET IDENTITY_INSERT [pedido] OFF
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [comentario](
	[idcomentario] [int] IDENTITY(1,1) NOT NULL,
	[idproducto] [int] NULL,
	[detalle] [varchar](250) NULL,
	[idusuario] [int] NULL,
	[fecharegistro] [datetime] NULL,
	[estado] [varchar](1) NULL,
 CONSTRAINT [PK_comentario] PRIMARY KEY CLUSTERED 
(
	[idcomentario] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [ProductoGetlistNew]
AS 
begin

	select top 3 idproducto,p.nombre,detalle,p.foto,c.nombre categoria,a.nombre autor,precio,stock 
	from producto p 
	inner join categoria c on c.idcategoria=p.idcategoria
	inner join autor a on a.idautor=p.idautor
	where p.estado='1'
	order by 1 desc


end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [ProductoGetlist]
	@idcategoria int
AS 
begin

	select idproducto,p.nombre,detalle,p.foto,c.nombre categoria,a.nombre autor,precio,stock 
	from producto p 
	inner join categoria c on c.idcategoria=p.idcategoria
	inner join autor a on a.idautor=p.idautor
	where p.estado='1'
	and p.idcategoria=@idcategoria


end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [pedidodetalle](
	[idpedidodetalle] [int] IDENTITY(1,1) NOT NULL,
	[idpedido] [int] NULL,
	[idproducto] [int] NULL,
	[cantidad] [smallint] NULL,
	[precio] [money] NULL,
	[subtotal] [money] NULL,
 CONSTRAINT [PK_pedidodetalle] PRIMARY KEY CLUSTERED 
(
	[idpedidodetalle] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [pedidodetalle] ON
INSERT [pedidodetalle] ([idpedidodetalle], [idpedido], [idproducto], [cantidad], [precio], [subtotal]) VALUES (1, 10, 1, 5, 2.1000, 10.5000)
INSERT [pedidodetalle] ([idpedidodetalle], [idpedido], [idproducto], [cantidad], [precio], [subtotal]) VALUES (2, 11, 1, 5, 2.1000, 10.5000)
INSERT [pedidodetalle] ([idpedidodetalle], [idpedido], [idproducto], [cantidad], [precio], [subtotal]) VALUES (3, 11, 2, 4, 4.5000, 18.0000)
INSERT [pedidodetalle] ([idpedidodetalle], [idpedido], [idproducto], [cantidad], [precio], [subtotal]) VALUES (4, 12, 2, 1, 4.5000, 4.5000)
SET IDENTITY_INSERT [pedidodetalle] OFF
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [PedidoInsert]
	@idusuario int,
	@fechaentrega datetime,
	@idpedido int out
as
begin

	INSERT INTO [zdb].[dbo].[pedido]
			   ([idusuario]
			   ,[fechapedido]
			   ,[fechaentrega]
			   ,[estado])
		 VALUES
			   (@idusuario
			   ,GETDATE()
			   ,@fechaentrega
			   ,'1')

	set @idpedido=SCOPE_IDENTITY()

end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [UsuarioDetalleInsert]
	@idusuario int,
	@nombre	varchar(50),
	@apellidos varchar(50),
	@telefono varchar(15),
	@direccion varchar(150),
	@distrito varchar(50),
	@tarjetatipo varchar(1),
	@tarjetanumero varchar(16),
	@tarjetaexpiracionmes varchar(2),
	@tarjetaexpiracionano varchar(4)
as
begin

	if ((select COUNT(1) from usuariodetalle u where u.idusuario=@idusuario)>0)
	begin
		UPDATE zdb.dbo.usuariodetalle
		   SET idusuario = @idusuario
			  ,nombre = @nombre
			  ,apellidos = @apellidos	
			  ,telefono = @telefono
			  ,direccion = @direccion
			  ,distrito = @distrito
			  ,tarjetatipo = @tarjetatipo
			  ,tarjetanumero = @tarjetanumero
			  ,tarjetaexpiracionmes = @tarjetaexpiracionmes
			  ,tarjetaexpiracionano = @tarjetaexpiracionano
		 WHERE idusuario=@idusuario
	end
	else
	begin
		INSERT INTO zdb.dbo.usuariodetalle
				   (idusuario
				   ,nombre
				   ,apellidos
				   ,telefono
				   ,direccion
				   ,distrito
				   ,tarjetatipo
				   ,tarjetanumero
				   ,tarjetaexpiracionmes
				   ,tarjetaexpiracionano)
			 VALUES
				   (@idusuario
				   ,@nombre
				   ,@apellidos
				   ,@telefono
				   ,@direccion
				   ,@distrito
				   ,@tarjetatipo
				   ,@tarjetanumero
				   ,@tarjetaexpiracionmes
				   ,@tarjetaexpiracionano)
	end

end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [UsuarioDetalleGetById]
	@idusuario int
AS 
begin

	select ud.*,u.correo
	from usuariodetalle ud
	inner join usuario u on u.idusuario=ud.idusuario
	where ud.idusuario=@idusuario

end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [usp_ins_comentario]
    @IdProducto int, 
    @Detalle varchar(50),
    @IdUsuario int     
AS 

    SET NOCOUNT ON;

INSERT INTO comentario
           (idproducto,
            detalle,
            idusuario,
            fecharegistro,
            estado)
     VALUES
           (@IdProducto,
            @Detalle,
            @IdUsuario,
            GETDATE(),
            1)
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [PedidoDetalleInsert]
	@idpedido int,
	@idproducto int,
	@cantidad int,
	@precio money
as
begin

	INSERT INTO [zdb].[dbo].[pedidodetalle]
			   ([idpedido]
			   ,[idproducto]
			   ,[cantidad]
			   ,[precio]
			   ,subtotal)
		 VALUES
			   (@idpedido
			   ,@idproducto
			   ,@cantidad
			   ,@precio
			   ,@cantidad*@precio)

end
GO
ALTER TABLE [comentario]  WITH CHECK ADD  CONSTRAINT [FK_comentario_producto] FOREIGN KEY([idproducto])
REFERENCES [producto] ([idproducto])
GO
ALTER TABLE [comentario] CHECK CONSTRAINT [FK_comentario_producto]
GO
ALTER TABLE [pedido]  WITH CHECK ADD  CONSTRAINT [FK_pedido_usuario] FOREIGN KEY([idusuario])
REFERENCES [usuario] ([idusuario])
GO
ALTER TABLE [pedido] CHECK CONSTRAINT [FK_pedido_usuario]
GO
ALTER TABLE [pedidodetalle]  WITH CHECK ADD  CONSTRAINT [FK_pedidodetalle_pedido] FOREIGN KEY([idpedido])
REFERENCES [pedido] ([idpedido])
GO
ALTER TABLE [pedidodetalle] CHECK CONSTRAINT [FK_pedidodetalle_pedido]
GO
ALTER TABLE [pedidodetalle]  WITH CHECK ADD  CONSTRAINT [FK_pedidodetalle_producto] FOREIGN KEY([idproducto])
REFERENCES [producto] ([idproducto])
GO
ALTER TABLE [pedidodetalle] CHECK CONSTRAINT [FK_pedidodetalle_producto]
GO
ALTER TABLE [producto]  WITH CHECK ADD  CONSTRAINT [FK_producto_autor] FOREIGN KEY([idautor])
REFERENCES [autor] ([idautor])
GO
ALTER TABLE [producto] CHECK CONSTRAINT [FK_producto_autor]
GO
ALTER TABLE [producto]  WITH CHECK ADD  CONSTRAINT [FK_producto_categoria] FOREIGN KEY([idcategoria])
REFERENCES [categoria] ([idcategoria])
GO
ALTER TABLE [producto] CHECK CONSTRAINT [FK_producto_categoria]
GO
ALTER TABLE [usuariodetalle]  WITH CHECK ADD  CONSTRAINT [FK_cliente_usuario] FOREIGN KEY([idusuario])
REFERENCES [usuario] ([idusuario])
GO
ALTER TABLE [usuariodetalle] CHECK CONSTRAINT [FK_cliente_usuario]
GO
