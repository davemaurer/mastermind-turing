module Messages
  def greet_player
    puts "Hello! Let's play Mastermind!"
  end

  def ask_for_guess
    puts "I've made a secret key out of the first letters in the colors 
          (R)ed, (B)lue, (G)reen, and (Y)ellow. An example secret would be RBBY.
          You can enter a guess by typing four letters as in the example. What is
          your guess? : "
  end

  def say_goodbye
    puts 'Quitting the game. Come back soon!!!'
  end

  def print_instructions
    puts "Once you hit (p)lay, you will guess four colors from (R)ed, (B)lue, (G)reen (Y)ellow.
          an example guess looks like this: gryg . After you guess, I will tell you how many colors
          you got right, and how many positions you got right. Got it? Ok, let's play."
  end

  def print_answer(secret)
    puts "The answer is #{secret}. And. You CHEATED!!!"
  end

  def ask_to_play_again
    puts 'Would you like to (p)lay again? If not you can (q)uit.'
  end

  def announce_invalid_input(started)
    err = "I can 't understand that. "
    if started
      puts err + 'Please enter a guess (example: bgry) or you can (q)uit.'
    else
      puts err + 'Please enter a command. (p)lay, (q)uit, (i)nstructions.'
    end
  end

  def give_guess_feedback(color_count, position_count)
    puts "You guessed #{color_count} correct colors, and #{position_count} correct positions.
          Please enter another guess."
  end
end
