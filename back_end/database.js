var mysql = require('mysql');

// const db_name = 'stage5'
// const rohi_db = 'rohi'


const db_name = process.env.DB_APP
const rohi_db = process.env.DB_AUTORITE

// var conn = mysql.createConnection({
//   host: 'localhost', // Replace with your host name
//   user: 'root',      // Replace with your database username
//   password: 'root',      // Replace with your database password
//   // database: 'stage', // // Replace with your database Name
//   database: db_name, // // Replace with your database Name
//   timezone: 'EAT'
// }); 
// conn.connect(function(err) {
//   if (err) throw err;
//   console.log('Database is connected successfully in ',db_name);
// });


// var rohi = mysql.createConnection({
//   host: 'localhost', // Replace with your host name
//   user: 'root',      // Replace with your database username
//   password: 'root',      // Replace with your database password
//   // database: 'stage', // // Replace with your database Name
//   database: rohi_db, // // Replace with your database Name
//   timezone: 'EAT'
// }); 
// rohi.connect(function(err) {
//   if (err) throw err;
//   console.log('Database is connected successfully in ',rohi_db);
// });

var conn = mysql.createConnection({
  host: '5.183.8.211', // Replace with your host name
  user: 'dev',      // Replace with your database username
  password: 'dev',      // Replace with your database password
  port: '3306',
  // database: 'stage', // // Replace with your database Name
  database: db_name, // // Replace with your database Name
  timezone: 'EAT'
}); 
conn.connect(function(err) {
  if (err) throw err;
  console.log('Database is connected successfully in ',db_name);
});


var rohi = mysql.createConnection({
  host: '5.183.8.211', // Replace with your host name
  port: '3306',
  user: 'dev',      // Replace with your database username
  password: 'dev',      // Replace with your database password
  // database: 'stage', // // Replace with your database Name
  database: rohi_db, // // Replace with your database Name
  timezone: 'EAT'
}); 
rohi.connect(function(err) {
  if (err) throw err;
  console.log('Database is connected successfully in ',rohi_db);
});

module.exports = {conn,db_name,rohi};

