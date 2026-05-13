const express = require('express')

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

app.listen(PORT, () => {
  console.log(`Servidor corriendo en puerto ${PORT} 
                \nServidor corriendo en http://localhost:${PORT}`)
})