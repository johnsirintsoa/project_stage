var mysql = require('mysql');

// const db_name = 'stage5'
const db_name = 'stage_temp'
var conn = mysql.createConnection({
  host: 'localhost', // Replace with your host name
  user: 'root',      // Replace with your database username
  password: 'root',      // Replace with your database password
  // database: 'stage', // // Replace with your database Name
  database: db_name, // // Replace with your database Name
  timezone: 'EAT'
}); 
conn.connect(function(err) {
  if (err) throw err;
  console.log('Database is connected successfully !');
});
module.exports = {conn,db_name};