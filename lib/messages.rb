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

  def give_instructions
    puts 'This is how you play'
  end

  def give_answer(secret)
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
end
