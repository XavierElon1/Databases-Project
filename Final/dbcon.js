var mysql = require('mysql');
var pool = mysql.createPool({
  connectionLimit : 10,
  host            : 'classmysql.engr.oregonstate.edu',
  user            : 'cs340_hollingx',
  password        : '7635',
  database        : 'cs340_hollingx'
});

module.exports.pool = pool;
