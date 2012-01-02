# Jaime Moran 2011

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
      when 'sharpen'
        imgCan.filter [ 0, -1,  0,
                       -1,  5, -1,
                        0, -1,  0 ]
      when 'extrasharp'
        imgCan.filter [ -1, -1, -1,
                        -1,  9, -1,
                        -1, -1, -1 ]
      when 'smooth'
        imgCan.filter [ 1, 1, 1,
                        1, 2, 1,
                        1, 1, 1 ]
      when 'raised'
        imgCan.filter [ 0, 0, -2,
                        0, 2,  0,
                        1, 0,  0 ]
      when 'motionblur'
        imgCan.filter [ 0, 0, 1,
                        0, 0, 0,
                        1, 0, 0 ]
      when 'restore'
        imgCan.restore()
