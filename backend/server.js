const express = require('express')

const pool = require('./db')

const app = express()

const PORT = 3000

app.get('/', (req, res) => {
  res.send('Hola mundo desde Express - Servidor Express funcionando')
})

app.get('/api', (req, res) => {
  res.json({
    message: 'Servidor funcionando, API funcionando correctamente',
    status: 'ok'
  })
})

app.get('/health-db', async (req, res) => {
  try {
    const result = await pool.query('SELECT NOW()')

    res.json({
      status: 'ok',
      database: 'connected',
      time: result.rows[0].now
    })
  } catch (error) {
    console.error(error)

    res.status(500).json({
      status: 'error',
      database: 'disconnected'
    })
  }
})

app.get('/patients', async (req, res) => {
  try {
    const result = await pool.query('SELECT * FROM paciente')

    res.json(result.rows)
  } catch (error) {
    console.error(error)

    res.status(500).json({
      status: 'error',
      message: 'Error obteniendo pacientes'
    })
  }
})

app.get('/patients-structure', async (req, res) => {
  try {
    const result = await pool.query(`
      SELECT column_name, data_type
      FROM information_schema.columns
      WHERE table_name = 'paciente'
    `)

    res.json(result.rows)
  } catch (error) {
    console.error(error)

    res.status(500).json({
      error: 'Error obteniendo estructura'
    })
  }
})

pool.query('SELECT NOW()', (err, result) => {
  if (err) {
    console.error('Error conectando PostgreSQL', err)
  } else {
    console.log('PostgreSQL conectado')
    console.log(result.rows)
  }
})

app.listen(PORT, () => {
  console.log(`Servidor corriendo en puerto ${PORT} 
                \nServidor corriendo en http://localhost:${PORT}`)
})