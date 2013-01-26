
class Wanda
    width: 50
    height: 50
    easterEggKey: 'FREE THE FISH'
    positionOfKey: 0

    constructor: (useAsEasterEgg, saveToStorage) ->
        that = @
        document.addEventListener 'DOMContentLoaded', () ->
            that.constructor_ useAsEasterEgg, saveToStorage

    constructor_: (useAsEasterEgg, saveToStorage) ->
        @createWandaElement()
        @reset()
        if useAsEasterEgg
            @easterEgg(saveToStorage)
        else
            @start()

    reset: () ->
        @top = @generateStartPositionForTop()
        @left = -@width
        #  There are two direction - up & down. I do not care which one it is
        #+ exactly. One is just true and other is false.
        @direction = true
        #  How many cycles the fish has been swimming in that direction.
        @directionCnt = 0
        @swimQuickAway = false

    createWandaElement: () ->
        that = @
        @elm = document.createElement 'div'
        @elm.id = 'wanda'
        @elm.addEventListener 'click', () ->
            that.swimQuickAway = true
        body = document.getElementsByTagName('body')[0]
        body.appendChild @elm

    easterEgg: (saveToStorage) ->
        if sessionStorage.freeTheFish
            @start()
            return
        that = @
        callback = (e) ->
            key = String.fromCharCode e.keyCode
            if key is that.easterEggKey[that.positionOfKey]
                that.positionOfKey += 1
                if that.positionOfKey is that.easterEggKey.length
                    that.start()
                    if saveToStorage
                        sessionStorage.freeTheFish = true
                    this.removeEventListener 'keydown', callback
            else if key is that.easterEggKey[0]
                that.positionOfKey = 1
            else
                that.positionOfKey = 0
        document.addEventListener 'keydown', callback

    start: () ->
        that = @
        @recalculateNewPosition()
        callback = () -> that.start()
        if @isOutOfScreen()
            @reset()
            setTimeout callback, @generateWhenToStartNextSwim()
        else
            setTimeout callback, if @swimQuickAway then 15 else 40
        @updatePosition()

    recalculateNewPosition: () ->
        @recalculateNewPositionForTop()
        @recalculateNewPositionForLeft()

    recalculateNewPositionForTop: () ->
        @top = if @direction then @top + 1 else @top - 1
        @directionCnt += 1
        if @shouldChangeDirection()
            @changeDirection()

    shouldChangeDirection: () ->
        @top is 0 or @top is window.innerHeight or @directionCnt > 10 + Math.random() * 1000

    changeDirection: () ->
        @direction = !@direction
        @directionCnt = 0

    recalculateNewPositionForLeft: () ->
        if !@swimQuickAway or @left > window.innerWidth / 2
            @left += 2
            @elm.className = ''
        else
            @left -= 2
            @elm.className = 'flip'

    updatePosition: () ->
        @elm.style.top = @top + 'px'
        @elm.style.left = @left + 'px'

    isOutOfScreen: () ->
        not (-@width < @left < window.innerWidth + @width)

    generateStartPositionForTop: () ->
        top = Math.floor Math.random() * (window.innerHeight - @width)

    generateWhenToStartNextSwim: () ->
        1000 + Math.random() * 10000
