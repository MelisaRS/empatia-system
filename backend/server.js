const express = require('express')
const bcrypt = require('bcryptjs')
const jwt = require('jsonwebtoken')

const pool = require('./db')

const app = express()

app.use(express.json())

const PORT = 3000

//////////////////////////////
// MIDDLEWARE AUTHORIZATION ///
//////////////////////////////

const authMiddleware = (req, res, next) => {
  try {

    const authHeader = req.headers.authorization

    if (!authHeader) {
      return res.status(401).json({
        status: 'error',
        message: 'Access token required'
      })
    }

    const token = authHeader.split(' ')[1]

    jwt.verify(
      token,
      process.env.JWT_SECRET
    )

    next()

  } catch (error) {

    if (error.name === 'TokenExpiredError') {
      return res.status(401).json({
        status: 'error',
        message: 'Token expired'
      })
    }

    return res.status(401).json({
      status: 'error',
      message: 'Invalid token'
    })
  }
}

/////////PROTECCIONES DE ROUTERS (RUTAS)////////
app.use('/users', authMiddleware)
app.use('/patients', authMiddleware)
app.use('/appointments', authMiddleware)
app.use('/therapy-sessions', authMiddleware)
///////////////////////////////////////////////

/////////////
// ROUTERS //
/////////////

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
    //console.log(result.rows)

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

    const { role_id, email, password, status } = req.body

    const password_hash = await bcrypt.hash(
      password,
      10
    )

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

////////////////////////////////

app.get('/patients/:id/history', async (req, res) => {
  try {

    const { id } = req.params

    const result = await pool.query(`
      SELECT
        ts.therapy_session_id,
        ts.progress,
        ts.observation,
        ts.registered_at,

        a.appointment_date,
        a.start_time,
        a.end_time

      FROM therapy_session ts

      INNER JOIN appointment a
        ON ts.appointment_id = a.appointment_id

      WHERE a.patient_id = $1

      ORDER BY a.appointment_date ASC
    `,
    [id])

    res.json({
      status: 'success',
      history: result.rows
    })

  } catch (error) {

    console.error(error)

    res.status(500).json({
      status: 'error',
      message: 'Error fetching patient history'
    })

  }
})

/////////////////////
// LOGIN
/////////////////////

app.post('/login', async (req, res) => {
  try {
    const { email, password } = req.body

    const result = await pool.query(
      `
      SELECT *
      FROM users
      WHERE email = $1
      `,
      [email]
    )

    if (result.rows.length === 0) {
      return res.status(401).json({
        status: 'error',
        message: 'Invalid credentials'
      })
    }

    const user = result.rows[0]

    const isValidPassword = await bcrypt.compare(
      password,
      user.password_hash
    )

    if (!isValidPassword) {
      return res.status(401).json({
        status: 'error',
        message: 'Invalid credentials'
      })
    }

    const token = jwt.sign(
      {
        user_id: user.user_id,
        email: user.email,
        role_id: user.role_id
      },
      process.env.JWT_SECRET,
      {
        expiresIn: '1h'
      }
    )

    res.json({
      status: 'success',
      message: 'Login successful',
      token
    })

  } catch (error) {
    console.error(error)

    res.status(500).json({
      status: 'error',
      message: 'Login failed'
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

//////////////
/// TEMPORAL
///////////////

// Esta comentado, pero borrarlo en un futuro cuando login este terminado
/*
bcrypt.hash('123456', 10)
  .then(hash => {
    console.log(hash)
  })
*/

/////////////////////////
// CRUD - APPOINTMENTS //
/////////////////////////

app.get('/appointments', async (req, res) => {
  try {

    const result = await pool.query(`
      SELECT *
      FROM appointment
      ORDER BY appointment_id ASC
    `)

    res.json(result.rows)

  } catch (error) {

    console.error(error)

    res.status(500).json({
      status: 'error',
      message: 'Error fetching appointments'
    })

  }
})

app.post('/appointments', async (req, res) => {
  try {

    const {
      patient_id,
      staff_id,
      service_id,
      appointment_date,
      start_time,
      end_time,
      reason,
      status
    } = req.body

    const result = await pool.query(`
      INSERT INTO appointment (
        patient_id,
        staff_id,
        service_id,
        appointment_date,
        start_time,
        end_time,
        reason,
        status
      )
      VALUES (
        $1,$2,$3,$4,$5,$6,$7,$8
      )
      RETURNING *
    `,
    [
      patient_id,
      staff_id,
      service_id,
      appointment_date,
      start_time,
      end_time,
      reason,
      status
    ])

    res.status(201).json({
      status: 'success',
      message: 'Appointment created successfully',
      appointment: result.rows[0]
    })

  } catch (error) {

    console.error(error)

    res.status(500).json({
      status: 'error',
      message: 'Error creating appointment'
    })

  }
})

app.put('/appointments/:id', async (req, res) => {
  try {

    const { id } = req.params

    const {
      appointment_date,
      start_time,
      end_time
    } = req.body

    const result = await pool.query(`
      UPDATE appointment
      SET
        appointment_date = $1,
        start_time = $2,
        end_time = $3
      WHERE appointment_id = $4
      RETURNING *
    `,
    [
      appointment_date,
      start_time,
      end_time,
      id
    ])

    res.json({
      status: 'success',
      message: 'Appointment rescheduled successfully',
      appointment: result.rows[0]
    })

  } catch (error) {

    console.error(error)

    res.status(500).json({
      status: 'error',
      message: 'Error rescheduling appointment'
    })

  }
})

app.put('/appointments/:id/cancel', async (req, res) => {
  try {

    const { id } = req.params

    const result = await pool.query(`
      UPDATE appointment
      SET status = 'Cancelada'
      WHERE appointment_id = $1
      RETURNING *
    `,
    [id])

    if (result.rows.length === 0) {
      return res.status(404).json({
        status: 'error',
        message: 'Appointment not found'
      })
    }

    res.json({
      status: 'success',
      message: 'Appointment cancelled successfully',
      appointment: result.rows[0]
    })

  } catch (error) {

    console.error(error)

    res.status(500).json({
      status: 'error',
      message: 'Error cancelling appointment'
    })

  }
})

/////////////////////////
// history //
/////////////////////////

app.post('/therapy-sessions', async (req, res) => {
  try {

    const {
      appointment_id,
      progress,
      observation
    } = req.body

    // 1. Verify appointment exists

    const appointmentResult = await pool.query(`
      SELECT *
      FROM appointment
      WHERE appointment_id = $1
    `,
    [appointment_id])

    if (appointmentResult.rows.length === 0) {
      return res.status(404).json({
        status: 'error',
        message: 'Appointment not found'
      })
    }

    // 2. Verify appointment is not cancelled

    const appointment = appointmentResult.rows[0]

    if (appointment.status === 'Cancelada') {
      return res.status(400).json({
        status: 'error',
        message: 'Cannot register a session for a cancelled appointment'
      })
    }

    // 3. Verify session does not already exist

    const sessionResult = await pool.query(`
      SELECT *
      FROM therapy_session
      WHERE appointment_id = $1
    `,
    [appointment_id])

    if (sessionResult.rows.length > 0) {
      return res.status(400).json({
        status: 'error',
        message: 'Therapy session already registered for this appointment',
        session: sessionResult.rows[0]
      })
    }

    // 4. Create session

    const result = await pool.query(`
      INSERT INTO therapy_session (
        appointment_id,
        progress,
        observation
      )
      VALUES (
        $1,
        $2,
        $3
      )
      RETURNING *
    `,
    [
      appointment_id,
      progress,
      observation
    ])

    res.status(201).json({
      status: 'success',
      message: 'Therapy session registered successfully',
      session: result.rows[0]
    })

  } catch (error) {

    console.error(error)

    res.status(500).json({
      status: 'error',
      message: 'Error registering therapy session'
    })

  }
})