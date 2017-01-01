
# Hideable v1.2.1 [![stable](http://badges.github.io/stability-badges/dist/stable.svg)](http://github.com/badges/stability-badges)

```coffee
Hideable = require "Hideable"

type = Type()

type.addMixin Hideable,

  # The default value of `isHiding`. Must be a boolean or null.
  isHiding: yes

  show: (done) ->
    # TODO: Perform show animation.

  hide: (done) ->
    # TODO: Perform hide animation.

Foo = type.build()

foo = Foo()
foo.isHiding # => true

foo.show()
foo.isHiding # => false

foo.hide()
foo.isHiding # => true
```

