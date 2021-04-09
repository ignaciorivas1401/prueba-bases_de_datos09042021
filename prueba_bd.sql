CREATE DATABASE prueba;
\c prueba;

--CREANDO TABLAS 

CREATE TABLE clientes(id SERIAL PRIMARY KEY,nombre_cliente VARCHAR(50),rut VARCHAR(20),direccion VARCHAR(100));

CREATE TABLE categorias(id SERIAL PRIMARY KEY,nombre_categoria VARCHAR(50),descripcion_categoria VARCHAR(200));

CREATE TABLE productos(id SERIAL PRIMARY KEY,nombre_producto VARCHAR(50),descripcion_producto VARCHAR(200),valor_unitario_usd SMALLINT, categoria_id INT, FOREIGN KEY (categoria_id)REFERENCES categorias(id));

CREATE TABLE facturas(id SERIAL PRIMARY KEY,fecha_factura DATE,sub_total_usd INT,iva_usd FLOAT,valor_total_usd FLOAT, total_productos SMALLINT, cliente_id INT, FOREIGN KEY (cliente_id)REFERENCES clientes(id));

CREATE TABLE facturas_productos(id SERIAL PRIMARY KEY, factura_id INT, producto_id INT, cantidad_producto INT, FOREIGN KEY (factura_id)REFERENCES facturas(id),FOREIGN KEY (producto_id)REFERENCES productos(id));

--LLENANDO TABLAS

INSERT INTO clientes (nombre_cliente,rut,direccion) VALUES ('ignacio','8935398-k','los cerezos 3949'),('pedro','16621886-1','los abetos 31423'),('ana','11507032-0','los ciruelos 5040'),('andres','23963221-1','las manzanas 3210'),('luisa','18091996-7','las moreras 6070');

INSERT INTO categorias(nombre_categoria,descripcion_categoria) VALUES ('tecnologia','producto electronico relacionado con el teletrabajo'),('aseo personal','producto destinado al aseo y limpieza de caracter indispensable'),('mundo hogar','producto destinado a mejorar el entorno domiciliario y el bienestar personal');

INSERT INTO productos (nombre_producto,descripcion_producto,valor_unitario_usd,categoria_id) VALUES ('cepillo de dientes','instrumento de higiene oral, utilizado para limpiar dientes y encias',2,2),('shampoo','producto para el cuidado del cabello, usado para limpiar la suciedad',3,2),('maquina de afeitar','rasuradora o rastrillo para afeitarse que protege la piel de la exposicion excesiva de la cuchilla eliminando riesgo de cortes',28,2),('teclado','dispositivo o periferico de entrada, que utiliza sistema de botones o teclas que envian toda la informacion a la computadora',31,1),('mouse','dispositivo apuntador utilizado para facilitar el manejo de un entorno grafico en la computadora',19,1),('pendrive','dispositivo de almacenamiento masivo',13,1),('sabanas','lienzo grande de algodon',25,3),('almohada','bolsa de tela suave y fina, rellena de material blando',15,3);

INSERT INTO facturas (fecha_factura,sub_total_usd,iva_usd,valor_total_usd,total_productos,cliente_id) VALUES ('2021-04-07',5,0.95,5.95,2,1),('2021-04-04',63,11.97,74.97,3,1),('2021-03-29',53,10.97,63.07,3,2),('2021-03-30',50,9.5,59.5,2,2),('2021-04-02',62,11.78,73.78,3,2),('2021-04-02',15,2.85,17.85,1,3),('2021-04-01',53,10.07,63.07,2,4),('2021-04-01',56,10.64,66.64,3,4),('2021-03-29',81,15.39,96.39,4,4),('2021-03-30',31,5.89,36.89,1,4);

INSERT INTO facturas_productos (factura_id,producto_id,cantidad_producto) VALUES (1,1,1),(1,2,1),(2,4,1),(2,5,1),(2,6,1),(3,6,1),(3,7,1),(3,8,1),(4,4,1),(4,5,1),(5,2,1),(5,3,1),(5,4,1),(6,8,1),(7,3,1),(7,7,1),(8,2,1),(8,3,1),(8,7,1),(9,2,1),(9,3,1),(9,4,1),(9,5,1),(10,4,1);

--CONSULTAS

SELECT * FROM clientes FULL JOIN facturas ON clientes.id = facturas.cliente_id WHERE valor_total_usd IN(SELECT MAX(valor_total_usd) FROM facturas);

--nota: por un error de tipeo ninguna factura me dio mayor a 100 :( pero si varias sobre 70 y tengo una sobre 90 u.u 
SELECT * FROM clientes FULL JOIN facturas ON clientes.id = facturas.cliente_id WHERE valor_total_usd > 70;

-- en caso de tener mayores a 100 la consulta seria asi: 
--SELECT * FROM clientes FULL JOIN facturas ON clientes.id = facturas.cliente_id WHERE valor_total_usd > 100;

SELECT COUNT(DISTINCT cliente_id) FROM facturas INNER JOIN facturas_productos ON facturas.id=facturas_productos.factura_id WHERE producto_id=6;