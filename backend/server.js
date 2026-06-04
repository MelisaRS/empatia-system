const express = require('express')

const pool = require('./db')

const app = express()

const PORT = 3000

app.get('/', (req, res) => {
  res.send('Express server running')
})

app.get('/api', (req, res) => {
  res.json({
    message: 'API is running successfully',
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
    const result = await pool.query('SELECT * FROM patient')

    res.json(result.rows)
  } catch (error) {
    console.error(error)

    res.status(500).json({
      status: 'error',
      message: 'Error fetching patients'
    })
  }
})

app.get('/patients-structure', async (req, res) => {
  try {
    const result = await pool.query(`
      SELECT column_name, data_type
      FROM information_schema.columns
      WHERE table_name = 'patient'
    `)

    res.json(result.rows)
  } catch (error) {
    console.error(error)

    res.status(500).json({
      error: 'Error fetching table structure'
    })
  }
})

pool.query('SELECT NOW()', (err, result) => {
  if (err) {
    console.error('PostgreSQL connection error', err)
  } else {
    console.log('PostgreSQL connected')
    console.log(result.rows)
  }
})

app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`)
})