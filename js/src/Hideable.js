var ReactiveVar, define;

ReactiveVar = require("reactive-var");

define = require("define");

module.exports = function(obj, config) {
  var isHiding, onHide, onShow;
  if (config == null) {
    config = {};
  }
  isHiding = ReactiveVar(config.isHiding != null ? config.isHiding : config.isHiding = false);
  onShow = config.onShow != null ? config.onShow : config.onShow = emptyFunction;
  onHide = config.onHide != null ? config.onHide : config.onHide = emptyFunction;
  return define(obj, {
    isHiding: {
      get: function() {
        return isHiding.get();
      }
    },
    show: function() {
      if (!isHiding) {
        return;
      }
      isHiding.set(false);
      return onShow();
    },
    hide: function() {
      if (isHiding) {
        return;
      }
      isHiding.set(true);
      return onHide();
    }
  });
};

//# sourceMappingURL=../../map/src/Hideable.map
