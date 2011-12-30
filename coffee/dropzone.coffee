class Dropzone
  constructor: (target)->
    @el = document.getElementById target

    # events
    @el.ondragover = ->
      @className = 'hover'
      return false

    @el.ondragleave  = ->
      @className = ''
      return false

  onImageDropped: (fun)->
    @el.ondrop  = (e)->
      @className = ''
      reader     = new FileReader()
      file       = e.dataTransfer.files[0]

      @innerHTML = 'Loading....'

      dropbox = this

      reader.onload = (e2)->
        dropbox.innerHTML = ''
        dropbox.className = 'editor'

        # create image and imageCanvas instances
        img     = new Image()
        img.src = e2.target.result

        # run callback and pass image
        fun img

      # this will read the file and fire the reader's `load` event when done
      reader.readAsDataURL file
