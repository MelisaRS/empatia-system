const express = require('express')

const pool = require('./db')

const app = express()

app.use(express.json())

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

///////
// CRUD - USER
////////

app.get('/users', async (req, res) => {
  try {
    const result = await pool.query(`
      SELECT * FROM users
      ORDER BY user_id ASC
    `)

    res.json(result.rows)
    console.log(result.rows)

  } catch (error) {
    console.error(error)

    res.status(500).json({
      status: 'error',
      message: 'Error fetching users'
    })
  }
})

app.post('/users', async (req, res) => {
  try {
    const { role_id, email, password_hash, status } = req.body

    const result = await pool.query(
      `
      INSERT INTO users (
        role_id,
        email,
        password_hash,
        status
      )
      VALUES ($1, $2, $3, $4)
      RETURNING *
      `,
      [role_id, email, password_hash, status]
    )

    res.status(201).json({
      status: 'success',
      message: 'User created successfully',
      user: result.rows[0]
    })

  } catch (error) {
    console.error(error)

    res.status(500).json({
      status: 'error',
      message: 'Error creating user'
    })
  }
})

app.put('/users/:id', async (req, res) => {
  try {
    const { id } = req.params

    const { role_id, email, password_hash, status } = req.body

    const result = await pool.query(
      `
      UPDATE users
      SET
        role_id = $1,
        email = $2,
        password_hash = $3,
        status = $4
      WHERE user_id = $5
      RETURNING *
      `,
      [role_id, email, password_hash, status, id]
    )

    res.json({
      status: 'success',
      message: 'User updated successfully',
      user: result.rows[0]
    })

  } catch (error) {
    console.error(error)

    res.status(500).json({
      status: 'error',
      message: 'Error updating user'
    })
  }
})

app.delete('/users/:id', async (req, res) => {
  try {
    const { id } = req.params

    const result = await pool.query(
      `
      UPDATE users
      SET status = 'Inactivo'
      WHERE user_id = $1
      RETURNING *
      `,
      [id]
    )

    res.json({
      status: 'success',
      message: 'User deleted successfully',
      user: result.rows[0]
    })

  } catch (error) {
    console.error(error)

    res.status(500).json({
      status: 'error',
      message: 'Error deleting user'
    })
  }
})

////////////
// PATIENTS/
////////////

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