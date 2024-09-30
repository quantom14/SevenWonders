//
//  Game.swift
//  SevenWonders
//
//  Created by Tom Bintener on 15/09/2024.
//

import Foundation
import SwiftData

@Model
final class Game {
    @Attribute(.unique) var id: UUID

    var date: Date
    
    var player1: Player
    var player2: Player
    
    func determineWinner() -> Player {
        if player1.militaryVictory || player1.scientificVictory {
            return player1
        } else if player2.militaryVictory || player2.scientificVictory {
            return player2
        } else if player1.totalPoints > player2.totalPoints {
            return player1
        } else {
            return player2
        }
    }
    
    func displayPlayers() -> String {
        return "\(player1.name) vs. \(player2.name)"
    }
    
    private init(date: Date, player1: Player, player2: Player) {
        self.id = UUID()
        self.date = date
        self.player1 = player1
        self.player2 = player2
    }
    
    class Builder {
        private var date: Date = .now
        private var player1: Player?
        private var player2: Player?
        
        func date(_ date: Date) -> Builder {
            self.date = date
            return self
        }
        
        func player1(_ player: Player) -> Builder {
            player1 = player
            return self
        }
        
        func player2(_ player: Player) -> Builder {
            player2 = player
            return self
        }
        
        func build() throws -> Game {
            // validate players
            guard let player1 = player1 else {
                throw GameValidationError.emptyPlayer
            }
            
            guard let player2 = player2 else {
                throw GameValidationError.emptyPlayer
            }
            
            try validateVictories(player1: player1, player2: player2)
            
            return Game(date: date, player1: player1, player2: player2)
        }
        
        // Validation method to ensure only one victory condition is true
        private func validateVictories(player1: Player, player2: Player) throws {
            let victories = [
                player1.militaryVictory, player1.scientificVictory,
                player2.militaryVictory, player2.scientificVictory
            ]
            let victoryCount = victories.filter { $0 }.count

            if victoryCount > 1 {
                throw GameValidationError.multipleVictoryCondition
            }
        }
    }
}
