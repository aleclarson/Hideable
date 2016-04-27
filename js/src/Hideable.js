var Event, Null, Void, define, isType, ref, validateTypes;

ref = require("type-utils"), Void = ref.Void, Null = ref.Null, isType = ref.isType, validateTypes = ref.validateTypes;

define = require("define");

Event = require("event");

module.exports = function(self, config) {
  var hide, show;
  if (config == null) {
    config = {};
  }
  validateTypes(config, {
    isHiding: [Boolean, Null],
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
      var arg, args, i, len;
      if (this.isHiding === false) {
        return;
      }
      this.isHiding = false;
      args = [];
      for (i = 0, len = arguments.length; i < len; i++) {
        arg = arguments[i];
        args.push(arg);
      }
      this.willShow.emitArgs(args);
      args.push(this.didShow.emit);
      return show.apply(this, args);
    },
    hide: function() {
      var arg, args, i, len;
      if (this.isHiding === true) {
        return;
      }
      this.isHiding = true;
      args = [];
      for (i = 0, len = arguments.length; i < len; i++) {
        arg = arguments[i];
        args.push(arg);
      }
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
