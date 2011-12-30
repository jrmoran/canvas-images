# Toolbar

# Pass a dom node `target` to the constructor. Use `onChange` to react
# to changes 
class Toolbar
  constructor: (target)->
    @el      = target
    @buttons = @el.getElementsByTagName 'li'
    @menus   = @el.getElementsByTagName 'ul'

    @menus[0].style.display = 'block'
    @menus[1].style.display = 'none'

  onChange: (fun)->
    # this iterates over menues and toggles visibility
    toggleMenu = =>
      for menu in @menus
        style  = menu.style.display
        nstyle = if style is "block" then "none" else "block"
        menu.style.display = nstyle

    # attach events to each button
    for btn in @buttons
      btn.onclick = ->
        name = @getAttribute 'name'
        fun name
        toggleMenu()
