// Generated by CoffeeScript 1.5.0
(function() {
  var Chat,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  Batman.config.minificationErrors = false;

  Chat = (function(_super) {

    __extends(Chat, _super);

    function Chat() {
      Chat.__super__.constructor.apply(this, arguments);
    }

    return Chat;

  })(Batman.App);

  Batman.container.Chat = Chat;

  window.addEventListener('load', function() {
    return Chat.run();
  });

}).call(this);
