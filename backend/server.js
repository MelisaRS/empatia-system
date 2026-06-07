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

//////////////////
// CRUD - USER //
/////////////////

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

/////////////////////
// CRUD - PATIENTS //
/////////////////////

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

app.post('/patients', async (req, res) => {
  try {
    const {
      first_name,
      last_name,
      birth_date,
      current_status,
      gender
    } = req.body

    const result = await pool.query(
      `
      INSERT INTO patient (
        first_name,
        last_name,
        birth_date,
        current_status,
        gender
      )
      VALUES ($1, $2, $3, $4, $5)
      RETURNING *
      `,
      [
        first_name,
        last_name,
        birth_date,
        current_status,
        gender
      ]
    )

    res.status(201).json({
      status: 'success',
      message: 'Patient created successfully',
      patient: result.rows[0]
    })

  } catch (error) {
    console.error(error)

    res.status(500).json({
      status: 'error',
      message: 'Error creating patient'
    })
  }
})

app.put('/patients/:id', async (req, res) => {
  try {
    const { id } = req.params

    const {
      first_name,
      last_name,
      birth_date,
      current_status,
      gender
    } = req.body

    const result = await pool.query(
      `
      UPDATE patient
      SET
        first_name = $1,
        last_name = $2,
        birth_date = $3,
        current_status = $4,
        gender = $5
      WHERE patient_id = $6
      RETURNING *
      `,
      [
        first_name,
        last_name,
        birth_date,
        current_status,
        gender,
        id
      ]
    )

    res.json({
      status: 'success',
      message: 'Patient updated successfully',
      patient: result.rows[0]
    })

  } catch (error) {
    console.error(error)

    res.status(500).json({
      status: 'error',
      message: 'Error updating patient'
    })
  }
})

app.get('/patients/search/:text', async (req, res) => {
  try {
    const { text } = req.params

    const result = await pool.query(
      `
      SELECT *
      FROM patient
      WHERE
        first_name ILIKE $1
        OR last_name ILIKE $1
      ORDER BY patient_id ASC
      `,
      [`%${text}%`]
    )

    res.json({
      status: 'success',
      results: result.rows.length,
      patients: result.rows
    })

  } catch (error) {
    console.error(error)

    res.status(500).json({
      status: 'error',
      message: 'Error searching patients'
    })
  }
})

/////////////////////
// 
/////////////////////

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