// Generated by CoffeeScript 1.5.0
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  Chat.MockStorage = (function() {

    function MockStorage() {
      this.storage = localStorage;
    }

    MockStorage.prototype.getItem = function(key) {
      return this.storage.getItem(key);
    };

    MockStorage.prototype.setItem = function(key, value) {
      return this.storage.setItem(key, value);
    };

    MockStorage.prototype.removeItem = function(key) {
      return this.storage.removeItem(key);
    };

    MockStorage.prototype.length = function() {
      return this.storage.length;
    };

    MockStorage.prototype.key = function(i) {
      return this.storage.key(i);
    };

    return MockStorage;

  })();

  Chat.SocketStorage = (function(_super) {

    __extends(SocketStorage, _super);

    function SocketStorage() {
      SocketStorage.__super__.constructor.apply(this, arguments);
      this.storage = new Chat.MockStorage();
    }

    SocketStorage.subscribe = function(model, storageKey) {
      var addModel, fun, json, randomInt;
      randomInt = function(min, max) {
        return Math.floor(Math.random() * (max - min + 1)) + min;
      };
      json = {
        text: "IT WORKS!",
        user: "robot"
      };
      addModel = function() {
        var record;
        json.id = json.id + randomInt(0, 1000);
        record = model.createFromJSON(json);
        return model.get("all").add(record);
      };
      SocketStorage.on(storageKey, addModel);
      fun = function() {
        Chat.SocketStorage.fire(storageKey);
        return setTimeout(fun, 3000);
      };
      return setTimeout(fun, 3000);
    };

    SocketStorage.prototype._forAllStorageEntries = function(iterator) {
      var i, key, _i, _ref;
      for (i = _i = 0, _ref = this.storage.length(); 0 <= _ref ? _i < _ref : _i > _ref; i = 0 <= _ref ? ++_i : --_i) {
        key = this.storage.key(i);
        iterator.call(this, key, this.storage.getItem(key));
      }
      return true;
    };

    SocketStorage.prototype.readAll = SocketStorage.skipIfError(function(env, next) {
      var key, model;
      try {
        arguments[0].recordsAttributes = this._storageEntriesMatching(env.subject, env.options.data);
      } catch (error) {
        arguments[0].error = error;
      }
      model = env.subject;
      key = model.storageKey;
      SocketStorage.subscribe(model, key);
      return next();
    });

    return SocketStorage;

  }).call(this, Batman.LocalStorage);

}).call(this);
