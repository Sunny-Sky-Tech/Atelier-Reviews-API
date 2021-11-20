// var mysql = require('mysql2');
import * as mysql from 'mysql2';

const connection = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: '',
  database: 'reviews_api'
});

export default connection;
