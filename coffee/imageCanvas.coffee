# # ImageCanvas

# The constructor requires an `Image` instance.
class ImageCanvas
  constructor: (img)->
    canvas  = document.createElement 'canvas'
    @ctx    = canvas.getContext '2d'
    @width  = canvas.width  = img.width
    @height = canvas.height = img.height
    document.body.appendChild canvas

    @ctx.drawImage img, 0, 0

    @imgData = @ctx.getImageData 0, 0, @width, @height

  # ## getColor
  # gets Color at a given `x`, `y` coordinate
  #
  # `@imgData` has a property `data` which is the image buffer. It's 
  # an array of numbers. A pixel is represented by four contigous elements
  #
  #          pixel         pixel             pixel
  #        ( 0 , 0 )     ( 0 , 1 )         ( 2 , 1 )
  #       ----------    ----------        ----------
  #     [ r, g, b, a,  r, g, b, a,   .... r, g, b, a ]
  # 
  getColor: (x, y)->
    index = ( y * @imgData.width + x ) * 4
    color = new Color
                  r: @imgData.data[index]
                  g: @imgData.data[index + 1]
                  b: @imgData.data[index + 2]
                  a: @imgData.data[index + 3]

  # ## setColor
  # sets color at a given coordinate
  setColor: (x, y, color)->
    index = ( y * @imgData.width + x ) * 4
    @imgData.data[index]     = color.r
    @imgData.data[index + 1] = color.g
    @imgData.data[index + 2] = color.b
    @imgData.data[index + 3] = color.a

  # ## eachPixel
  # Iterate over each pixel and run `fun`, this function is passed a
  # `Color` instance, and the `x`, `y` coordinates. The `ImageCanvas`
  # instance is automarically redrawn after the loop is done.
  eachPixel: (fun)->
    for x in [0..@imgData.width]
      for y in [0..@imgData.height]
        color = @getColor x, y
        fun color, x, y

    @redraw()

  # this puts the image buffer back to the image
  redraw: -> @ctx.putImageData @imgData, 0, 0
