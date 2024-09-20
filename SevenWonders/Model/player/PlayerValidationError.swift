//
//  PlayerValidationError.swift
//  SevenWonders
//
//  Created by Tom Bintener on 15/09/2024.
//

import Foundation

enum PlayerValidationError: Error {
    case emptyName
    case multipleVictoryCondition

    var localizedDescription: String {
        switch self {
        case .emptyName:
            return "A player must have a name"
        case .multipleVictoryCondition:
            return "A player cannot have multiple victory conditions"
        }
    }
}
