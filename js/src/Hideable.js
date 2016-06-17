var Event, Null, assertTypes, configTypes, define;

require("isDev");

assertTypes = require("assertTypes");

define = require("define");

Event = require("Event");

Null = require("Null");

if (isDev) {
  configTypes = {
    isHiding: [Boolean, Null],
    show: Function,
    hide: Function,
    onShowStart: Function.Maybe,
    onShowEnd: Function.Maybe,
    onHideStart: Function.Maybe,
    onHideEnd: Function.Maybe
  };
}

module.exports = function(self, config) {
  var hide, show;
  if (isDev) {
    assertTypes(config, configTypes);
  }
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
      this.willShow.emit.apply(this, args);
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
      this.willHide.emit.apply(this, args);
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
