$ ->
  app.initialize()

window.app =
  my_hand: 0
  your_hand: 0
  my_life: 5
  your_life: 5
  your_hand_string: ""
  all_result: ""
  final_result: ""

  initialize:->
    @beginTitle()
    @mySetBind()
    @checkLife()
    @resetGame()
    @returnTitle()
    


  beginTitle:->
    $('#start-button').click ->
      $('#start-title').css 'display', 'none'
      $('#game-screen').css 'display', 'block'
   



    $('service-button').click ->
      $('h1').css 'display', 'none'
      $("#start-button").css 'display', 'none'
      $("#service-button").css 'display', 'none'




  mySetBind:->
    $('#gu').bind 'click', =>
      @putAllHands("ryu_gu", 0)
     
    $('#choki').bind 'click', =>
      @putAllHands("ryu_choki", 1)
     
    $('#pa').bind 'click',=>
      @putAllHands("ryu_pa", 2)
      
  putAllHands:(hand, @my_hand) ->
    @choiceYouHand()
    @changeMyHand(hand)
    @showResult()
    @checkLife()
    @announceFinal()

  changeMyHand:(hand)->
    $('#my').html """<img src="./image/#{hand}.gif">"""

  choiceYouHand: ->
    @your_hand = _.random 0, 2 #0, 1, 2
     
    your_hand_string = ["ken_gu", "ken_choki", "ken_pa"]

    $('#you').html """<img src="./image/#{your_hand_string[@your_hand]}.gif">"""

  showResult: () ->
    diff_hands = @your_hand - @my_hand
    
    if (diff_hands == -2) or (diff_hands == 1)
      @all_result = "勝利"
    else if diff_hands == 0 
      @all_result = "アイコ"
    else if(diff_hands == -1) or (diff_hands == 2)
      @all_result = "敗北"
    $('#result').html "<h>#{@all_result}</h>"
  
  checkLife: () ->
    if @all_result == "勝利"
      @your_life = @your_life-1
    else if @all_result == "敗北"
      @my_life = @my_life-1

    @changemyHeart()
    @changeyourHeart()



  changemyHeart: () ->
    myHeart = ""
    for i in [0...@my_life]
      console.log "test"
     
      myHeart = myHeart + "❤️"
      console.log "zikken" 
    console.log myHeart

    $('#my-life').html "<h>#{myHeart}</h>"
    

  changeyourHeart: () ->
    yourHeart = ""
    for i in [0...@your_life]
      yourHeart = yourHeart + "❤️"
    

    $('#your-life').html "<h>#{yourHeart}</h>"
  

  announceFinal: () ->

    if @your_life == 0
      @lockButton("You Win!!")

    else if @my_life == 0
      @lockButton("You Lose…") 
      
    
    $('#final-result').html "<h>#{@final_result}</h>"

  lockButton: (@final_result) ->
    $('#gu, #choki, #pa').unbind 'click'
 
  resetGame: () ->
    $('#reset-button').bind 'click',=>
      
      # my, youの画像
      $('#my').html """<img src="./image/ryu_stand.gif">"""
      $('#you').html """<img src="./image/ken_stand.gif">"""

      # ハートを戻す
      @my_life = 5
      @changemyHeart()

      @your_life = 5
      @changeyourHeart()

      # 判定
      $('#result').html "いざ、尋常に勝負！！"

      # 最終結果
      $('#final-result').html "最終結果"

      if (@final_result == "You Win!!") or (@final_result == "You Lose…")
        console.log "invalid"
        @mySetBind()
        @final_result = ""
  
  returnTitle: () ->
    $('#title-button').bind 'click',=>
      $('#game-screen').css 'display', 'none'
      $('#start-title').css 'display', 'block'
      $('#my').html """<img src="./image/ryu_stand.gif">"""
      $('#you').html """<img src="./image/ken_stand.gif">"""

      @my_life = 5
      @changemyHeart()

      @your_life = 5
      @changeyourHeart()

      $('#result').html "いざ、尋常に勝負！！"
      $('#final-result').html "最終結果"

      if (@final_result == "You Win!!") or (@final_result == "You Lose…")
        console.log "invalid"
        @mySetBind()
        @final_result = ""




      
