
ReactiveVar = require "reactive-var"
define = require "define"

module.exports = (obj, config = {}) ->

  isHiding = ReactiveVar config.isHiding ?= no
  onShow = config.onShow ?= emptyFunction
  onHide = config.onHide ?= emptyFunction

  define obj,

    isHiding: get: ->
      isHiding.get()

    show: ->
      return unless isHiding
      isHiding.set no
      onShow()

    hide: ->
      return if isHiding
      isHiding.set yes
      onHide()
