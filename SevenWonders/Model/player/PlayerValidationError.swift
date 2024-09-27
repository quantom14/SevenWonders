//
//  PlayerValidationError.swift
//  SevenWonders
//
//  Created by Tom Bintener on 15/09/2024.
//

import Foundation

enum PlayerValidationError: Error {
    case emptyName
    case simultaneousVictoryCondition

    var errorMessage: String {
        switch self {
        case .emptyName:
            return "A player must have a name"
        case .simultaneousVictoryCondition:
            return "A player cannot win by military and scientific victory simultaneously"
        }
    }
}
