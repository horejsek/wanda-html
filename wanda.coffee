
class Wanda
    width: 50
    height: 50

    constructor: () ->
        @createWandaElement()
        @top = @generateStartPositionForTop()
        @left = -@width
        #  There are two direction - up & down. I do not care which one it is
        #+ exactly. One is just true and other is false.
        @direction = true
        #  How many cycles the fish has been swimming in that direction.
        @directionCnt = 0
        @swimQuickAway = false
        @start()

    createWandaElement: () ->
        that = @
        @elm = document.createElement 'div'
        @elm.id = 'wanda'
        @elm.addEventListener 'click', () ->
            that.swimQuickAway = true
        body = document.getElementsByTagName('body')[0]
        body.appendChild @elm

    start: () ->
        @recalculateNewPosition()
        @updatePosition()

        that = @
        callback = () -> that.start()

        if @isOutOfScreen()
            @left = -@width
            @top = @generateStartPositionForTop()
            @swimQuickAway = false
            setTimeout callback, @generateWhenToStartNextSwim()
        else
            setTimeout callback, if @swimQuickAway then 15 else 40

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


document.addEventListener 'DOMContentLoaded', () ->
    new Wanda()

