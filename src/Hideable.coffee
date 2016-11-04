
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

module.exports = (type, config) ->

  isDev and
  assertTypes config, configTypes

  type.defineReactiveValues
    isHiding: config.isHiding

  type.addMixin Event.Mixin, events

  type.defineMethods prototype

  type.defineMethods
    __show: config.show
    __hide: config.hide

events =
  willShow: null
  didShow: null
  willHide: null
  didHide: null

prototype =

  show: ->

    return if @isHiding is no
    @isHiding = no

    args = cloneArgs arguments
    @__events.willShow.apply this, args

    args[@__show.length - 1] = @__events.didShow
    return @__show.apply this, args

  hide: ->

    return if @isHiding is yes
    @isHiding = yes

    args = cloneArgs arguments
    @__events.willHide.apply this, args

    args[@__hide.length - 1] = @__events.didHide
    return @__hide.apply this, args
