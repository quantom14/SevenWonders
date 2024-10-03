//
//  GameValidationError.swift
//  SevenWonders
//
//  Created by Tom Bintener on 15/09/2024.
//

import Foundation

enum GameValidationError: Error {
    case emptyPlayer
    case futureDate
    case multipleVictoryCondition

    var errorMessage: String {
        switch self {
        case .emptyPlayer:
            return "The player must not be empty"
        case .futureDate:
            return "You don't have a DeLorean so you cannot save a game that you played in the future"
        case .multipleVictoryCondition:
            return "Two players cannot simultaneously win the game via a victory condition"
        }
    }
}
