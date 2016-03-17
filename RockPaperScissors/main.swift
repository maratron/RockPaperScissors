//
//  main.swift
//  RockPaperScissors
//
//  Created by Nico Hämäläinen on 17/03/16.
//  Copyright © 2016 sizeof.io. All rights reserved.
//
import Foundation
import GameplayKit

// MARK: - Possible Choices

enum Choice: Int {
  case Rock
  case Paper
  case Scissors
}

extension Choice {
  /// Create a new Choice value from string input
  ///
  /// - parameter string: The string value to check
  /// - returns: The correct Choice value or nil
  init?(string: String) {
    switch string.uppercaseString {
    case "R":
      self = .Rock
    case "P":
      self = .Paper
    case "S":
      self = .Scissors
    default:
      return nil
    }
  }
  
  /// Checks whether the current choice beats the given choice
  ///
  /// - parameter choice: The choice to check against
  /// - returns: True or false
  func beats(choice: Choice) -> Bool {
    if choice == self { return false }
    
    switch self {
    case .Rock:     return choice == .Scissors
    case .Paper:    return choice == .Rock
    case .Scissors: return choice == .Paper
    }
  }
  
  /// Returns a random Choice value from the enum
  ///
  /// - returns: The random value
  static func random() -> Choice {
    return Choice(rawValue: GKRandomSource.sharedRandom().nextIntWithUpperBound(3))!
  }
}

// MARK: - Helpers

func getUserInput() -> String {
  let data = NSFileHandle.fileHandleWithStandardInput().availableData
  
  guard let string = String(data: data, encoding: NSUTF8StringEncoding) else {
    print("Could not get string from data.")
    return ""
  }
  
  let characterSet = NSCharacterSet.whitespaceAndNewlineCharacterSet()
  return string.stringByTrimmingCharactersInSet(characterSet)
}

/// Prompt the user for a choice input
///
/// - returns: The parsed Choice value, or nil
func getUserInputChoice() -> Choice? {
  return Choice(string: getUserInput())
}

// MARK: - Main Game

func startGame() {
  print("Welcome to Rock Paper Scissors!")
  
  let maximumRoundCount = 3
  var currentRoundCount = 0
  
  var playerWins = 0
  
  while currentRoundCount < maximumRoundCount {
    print("(R)ock (P)aper or (S)cissors?")
    if let choice = getUserInputChoice() {
      let opponentChoice = Choice.random()
      
      guard choice != opponentChoice else {
        print("Both picked \(choice). It's a draw!")
        continue
      }
      
      if choice.beats(opponentChoice) {
        print("Your \(choice) beats the opponent's \(opponentChoice). You win!")
        playerWins += 1
      }
      else {
        print("The opponent's \(opponentChoice) beats your \(choice). You lose!")
      }
      
      currentRoundCount += 1
    }
  }
  
  let winDifference = maximumRoundCount - playerWins
  if playerWins >= 2 {
    print("You won the game! Score: \(playerWins)-\(winDifference)")
  }
  else {
    print("You lost the game! Score: \(winDifference)-\(playerWins)")
  }
  
  print("Thanks for playing!")
}

startGame()