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

print(Choice.Rock)