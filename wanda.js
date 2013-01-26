var Wanda;

Wanda = (function() {

  Wanda.prototype.width = 50;

  Wanda.prototype.height = 50;

  Wanda.prototype.easterEggKey = 'FREE THE FISH';

  Wanda.prototype.positionOfKey = 0;

  function Wanda(useAsEasterEgg, saveToStorage) {
    var that;
    that = this;
    document.addEventListener('DOMContentLoaded', function() {
      return that.constructor_(useAsEasterEgg, saveToStorage);
    });
  }

  Wanda.prototype.constructor_ = function(useAsEasterEgg, saveToStorage) {
    this.createWandaElement();
    this.reset();
    if (useAsEasterEgg) {
      return this.easterEgg(saveToStorage);
    } else {
      return this.start();
    }
  };

  Wanda.prototype.reset = function() {
    this.top = this.generateStartPositionForTop();
    this.left = -this.width;
    this.direction = true;
    this.directionCnt = 0;
    return this.swimQuickAway = false;
  };

  Wanda.prototype.createWandaElement = function() {
    var body, that;
    that = this;
    this.elm = document.createElement('div');
    this.elm.id = 'wanda';
    this.elm.addEventListener('click', function() {
      return that.swimQuickAway = true;
    });
    body = document.getElementsByTagName('body')[0];
    return body.appendChild(this.elm);
  };

  Wanda.prototype.easterEgg = function(saveToStorage) {
    var callback, that;
    if (sessionStorage.freeTheFish) {
      this.start();
      return;
    }
    that = this;
    callback = function(e) {
      var key;
      key = String.fromCharCode(e.keyCode);
      if (key === that.easterEggKey[that.positionOfKey]) {
        that.positionOfKey += 1;
        if (that.positionOfKey === that.easterEggKey.length) {
          that.start();
          if (saveToStorage) sessionStorage.freeTheFish = true;
          return this.removeEventListener('keydown', callback);
        }
      } else if (key === that.easterEggKey[0]) {
        return that.positionOfKey = 1;
      } else {
        return that.positionOfKey = 0;
      }
    };
    return document.addEventListener('keydown', callback);
  };

  Wanda.prototype.start = function() {
    var callback, that;
    that = this;
    this.recalculateNewPosition();
    callback = function() {
      return that.start();
    };
    if (this.isOutOfScreen()) {
      this.reset();
      setTimeout(callback, this.generateWhenToStartNextSwim());
    } else {
      setTimeout(callback, this.swimQuickAway ? 15 : 40);
    }
    return this.updatePosition();
  };

  Wanda.prototype.recalculateNewPosition = function() {
    this.recalculateNewPositionForTop();
    return this.recalculateNewPositionForLeft();
  };

  Wanda.prototype.recalculateNewPositionForTop = function() {
    this.top = this.direction ? this.top + 1 : this.top - 1;
    this.directionCnt += 1;
    if (this.shouldChangeDirection()) return this.changeDirection();
  };

  Wanda.prototype.shouldChangeDirection = function() {
    return this.top === 0 || this.top === window.innerHeight || this.directionCnt > 10 + Math.random() * 1000;
  };

  Wanda.prototype.changeDirection = function() {
    this.direction = !this.direction;
    return this.directionCnt = 0;
  };

  Wanda.prototype.recalculateNewPositionForLeft = function() {
    if (!this.swimQuickAway || this.left > window.innerWidth / 2) {
      this.left += 2;
      return this.elm.className = '';
    } else {
      this.left -= 2;
      return this.elm.className = 'flip';
    }
  };

  Wanda.prototype.updatePosition = function() {
    this.elm.style.top = this.top + 'px';
    return this.elm.style.left = this.left + 'px';
  };

  Wanda.prototype.isOutOfScreen = function() {
    var _ref;
    return !((-this.width < (_ref = this.left) && _ref < window.innerWidth + this.width));
  };

  Wanda.prototype.generateStartPositionForTop = function() {
    var top;
    return top = Math.floor(Math.random() * (window.innerHeight - this.width));
  };

  Wanda.prototype.generateWhenToStartNextSwim = function() {
    return 1000 + Math.random() * 10000;
  };

  return Wanda;

})();
