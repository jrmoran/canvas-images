# # Running

#
dz = new Dropzone(document.getElementById 'dropzone')
dz.onImageDropped (img)->
  toolbar = new Toolbar(document.getElementById 'toolbar')
  imgCan  = new ImageCanvas img, dz.el

  toolbar.onChange (option)->
    switch option
      when 'grayscale'
        if imgCan
          imgCan.eachPixel (color, x, y)->
            imgCan.setColor x, y, color.toGrayScale()
      when 'restore'
        console.log 'restore'
