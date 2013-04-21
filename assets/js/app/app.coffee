#= require ../vendor/jquery

socket = io.connect()
video = document.querySelector 'video'
img = document.querySelector '#screenshot'
canvas = document.querySelector '#capture'

socket.on 'connect', ->
  socket.on 'frame', (dataUrl) ->
    img.src = dataUrl
    

  navigator.webkitGetUserMedia video: true, (stream) ->
    video.src = window.URL.createObjectURL stream
    context = canvas.getContext '2d'

    setInterval ->
      canvas.width = video.videoWidth
      canvas.height = video.videoHeight
    , 500

    setInterval ->
      context.drawImage(video, 0, 0)
      socket.emit 'frame', canvas.toDataURL('image/webp', 0.1)
    , 10