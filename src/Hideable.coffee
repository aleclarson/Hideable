
{ isType, validateTypes } = require "type-utils"

define = require "define"
Event = require "event"

module.exports = (self, config = {}) ->

  validateTypes config,
    isHiding: [ Boolean, Void ]
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

    show: (args...) ->
      return if @isHiding is no
      @isHiding = no
      @willShow.emitArgs args
      args.push @didShow.emit
      show.apply this, args

    hide: (args...) ->
      return if @isHiding is yes
      @isHiding = yes
      @willHide.emitArgs args
      args.push @didHide.emit
      hide.apply this, args

    willShow: Event config.onShowStart

    didShow: Event config.onShowEnd

    willHide: Event config.onHideStart

    didHide: Event config.onHideEnd
