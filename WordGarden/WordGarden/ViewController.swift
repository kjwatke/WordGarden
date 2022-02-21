//
//  ViewController.swift
//  WordGarden
//
//  Created by Kevin Watke on 2/19/22.
//

import UIKit

class ViewController: UIViewController {

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
        
    }
    
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
        underscoreLabel.text = "_ _ _ _ _"
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
        guessesLabel.text = "You've Made Zero Guesses"
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
        
        updateUIAfterGuess()
        
    }
    
    
    @objc private func guessLetterButtonPressed(_ sender: UIButton) {
        
        updateUIAfterGuess()
        
    }
    
    
    @objc private func restartGamePressed(_ sender: UIButton) {
        
        print("Restart Game")
    }
    
    
    @objc private func guessedLetterFieldChanged(_ sender: UITextField) {
        
        let text = guessTextInput.text!
        guessSubmitted.isEnabled = !(text.isEmpty)

        
        guard let char = text.last else {
            
            guessTextInput.text = ""
            return
            
        }
        
        guessTextInput.text = String(char)
        
        
    }
}
