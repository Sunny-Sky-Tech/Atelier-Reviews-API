// import * as mysql from 'mysql2';
const mysql = require('mysql2');
import {} from 'dotenv/config'

const connection = mysql.createConnection({
  host: process.env.MYSQL_HOST,
  user: process.env.MYSQL_USER,
  password: process.env.MYSQL_PASSWORD,
  database: process.env.MYSQL_DATABASE,
  multipleStatements: true
});

export default connection;
