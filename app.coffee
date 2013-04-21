express = require('express')
app = express()
app.use require('connect-assets')()
server = require('http').createServer(app)
io = require('socket.io').listen(server)

io.set 'transports', ['websocket']

app.set 'view engine', 'jade'
app.set 'views', "#{__dirname}/views"
app.use express.static "#{__dirname}/public"

app.get '/', (req, res) -> res.render 'index.jade'

io.sockets.on 'connection', (socket) ->
  socket.on 'frame', (data) ->
    socket.broadcast.volatile.emit('frame', data)


server.listen 3000