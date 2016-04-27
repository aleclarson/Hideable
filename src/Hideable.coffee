
{ Void, Null, isType, validateTypes } = require "type-utils"

define = require "define"
Event = require "event"

module.exports = (self, config = {}) ->

  validateTypes config,
    isHiding: [ Boolean, Null ]
    show: Function
    hide: Function
    onShowStart: [ Function, Void ]
    onShowEnd: [ Function, Void ]
    onHideStart: [ Function, Void ]
    onHideEnd: [ Function, Void ]

  { show, hide } = config

  define self,

    isHiding:
      value: config.isHiding
      reactive: yes

    show: ->
      return if @isHiding is no
      @isHiding = no
      args = [] # Cannot leak the 'arguments' object.
      args.push arg for arg in arguments
      @willShow.emitArgs args
      args.push @didShow.emit
      show.apply this, args

    hide: ->
      return if @isHiding is yes
      @isHiding = yes
      args = [] # Cannot leak the 'arguments' object.
      args.push arg for arg in arguments
      @willHide.emitArgs args
      args.push @didHide.emit
      hide.apply this, args

    willShow: Event config.onShowStart

    didShow: Event config.onShowEnd

    willHide: Event config.onHideStart

    didHide: Event config.onHideEnd
