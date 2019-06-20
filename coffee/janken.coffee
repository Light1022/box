$ ->
  app.initialize()

window.app =
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
    @beginTitle()
    @mySetBind()
    @checkLife()
    @setPosition()
    @checkMark()
    @resetGame()
    @returnTitle()
    @endGame()

  
 

 


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
      $('#my').html """<img src="./image/ryuskills/#{hand}.gif">"""
    
    if @round_count % 4 == 0
      $('#my').html """<img src="./image/ryuskills/#{hand}_ex.gif">"""
    console.log "exwaza"

  choiceYouHand: ->
    @your_hand = _.random 0, 2 #0, 1, 2
     
    your_hand_string = ["ken_gu", "ken_choki", "ken_pa"]
    if @round_count % 4 != 0
      $('#you').html """<img src="./image/kenskills/#{your_hand_string[@your_hand]}.gif">"""
    if @round_count % 4 == 0
      $('#you').html """<img src="./image/kenskills/#{your_hand_string[@your_hand]}_ex.gif">"""

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
      setTimeout (->
        $('#my').html """<img src="./image/ryu_stand.gif">"""
        $('#you').html """<img src="./image/ken_stand.gif">"""
        $('#result').html "Get Ready...?"
       ), @wait_time
      
      


  announceFinal: () ->
    console.log "yuorlife: #{@your_life}, mylife: #{@my_life}"

    if @your_life <= 0 
      @lockButton("You Win!!")
      $('#my').html """<img src="./image/ryu_victory.gif">"""
      $('#you').html """<img src="./image/ken_lose.gif">"""

    else if @my_life <= 0
      @lockButton("You Lose…") 
      $('#my').html """<img src="./image/ryu_lose.gif">"""
      $('#you').html """<img src="./image/ken_victory.gif">"""

    if @round_count == 12 
      if @my_life > @your_life
        @lockButton("You Win!!")
        $('#my').html """<img src="./image/ryu_victory.gif">"""
        $('#you').html """<img src="./image/ken_lose.gif">"""

      else if @your_life > @my_life
        @lockButton("You Lose…")
        $('#my').html """<img src="./image/ryu_lose.gif">"""
        $('#you').html """<img src="./image/ken_victory.gif">"""
      else if @your_life == @my_life
        @lockButton("Draw Game")
        $('#my').html """<img src="./image/ryu_stand.gif">"""
        $('#you').html """<img src="./image/ken_stand.gif">"""
    

    
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
      $('#my').html """<img src="./image/ryu_stand.gif">"""
      $('#you').html """<img src="./image/ken_stand.gif">"""
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
      $('#my').html """<img src="./image/ryu_stand.gif">"""
      $('#you').html """<img src="./image/ken_stand.gif">"""
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
      setTimeout (->
        $('#my').html """<img src="./image/ryu_stand.gif">"""
        $('#you').html """<img src="./image/ken_stand.gif">"""
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
      $('#block').html """<img src="./image/1pwins/ryu_win_ken_lose.png">"""
      $('#block').animate {
         opacity: 1.0;
        }, @wait_time
      @lockButton("You Win!!")
    
    else if @your_victory == 2
      $('#block').html """<img src="./image/2pwins/ryu_lose_ken_win.png">"""
      $('#block').animate {
         opacity: 1.0;
        }, @wait_time
      @lockButton("You Lose…")
      



    





      
