# Jaime Moran 2011

# # ImageCanvas

# The constructor requires an `Image` instance and a `target` dom node
# where the canvas will be appended.
class ImageCanvas
  constructor: (img, target)->
    canvas  = document.createElement 'canvas'
    return if not canvas.getContext

    @ctx    = canvas.getContext '2d'
    @width  = canvas.width  = img.width
    @height = canvas.height = img.height

    target.appendChild canvas
    target.style.width  = "#{@width}px"
    target.style.height = "#{@height}px"

    @ctx.drawImage img, 0, 0

    @imgData   = @ctx.getImageData 0, 0, @width, @height
    @cacheData = @ctx.getImageData 0, 0, @width, @height

  # ## getIndex
  # Canvas' context has a method `getImageData` which is the returns an object
  # with a `data` property. This is an array of numbers that acts as a buffer
  # of image pixels. Each pixel is represented by a segment of four contigous 
  # elements
  #
  #          pixel         pixel             pixel
  #        ( 0 , 0 )     ( 0 , 1 )         ( 2 , 1 )
  #       ----------    ----------        ----------
  #     [ r, g, b, a,  r, g, b, a,   .... r, g, b, a ]
  # 
  # To obtain the starting point of each segment, I use the method
  # `getIndex`.
  getIndex: (x, y, buffer = @imgData) ->
    index = ( y * buffer.width + x ) * 4

  # ## getColor
  # gets Color at a given `x`, `y` coordinate
  getColor: (x, y, buffer = @imgData)->
    return new Color(0, 0, 0, 0) if x < 0 or y < 0
    index = @getIndex x, y, buffer
    color = new Color
                  r: buffer.data[index]
                  g: buffer.data[index + 1]
                  b: buffer.data[index + 2]
                  a: buffer.data[index + 3]

  # ## setColor
  # sets color at a given coordinate
  setColor: (x, y, color, buffer = @imgData)->
    index = @getIndex x, y, buffer
    buffer.data[index]     = color.r
    buffer.data[index + 1] = color.g
    buffer.data[index + 2] = color.b
    buffer.data[index + 3] = color.a

  # ## eachPixel
  # Iterate over each pixel and run `fun`, this function is passed a
  # `Color` instance, and the `x`, `y` coordinates. The `ImageCanvas`
  # instance is automarically redrawn after the loop is done.
  eachPixel: (fun, buffer = @imgData)->
    for x in [0..buffer.width]
      for y in [0..buffer.height]
        color = @getColor x, y, buffer
        fun color, x, y

    @redraw buffer

  # this puts an image buffer back to the image
  redraw: (buffer = @imgData)-> @ctx.putImageData buffer, 0, 0

  # pass convolution filter
  filter: (filter)->
    # compute denominator for filter and express it in fractions
    denom  = 0
    denom += x for x in filter
    filter = (x / denom for x in filter)

    # `indices` helps getting neighboring pixels, for example 
    # when evaluating pixel at coord `1, 1`
    #
    #     (0,0)  (1,0)  (2,0)
    #     (0,1)  (1,1)  (2,1)
    #     (0,2)  (1,2)  (2,2)
    #
    # we access the surrounding pixels by addition and substraction
    #
    #     (-1,-1)  (0,-1)  (1,-1)
    #     (-1, 0)  (0, 0)  (1, 0)
    #     (-1, 1)  (0, 1)  (1, 1)
    #
    indices = [-1, 0, 1]     # this could be expanded to support bigger matrices

    # retreive pixels
    @eachPixel (color, x, y)=>
      # After getting the surrounding pixels we multiply each with their
      # respective filter item
      counter = 0
      nColor  = new Color 0, 0, 0, 255

      for iy in indices
        for ix in indices
          # color is obtained from cached data, otherwise the filter is
          # applied to already filtered upper pixels
          color = @getColor x + ix, y + iy, @cacheData
          nColor.r += color.r * filter[counter]
          nColor.g += color.g * filter[counter]
          nColor.b += color.b * filter[counter]
          counter++

      @setColor x, y, nColor

  # restore image to its original state
  restore: -> 
    @ctx.putImageData @cacheData, 0, 0
    @imgData   = @ctx.getImageData 0, 0, @width, @height
