// const mysql = require('mysql')
// module.exports = mysql.createConnection({
//   host: "localhost",
//   user: "root",
//   password: "root",
//   database: "stage",
// }).connect(function(err) {
//   if (err) throw err;
//   console.log('Database is connected successfully !');
// });

var mysql = require('mysql');
var conn = mysql.createConnection({
  host: 'localhost', // Replace with your host name
  user: 'root',      // Replace with your database username
  password: 'root',      // Replace with your database password
  database: 'stage' // // Replace with your database Name
}); 
conn.connect(function(err) {
  if (err) throw err;
  console.log('Database is connected successfully !');
});
module.exports = conn;