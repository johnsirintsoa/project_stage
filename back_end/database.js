// var mysql = require('mysql');
var mysql = require('mysql2')
const {Client} = require('ssh2')
const sshClient = new Client();

// const db_name = 'stage5'
// const rohi_db = 'rohi'

const dbConfigBase = {
  host: process.env.HOST,
  port: process.env.DB_PORT,
  user: process.env.DB_USERNAME,
  password: process.env.DB_PASSWORD,
}

const rohiAudience_db = process.env.DB_APP
const rohi_db = process.env.DB_AUTORITE

const dbServerRohi = {
  ...dbConfigBase,
  database : rohi_db
}
const dbServerAudience = {
  ...dbConfigBase,
  database : rohiAudience_db
}

const sshTunnelConfig = {
  host: process.env.HOST,
  port: 22,
  username: process.env.SSH_USER,
  password: process.env.SSH_PASSWORD
}
const forwardConfig = {
  srcHost: '127.0.0.1',
  srcPort: 3306,
  dstHost: dbConfigBase.host,
  dstPort: dbConfigBase.port
};

const SSHDBConnectionRohi = new Promise((resolve, reject) => {
  sshClient.on('ready', () => {
      sshClient.forwardOut(
          forwardConfig.srcHost,
          forwardConfig.srcPort,
          forwardConfig.dstHost,
          forwardConfig.dstPort,
          (err, stream) => {
              if (err) reject(err);
              const updatedDbServer = {
                  ...dbServerRohi,
                  stream
              };
              const connectionPool = mysql.createPool(updatedDbServer);


              connectionPool.getConnection(function(err, connection) {
                if (err) {
                  if(connection)
                  connection.release();
                  console.log(' Error getting mysql_pool connection: ' + err);
                  throw err;
                }
                console.log('Database is connected successfully in ',rohi_db);
                resolve(connection);
              });
          });
  }).connect(sshTunnelConfig);
});

const SSHDBConnectionRohiAudience = new Promise((resolve, reject) => {
  sshClient.on('ready', () => {
      sshClient.forwardOut(
          forwardConfig.srcHost,
          forwardConfig.srcPort,
          forwardConfig.dstHost,
          forwardConfig.dstPort,
          (err, stream) => {
              if (err) reject(err);
              const updatedDbServer = {
                  ...dbServerAudience,
                  stream
              };
              const connectionPool = mysql.createPool(updatedDbServer);


              connectionPool.getConnection(function(err, connection) {
                if (err) {
                  if(connection)
                  connection.release();
                  console.log(' Error getting mysql_pool connection: ' + err);
                  throw err;
                }
                console.log('Database is connected successfully in ',rohiAudience_db);
                resolve(connection);
              });
          });
  }).connect(sshTunnelConfig);
});


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

// var rohiAudience = mysql.createPool({
//   connectionLimit : 0,
//   host: '5.183.8.211', // Replace with your host name
//   user: 'dev',      // Replace with your database username
//   password: 'dev',      // Replace with your database password
//   port: '3306',
//   // database: 'stage', // // Replace with your database Name
//   database: rohiAudience_db, // // Replace with your database Name
//   timezone: 'EAT'
// });

// rohiAudience.getConnection(function(err, connection) {
//   if (err) {
//     if(connection)
//     connection.release();
//     console.log(' Error getting mysql_pool connection: ' + err);
//     throw err;
//   }
//   console.log('Database is connected successfully in ',rohiAudience_db);
// });


// var rohi = mysql.createPool({
//   connectionLimit : 0,
//   host: '5.183.8.211', // Replace with your host name
//   port: '3306',
//   user: 'dev',      // Replace with your database username
//   password: 'dev',      // Replace with your database password
//   // database: 'stage', // // Replace with your database Name
//   database: rohi_db, // // Replace with your database Name
//   timezone: 'EAT'
// }); 

// rohi.getConnection(function(err, connection) {
//   if (err) {
//     if(connection)
//     connection.release();
//     console.log(' Error getting mysql_pool connection: ' + err);
//     throw err;
//   }
//   console.log('Database is connected successfully in ',rohi_db);
// });

module.exports = {rohiAudience: SSHDBConnectionRohiAudience,rohi:SSHDBConnectionRohi};

