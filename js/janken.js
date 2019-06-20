// Generated by CoffeeScript 1.12.7
(function() {
  $(function() {
    return app.initialize();
  });

  window.app = {
    my_hand: 0,
    your_hand: 0,
    my_life: 100,
    your_life: 100,
    my_victory: 0,
    your_victory: 0,
    round_count: 0,
    wait_time: 5000,
    your_hand_string: "",
    all_result: "",
    final_result: "",
    initialize: function() {
      this.beginTitle();
      this.mySetBind();
      this.checkLife();
      this.setPosition();
      this.checkMark();
      this.resetGame();
      this.returnTitle();
      return this.endGame();
    },
    beginTitle: function() {
      $('#start-button').click(function() {
        $('#start-title').css('display', 'none');
        return $('#game-screen').css('display', 'block');
      });
      return $('service-button').click(function() {
        $('h1').css('display', 'none');
        $("#start-button").css('display', 'none');
        return $("#service-button").css('display', 'none');
      });
    },
    mySetBind: function() {
      $('#gu').bind('click', (function(_this) {
        return function() {
          return _this.putAllHands("ryu_gu", 0);
        };
      })(this));
      $('#choki').bind('click', (function(_this) {
        return function() {
          return _this.putAllHands("ryu_choki", 1);
        };
      })(this));
      return $('#pa').bind('click', (function(_this) {
        return function() {
          return _this.putAllHands("ryu_pa", 2);
        };
      })(this));
    },
    putAllHands: function(hand, my_hand) {
      this.my_hand = my_hand;
      console.log("hands");
      this.countupRound();
      this.choiceYouHand();
      this.changeMyHand(hand);
      this.showResult();
      this.checkLife();
      this.announceFinal();
      this.checkMark();
      this.nextGame();
      return this.endGame();
    },
    changeMyHand: function(hand) {
      if (this.round_count % 4 !== 0) {
        $('#my').html("<img src=\"./image/ryuskills/" + hand + ".gif\">");
      }
      if (this.round_count % 4 === 0) {
        $('#my').html("<img src=\"./image/ryuskills/" + hand + "_ex.gif\">");
      }
      return console.log("exwaza");
    },
    choiceYouHand: function() {
      var your_hand_string;
      this.your_hand = _.random(0, 2);
      your_hand_string = ["ken_gu", "ken_choki", "ken_pa"];
      if (this.round_count % 4 !== 0) {
        $('#you').html("<img src=\"./image/kenskills/" + your_hand_string[this.your_hand] + ".gif\">");
      }
      if (this.round_count % 4 === 0) {
        return $('#you').html("<img src=\"./image/kenskills/" + your_hand_string[this.your_hand] + "_ex.gif\">");
      }
    },
    showResult: function() {
      var diff_hands;
      diff_hands = this.your_hand - this.my_hand;
      if ((diff_hands === -2) || (diff_hands === 1)) {
        this.all_result = "Hit!!";
      } else if (diff_hands === 0) {
        this.all_result = "アイコ";
      } else if ((diff_hands === -1) || (diff_hands === 2)) {
        this.all_result = "Damage!!";
      }
      return $('#result').html("<h>" + this.all_result + "</h>");
    },
    checkLife: function() {
      console.log("round_count in check life" + this.round_count);
      if (this.all_result === "Hit!!") {
        if (this.round_count % 4 !== 0) {
          this.your_life = this.your_life - 20;
        } else {
          this.your_life = this.your_life - 60;
          console.log("gon");
        }
        $('#your-life').attr({
          value: this.your_life
        });
      } else if (this.all_result === "Damage!!") {
        if (this.round_count % 4 !== 0) {
          this.my_life = this.my_life - 20;
        } else {
          this.my_life = this.my_life - 60;
        }
        $('#my-life').attr({
          value: this.my_life
        });
      }
      this.changemyHeart();
      return this.changeyourHeart();
    },
    changemyHeart: function() {
      var i, j, myHeart, ref, results;
      myHeart = "";
      results = [];
      for (i = j = 0, ref = this.my_life; 0 <= ref ? j < ref : j > ref; i = 0 <= ref ? ++j : --j) {
        results.push(myHeart = myHeart);
      }
      return results;
    },
    changeyourHeart: function() {
      var i, j, ref, results, yourHeart;
      yourHeart = "";
      results = [];
      for (i = j = 0, ref = this.your_life; 0 <= ref ? j < ref : j > ref; i = 0 <= ref ? ++j : --j) {
        results.push(yourHeart = yourHeart);
      }
      return results;
    },
    checkMark: function() {
      console.log("abc");
      console.log(this.final_result);
      if (this.final_result === "You Win!!") {
        this.my_victory = this.my_victory + 1;
        console.log("winner");
      } else if (this.final_result === "You Lose…") {
        this.your_victory = this.your_victory + 1;
      }
      this.addmyMark();
      return this.addyourMark();
    },
    addmyMark: function() {
      var i, j, ref;
      this.myMark = "";
      for (i = j = 0, ref = this.my_victory; 0 <= ref ? j < ref : j > ref; i = 0 <= ref ? ++j : --j) {
        this.myMark = this.myMark + "<img src=\"./image/winmark.jpg\">";
      }
      return $('#my-mark').html("<h>" + this.myMark + "</h>");
    },
    addyourMark: function() {
      var i, j, ref;
      this.yourMark = "";
      for (i = j = 0, ref = this.your_victory; 0 <= ref ? j < ref : j > ref; i = 0 <= ref ? ++j : --j) {
        this.yourMark = this.yourMark + "<img src=\"./image/winmark.jpg\">";
      }
      return $('#your-mark').html("<h>" + this.yourMark + "</h>");
    },
    setPosition: function() {
      return $('#my-choice').click((function(_this) {
        return function() {
          return setTimeout((function() {
            $('#my').html("<img src=\"./image/ryu_stand.gif\">");
            $('#you').html("<img src=\"./image/ken_stand.gif\">");
            return $('#result').html("Get Ready...?");
          }), _this.wait_time);
        };
      })(this));
    },
    announceFinal: function() {
      console.log("yuorlife: " + this.your_life + ", mylife: " + this.my_life);
      if (this.your_life <= 0) {
        this.lockButton("You Win!!");
        $('#my').html("<img src=\"./image/ryu_victory.gif\">");
        $('#you').html("<img src=\"./image/ken_lose.gif\">");
      } else if (this.my_life <= 0) {
        this.lockButton("You Lose…");
        $('#my').html("<img src=\"./image/ryu_lose.gif\">");
        $('#you').html("<img src=\"./image/ken_victory.gif\">");
      }
      if (this.round_count === 12) {
        if (this.my_life > this.your_life) {
          this.lockButton("You Win!!");
          $('#my').html("<img src=\"./image/ryu_victory.gif\">");
          $('#you').html("<img src=\"./image/ken_lose.gif\">");
        } else if (this.your_life > this.my_life) {
          this.lockButton("You Lose…");
          $('#my').html("<img src=\"./image/ryu_lose.gif\">");
          $('#you').html("<img src=\"./image/ken_victory.gif\">");
        } else if (this.your_life === this.my_life) {
          this.lockButton("Draw Game");
          $('#my').html("<img src=\"./image/ryu_stand.gif\">");
          $('#you').html("<img src=\"./image/ken_stand.gif\">");
        }
      }
      return $('#final-result').html("<h>" + this.final_result + "</h>");
    },
    countupRound: function() {
      this.round_count = this.round_count + 1;
      $('#count-round').html("<img src=\"./image/rounds/round_" + this.round_count + ".png\">");
      return console.log("count");
    },
    lockButton: function(final_result) {
      this.final_result = final_result;
      return $('#gu, #choki, #pa').unbind('click');
    },
    resetGame: function() {
      return $('#reset-button').bind('click', (function(_this) {
        return function() {
          $('#count-round').html("<img src=\"./image/rounds/round_1.png\">");
          _this.round_count = 0;
          $('#my').html("<img src=\"./image/ryu_stand.gif\">");
          $('#you').html("<img src=\"./image/ken_stand.gif\">");
          $('#block').animate({
            opacity: 0.0
          });
          $('#my-life').attr({
            value: 100
          });
          $('#your-life').attr({
            value: 100
          });
          _this.my_victory = 0;
          _this.addmyMark();
          _this.your_victory = 0;
          _this.addyourMark();
          _this.my_life = 100;
          _this.your_life = 100;
          $('#result').html("Get Ready...?");
          $('#final-result').html("最終結果");
          if ((_this.final_result === "You Win!!") || (_this.final_result === "You Lose…") || (_this.final_result === "Draw Game")) {
            console.log("invalid");
            _this.mySetBind();
            return _this.final_result = "";
          }
        };
      })(this));
    },
    returnTitle: function() {
      return $('#title-button').bind('click', (function(_this) {
        return function() {
          $('#count-round').html("<img src=\"./image/rounds/round_1.png\">");
          _this.round_count = 0;
          $('#game-screen').css('display', 'none');
          $('#start-title').css('display', 'block');
          $('#my').html("<img src=\"./image/ryu_stand.gif\">");
          $('#you').html("<img src=\"./image/ken_stand.gif\">");
          $('#block').animate({
            opacity: 0.0
          });
          $('#my-life').attr({
            value: 100
          });
          $('#your-life').attr({
            value: 100
          });
          _this.my_victory = 0;
          _this.addmyMark();
          _this.your_victory = 0;
          _this.addyourMark();
          _this.my_life = 100;
          _this.your_life = 100;
          $('#result').html("Get Ready...?");
          $('#final-result').html("最終結果");
          if ((_this.final_result === "You Win!!") || (_this.final_result === "You Lose…") || (_this.final_result === "Draw Game")) {
            console.log("invalid");
            _this.mySetBind();
            return _this.final_result = "";
          }
        };
      })(this));
    },
    nextGame: function() {
      console.log("nextgame");
      if ((this.final_result === "You Win!!") || (this.final_result === "You Lose…") || (this.final_result === "Draw Game")) {
        setTimeout((function() {
          $('#my').html("<img src=\"./image/ryu_stand.gif\">");
          $('#you').html("<img src=\"./image/ken_stand.gif\">");
          $('#result').html("Get Ready...?");
          return $('#final-result').html("最終結果");
        }), this.wait_time);
        $('#count-round').html("<img src=\"./image/rounds/round_1.png\">");
        this.round_count = 0;
        $('#my-life').attr({
          value: 100
        });
        $('#your-life').attr({
          value: 100
        });
        this.mySetBind();
        this.final_result = "";
        this.my_life = 100;
        return this.your_life = 100;
      }
    },
    endGame: function() {
      console.log("endgame");
      if (this.my_victory === 2) {
        console.log("cuo");
        $('#block').html("<img src=\"./image/1pwins/ryu_win_ken_lose.png\">");
        $('#block').animate({
          opacity: 1.0
        }, this.wait_time);
        return this.lockButton("You Win!!");
      } else if (this.your_victory === 2) {
        $('#block').html("<img src=\"./image/2pwins/ryu_lose_ken_win.png\">");
        $('#block').animate({
          opacity: 1.0
        }, this.wait_time);
        return this.lockButton("You Lose…");
      }
    }
  };

}).call(this);
