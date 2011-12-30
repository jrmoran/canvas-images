# # Running

#
dz = new Dropzone document.getElementsByClassName('dropzone')[0] 
dz.onImageDropped (img)->
  toolbar = new Toolbar document.getElementsByClassName('toolbar')[0]
  imgCan  = new ImageCanvas img, dz.el

  toolbar.onChange (option)->
    return unless imgCan
    switch option
      when 'grayscale'
        imgCan.eachPixel (color, x, y)->
          imgCan.setColor x, y, color.toGrayScale()
      when 'brigthen'
        imgCan.eachPixel (color, x, y)->
          imgCan.setColor x, y, color.brigthen 80
      when 'invert'
        imgCan.eachPixel (color, x, y)->
          imgCan.setColor x, y, color.invert()
      when 'darken'
        imgCan.eachPixel (color, x, y)->
          imgCan.setColor x, y, color.darken 100
      when 'restore'
        imgCan.restore()

