var Wanda;

Wanda = (function() {
  /**
  @type {number}
  @private
  */
  Wanda.prototype.width = 50;

  /**
  @type {number}
  @private
  */

  Wanda.prototype.height = 50;

  /**
  @type {string}
  @private
  */

  Wanda.prototype.easterEggKey = 'FREE THE FISH';

  /**
  @type {number}
  @private
  */

  Wanda.prototype.positionOfKey = 0;

  /**
  @param {boolean} useAsEasterEgg
  @param {boolean} saveToStorage
  @constructor
  */

  function Wanda(useAsEasterEgg, saveToStorage) {
    var callback, that;
    that = this;
    callback = function() {
      return that.constructor_(useAsEasterEgg, saveToStorage);
    };
    document.addEventListener('DOMContentLoaded', callback, false);
  }

  /**
  @param {boolean} useAsEasterEgg
  @param {boolean} saveToStorage
  @private
  */

  Wanda.prototype.constructor_ = function(useAsEasterEgg, saveToStorage) {
    this.createWandaElement();
    this.reset();
    if (useAsEasterEgg) {
      return this.easterEgg(saveToStorage);
    } else {
      return this.start();
    }
  };

  /**
  @private
  */

  Wanda.prototype.reset = function() {
    this.top = this.generateStartPositionForTop();
    this.left = -this.width;
    this.direction = true;
    this.directionCnt = 0;
    return this.swimQuickAway = false;
  };

  /**
  @private
  */

  Wanda.prototype.createWandaElement = function() {
    var body, callback, that;
    that = this;
    callback = function() {
      return that.swimQuickAway = true;
    };
    this.elm = document.createElement('div');
    this.elm.id = 'wanda';
    this.elm.addEventListener('click', callback, false);
    body = document.getElementsByTagName('body')[0];
    return body.appendChild(this.elm);
  };

  /**
  @param {boolean} saveToStorage
  @private
  */

  Wanda.prototype.easterEgg = function(saveToStorage) {
    var callback, that;
    if (window.sessionStorage.freeTheFish) {
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
          if (saveToStorage) window.sessionStorage.freeTheFish = true;
          return this.removeEventListener('keydown', callback);
        }
      } else if (key === that.easterEggKey[0]) {
        return that.positionOfKey = 1;
      } else {
        return that.positionOfKey = 0;
      }
    };
    return document.addEventListener('keydown', callback, false);
  };

  /**
  @private
  */

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

  /**
  @private
  */

  Wanda.prototype.recalculateNewPosition = function() {
    this.recalculateNewPositionForTop();
    return this.recalculateNewPositionForLeft();
  };

  /**
  @private
  */

  Wanda.prototype.recalculateNewPositionForTop = function() {
    this.top = this.direction ? this.top + 1 : this.top - 1;
    this.directionCnt += 1;
    if (this.shouldChangeDirection()) return this.changeDirection();
  };

  /**
  @private
  */

  Wanda.prototype.shouldChangeDirection = function() {
    return this.top === 0 || this.top === window.innerHeight || this.directionCnt > 10 + Math.random() * 1000;
  };

  /**
  @private
  */

  Wanda.prototype.changeDirection = function() {
    this.direction = !this.direction;
    return this.directionCnt = 0;
  };

  /**
  @private
  */

  Wanda.prototype.recalculateNewPositionForLeft = function() {
    if (!this.swimQuickAway || this.left > window.innerWidth / 2) {
      this.left += 2;
      return this.elm.className = '';
    } else {
      this.left -= 2;
      return this.elm.className = 'flip';
    }
  };

  /**
  @private
  */

  Wanda.prototype.updatePosition = function() {
    this.elm.style.top = this.top + 'px';
    return this.elm.style.left = this.left + 'px';
  };

  /**
  @private
  */

  Wanda.prototype.isOutOfScreen = function() {
    var _ref;
    return !((-this.width < (_ref = this.left) && _ref < window.innerWidth + this.width));
  };

  /**
  @private
  */

  Wanda.prototype.generateStartPositionForTop = function() {
    var top;
    return top = Math.floor(Math.random() * (window.innerHeight - this.width));
  };

  /**
  @private
  */

  Wanda.prototype.generateWhenToStartNextSwim = function() {
    return 1000 + Math.random() * 10000;
  };

  return Wanda;

})();

window['Wanda'] = Wanda;
