/*Grupo : TI 4A. Equipo: 
Stephanie Paulina Pech Cervera
Samir Ivan Molina Arredondo
Alejandro Martin Caamal
Antonio Chi Moo
Juan Romero Yam
*/
var mysql = require('mysql');
var express = require('express');

var app = express();
app.use(express.json());

const puerto=process.env.PUERTO || 7002;

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
});

//GET- Mostrar
app.listen(puerto, ()=>{
console.log("Servidor ok en puerto:"+puerto);
});

app.get('/api/Clase3', (req,res)=>{
   conexion.query('SELECT * FROM Articulo', (error, filas)=>{
     if(error){
        throw error;
     }else{
        res.send(filas);
     }
  })
});

app.get('/api/Clase3/:idArticulo', (req,res)=>{
   conexion.query('SELECT * FROM Articulo WHERE idArticulo = ?',[req.params.idArticulo], (error, fila)=>{
     if(error){
        throw error;
     }else{
        res.send(fila);
     }
  })
});

//POST-Insertar
app.post('/api/Clase3',(req,res)=>{
  let data= {nombreArticulo:req.body.nombreArticulo,precio:req.body.precio,stock:req.body.stock}
  let sql = "INSERT INTO Articulo SET ?";
  conexion.query(sql, data, function(error, results){
    if(error){
        throw error;
     }else{
        res.send(results);
     }
  });
});


//PUT-Editar

app.put('/api/Clase3/:idArticulo', (req,res)=>{
   let idArticulo = req.params.idArticulo;
   let nombreArticulo= req.body.nombreArticulo;
   let precio=req.body.precio;
   let stock=req.body.stock;
   let sql="UPDATE Articulo SET nombreArticulo = ?, precio = ?, stock = ? WHERE idArticulo = ?";
   conexion.query(sql, [nombreArticulo, precio, stock, idArticulo],function(error, results){
    if(error){
        throw error;
     }else{
        res.send(results);
     }
   });
});

//DELETE-Eliminar 
app.delete('/api/Clase3/:idArticulo', (req,res)=>{
      conexion.query('DELETE FROM Articulo WHERE idArticulo = ?', [req.params.idArticulo], function(error,filas){
         if(error){
            throw error;
         }else{
            res.send(filas);
         }
      });
});
