
emptyFunction = require "emptyFunction"
assertTypes = require "assertTypes"
cloneArgs = require "cloneArgs"
Builder = require "Builder"
Event = require "Event"
isDev = require "isDev"
Null = require "Null"

isDev and
configTypes =
  isHiding: Boolean.or Null
  show: Function
  hide: Function

module.exports = (type, config) ->

  isDev and
  assertTypes config, configTypes

  # When `config.isHiding` equals null, its visibility is "unknown".
  type.defineReactiveValues
    isHiding: config.isHiding

  type.defineMethods
    __show: config.show
    __hide: config.hide

  mixin.apply type

mixin = Builder.Mixin()

mixin.defineValues ->

  willShow: Event()

  didShow: Event()

  willHide: Event()

  didHide: Event()

mixin.defineMethods

  show: ->

    return if @isHiding is no
    @isHiding = no

    args = cloneArgs arguments
    @willShow.applyEmit args

    args[@__show.length - 1] = @didShow.bindEmit()
    return @__show.apply this, args

  hide: ->

    return if @isHiding is yes
    @isHiding = yes

    args = cloneArgs arguments
    @willHide.applyEmit args

    args[@__hide.length - 1] = @didHide.bindEmit()
    return @__hide.apply this, args
