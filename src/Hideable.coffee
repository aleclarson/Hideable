
emptyFunction = require "emptyFunction"
assertTypes = require "assertTypes"
cloneArgs = require "cloneArgs"
Event = require "Event"
isDev = require "isDev"
Null = require "Null"

isDev and
configTypes =
  isHiding: Boolean.or Null # <- `null` means "could be hiding or not hiding"
  show: Function
  hide: Function
  disableEvents: Boolean.Maybe

module.exports = (type, config) ->

  isDev and
  assertTypes config, configTypes

  type.defineReactiveValues
    isHiding: config.isHiding

  if config.disableEvents is yes
  then type.definePrototype {__events: eventsDisabled}
  else type.defineEvents events

  type.defineMethods prototype

  type.defineMethods
    _show: config.show
    _hide: config.hide

events =
  willShow: null
  didShow: null
  willHide: null
  didHide: null

eventsDisabled =
  willShow: emptyFunction
  didShow: emptyFunction
  willHide: emptyFunction
  didHide: emptyFunction

prototype =

  show: ->

    return if @isHiding is no
    @isHiding = no

    args = cloneArgs arguments
    @__events.willShow.apply this, args

    args.push @__events.didShow
    return @_show.apply this, args

  hide: ->

    return if @isHiding is yes
    @isHiding = yes

    args = cloneArgs arguments
    @__events.willHide.apply this, args

    args.push @__events.didHide
    return @_hide.apply this, args
