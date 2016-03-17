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
  
  /// The string representation of the choice value
  var description: String {
    switch self {
    case .Rock: return "Rock"
    case .Paper: return "Paper"
    case .Scissors: return "Scissors"
    }
  }
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

func start() {
  print("Welcome to Rock Paper Scissors!")
  
  // Best of 3
  let maximumRounds = 3
  var currentRounds = 0
  
  // How many wins?
  var wins = 0
  
  while currentRounds < maximumRounds {
    print("Pick one: R, P, S")
    if let choice = getUserInputChoice() {
      let opposingChoice = Choice.random()
      
      print("You picked \(choice)")
      print("Opponent picked \(opposingChoice)")

      // Skip the score checking if it's a draw
      guard choice != opposingChoice else {
        print("It's a draw!")
        continue
      }

      // Check for player win
      if choice.beats(opposingChoice) {
        print("Your \(choice) beats the opponent's \(opposingChoice)!")
        wins += 1
      }
      else {
        print("The opponent's \(opposingChoice) beats your \(choice)!")
      }
      
      // Increase round counter
      currentRounds += 1
    }
  }
  
  if wins >= 2 {
    print("You won \(wins)-\(maximumRounds-wins)!")
  }
  else {
    print("You lost \(maximumRounds-wins)-\(wins)!")
  }
  
  print("Thanks for playing!")
}

start()