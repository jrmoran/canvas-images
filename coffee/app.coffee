# # Running
dz = new Dropzone 'dropzone'
dz.onImageDropped (img)->
  imgCan  = new ImageCanvas img, dz.el

  #     image operations
  #     imgCan.eachPixel (color, x, y)->
  #       imgCan.setColor x, y, color.toGrayScale()
