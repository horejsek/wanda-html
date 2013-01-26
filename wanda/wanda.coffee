
class Wanda
    ###*
    @type {number}
    @private
    ###
    width: 50

    ###*
    @type {number}
    @private
    ###
    height: 50

    ###*
    @type {string}
    @private
    ###
    easterEggKey: 'FREE THE FISH'

    ###*
    @type {number}
    @private
    ###
    positionOfKey: 0

    ###*
    @param {boolean} useAsEasterEgg
    @param {boolean} saveToStorage
    @constructor
    ###
    constructor: (useAsEasterEgg, saveToStorage) ->
        that = @
        callback = () ->
            that.constructor_ useAsEasterEgg, saveToStorage
        document.addEventListener 'DOMContentLoaded', callback, false

    ###*
    @param {boolean} useAsEasterEgg
    @param {boolean} saveToStorage
    @private
    ###
    constructor_: (useAsEasterEgg, saveToStorage) ->
        @createWandaElement()
        @reset()
        if useAsEasterEgg
            @easterEgg(saveToStorage)
        else
            @start()

    ###*
    @private
    ###
    reset: () ->
        @top = @generateStartPositionForTop()
        @left = -@width
        #  There are two direction - up & down. I do not care which one it is
        #+ exactly. One is just true and other is false.
        @direction = true
        #  How many cycles the fish has been swimming in that direction.
        @directionCnt = 0
        @swimQuickAway = false

    ###*
    @private
    ###
    createWandaElement: () ->
        that = @
        callback = () ->
            that.swimQuickAway = true

        @elm = document.createElement 'div'
        @elm.id = 'wanda'
        @elm.addEventListener 'click', callback, false

        body = document.getElementsByTagName('body')[0]
        body.appendChild @elm

    ###*
    @param {boolean} saveToStorage
    @private
    ###
    easterEgg: (saveToStorage) ->
        if window.sessionStorage.freeTheFish
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
                        window.sessionStorage.freeTheFish = true
                    this.removeEventListener 'keydown', callback
            else if key is that.easterEggKey[0]
                that.positionOfKey = 1
            else
                that.positionOfKey = 0
        document.addEventListener 'keydown', callback, false

    ###*
    @private
    ###
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

    ###*
    @private
    ###
    recalculateNewPosition: () ->
        @recalculateNewPositionForTop()
        @recalculateNewPositionForLeft()

    ###*
    @private
    ###
    recalculateNewPositionForTop: () ->
        @top = if @direction then @top + 1 else @top - 1
        @directionCnt += 1
        if @shouldChangeDirection()
            @changeDirection()

    ###*
    @private
    ###
    shouldChangeDirection: () ->
        @top is 0 or @top is window.innerHeight or @directionCnt > 10 + Math.random() * 1000

    ###*
    @private
    ###
    changeDirection: () ->
        @direction = !@direction
        @directionCnt = 0

    ###*
    @private
    ###
    recalculateNewPositionForLeft: () ->
        if !@swimQuickAway or @left > window.innerWidth / 2
            @left += 2
            @elm.className = ''
        else
            @left -= 2
            @elm.className = 'flip'

    ###*
    @private
    ###
    updatePosition: () ->
        @elm.style.top = @top + 'px'
        @elm.style.left = @left + 'px'

    ###*
    @private
    ###
    isOutOfScreen: () ->
        not (-@width < @left < window.innerWidth + @width)

    ###*
    @private
    ###
    generateStartPositionForTop: () ->
        top = Math.floor Math.random() * (window.innerHeight - @width)

    ###*
    @private
    ###
    generateWhenToStartNextSwim: () ->
        1000 + Math.random() * 10000

# Store the function in a global property referenced by a string.
window['Wanda'] = Wanda
