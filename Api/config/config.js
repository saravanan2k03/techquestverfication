var sql = require('mssql');
//2.
var config = {
    server: '103.207.1.92',
    database: 'canteen',
    user: 'mzcanteen',
    password: 'Checkme@987',
    "options": {
        "encrypt": true,
        "trustServerCertificate": true}
};

var dbConn = new sql.ConnectionPool(config);
dbConn.connect();
var RequestDatabase = new sql.Request(dbConn);
module.exports={
    RequestDatabase:RequestDatabase,
    dbConn:dbConn
};

