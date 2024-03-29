// Generated by CoffeeScript 1.12.7
(function() {
  $(function() {
    return app.initialize();
  });

  window.app = {
    chara: "",
    chara_number: "",
    my_hand: 0,
    my_player: "",
    your_player: "",
    your_hand: 0,
    wait_time: 5000,
    your_hand_string: "",
    all_result: "",
    final_result: "",
    is_test: false,
    test2: false,
    HAND_STR: ["gu", "choki", "pa"],
    initialize: function() {
      console.log('initil');
      this.setTest();
      this.setTransrate();
      this.beginTitle();
      this.selectChara();
      this.startGame();
      this.mySetBind();
      this.checkLife();
      this.checkMark();
      this.endGame();
      return this.setGameButtonBind();
    },
    setTest2: function(bool) {
      return this.test2 = bool;
    },
    setTest: function() {
      if (this.is_test) {
        this.wait_time = 1000;
        this.my_player = "ken";
        this.your_player = "ryu";
        $('#my').html("<img src=\"./image/" + this.my_player + "_stand.gif\">");
        $('#you').html("<img src=\"./image/" + this.your_player + "_stand.gif\">");
        $('#gu').html("<img src=\"./image/select/" + this.my_player + "_hado_gazou.jpg\">");
        $('#choki').html("<img src=\"./image/select/" + this.my_player + "_shoryu_gazou.jpg\">");
        $('#pa').html("<img src=\"./image/select/" + this.my_player + "_tatsumaki_gazou.jpg\">");
        $('#2pgu').html("<img src=\"./image/select/" + this.your_player + "_hado_gazou.jpg\">");
        $('#2pchoki').html("<img src=\"./image/select/" + this.your_player + "_shoryu_gazou.jpg\">");
        $('#2ppa').html("<img src=\"./image/select/" + this.your_player + "_tatsumaki_gazou.jpg\">");
        this.changeScreen("#game-screen");
        return this.resetGame();
      }
    },
    setTransrate: function() {
      this.JANKEN_WIN_STR = "HIT!!";
      this.JANKEN_DRAW_STR = "アイコ";
      return this.JANKEN_LOSE_STR = "DAMAGE!";
    },
    changeScreen: function(target_id) {
      $(".screen").css("display", "none");
      return $(target_id).css("display", "block");
    },
    beginTitle: function() {
      $('#start-button').click((function(_this) {
        return function() {
          _this.changeScreen("#characterselect-screen");
          return _this.is_normal = true;
        };
      })(this));
      return $('#service-button').click((function(_this) {
        return function() {
          _this.changeScreen("#characterselect-screen");
          return _this.is_normal = false;
        };
      })(this));
    },
    selectChara: function() {
      var self;
      self = this;
      return $('.chara').bind('click', function() {
        var chara, characters, player;
        characters = {
          ryu: {
            name: "ryu",
            life: 100,
            gu: 22,
            choki: 18,
            pa: 15
          },
          ken: {
            name: "ken",
            life: 100,
            gu: 5,
            choki: 30,
            pa: 20
          },
          goki: {
            name: "goki",
            life: 80,
            gu: 25,
            choki: 25,
            pa: 25
          }
        };
        player = $(this).attr('data-player');
        chara = $(this).attr('data-chara');
        $("#" + player + "-select").html("<img src=\"./image/" + chara + "_select.gif\">");
        if (player === 'my') {
          self.my_player = characters[chara];
        } else {
          self.your_player = characters[chara];
        }
        return self.resetCaution();
      });
    },
    startGame: function() {
      return $('#vs').bind('click', (function(_this) {
        return function() {
          console.log("vs click");
          console.log(_this.my_player);
          if ((_this.my_player !== "") && (_this.your_player !== "")) {
            _this.changeScreen("#game-screen");
            _this.resetGame();
            $('#my').html("<img src=\"./image/" + _this.my_player.name + "_stand.gif\">");
            $('#you').html("<img src=\"./image/" + _this.your_player.name + "_stand.gif\">");
            $('#gu').html("<img src=\"./image/select/" + _this.my_player.name + "_hado_gazou.jpg\">");
            $('#choki').html("<img src=\"./image/select/" + _this.my_player.name + "_shoryu_gazou.jpg\">");
            $('#pa').html("<img src=\"./image/select/" + _this.my_player.name + "_tatsumaki_gazou.jpg\">");
            $('#2pgu').html("<img src=\"./image/select/" + _this.your_player.name + "_hado_gazou.jpg\">");
            $('#2pchoki').html("<img src=\"./image/select/" + _this.your_player.name + "_shoryu_gazou.jpg\">");
            $('#2ppa').html("<img src=\"./image/select/" + _this.your_player.name + "_tatsumaki_gazou.jpg\">");
          } else {
            $('#caution').slideDown('slow');
          }
          _this.my_life = _this.my_player.life;
          _this.your_life = _this.your_player.life;
          $('#my-life').attr({
            max: _this.my_life
          });
          return $('#your-life').attr({
            max: _this.your_life
          });
        };
      })(this));
    },
    resetCaution: function() {
      if ((this.my_player !== "") && (this.your_player !== "")) {
        return $('#caution').css('display', 'none');
      }
    },
    mySetBind: function() {
      $('#gu').bind('click', (function(_this) {
        return function() {
          return _this.putAllHands(0);
        };
      })(this));
      $('#choki').bind('click', (function(_this) {
        return function() {
          return _this.putAllHands(1);
        };
      })(this));
      return $('#pa').bind('click', (function(_this) {
        return function() {
          return _this.putAllHands(2);
        };
      })(this));
    },
    putAllHands: function(hand) {
      console.log("putAllHands");
      this.my_hand = hand;
      this.countupRound();
      this.choiceYouHand();
      this.changeMyHand(hand);
      this.showRoundResult();
      this.checkLife(hand);
      this.setPosition();
      this.announceFinal();
      this.checkMark();
      this.nextGame();
      return this.endGame();
    },
    changeMyHand: function(hand) {
      var file_name;
      file_name = (this.round_count % 4 !== 0) ? this.my_player.name + "_" + this.HAND_STR[hand] + ".gif" : this.my_player.name + "_" + this.HAND_STR[hand] + "_ex.gif";
      $('#my').html("<img src=\"./image/" + this.my_player.name + "skills/" + file_name + "\">");
      return $('#gu, #choki, #pa').unbind('click');
    },
    choiceYouHand: function() {
      var file_name;
      this.your_hand = _.random(0, 2);
      file_name = (this.round_count % 4 !== 0) ? this.your_player.name + "_" + this.HAND_STR[this.your_hand] + ".gif" : this.your_player.name + "_" + this.HAND_STR[this.your_hand] + "_ex.gif";
      $('#you').html("<img src=\"./image/" + this.your_player.name + "skills/" + file_name + "\">");
      return console.log(this.your_hand);
    },
    showRoundResult: function() {
      var diff_hands;
      diff_hands = this.your_hand - this.my_hand;
      if ((diff_hands === -2) || (diff_hands === 1)) {
        this.all_result = this.JANKEN_WIN_STR;
      } else if (diff_hands === 0) {
        this.all_result = this.JANKEN_DRAW_STR;
      } else if ((diff_hands === -1) || (diff_hands === 2)) {
        this.all_result = this.JANKEN_LOSE_STR;
      }
      return $('#result').html("<h>" + this.all_result + "</h>");
    },
    checkLife: function(hand) {
      if (this.is_normal) {
        if (this.all_result === this.JANKEN_WIN_STR) {
          if (this.round_count % 4 !== 0) {
            this.your_life = this.your_life - this.my_player[this.HAND_STR[hand]];
          } else {
            this.your_life = this.your_life - this.my_player[this.HAND_STR[hand]] * 3;
          }
          return $('#your-life').attr({
            value: this.your_life
          });
        } else if (this.all_result === this.JANKEN_LOSE_STR) {
          if (this.round_count % 4 !== 0) {
            this.my_life = this.my_life - this.your_player[this.HAND_STR[this.your_hand]];
          } else {
            this.my_life = this.my_life - this.your_player[this.HAND_STR[this.your_hand]] * 3;
          }
          return $('#my-life').attr({
            value: this.my_life
          });
        }
      } else {
        if (this.all_result === this.JANKEN_WIN_STR) {
          if (this.round_count % 4 !== 0) {
            this.my_life = this.my_life - this.your_player[this.HAND_STR[this.your_hand]];
            console.log(this.my_life);
          } else {
            this.my_life = this.my_life - this.your_player[this.HAND_STR[this.your_hand]] * 3;
          }
          return $('#my-life').attr({
            value: this.my_life
          });
        } else if (this.all_result === this.JANKEN_LOSE_STR) {
          if (this.round_count % 4 !== 0) {
            this.your_life = this.your_life - this.my_player[this.HAND_STR[hand]];
            console.log("damage");
          } else {
            this.your_life = this.your_life - this.my_player[this.HAND_STR[hand]] * 3;
          }
          return $('#your-life').attr({
            value: this.your_life
          });
        }
      }
    },
    checkMark: function() {
      if (this.final_result === "You Win!!") {
        this.my_victory = this.my_victory + 1;
      } else if (this.final_result === "You Lose…") {
        this.your_victory = this.your_victory + 1;
      }
      return this.showMark();
    },
    showMark: function() {
      var i, j, k, myMark, ref, ref1, yourMark;
      myMark = "";
      for (i = j = 0, ref = this.my_victory; 0 <= ref ? j < ref : j > ref; i = 0 <= ref ? ++j : --j) {
        myMark = myMark + "<img src=\"./image/winmark.jpg\">";
      }
      $('#my-mark').html("<h>" + myMark + "</h>");
      yourMark = "";
      for (i = k = 0, ref1 = this.your_victory; 0 <= ref1 ? k < ref1 : k > ref1; i = 0 <= ref1 ? ++k : --k) {
        yourMark = yourMark + "<img src=\"./image/winmark.jpg\">";
      }
      return $('#your-mark').html("<h>" + yourMark + "</h>");
    },
    setPosition: function() {
      return setTimeout(((function(_this) {
        return function() {
          _this.resetRound();
          if (!((_this.my_victory === 2) || (_this.your_victory === 2))) {
            return _this.mySetBind();
          }
        };
      })(this)), this.wait_time);
    },
    announceFinal: function() {
      if (this.your_life <= 0) {
        this.showMatchResult("You Win!!", "victory", "lose");
      } else if (this.my_life <= 0) {
        this.showMatchResult("You Lose…", "lose", "victory");
      }
      if (this.round_count === 12) {
        if (this.my_life > this.your_life) {
          this.showMatchResult("You Win!!", "victory", "lose");
        } else if (this.your_life > this.my_life) {
          this.showMatchResult("You Lose…", "lose", "victory");
        } else if (this.your_life === this.my_life) {
          this.showMatchResult("Draw Game", "stand", "stand");
        }
      }
      return $('#final-result').html("<h>" + this.final_result + "</h>");
    },
    showMatchResult: function(result_message, my_result, your_result) {
      this.lockButton(result_message);
      $('#my').html("<img src=\"./image/" + this.my_player.name + "_" + my_result + ".gif\">");
      return $('#you').html("<img src=\"./image/" + this.your_player.name + "_" + your_result + ".gif\">");
    },
    countupRound: function() {
      this.round_count = this.round_count + 1;
      return $('#count-round').html("<img src=\"./image/rounds/round_" + this.round_count + ".png\">");
    },
    lockButton: function(final_result) {
      this.final_result = final_result;
      return $('#gu, #choki, #pa').unbind('click');
    },
    setGameButtonBind: function() {
      $('#reset-button').bind('click', (function(_this) {
        return function() {
          _this.resetGame();
          return $('#block').animate({
            opacity: 0.0
          }, 10);
        };
      })(this));
      return $('#title-button').bind('click', (function(_this) {
        return function() {
          _this.changeScreen("#title-screen");
          $('#block').animate({
            opacity: 0.0
          }, 1000);
          _this.startGame();
          _this.round_count = 0;
          _this.my_player = "";
          console.log("reset");
          _this.your_player = "";
          $("#my-select").html("");
          return $("#your-select").html("");
        };
      })(this));
    },
    nextGame: function() {
      if ((this.final_result === "You Win!!") || (this.final_result === "You Lose…") || (this.final_result === "Draw Game")) {
        return setTimeout(((function(_this) {
          return function() {
            _this.resetMatch();
            return $('#final-result').html("最終結果");
          };
        })(this)), this.wait_time);
      }
    },
    endGame: function() {
      if (this.my_victory === 2) {
        $('#block').html("<img src=\"./image/1pwins/" + this.my_player.name + "_win_" + this.your_player.name + "_lose.png\">");
        $('#block').animate({
          opacity: 1.0
        }, 2000);
        return this.lockButton("You Win!!");
      } else if (this.your_victory === 2) {
        $('#block').html("<img src=\"./image/2pwins/" + this.my_player.name + "_lose_" + this.your_player.name + "_win.png\">");
        $('#block').animate({
          opacity: 1.0
        }, 2000);
        return this.lockButton("You Lose…");
      }
    },
    resetRound: function() {
      if (this.my_player !== "") {
        $('#my').html("<img src=\"./image/" + this.my_player.name + "_stand.gif\">");
        $('#you').html("<img src=\"./image/" + this.your_player.name + "_stand.gif\">");
        return $('#result').html("Get Ready...?");
      }
    },
    resetMatch: function() {
      $('#count-round').html("<img src=\"./image/rounds/round_1.png\">");
      this.round_count = 0;
      this.my_life = this.my_player.life;
      this.your_life = this.your_player.life;
      $('#my-life').attr({
        value: this.my_life
      });
      $('#your-life').attr({
        value: this.your_life
      });
      $('#final-result').html("最終結果");
      this.final_result = "";
      return this.resetRound();
    },
    resetGame: function() {
      this.round_count = 0;
      this.my_victory = 0;
      this.your_victory = 0;
      this.showMark();
      this.resetMatch();
      if ((this.final_result === "You Win!!") || (this.final_result === "You Lose…") || (this.final_result === "Draw Game")) {
        return this.mySetBind();
      }
    }
  };

}).call(this);
