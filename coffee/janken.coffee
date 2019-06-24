$ ->
  app.initialize()

window.app =
  chara: ""
  chara_number: ""
  my_hand: 0
  your_hand: 0
  my_life: 100
  your_life: 100
  my_victory: 0
  your_victory: 0
  round_count: 0
  wait_time: 5000
  your_hand_string: ""
  all_result: ""
  final_result: ""

  initialize:->
    @setChara()
    @beginTitle()
    @mySetBind()
    @checkLife()
    @setPosition()
    @checkMark()
    @resetGame()
    @returnTitle()
    @endGame()


  beginTitle:->
    console.log "beginTitle"
    console.log @my_player
    console.log @your_player
    $('#start-button').click =>
      console.log @my_player
      console.log @your_player
      $('#start-title').css 'display', 'none'
      $('#game-screen').css 'display', 'block'
      $('#my').html """<img src="./image/#{@my_player}_stand.gif">"""
      $('#you').html """<img src="./image/#{@your_player}_stand.gif">"""
      $('#gu').html """<img src="./image/select/#{@my_player}_hado_gazou.jpg">"""
      $('#choki').html """<img src="./image/select/#{@my_player}_shoryu_gazou.jpg">"""
      $('#pa').html """<img src="./image/select/#{@my_player}_tatsumaki_gazou.jpg">"""
      $('#2pgu').html """<img src="./image/select/#{@your_player}_hado_gazou.jpg">"""
      $('#2pchoki').html """<img src="./image/select/#{@your_player}_shoryu_gazou.jpg">"""
      $('#2ppa').html """<img src="./image/select/#{@your_player}_tatsumaki_gazou.jpg">"""
      $('#block').animate {
        opacity: 0.0;
        }
   

    $('service-button').click ->
      $('h1').css 'display', 'none'
      $("#start-button").css 'display', 'none'
      $("#service-button").css 'display', 'none'

  setChara:->
    ALL_CHARACTERS = ["ryu","ken","goki"]
    my_charanumber = 2 #TODO セレクト画面で帰る変数
    @my_player = ALL_CHARACTERS[my_charanumber]
    
    your_charanumber = 0
    @your_player = ALL_CHARACTERS[your_charanumber]
    

  mySetBind:->
    $('#gu').bind 'click', =>
      @putAllHands("#{@my_player}_gu", 0)
     
    $('#choki').bind 'click', =>
      @putAllHands("#{@my_player}_choki", 1)
     
    $('#pa').bind 'click',=>
      @putAllHands("#{@my_player}_pa", 2)
  
  
  putAllHands:(hand, @my_hand) ->
    console.log "hands"
    @countupRound()
    @choiceYouHand()
    @changeMyHand(hand)
    @showResult()
    @checkLife()
    @announceFinal()
    @checkMark()
    @nextGame()
    @endGame()
  
  changeMyHand:(hand)->
    if @round_count % 4 != 0
      $('#my').html """<img src="./image/#{@my_player}skills/#{hand}.gif">"""
      console.log "waza"
    
    if @round_count % 4 == 0
      $('#my').html """<img src="./image/#{@my_player}skills/#{hand}_ex.gif">"""
    console.log "exwaza"
    
  
  

  choiceYouHand: ->
    @your_hand = _.random 0, 2 #0, 1, 2
     
    your_hand_string = ["#{@your_player}_gu", "#{@your_player}_choki", "#{@your_player}_pa"]
    if @round_count % 4 != 0
      $('#you').html """<img src="./image/#{@your_player}skills/#{your_hand_string[@your_hand]}.gif">"""
    if @round_count % 4 == 0
      $('#you').html """<img src="./image/#{@your_player}skills/#{your_hand_string[@your_hand]}_ex.gif">"""

  showResult: () ->
    diff_hands = @your_hand - @my_hand
    
    if (diff_hands == -2) or (diff_hands == 1)
      @all_result = "Hit!!"
    else if diff_hands == 0 
      @all_result = "アイコ"
    else if(diff_hands == -1) or (diff_hands == 2)
      @all_result = "Damage!!"
    $('#result').html "<h>#{@all_result}</h>"
  


  checkLife: () ->
    console.log("round_count in check life#{@round_count}")
    if @all_result == "Hit!!"
      if @round_count % 4 != 0
        @your_life = @your_life-20
      else
        @your_life = @your_life-60
        console.log "gon"
      $('#your-life').attr(value:@your_life) 
    
    else if @all_result == "Damage!!"
      if @round_count % 4 !=0
        @my_life = @my_life-20
      else
        @my_life = @my_life-60
      $('#my-life').attr(value:@my_life) 
    #debugger

    @changemyHeart()
    @changeyourHeart()



  changemyHeart: () ->
    myHeart = ""
    for i in [0...@my_life]
     
      myHeart = myHeart 

    

  changeyourHeart: () ->
    yourHeart = ""
    for i in [0...@your_life]
      yourHeart = yourHeart
    



  checkMark: () ->
    console.log "abc"
    console.log @final_result
    if @final_result == "You Win!!"
      @my_victory = @my_victory+1
      console.log "winner"
    else if @final_result == "You Lose…"
      @your_victory = @your_victory+1

  
      
    @addmyMark()
    @addyourMark()

  


  addmyMark: () ->
    @myMark = ""
    for i in [0...@my_victory]
      @myMark = @myMark + """<img src="./image/winmark.jpg">"""

    $('#my-mark').html "<h>#{@myMark}</h>"
  
  addyourMark: () ->
    @yourMark = ""
    for i in [0...@your_victory]
      @yourMark = @yourMark + """<img src="./image/winmark.jpg">"""
    
    $('#your-mark').html "<h>#{@yourMark}</h>"

  setPosition:->
    $('#my-choice').click =>
      setTimeout (=>
        $('#my').html """<img src="./image/#{@my_player}_stand.gif">"""
        $('#you').html """<img src="./image/#{@your_player}_stand.gif">"""
        $('#result').html "Get Ready...?"
       ), @wait_time
      


  announceFinal: () ->
    console.log "yuorlife: #{@your_life}, mylife: #{@my_life}"

    if @your_life <= 0 
      @lockButton("You Win!!")
      $('#my').html """<img src="./image/#{@my_player}_victory.gif">"""
      $('#you').html """<img src="./image/#{@your_player}_lose.gif">"""

    else if @my_life <= 0
      @lockButton("You Lose…") 
      $('#my').html """<img src="./image/#{@my_player}_lose.gif">"""
      $('#you').html """<img src="./image/#{@your_player}_victory.gif">"""

    if @round_count == 12 
      if @my_life > @your_life
        @lockButton("You Win!!")
        $('#my').html """<img src="./image/#{@my_player}_victory.gif">"""
        $('#you').html """<img src="./image/#{@your_player}_lose.gif">"""

      else if @your_life > @my_life
        @lockButton("You Lose…")
        $('#my').html """<img src="./image/#{@my_player}_lose.gif">"""
        $('#you').html """<img src="./image/#{@your_player}_victory.gif">"""
      else if @your_life == @my_life
        @lockButton("Draw Game")
        $('#my').html """<img src="./image/#{@my_player}_stand.gif">"""
        $('#you').html """<img src="./image/#{@your_player}_stand.gif">"""
    

    
    $('#final-result').html "<h>#{@final_result}</h>"
  
  
 
  countupRound:->
    @round_count = @round_count+1 
    $('#count-round').html """<img src="./image/rounds/round_#{@round_count}.png">"""
    console.log "count"

  


  lockButton: (@final_result) ->
    $('#gu, #choki, #pa').unbind 'click'
 
  resetGame: () ->
    $('#reset-button').bind 'click',=>
      $('#count-round').html """<img src="./image/rounds/round_1.png">"""
      @round_count = 0
      
      # my, youの画像
      $('#my').html """<img src="./image/#{@my_player}_stand.gif">"""
      $('#you').html """<img src="./image/#{@your_player}_stand.gif">"""
      $('#block').animate {
         opacity: 0.0;
        }

      # ハートを戻す
      $('#my-life').attr(value:100) 
      $('#your-life').attr(value:100)
  
    
      @my_victory = 0
      @addmyMark()

      @your_victory =0
      @addyourMark()
      
      @my_life = 100

      @your_life = 100

      # 判定
      $('#result').html "Get Ready...?"

      # 最終結果
      $('#final-result').html "最終結果"
      
      if (@final_result == "You Win!!") or (@final_result == "You Lose…") or (@final_result == "Draw Game")
        console.log "invalid"
        @mySetBind()
        @final_result = ""
      
      


  returnTitle: () ->
    $('#title-button').bind 'click',=>
      $('#count-round').html """<img src="./image/rounds/round_1.png">"""
      @round_count = 0
      
      $('#game-screen').css 'display', 'none'
      $('#start-title').css 'display', 'block'
      $('#my').html """<img src="./image/#{@my_player}_stand.gif">"""
      $('#you').html """<img src="./image/#{@your_player}_stand.gif">"""
      $('#block').animate {
         opacity: 0.0;
        }

      $('#my-life').attr(value:100) 
      $('#your-life').attr(value:100)
    
      
    
      @my_victory = 0
      @addmyMark()

      @your_victory =0
      @addyourMark()
      
      @my_life = 100

      @your_life = 100
  

      $('#result').html "Get Ready...?"
      $('#final-result').html "最終結果"

      if (@final_result == "You Win!!") or (@final_result == "You Lose…") or (@final_result == "Draw Game")
        console.log "invalid"
        @mySetBind()
        @final_result = ""

        
      
      

  nextGame: () ->
    console.log "nextgame"
    if (@final_result == "You Win!!") or (@final_result == "You Lose…") or (@final_result == "Draw Game")
      setTimeout (=>
        $('#my').html """<img src="./image/#{@my_player}_stand.gif">"""
        $('#you').html """<img src="./image/#{@your_player}_stand.gif">"""
        $('#result').html "Get Ready...?"
        $('#final-result').html "最終結果"
        
       ), @wait_time
       
      $('#count-round').html """<img src="./image/rounds/round_1.png">"""
      @round_count = 0
      
      
      $('#my-life').attr(value:100) 
      $('#your-life').attr(value:100)
      
      @mySetBind() 
      @final_result = ""
       
      @my_life = 100

      @your_life = 100
       
    
      
  endGame: () ->
    console.log "endgame" 
    if @my_victory == 2 
      console.log "cuo"
      $('#block').html """<img src="./image/1pwins/#{@my_player}_win_#{@your_player}_lose.png">"""
      $('#block').animate {
         opacity: 1.0;
        }, 2000
      @lockButton("You Win!!")
    
    else if @your_victory == 2
      $('#block').html """<img src="./image/2pwins/#{@my_player}_lose_#{@your_player}_win.png">"""
      $('#block').animate {
         opacity: 1.0;
        }, 2000
      @lockButton("You Lose…")
      



    





      
