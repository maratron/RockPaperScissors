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
}

print(Choice.Rock.beats(Choice.Paper))     // False
print(Choice.Rock.beats(Choice.Scissors))  // True
print(Choice.Scissors.beats(Choice.Rock))  // False
print(Choice.Scissors.beats(Choice.Paper)) // True