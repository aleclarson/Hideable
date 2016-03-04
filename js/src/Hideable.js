var Event, define, isType, ref, validateTypes,
  slice = [].slice;

ref = require("type-utils"), isType = ref.isType, validateTypes = ref.validateTypes;

define = require("define");

Event = require("event");

module.exports = function(self, config) {
  var hide, show;
  if (config == null) {
    config = {};
  }
  validateTypes(config, {
    isHiding: [Boolean, Void],
    show: Function,
    hide: Function,
    onShowStart: [Function, Void],
    onShowEnd: [Function, Void],
    onHideStart: [Function, Void],
    onHideEnd: [Function, Void]
  });
  show = config.show, hide = config.hide;
  return define(self, {
    isHiding: {
      value: config.isHiding,
      reactive: true
    },
    show: function() {
      var args;
      args = 1 <= arguments.length ? slice.call(arguments, 0) : [];
      if (this.isHiding === false) {
        return;
      }
      this.isHiding = false;
      this.willShow.emitArgs(args);
      args.push(this.didShow.emit);
      return show.apply(this, args);
    },
    hide: function() {
      var args;
      args = 1 <= arguments.length ? slice.call(arguments, 0) : [];
      if (this.isHiding === true) {
        return;
      }
      this.isHiding = true;
      this.willHide.emitArgs(args);
      args.push(this.didHide.emit);
      return hide.apply(this, args);
    },
    willShow: Event(config.onShowStart),
    didShow: Event(config.onShowEnd),
    willHide: Event(config.onHideStart),
    didHide: Event(config.onHideEnd)
  });
};

//# sourceMappingURL=../../map/src/Hideable.map
