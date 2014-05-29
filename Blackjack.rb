class CardGame
  @@deck = [2,2,2,2,3,3,3,3,4,4,4,4,5,5,5,5,6,6,6,6,7,7,7,7,
            8,8,8,8,9,9,9,9,10,10,10,10,10,'A','A','A','A',
            'K','K','K','K','Q','Q','Q','Q','J','J','J','J',
            2,2,2,2,3,3,3,3,4,4,4,4,5,5,5,5,6,6,6,6,7,7,7,7,
            8,8,8,8,9,9,9,9,10,10,10,10,10,'A','A','A','A',
            'K','K','K','K','Q','Q','Q','Q','J','J','J','J',
            2,2,2,2,3,3,3,3,4,4,4,4,5,5,5,5,6,6,6,6,7,7,7,7,
            8,8,8,8,9,9,9,9,10,10,10,10,10,'A','A','A','A',
            'K','K','K','K','Q','Q','Q','Q','J','J','J','J',
            2,2,2,2,3,3,3,3,4,4,4,4,5,5,5,5,6,6,6,6,7,7,7,7,
            8,8,8,8,9,9,9,9,10,10,10,10,10,'A','A','A','A',
            'K','K','K','K','Q','Q','Q','Q','J','J','J','J'].shuffle

  @@player =[]
  @@player_num = []

  @@dealer = []
  @@dealer_num = []

  @@player_name = []
  @@dealer_name = ["Mike", "Eric", "David", "John", "Chris"].shuffle
  @@dealer_bullshits = ["I'm sure you will win this time",
                        "Honestly I hate this Casino. Off the Record. Ok?",
                        "I have to go home in 2 hours. I hate my wife",
                        "I think you are very lucky person",
                        "Where are you from ?", "Do you always come here?"]


  def initialize(start)
    @name
    @start = start
    return :welcome
  end

  def play()

    next_stage = @start

    while true
      puts
      place = method(next_stage)
      next_stage = place.call

    end
  end



  def prompt
    print ">            "
  end

  def load_game
    sleep 1
    puts "Loading the BlackJack Master v0.58313901809(alpharomeo)"
    sleep 1
    puts "..."
    sleep 1
    puts "......Shuffling The Deck"
    sleep 1
    puts "........................"
    puts "Game is ready"
    sleep 2
  end

  def welcome()
    load_game
    player_name_check
    deal_first_cards

  end

  def welcome_play_again()

    player_name_check
    deal_first_cards

  end

  def deal_first_cards
    puts "Dealing cards for you...."
    puts "-------------------------"
    sleep 2
    first_card_deal_function

    cards_at_player

    cards_at_dealer

    verify_blackjack
    deal_second_cards

  end

  def deal_second_cards
    stay_or_hit_question
  end

  def stay_or_hit_question

    puts "Would you like Stay 'S' or Hit 'H'"
    answer_gets_chomp

    if @answer == 's'
      cards_opened_his_cards
      check_card17
      cards_at_dealer_second_cards
      verify_for_dealer

    elsif @answer == "h"
      sleep 1
      print"\n"
      puts "Dealing cards for you...."
      puts "-------------------------"
      deal_for_player

      cards_at_player_second_cards
      # sleep 1
      player_card_calculator
      verify_for_player

    else
      puts "Wrong Key Entered. Enter Required Key"
      stay_or_hit_question


    end

  end

  def verify_for_player

    if player_card_calculator > 21
      puts "You are busted. Dealer Wins"
      play_again
    else
      stay_or_hit_question
    end

  end



  def deal_for_player
    card_converter_player
  end

  def verify_for_dealer

    if dealer_card_calculator > 21
      sleep 1
      puts "Dealer busted. You won"
      play_again

    elsif dealer_card_calculator == 21
      sleep 1
      puts "Dealer Won with making 21"
      play_again

    elsif dealer_card_calculator > player_card_calculator
      sleep 1
      puts "Dealer Won by numbers"
      play_again


    elsif dealer_card_calculator < player_card_calculator
      sleep 1
      puts "Dealer lost by number"
      play_again


    elsif dealer_card_calculator == player_card_calculator
      sleep 1
      puts "It is a Push. No Winner"
      play_again

    end
  end


  def cards_at_dealer_second_cards
    puts "Dealer finished his hand . He got #{@@dealer.join(", ")}"
    puts "Total cards at dealer: #{dealer_card_calculator}"
  end

  def cards_opened_his_cards
    puts "Dealer flipped up his all cards . He got #{@@dealer.join(", ")}"
    puts "Total cards at dealer: #{dealer_card_calculator}"
  end



  def check_card17
    while dealer_card_calculator < 17  do
      deal_for_dealer
      sleep 2
      dealer_last_opened

    end
  end

  def dealer_last_opened
    puts "Dealer pulled #{@@dealer.last}"
  end

  def deal_for_dealer                 #need to fix deal UNTIL 17 option here
    card_converter_dealer
  end


  def cards_at_player_second_cards
    puts  "This is what you have so far #{@@player.join(", ")} "
    puts "Total of your cards: #{player_card_calculator}"
  end





  def verify_blackjack
    if player_card_calculator == 21  && dealer_card_calculator != 21
      puts
      sleep 3
      puts "You made blackjack. You won"
      blackjack_sign

      play_again

    elsif dealer_card_calculator == 21 && player_card_calculator != 21
      puts

      sleep 3
      puts "Dealer made Blackjack. Casino won"
      puts "Dealers cards ara #{@@dealer}"
      blackjack_sign
      play_again

    elsif dealer_card_calculator == 21 && player_card_calculator == 21
      puts "Push"
      play_again
    elsif dealer_card_calculator != 21 && player_card_calculator != 21
      puts
      puts
      deal_second_cards
    end
  end

  def play_again
    puts "Would you like to play again"
    puts "Press 'P' to Play again. 'Q' for Exit the game "
    answer_gets_chomp
    if @answer == 'q'
      puts "Thank you for playing at Casino Royal."
      exit_game
    elsif @answer == 'p'
      @@dealer.clear; @@player.clear
      @@dealer_num.clear; @@player_num.clear
      welcome_play_again
    else
      puts "Wrong Key Entered. Enter Required Key"
      play_again

    end

  end

  def exit_game
    Process.exit
  end



  def first_card_deal_function
    card_converter_player
    card_converter_player
    card_converter_dealer
    card_converter_dealer

  end

  def card_converter_player
    @@card_pop1 = @@deck.pop

    if @@card_pop1 == 'A'
      @@player_num.push(1)
      @@player.push(@@card_pop1)

    elsif @@card_pop1 == 'Q'
      @@player_num.push(10)
      @@player.push(@@card_pop1)


    elsif @@card_pop1 == 'K'
      @@player_num.push(10)
      @@player.push(@@card_pop1)

    elsif @@card_pop1 == 'J'
      @@player_num.push(10)
      @@player.push(@@card_pop1)
    else
      @@player_num.push(@@card_pop1)
      @@player.push(@@card_pop1)

    end
  end

  def card_converter_dealer
    @@card_pop = @@deck.pop

    if @@card_pop == 'A'
      @@dealer_num.push(1)
      @@dealer.push(@@card_pop)

    elsif @@card_pop == 'Q'
      @@dealer_num.push(10)
      @@dealer.push(@@card_pop)

    elsif @@card_pop == 'K'
      @@dealer_num.push(10)
      @@dealer.push(@@card_pop)

    elsif @@card_pop == 'J'
      @@dealer_num.push(10)
      @@dealer.push(@@card_pop)

    else
      @@dealer_num.push(@@card_pop)
      @@dealer.push(@@card_pop)
    end
  end

  def casino_sign
  puts '************************************'
  puts '*       Welcome Casino Royal       *'
  puts '************************************'
  puts
  end

  def blackjack_sign
  puts '************************************'
  puts '*           BLACKJACK!             *'
  puts '************************************'
  end

  def ask_name
    puts 'What should I call your name?'
    prompt
  end

  def answer_gets_chomp
    @answer = gets.chomp.downcase
  end

  def player1_name
    puts "Nice to meet you #{@@player_name[0].capitalize}. Lets Start!"
  end

  def dealers_name(name)
    puts "My Name is #{name}. Good Luck Guys!"
  end


  def player_name_check
    if @@player_name.empty?
      puts `clear`
      casino_sign
      puts
      dealers_name(@@dealer_name.first)
      ask_name
      answer_gets_chomp
      @@player_name.push(@answer)
      sleep 1
      player1_name


    elsif !@@player_name.empty?
      puts `clear`
      casino_sign
      sleep 2
      puts "Good luck Again #{@@player_name[0].capitalize}"
      sleep 1
      @@dealer_bullshits.shift
      puts @@dealer_bullshits.first
      puts
    end

  end

  def cards_at_player
    print "This is what you have so far #{@@player[0]} and #{@@player[1]}"
    puts
    puts "Total of your cards: #{player_card_calculator}"
    puts "\n"
  end

  def cards_at_dealer
    print "Dealer has #{@@dealer[0]} . His second card is flipped down"
  end


  def player_card_calculator
    if @@player_num.include?(1) && player_card_total <=11
        player_card_total + 10
    else
        player_card_total
    end


  end

  def dealer_card_calculator
    if @@dealer_num.include?(1) && dealer_card_total <=11
      dealer_card_total + 10
    else
      dealer_card_total
    end

  end

  def player_card_total
    @@player_num.inject {|sum,x| sum + x}
  end

  def dealer_card_total
    @@dealer_num.inject {|sum,x| sum + x}
  end

end


cards_game = CardGame.new(:welcome)
cards_game.play()

