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
}

if let rock = Choice(string: "R") {
  print(rock) // This should print "Rock"
}