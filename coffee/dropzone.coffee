# Jaime Moran 2011

# # Dropzone

# Makes a dom node `target` a dropzone for images
class Dropzone
  constructor: (target)->
    @el = target

    # events
    @el.ondragover = ->
      @classList.remove 'editor'
      @classList.add 'hover'
      return false

    @el.ondragleave  = ->
      @classList.remove 'hover'
      return false


  # run callback `fun` when a new image has been dropped. The callback
  # will be passed the `Image` instance
  onImageDropped: (fun)->
    @el.ondrop  = (e)->
      reader     = new FileReader()
      file       = e.dataTransfer.files[0]

      @innerHTML = 'Loading....'
      dropbox    = this

      reader.onload = (e2)->
        dropbox.innerHTML = ''
        dropbox.classList.add 'editor'

        img     = new Image()           # create image and imageCanvas instances 
        img.src = e2.target.result

        img.onload = ->
          fun img                       # run callback and pass image

        e2.preventDefault()

      # this will read the file and fire the reader's `load` event when done
      reader.readAsDataURL file
      e.preventDefault()
