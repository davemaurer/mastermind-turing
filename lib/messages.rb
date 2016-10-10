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
end