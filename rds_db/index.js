const mysql = require('mysql');

exports.handler = async (event) => {
  const connection = mysql.createConnection({
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME
  });

  const body = JSON.parse(event.body);
  const { firstName, lastName, email } = body;

  return new Promise((resolve, reject) => {
    connection.connect();

    const query = 'INSERT INTO students (first_name, last_name, email) VALUES (?, ?, ?)';
    connection.query(query, [firstName, lastName, email], (error, results) => {
      connection.end();

      if (error) {
        reject({
          statusCode: 500,
          body: JSON.stringify({ message: 'Internal server error' })
        });
      } else {
        resolve({
          statusCode: 200,
          body: JSON.stringify({ message: 'User registered successfully' })
        });
      }
    });
  });
};
