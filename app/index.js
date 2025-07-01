const express = require('express');
const mysql = require('mysql2/promise');

const app = express();
const port = 3000;

const dbHost = process.env.DB_HOST;
const dbUser = process.env.DB_USER || 'admin';
const dbPassword = process.env.DB_PASSWORD;
const dbName = process.env.DB_NAME || 'myappdb';

console.log('DB CONFIG:');
console.log(`HOST: ${dbHost}`);
console.log(`USER: ${dbUser}`);
console.log(`DB: ${dbName}`);

let pool;

// ✅ ROOT PATH → uses DB
app.get('/', async (req, res) => {
  try {
    if (!pool) {
      pool = mysql.createPool({
        host: dbHost,
        user: dbUser,
        password: dbPassword,
        database: dbName,
        waitForConnections: true,
        connectionLimit: 10,
        queueLimit: 0,
      });
      console.log('✅ DB pool created');
    }

    const [rows] = await pool.query('SELECT NOW() AS now');
    res.send(`Hello from Node.js behind NGINX! DB time: ${rows[0].now}`);
  } catch (err) {
    console.error('❌ DB error:', err);
    res.status(500).send('DB error');
  }
});

// ✅ HEALTH PATH → NO DB CALL, always OK
app.get('/health', (req, res) => {
  res.status(200).send('OK');
});

app.listen(port, '0.0.0.0', () => {
  console.log(`✅ App listening on http://0.0.0.0:${port}`);
});
