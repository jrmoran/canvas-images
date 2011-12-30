# # Color
#
# * red
# * gree
# * blue
# * opacity - 255 is full opaque
#
# instantiate with multiple args
#
#     new Color(r<int>, g<int>, b<int>, a<int>)
#
# or an object literal
#
#     new Color({ r: <int>, g: <int>, b: <int>, a: <int>})

#
class Color
  constructor: ->
    if arguments.length is 4
      [@r, @g, @b, @a] = arguments

    if arguments.length is 1
      {@r, @g, @b, @a} = arguments[0]

  toGrayScale: ->
    # relative luminance
    l = 0.2126 * @r + 0.7152 * @g + 0.0722 * @b
    @r = l 
    @g = l
    @b = l
    this

  # TODO: brigthen and darken should be percentages
  brigthen: (n)->
    if n >= 0 and n <= 255
      @r = if (r = @r + n) < 255 then r else 255
      @g = if (g = @g + n) < 255 then g else 255
      @b = if (b = @b + n) < 255 then b else 255

    this

  darken: (n)->
    if n >= 0 and n <= 255
      @r = if (r = @r - n) > 0 then r else 0
      @g = if (g = @g - n) > 0 then g else 0
      @b = if (b = @b - n) > 0 then b else 0

    this

  invert: ->
    @r = 255 - @r
    @g = 255 - @g
    @b = 255 - @b
    this

  isEqual: (c)->
    if @r is c.r and @b is c.b and @g is c.g and @a is c.a
      true
    else
      false
