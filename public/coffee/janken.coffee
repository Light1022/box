$ ->
  app.initialize()

window.app =
  chara: ""
  chara_number: ""
  my_hand: 0
  my_player:"" 
  your_player:"" 
  your_hand: 0
  wait_time: 5000
  your_hand_string: ""
  all_result: ""
  final_result: ""
  is_test: false 
  test2: false
  HAND_STR: ["gu", "choki", "pa"]

  initialize:->
    console.log('initil')
    @setTest()
    @setTransrate()
    @beginTitle()
    @selectChara()
    @startGame()
    @mySetBind()
    @checkLife()
    @checkMark()
    @endGame()
    @setGameButtonBind()

  setTest2:(bool) ->
    @test2 = bool

  setTest:() ->
    if @is_test
      @wait_time = 1000
      @my_player = "ken"
      @your_player = "ryu"
      $('#my').html """<img src="./image/#{@my_player}_stand.gif">"""
      $('#you').html """<img src="./image/#{@your_player}_stand.gif">"""
      $('#gu').html """<img src="./image/select/#{@my_player}_hado_gazou.jpg">"""
      $('#choki').html """<img src="./image/select/#{@my_player}_shoryu_gazou.jpg">"""
      $('#pa').html """<img src="./image/select/#{@my_player}_tatsumaki_gazou.jpg">"""
      $('#2pgu').html """<img src="./image/select/#{@your_player}_hado_gazou.jpg">"""
      $('#2pchoki').html """<img src="./image/select/#{@your_player}_shoryu_gazou.jpg">""" 
      $('#2ppa').html """<img src="./image/select/#{@your_player}_tatsumaki_gazou.jpg">""" 
      @changeScreen("#game-screen")
      @resetGame()
 
  setTransrate:() ->
    @JANKEN_WIN_STR =  "HIT!!"
    @JANKEN_DRAW_STR =  "アイコ"
    @JANKEN_LOSE_STR =  "DAMAGE!"

  changeScreen:(target_id) ->
    $(".screen").css "display", "none"
    $(target_id).css "display", "block"

  beginTitle:->
    $('#start-button').click =>
      @changeScreen("#characterselect-screen")
      @is_normal = true

    $('#service-button').click =>
      @changeScreen("#characterselect-screen")
      @is_normal = false
  
  selectChara:->
    self = @
    $('.chara').bind 'click', ->
      characters = {
        ryu:{name: "ryu", life: 100, gu: 22, choki: 18, pa: 15},
        ken:{name: "ken", life: 100, gu: 5, choki: 30, pa: 20},
        goki:{name: "goki", life: 80, gu: 25, choki: 25, pa: 25}
        }

      player =  $(@).attr 'data-player'
      chara = $(@).attr 'data-chara'
      $("##{player}-select").html """<img src="./image/#{chara}_select.gif">"""

      if player == 'my'
        self.my_player = characters[chara]
      else
        self.your_player = characters[chara]

      self.resetCaution()
   
  startGame:->
    $('#vs').bind 'click', => 
      console.log("vs click")
      console.log @my_player
      if(@my_player != "") and (@your_player != "")
        @changeScreen("#game-screen")
        @resetGame()

        $('#my').html """<img src="./image/#{@my_player.name}_stand.gif">"""
        $('#you').html """<img src="./image/#{@your_player.name}_stand.gif">"""
        $('#gu').html """<img src="./image/select/#{@my_player.name}_hado_gazou.jpg">"""
        $('#choki').html """<img src="./image/select/#{@my_player.name}_shoryu_gazou.jpg">"""
        $('#pa').html """<img src="./image/select/#{@my_player.name}_tatsumaki_gazou.jpg">"""
        $('#2pgu').html """<img src="./image/select/#{@your_player.name}_hado_gazou.jpg">"""
        $('#2pchoki').html """<img src="./image/select/#{@your_player.name}_shoryu_gazou.jpg">""" 
        $('#2ppa').html """<img src="./image/select/#{@your_player.name}_tatsumaki_gazou.jpg">""" 
      else
        $('#caution').slideDown 'slow'
    
      @my_life = @my_player.life
      @your_life = @your_player.life
      $('#my-life').attr(max:@my_life) 
      $('#your-life').attr(max:@your_life) 
        
  

  resetCaution:->
    if(@my_player != "") and (@your_player != "")
      $('#caution').css 'display', 'none'
    
  mySetBind:->
    $('#gu').bind 'click', =>
      @putAllHands(0)

     
    $('#choki').bind 'click', =>
      @putAllHands(1)
     
    $('#pa').bind 'click',=>
      @putAllHands(2)
  
  putAllHands:(hand) ->
    @my_hand = hand
    @countupRound()
    @choiceYouHand()
    @changeMyHand(hand)
    @showRoundResult()
    @checkLife(hand)
    @setPosition()
    @announceFinal()
    @checkMark()
    @nextGame()
    @endGame()
  
  changeMyHand:(hand)->
    file_name = if (@round_count % 4 != 0) then "#{@my_player.name}_#{@HAND_STR[hand]}.gif" else "#{@my_player.name}_#{@HAND_STR[hand]}_ex.gif"
    $('#my').html """<img src="./image/#{@my_player.name}skills/#{file_name}">"""
    $('#gu, #choki, #pa').unbind 'click'
        
  choiceYouHand: ->
    @your_hand = _.random 0, 2 #0, 1, 2

    file_name = if (@round_count % 4 != 0) then "#{@your_player.name}_#{@HAND_STR[@your_hand]}.gif" else "#{@your_player.name}_#{@HAND_STR[@your_hand]}_ex.gif"
    $('#you').html """<img src="./image/#{@your_player.name}skills/#{file_name}">"""
    console.log @your_hand

  showRoundResult: () ->
    diff_hands = @your_hand - @my_hand
    
    if (diff_hands == -2) or (diff_hands == 1)
      @all_result = @JANKEN_WIN_STR
    else if diff_hands == 0 
      @all_result = @JANKEN_DRAW_STR
    else if(diff_hands == -1) or (diff_hands == 2)
      @all_result = @JANKEN_LOSE_STR
    $('#result').html "<h>#{@all_result}</h>"
  
  checkLife: (hand) ->
    if @is_normal
      if @all_result == @JANKEN_WIN_STR
        if @round_count % 4 != 0
          @your_life = @your_life-@my_player[@HAND_STR[hand]]
        else
          @your_life = @your_life-@my_player[@HAND_STR[hand]]*3
        $('#your-life').attr(value:@your_life) 
    
      else if @all_result == @JANKEN_LOSE_STR
        if @round_count % 4 !=0
          @my_life = @my_life-@your_player[@HAND_STR[@your_hand]]
        else
          @my_life = @my_life-@your_player[@HAND_STR[@your_hand]]*3
        $('#my-life').attr(value:@my_life) 

    else
      if @all_result == @JANKEN_WIN_STR
        if @round_count % 4 !=0
          @my_life = @my_life-@your_player[@HAND_STR[@your_hand]]
          console.log @my_life
        else
          @my_life = @my_life-@your_player[@HAND_STR[@your_hand]]*3
        $('#my-life').attr(value:@my_life) 

      else if @all_result == @JANKEN_LOSE_STR
        if @round_count % 4 != 0
          @your_life = @your_life-@my_player[@HAND_STR[hand]]
          console.log "damage"
        else
          @your_life = @your_life-@my_player[@HAND_STR[hand]]*3
        $('#your-life').attr(value:@your_life) 
 
  checkMark: () ->
    if @final_result == "You Win!!"
      @my_victory = @my_victory+1
    else if @final_result == "You Lose…"
      @your_victory = @your_victory+1

    @showMark()

  showMark: () ->
    myMark = ""
    for i in [0...@my_victory]
      myMark = myMark + """<img src="./image/winmark.jpg">"""

    $('#my-mark').html "<h>#{myMark}</h>"

    yourMark = ""
    for i in [0...@your_victory]
      yourMark = yourMark + """<img src="./image/winmark.jpg">"""
    
    $('#your-mark').html "<h>#{yourMark}</h>"

  setPosition:->
    setTimeout (=>
      @resetRound()
      unless ((@my_victory == 2) or (@your_victory == 2))
        @mySetBind()
    ), @wait_time

  announceFinal: () ->
    if @your_life <= 0 
      @showMatchResult "You Win!!", "victory", "lose"

    else if @my_life <= 0
      @showMatchResult "You Lose…", "lose", "victory"

    if @round_count == 12 
      if @my_life > @your_life
        @showMatchResult "You Win!!", "victory", "lose"

      else if @your_life > @my_life
        @showMatchResult "You Lose…", "lose", "victory"

      else if @your_life == @my_life
        @showMatchResult "Draw Game", "stand", "stand"
    
    $('#final-result').html "<h>#{@final_result}</h>"

  showMatchResult:(result_message, my_result, your_result) ->
    @lockButton(result_message)
    $('#my').html """<img src="./image/#{@my_player.name}_#{my_result}.gif">"""
    $('#you').html """<img src="./image/#{@your_player.name}_#{your_result}.gif">"""

  countupRound:->
    @round_count = @round_count+1 
    $('#count-round').html """<img src="./image/rounds/round_#{@round_count}.png">"""

  lockButton: (@final_result) ->
    $('#gu, #choki, #pa').unbind 'click'
 
  setGameButtonBind:() ->
    $('#reset-button').bind 'click',=>
      @resetGame()
      $('#block').animate {
         opacity: 0.0;
        }, 10
      @mySetBind()

    $('#title-button').bind 'click',=>
      @changeScreen("#title-screen") 
      $('#block').animate {
         opacity: 0.0;
        }, 1000
      @startGame()
      @my_player = ""
      console.log "reset"
      @your_player = ""
      $("#my-select").html ""
      $("#your-select").html ""
      @mySetBind()
      

  nextGame: () ->
    if (@final_result == "You Win!!") or (@final_result == "You Lose…") or (@final_result == "Draw Game")
      setTimeout (=>
        @resetMatch()
        $('#final-result').html "最終結果"
       ), @wait_time

  endGame: () ->
    if @my_victory == 2 
      $('#block').html """<img src="./image/1pwins/#{@my_player.name}_win_#{@your_player.name}_lose.png">"""
      $('#block').animate {
         opacity: 1.0;
        }, 2000
      @lockButton("You Win!!")
    
    else if @your_victory == 2
      $('#block').html """<img src="./image/2pwins/#{@my_player.name}_lose_#{@your_player.name}_win.png">"""
      $('#block').animate {
         opacity: 1.0;
        }, 2000
      @lockButton("You Lose…")

  resetRound:() ->
    $('#my').html """<img src="./image/#{@my_player.name}_stand.gif">"""
    $('#you').html """<img src="./image/#{@your_player.name}_stand.gif">"""
    $('#result').html "Get Ready...?"

  resetMatch:() ->
    $('#count-round').html """<img src="./image/rounds/round_1.png">"""
    @round_count = 0 
      
    @my_life = @my_player.life
    @your_life = @your_player.life
    $('#my-life').attr(value:@my_life) 
    $('#your-life').attr(value:@your_life) 
    
    $('#final-result').html "最終結果"
    @final_result = ""
    
    @resetRound()
    
  resetGame: () ->
    @my_victory = 0
    @your_victory =0
    @showMark()
    
 
    @resetMatch()
    if (@final_result == "You Win!!") or (@final_result == "You Lose…") or (@final_result == "Draw Game")
      @mySetBind()
