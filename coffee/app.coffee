# # loadImage

# Load an image from a local `url` and run `fun` when the image is
# loaded. `fun` is passed and instance of `ImageCanvas` as argument.
loadImage = (filename, fun)->
  img        = new Image()
  img.src    = filename
  img.onload = -> 
    imageCanvas = new ImageCanvas img
    fun imageCanvas

# # Running

#
loadImage 'images/salvador_del_mundo.jpg', (imageCanvas)->
  imageCanvas.eachPixel (color, x, y)->
    # imageCanvas.setColor x, y, color.toGrayScale()
    imageCanvas.setColor x, y, color.invert()
    # imageCanvas.setColor x, y, color.brigthen( 100 )
    # imageCanvas.setColor x, y, color.darken( 150 )


# checking if colors are equal
#
#     ca = new Color 100, 100, 100, 100
#     cb = new Color 100, 100, 100, 100
#
#     msg = if ca is cb then 'Y' else 'N'
#     console.log 'ca === cb\t', msg              # N
#
#     msg = if ca.isEqual(cb) then 'Y' else 'N'
#     console.log 'ca.isEqual(cb)\t', msg         # Y
