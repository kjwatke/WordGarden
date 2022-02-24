//
//  ViewController.swift
//  WordGarden
//
//  Created by Kevin Watke on 2/19/22.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Properties
    
    var wordsGuessedLabel: UILabel!
    var wordsMissedLabel: UILabel!
    var wordsRemainingLabel: UILabel!
    var wordsInGameLabel: UILabel!
    var titleLabel: UILabel!
    var underscoreLabel: UILabel!
    var guessSubmitted: UIButton!
    var guessTextInput: UITextField!
    var restartButton: UIButton!
    var guessesLabel: UILabel!
    var flowerImageView: UIImageView!
    var horizontalTopLabelContainer: UIStackView!
    var horizontalBottomLabelContainer: UIStackView!
    var verticalStackContainer: UIStackView!
    var guessLetterContainer: UIStackView!
    var labelsContainer: UIStackView!
    
    var wordsToGuess = ["SWIFT", "DOG", "CAT"]
    var currentWordIndex = 0
    var wordToGuess = ""
    var lettersGuessed = ""
    var maxNumberOfWrongGuesses = 8
    var wrongGuessesRemaining = 8
    var wordsGuessedCount = 0
    var wordsMissedCount = 0
    var guessCount = 0
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .link
        
        configureLabels()
        configureLabelContainers()
        configureTitleLabel()
        configureUnderscoreLabel()
        configureGuessPrompt()
        restartGame()
        configureGuessLabel()
        configureFlowerImageView()
        configureLabelsContainer()
        
        setupGame()
        updateGameStatusLabels()
        
    }
    
    // MARK: - UI creation
    
    // Configure attributes for the labels
    
    func configureLabels() {
        
        // Configure wordsGuessedLabel properties
        
        wordsGuessedLabel = UILabel(frame: .zero)
        wordsGuessedLabel.translatesAutoresizingMaskIntoConstraints = false
        wordsGuessedLabel.text = "Words Guessed: 0"
        wordsGuessedLabel.textColor = .white
        wordsGuessedLabel.textAlignment = .left
        wordsGuessedLabel.font = UIFont.systemFont(ofSize: 12.0)
        
        // Configure wordsMissedLabel properties
        
        wordsMissedLabel = UILabel(frame: .zero)
        wordsMissedLabel.translatesAutoresizingMaskIntoConstraints = false
        wordsMissedLabel.text = "Words Missed: 0"
        wordsMissedLabel.textColor = .white
        wordsMissedLabel.textAlignment = .left
        wordsMissedLabel.font = UIFont.systemFont(ofSize: 12.0)
        
        // Configure wordsRemainingLabel
        
        wordsRemainingLabel = UILabel(frame: .zero)
        wordsRemainingLabel.translatesAutoresizingMaskIntoConstraints = false
        wordsRemainingLabel.text = "Words Remaining: 0"
        wordsRemainingLabel.textColor = .white
        wordsRemainingLabel.textAlignment = .right
        wordsRemainingLabel.font = UIFont.systemFont(ofSize: 12.0)
        
        // Configure wordsInGameLabel
        
        wordsInGameLabel = UILabel(frame: .zero)
        wordsInGameLabel.translatesAutoresizingMaskIntoConstraints = false
        wordsInGameLabel.text = "Words in Game: 0"
        wordsInGameLabel.textColor = .white
        wordsInGameLabel.textAlignment = .right
        wordsInGameLabel.font = UIFont.systemFont(ofSize: 12.0)
        
    }
    
    
    // Configure container views for labels
    
    func configureLabelContainers() {
        // Layout two labels in each horizontal stack view.
        // Place those two horizontal containers in one vertical container.
        
        horizontalTopLabelContainer = UIStackView(arrangedSubviews: [wordsGuessedLabel, wordsRemainingLabel])
        horizontalTopLabelContainer.axis = .horizontal
        horizontalTopLabelContainer.distribution = .fill
        horizontalTopLabelContainer.alignment = .fill
        
        horizontalBottomLabelContainer = UIStackView(arrangedSubviews: [wordsMissedLabel, wordsInGameLabel])
        horizontalBottomLabelContainer.axis = .horizontal
        horizontalBottomLabelContainer.distribution = .fillEqually
        horizontalBottomLabelContainer.alignment = .fill
        
        verticalStackContainer = UIStackView(arrangedSubviews: [horizontalTopLabelContainer, horizontalBottomLabelContainer])
        verticalStackContainer.axis = .vertical
        verticalStackContainer.distribution = .fill
        verticalStackContainer.alignment = .fill
        verticalStackContainer.translatesAutoresizingMaskIntoConstraints = false
        verticalStackContainer.spacing = 5
        
        view.addSubview(verticalStackContainer)
        
        NSLayoutConstraint.activate([
            verticalStackContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25),
            verticalStackContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            verticalStackContainer.heightAnchor.constraint(equalToConstant: 31.0),
            
            wordsGuessedLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.48),
            wordsRemainingLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.48),
            wordsMissedLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.48),
            wordsInGameLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.48),
            
        ])
        
    }
    
    
    func configureTitleLabel() {
        
        // Configure the title label
        
        titleLabel = UILabel(frame: .zero)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "How Many Guesses to Uncover the Hidden Word?"
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        titleLabel.textColor = .white
        titleLabel.font = UIFont(name: "Copperplate", size: 24.0)
        view.addSubview(titleLabel)
        
    }
    
    
    func configureUnderscoreLabel() {
        
        // Configure the underscore label
        
        underscoreLabel = UILabel(frame: .zero)
        underscoreLabel.translatesAutoresizingMaskIntoConstraints = false
        underscoreLabel.textColor = .white
        underscoreLabel.text = "_"
        underscoreLabel.textAlignment = .center
        
        view.addSubview(underscoreLabel)
        
    }
    
    
    func configureGuessPrompt() {
        
        // Configure the textfield and the submit button for guessing a letter
        
        guessTextInput = UITextField(frame: CGRect(x: 0, y: 0, width: 30, height: 34))
        guessTextInput.textAlignment = .center
        guessTextInput.borderStyle = .roundedRect
        guessTextInput.addTarget(self, action: #selector(doneKeyPressed), for: .primaryActionTriggered)
        guessTextInput.addTarget(self, action: #selector(guessedLetterFieldChanged), for: .editingChanged)
        
        // Run keyboard configuration
        
        configureKeyboard()
        
        guessSubmitted = UIButton(type: .system)
        guessSubmitted.setTitle("Guess a Letter", for: .normal)
        guessSubmitted.isEnabled = false
        guessSubmitted.addTarget(self, action: #selector(guessLetterButtonPressed), for: .touchUpInside)
        
        guessLetterContainer = UIStackView(arrangedSubviews: [guessTextInput, guessSubmitted])
        guessLetterContainer.axis = .horizontal
        guessLetterContainer.distribution = .fillProportionally
        guessLetterContainer.alignment = .center
        guessLetterContainer.spacing = 10
        guessLetterContainer.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(guessLetterContainer)
        
    }
    
    
    func configureKeyboard() {
        
        // Configure the properties of the keyboard
        
        guessTextInput.spellCheckingType = .no
        guessTextInput.autocorrectionType = .no
        guessTextInput.autocapitalizationType = .allCharacters
        guessTextInput.returnKeyType = .done
        guessTextInput.enablesReturnKeyAutomatically = true
        
    }
    
    
    func restartGame() {
        
        // Configure the button to replay the game and add a selector method to call when user clicks
        
        restartButton = UIButton(frame: .zero)
        restartButton.translatesAutoresizingMaskIntoConstraints = false
        restartButton.setTitle("Play Again", for: .normal)
        restartButton.backgroundColor = .white
        restartButton.layer.borderWidth = 1
        restartButton.layer.borderColor = UIColor.black.cgColor
        restartButton.setTitleColor(.black, for: .normal)
        restartButton.isHidden = true
        view.addSubview(restartButton)
        restartButton.addTarget(self, action: #selector(restartGamePressed), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            restartButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -120),
            restartButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            restartButton.widthAnchor.constraint(equalToConstant: 100),
            restartButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    
    func configureGuessLabel() {
        
        // Configure label to show how many guesses user has currently guessed
        
        guessesLabel = UILabel(frame: .zero)
        guessesLabel.translatesAutoresizingMaskIntoConstraints = false
        guessesLabel.text = "You've Made 0 Guesses"
        guessesLabel.backgroundColor = .white
        guessesLabel.layer.borderColor = UIColor.black.cgColor
        guessesLabel.layer.borderWidth = 1
        guessesLabel.textAlignment = .center
        guessesLabel.numberOfLines = 0
        guessesLabel.textColor = .black
        view.addSubview(guessesLabel)
        
        NSLayoutConstraint.activate([
            
            guessesLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -20),
            guessesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            guessesLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            guessesLabel.heightAnchor.constraint(equalToConstant: 74),
            
        ])
    }
    
    
    func configureFlowerImageView() {
        
        // Configure the image view to display the flower image
        
        flowerImageView = UIImageView(frame: .zero)
        flowerImageView.translatesAutoresizingMaskIntoConstraints = false
        flowerImageView.backgroundColor = .white
        flowerImageView.contentMode = .scaleAspectFit
        flowerImageView.clipsToBounds = false
        flowerImageView.image = UIImage(named: "flower8")
        view.addSubview(flowerImageView)
        
        
        
        NSLayoutConstraint.activate([
            
            flowerImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.45),
            flowerImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            flowerImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            flowerImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            
        ])
        
        flowerImageView.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 200), for: .vertical)
        flowerImageView.setContentHuggingPriority(UILayoutPriority(rawValue: 280), for: .vertical)
        
        
    }
    
    
    func configureLabelsContainer() {
        
        labelsContainer = UIStackView(arrangedSubviews: [titleLabel, underscoreLabel, guessLetterContainer])
        labelsContainer.translatesAutoresizingMaskIntoConstraints = false
        labelsContainer.axis = .vertical
        labelsContainer.alignment = .center
        labelsContainer.distribution = .fillProportionally
        labelsContainer.spacing = 15
        view.addSubview(labelsContainer)
        
        NSLayoutConstraint.activate([
            
            labelsContainer.topAnchor.constraint(equalTo: verticalStackContainer.bottomAnchor, constant: 50),
            labelsContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            labelsContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
        ])
    }
    
}


// MARK: - Game Logic

extension ViewController {
    
    
    func setupGame () {
        
        wordToGuess = wordsToGuess[currentWordIndex]
        underscoreLabel.text = "_" + String(repeating: " _", count: wordToGuess.count - 1)
    }
    
    
    func formatRevealedWord() {
        
        // Format and show revealedWord in wordBeingRevealed to include new guess
        
        var revealedWord = ""
        
        // Loop through all letters in wordToGuess
        
        for letter in wordToGuess {
            
            // Check if letter in wordToGuess is in lettersGuessed
            
            if lettersGuessed.contains(letter) {
                
                // Add this letter + a blank space to revealedWord
                
                revealedWord += String(letter) + " "
            }
            else {
                revealedWord += "_ "
            }
        }
        
        // Remove extra last space at the end of revealedWord
        
        revealedWord.removeLast()
        
        underscoreLabel.text = revealedWord
        
    }
    
    
    func updateAfterWinOrLose() {
        
        // Handle game over
        
        currentWordIndex += 1
        wordsMissedCount += 1
        guessTextInput.isEnabled = false
        guessSubmitted.isEnabled = false
        restartButton.isHidden = false
        
        // Update the four labels
        
        updateGameStatusLabels()
        
    }
    
    
    func updateGameStatusLabels() {
        
        wordsGuessedLabel.text = "Words Guessed: \(wordsGuessedCount)"
        wordsMissedLabel.text = "Words Missed: \(wordsMissedCount)"
        wordsRemainingLabel.text = "Words to Guess: \(wordsToGuess.count - (wordsGuessedCount + wordsMissedCount) )"
        wordsInGameLabel.text = "Words in Game: \(wordsToGuess.count)"
        
    }
    
    func drawFlowerAndPlaySound() {
        
        if !wordToGuess.contains(guessTextInput.text!) {
            
            wrongGuessesRemaining -= 1
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                UIView.transition(
                    with: self.flowerImageView,
                    duration: 0.5,
                    options: .transitionCrossDissolve,
                    animations: {self.flowerImageView.image = UIImage(named: "wilt\(self.wrongGuessesRemaining)")}) { _ in
                        
                        if self.wrongGuessesRemaining != 0 {
                            self.flowerImageView.image = UIImage(named: "flower\(self.wrongGuessesRemaining)")
                        }
                        else {
                            
                            SoundManager.playSound(name: "word-not-guessed")
                            
                            UIView.transition(
                                with: self.flowerImageView,
                                duration: 0.5,
                                options: .transitionCrossDissolve,
                                animations: {self.flowerImageView.image = UIImage(named: "flower\(self.wrongGuessesRemaining)")},
                                completion: nil
                            )
                            
                        }
                        
                    }
                SoundManager.playSound(name: "incorrect")
            }
        }
        else {
            SoundManager.playSound(name: "correct")
        }
        
    }
    
    
    func guessALetter() {
        
        // Get current letter guessed and add it to lettersGuessed
        
        let currentLetterGuessed = guessTextInput.text!
        
        guard !lettersGuessed.contains(currentLetterGuessed) else {
            
            let alertVC = UIAlertController(
                title: "Error, Duplicate Guess",
                message: "You've already made that guess, try a different letter",
                preferredStyle: .alert
            )
            
            let action = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
            alertVC.addAction(action)
            present(alertVC, animated: false, completion: nil)
            
            return
            
        }
        
        handleValidatedGuess()
        
    }
    
    
    func handleValidatedGuess() {
        
        lettersGuessed += guessTextInput.text!
        
        formatRevealedWord()
        
        // update image, if needed, and keep track of wrong guesses
        
        drawFlowerAndPlaySound()
        
        // Keep track of the guesses and change guess to plural when guesscount is anything other than 1
        
        guessCount += 1
        let guesses = guessCount == 1 ? "Guess" : "Guesses"
        guessesLabel.text = "You've made \(guessCount) \(guesses)"
        
        // Check for win or lose
        
        if let userAnswer = underscoreLabel.text {
            if !userAnswer.contains("_") {
                guessesLabel.text = "You've guessed it! It took you \(guessCount) guesses to guess the word"
                wordsGuessedCount += 1
                SoundManager.playSound(name: "word-guessed")
                updateAfterWinOrLose()
            }
            else if wrongGuessesRemaining == 0 {
                guessesLabel.text = "So sorry. You're all out of guesses."
                SoundManager.playSound(name: "word-not-guessed")
                updateAfterWinOrLose()
            }
        }
        
    }
}





// MARK: - Selector methods

extension ViewController {
    
    
    private func updateUIAfterGuess() {
        
        let guess = guessTextInput.text!
        print("Guess: ", guess)
        
        guessTextInput.text = ""
        guessSubmitted.isEnabled = !(guessTextInput.text!.isEmpty)
        guessTextInput.resignFirstResponder()
        
    }
    
    
    @objc private func doneKeyPressed(_ sender: Any) {
        guessALetter()
        updateUIAfterGuess()
        
    }
    
    
    @objc private func guessLetterButtonPressed(_ sender: UIButton) {
        guessALetter()
        updateUIAfterGuess()
        
    }
    
    
    @objc private func restartGamePressed(_ sender: UIButton) {
        
        if currentWordIndex == wordToGuess.count {
            
            currentWordIndex = 0
            wordsGuessedCount = 0
            wordsMissedCount = 0
            
        }
        
        restartButton.isHidden = true
        guessTextInput.isEnabled = true
        guessSubmitted.isEnabled = false
        wordToGuess = wordsToGuess[currentWordIndex]
        wrongGuessesRemaining = maxNumberOfWrongGuesses
        underscoreLabel.text = "_" + String(repeating: " _", count: wordToGuess.count - 1)
        guessCount = 0
        flowerImageView.image = UIImage(named: "flower\(maxNumberOfWrongGuesses)")
        lettersGuessed = ""
        guessesLabel.text = "You've Made 0 Guesses"
        updateGameStatusLabels()
        
    }
    
    
    @objc private func convertInputToUppercased(_ sender: UITextField) {
        
        let input = sender.text!
        sender.text = input.uppercased()
        
    }
    
    
    @objc private func guessedLetterFieldChanged(_ sender: UITextField) {
        
        let text = guessTextInput.text!
        guessSubmitted.isEnabled = !(text.isEmpty)
        
        
        guard let char = text.last else {
            
            guessTextInput.text = ""
            return
            
        }
        
        guessTextInput.text = String(char).uppercased()
        
        
    }
}
