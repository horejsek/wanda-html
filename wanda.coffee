
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

    generateStartPositionForTop: () ->
        top = Math.floor Math.random() * (window.innerHeight - @width)

    start: () ->
        @recalculateNewPosition()
        @updatePosition()

        that = @
        callback = () -> that.start()

        if @isOutOfScreen()
            @left = -@width
            @top = @generateStartPositionForTop()
            @swimQuickAway = false
            setTimeout callback, 1000 + Math.random() * 10000
        else
            setTimeout callback, if @swimQuickAway then 5 else 20

    recalculateNewPosition: () ->
        @recalculateNewPositionForTop()
        @recalculateNewPositionForLeft()

    recalculateNewPositionForTop: () ->
        @top = if @direction then @top + 1 else @top - 1
        @directionCnt += 1
        if @directionCnt > 20
            @direction = !@direction
            @directionCnt = 0

    recalculateNewPositionForLeft: () ->
        if !@swimQuickAway or @left > window.innerWidth / 2
            @left += 1
            @elm.className = ''
        else
            @left -= 1
            @elm.className = 'flip'

    isOutOfScreen: () ->
        not (-@width < @left < window.innerWidth + @width)

    updatePosition: () ->
        @elm.style.top = @top + 'px'
        @elm.style.left = @left + 'px'


document.addEventListener 'DOMContentLoaded', () ->
    new Wanda()

  
