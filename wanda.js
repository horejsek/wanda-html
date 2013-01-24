(function() {
  var Wanda;

  Wanda = (function() {

    Wanda.prototype.width = 50;

    Wanda.prototype.height = 50;

    function Wanda() {
      this.createWandaElement();
      this.top = this.generateStartPositionForTop();
      this.left = -this.width;
      this.direction = true;
      this.directionCnt = 0;
      this.swimQuickAway = false;
      this.start();
    }

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

    Wanda.prototype.generateStartPositionForTop = function() {
      return Math.floor(Math.random() * window.innerHeight);
    };

    Wanda.prototype.start = function() {
      var callback, that;
      this.recalculateNewPosition();
      this.updatePosition();
      that = this;
      callback = function() {
        return that.start();
      };
      if (this.isOutOfScreen()) {
        this.left = -this.width;
        this.top = this.generateStartPositionForTop();
        this.swimQuickAway = false;
        return setTimeout(callback, 1000 + Math.random() * 10000);
      } else {
        return setTimeout(callback, this.swimQuickAway ? 5 : 20);
      }
    };

    Wanda.prototype.recalculateNewPosition = function() {
      this.recalculateNewPositionForTop();
      return this.recalculateNewPositionForLeft();
    };

    Wanda.prototype.recalculateNewPositionForTop = function() {
      this.top = this.direction ? this.top + 1 : this.top - 1;
      this.directionCnt += 1;
      if (this.directionCnt > 20) {
        this.direction = !this.direction;
        return this.directionCnt = 0;
      }
    };

    Wanda.prototype.recalculateNewPositionForLeft = function() {
      if (!this.swimQuickAway || this.left > window.innerWidth / 2) {
        this.left += 1;
        return this.elm.className = '';
      } else {
        this.left -= 1;
        return this.elm.className = 'flip';
      }
    };

    Wanda.prototype.isOutOfScreen = function() {
      var _ref;
      return !((-this.width < (_ref = this.left) && _ref < window.innerWidth + this.width));
    };

    Wanda.prototype.updatePosition = function() {
      this.elm.style.top = this.top + 'px';
      return this.elm.style.left = this.left + 'px';
    };

    return Wanda;

  })();

  document.addEventListener('DOMContentLoaded', function() {
    return new Wanda();
  });

}).call(this);
