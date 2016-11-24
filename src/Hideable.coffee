
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

  type.defineValues createValues
  type.defineMethods prototype

  type.defineMethods
    __show: config.show
    __hide: config.hide

createValues = ->
  willShow: Event.sync()
  didShow: Event.sync()
  willHide: Event.sync()
  didHide: Event.sync()

prototype =

  show: ->

    return if @isHiding is no
    @isHiding = no

    args = cloneArgs arguments
    @willShow.emit.apply this, args

    args[@__show.length - 1] = @didShow.emit
    return @__show.apply this, args

  hide: ->

    return if @isHiding is yes
    @isHiding = yes

    args = cloneArgs arguments
    @willHide.emit.apply this, args

    args[@__hide.length - 1] = @didHide.emit
    return @__hide.apply this, args
