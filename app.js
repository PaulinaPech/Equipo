var mysql = require('mysql');
var express = require('express');

var app = express();

//Conexión de la base de datos 
var conexion = mysql.createConnection({
host: 'localhost',
database: 'Clase3',
user: 'root',
password: '180600045-9',
port: 3306
});

conexion.connect(function(error){
if (error){
    throw error;
}else{
    console.log('Conexion exitosa');
}
})
/*Mostrar-Prueba uno
conexion.query('SELECT * FROM Producto', function (error,filas){
    if(error){
        throw error;
    }else{
        filas.forEach(fila => {
            console.log(fila);
        });
    }
});*/

//GET
app.get('/', function(req,res){
   res.send('Ruta principal');
});

const puerto=process.env.PUERTO;
app.listen(puerto, function(){
console.log("Servidor ok en puerto:"+puerto);
});



/*
app.get('/api/Clase3', (req,res)=>{
  conexion.query('SELECT * FROM Producto', (error, filas)=>{
     if(error){
        throw error;
     }else{
        res.send(filas);
     }
  })
});
Insertar-Prueba dos
conexion.query('INSERT into Producto (idProducto, nombreProducto, precio, vigente, idCategoria_FK) VALUES (4, "Samsumg g350", 500, 1, 1004)', function(error, results){
if(error) throw error;
console.log('Registro Agregado'. results)
});*/

conexion.end();
