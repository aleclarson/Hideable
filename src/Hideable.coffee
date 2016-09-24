
assertTypes = require "assertTypes"
define = require "define"
Event = require "Event"
isDev = require "isDev"
Null = require "Null"

isDev and
configTypes =
  isHiding: Boolean.or Null
  show: Function
  hide: Function
  onShowStart: Function.Maybe
  onShowEnd: Function.Maybe
  onHideStart: Function.Maybe
  onHideEnd: Function.Maybe

module.exports = (self, config) ->

  isDev and
  assertTypes config, configTypes

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

      @willShow.emit.apply this, args

      args.push @didShow.emit
      show.apply this, args

    hide: ->

      return if @isHiding is yes
      @isHiding = yes

      args = [] # Cannot leak the 'arguments' object.
      args.push arg for arg in arguments

      @willHide.emit.apply this, args

      args.push @didHide.emit
      hide.apply this, args

    willShow: Event config.onShowStart

    didShow: Event config.onShowEnd

    willHide: Event config.onHideStart

    didHide: Event config.onHideEnd
