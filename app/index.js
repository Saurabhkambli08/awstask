const express = require('express');
const mysql = require('mysql2/promise');  // Use the promise version

const app = express();
const port = 3000;

// Pull DB details from env vars
const dbHost = process.env.DB_HOST;
const dbUser = process.env.DB_USER;
const dbPassword = process.env.DB_PASSWORD;
const dbName = process.env.DB_NAME || 'myappdb';  // fallback

// Create DB connection pool
let pool;

(async () => {
  try {
    pool = mysql.createPool({
      host: dbHost,
      user: dbUser,
      password: dbPassword,
      database: dbName,
      waitForConnections: true,
      connectionLimit: 10,
      queueLimit: 0,
    });
    console.log('✅ Connected to MySQL!');
  } catch (err) {
    console.error('❌ DB connection error:', err);
    process.exit(1);
  }
})();

app.get('/', async (req, res) => {
  try {
    const [rows] = await pool.query('SELECT NOW() AS now');
    res.send(`Hello from Node.js behind NGINX! DB time: ${rows[0].now}`);
  } catch (err) {
    console.error(err);
    res.status(500).send('DB error');
  }
});

app.listen(port, () => {
  console.log(`App listening at http://localhost:${port}`);
});