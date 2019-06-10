$ ->
  app.initialize()

window.app =
  my_hand: 0
  your_hand: 0
  my_life: "❤️❤️❤️❤️❤️"
  your_life: "❤️❤️❤️❤️❤️"
  your_hand_string: ""
  all_result: ""
  final_result: ""

  initialize:->
    @mySetBind()
    @checkLife()
    @resetGame()

  mySetBind:->
    $('#gu').bind 'click', =>
      @my_hand = 0
      @changeMyHand('gu')
      @choiceYouHand()
      @showResult()
      @checkLife()
      @announceFinal()

    $('#choki').bind 'click', =>
      @my_hand = 1
      @changeMyHand('choki')
      @choiceYouHand()
      @showResult()
      @checkLife()
      @announceFinal()



    $('#pa').bind 'click',=>
      @my_hand = 2
      @changeMyHand('pa')
      @choiceYouHand()
      @showResult()
      @checkLife() 
      @announceFinal()

  changeMyHand:(hand)->
    $('#my').html """<img src="./image/#{hand}.png">"""


  choiceYouHand: ->
    @your_hand = _.random 0, 2 #0, 1, ＃

    if @your_hand == 0
      @your_hand_string = "gu"
    else if @your_hand == 1
      @your_hand_string = "choki"
    else 
      @your_hand_string = "pa"

    $('#you').html """<img src="./image/#{@your_hand_string}.png">"""

  showResult: () ->
    diff_hands = @your_hand - @my_hand
    
    if (diff_hands == -2) or (diff_hands == 1)
      @all_result = "勝利"
    else if diff_hands == 0 
      @all_result = "アイコ"
    else if(diff_hands == -1) or (diff_hands == 2)
      @all_result = "敗北"
    $('#result').html "<p>#{@all_result}</p>"
  
  checkLife: () ->
    if @all_result == "勝利"
      @your_life = @your_life.substr(2)
    else if @all_result == "敗北"
      @my_life = @my_life.substr(2)

    $('#my-life').html "<p>#{@my_life}</p>"
    $('#your-life').html "<p>#{@your_life}</p>"


  announceFinal: () ->

    if @your_life == ""
      @final_result ="You Win!!"
      $('#gu,#choki,#pa').unbind 'click'

    else if @my_life == ""
      @final_result ="You Lose…"
      $('#gu, #choki, #pa').unbind 'click'
    
    $('#final-result').html "<p>#{@final_result}</p>"
  

  resetGame: () ->
    $('#reset-button').bind 'click',=>
      
      # my, youの画像
      $('#my').html "my"
      $('#you').html "you"

      # ハートを戻す
      $('#my-life').html  "❤️❤️❤️❤️❤️"
      @my_life = "❤️❤️❤️❤️❤️"

      $('#your-life').html "❤️❤️❤️❤️❤️"
      @your_life = "❤️❤️❤️❤️❤️"

      # 判定
      $('#result').html "いざ、尋常に勝負！！"

      # 最終結果
      $('#final-result').html "最終結果"

      if (@final_result == "You Win!!") or (@final_result == "You Lose…")
        console.log "invalid"
        @mySetBind()
      
      console.log $("#gu")

