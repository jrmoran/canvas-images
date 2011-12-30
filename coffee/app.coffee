# # Running

#
dz = new Dropzone(document.getElementById 'dropzone')
dz.onImageDropped (img)->
  toolbar = new Toolbar(document.getElementById 'toolbar')
  imgCan  = new ImageCanvas img, dz.el

  toolbar.onChange (option)->
    return unless imgCan
    switch option
      when 'grayscale'
        imgCan.eachPixel (color, x, y)->
          imgCan.setColor x, y, color.toGrayScale()
      when 'restore'
        imgCan.restore()

