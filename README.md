
# hideable v1.2.0 [![stable](http://badges.github.io/stability-badges/dist/stable.svg)](http://github.com/badges/stability-badges)

```coffee
Hideable = require "hideable"

obj = Hideable {},

  onShow: ->
    # Do stuff when 'show()' is called!

  onHide: ->
    # Do stuff when 'hide()' is called!

obj.isHiding # = false

obj.hide()

obj.show()
```

*Documentation at a later date*
