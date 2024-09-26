//
//  GameValidationError.swift
//  SevenWonders
//
//  Created by Tom Bintener on 15/09/2024.
//

import Foundation

enum GameValidationError: Error {
    case emptyPlayer
    case multipleVictoryCondition

    var errorMessage: String {
        switch self {
        case .emptyPlayer:
            return "The player must not be empty"
        case .multipleVictoryCondition:
            return "Both players cannot have a victory condition simultaneously"
        }
    }
}
