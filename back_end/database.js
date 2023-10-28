var mysql = require('mysql');

// const db_name = 'stage5'
// const rohi_db = 'rohi'


const rohiAudience_db = process.env.DB_APP
const rohi_db = process.env.DB_AUTORITE

// var rohiAudience = mysql.createPool({
//   connectionLimit : 0,
//   host: 'localhost', // Replace with your host name
//   user: 'root',      // Replace with your database username
//   password: 'root',      // Replace with your database password
//   // database: 'stage', // // Replace with your database Name
//   database: rohiAudience_db, // // Replace with your database Name
//   timezone: 'EAT',
// }); 
// rohiAudience.getConnection(function(err) {
//   if (err) {
//     connection.release();
//     console.log(' Error getting mysql_pool connection: ' + err);
//     throw err;
//   }
//   console.log('Database is connected successfully in ',rohiAudience_db);
// });


// var rohi = mysql.createPool({
//   connectionLimit : 0,
//   host: 'localhost', // Replace with your host name
//   user: 'root',      // Replace with your database username
//   password: 'root',      // Replace with your database password
//   // database: 'stage', // // Replace with your database Name
//   database: rohi_db, // // Replace with your database Name
//   timezone: 'EAT'
// }); 
// rohi.getConnection(function(err) {
//   if (err) {
//     connection.release();
//     console.log(' Error getting mysql_pool connection: ' + err);
//     throw err;
//   }
//   console.log('Database is connected successfully in ',rohi_db);
// });

var rohiAudience = mysql.createPool({
  connectionLimit : 0,
  host: '5.183.8.211', // Replace with your host name
  user: 'dev',      // Replace with your database username
  password: 'dev',      // Replace with your database password
  port: '3306',
  // database: 'stage', // // Replace with your database Name
  database: rohiAudience_db, // // Replace with your database Name
  timezone: 'EAT'
});

rohiAudience.getConnection(function(err, connection) {
  if (err) {
    connection.release();
    console.log(' Error getting mysql_pool connection: ' + err);
    throw err;
  }
  console.log('Database is connected successfully in ',rohiAudience_db);
});


var rohi = mysql.createPool({
  connectionLimit : 0,
  host: '5.183.8.211', // Replace with your host name
  port: '3306',
  user: 'dev',      // Replace with your database username
  password: 'dev',      // Replace with your database password
  // database: 'stage', // // Replace with your database Name
  database: rohi_db, // // Replace with your database Name
  timezone: 'EAT'
}); 

rohi.getConnection(function(err, connection) {
  if (err) {
    connection.release();
    console.log(' Error getting mysql_pool connection: ' + err);
    throw err;
  }
  console.log('Database is connected successfully in ',rohi_db);
});

module.exports = {rohiAudience,rohi};

