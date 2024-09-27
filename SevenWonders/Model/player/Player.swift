//
//  PlayerPoints.swift
//  SevenWonders
//
//  Created by Tom Bintener on 15/09/2024.
//

import Foundation
import SwiftData

@Model
class Player {
    @Attribute(.unique) var id: UUID
    var name: String

    var bluePoints: Int
    var greenPoints: Int
    var yellowPoints: Int
    var purplePoints: Int
    var pyramidPoints: Int
    var tokenPoints: Int
    var coinPoints: Int
    var militaryPoints: Int

    var militaryVictory: Bool
    var scientificVictory: Bool

    var totalPoints: Int {
        return bluePoints + greenPoints + yellowPoints + purplePoints + pyramidPoints + tokenPoints + coinPoints + militaryPoints
    }

    private init(name: String, bluePoints: Int = 0, greenPoints: Int = 0, yellowPoints: Int = 0, purplePoints: Int = 0, pyramidPoints: Int = 0, tokenPoints: Int = 0, coinPoints: Int = 0, militaryPoints: Int = 0, militaryVictory: Bool = false, scientificVictory: Bool = false) {
        self.id = UUID()
        self.name = name
        self.bluePoints = bluePoints
        self.greenPoints = greenPoints
        self.yellowPoints = yellowPoints
        self.purplePoints = purplePoints
        self.pyramidPoints = pyramidPoints
        self.tokenPoints = tokenPoints
        self.coinPoints = coinPoints
        self.militaryPoints = militaryPoints
        self.militaryVictory = militaryVictory
        self.scientificVictory = scientificVictory
    }

    class Builder {
        private var name: String?
        private var bluePoints: Int = 0
        private var greenPoints: Int = 0
        private var yellowPoints: Int = 0
        private var purplePoints: Int = 0
        private var pyramidPoints: Int = 0
        private var tokenPoints: Int = 0
        private var coinPoints: Int = 0
        private var militaryPoints: Int = 0
        private var militaryVictory: Bool = false
        private var scientificVictory: Bool = false

        func name(_ name: String) -> Builder {
            if !name.isEmpty {
                self.name = name
            }
            return self
        }

        func bluePoints(_ points: Int) -> Builder {
            bluePoints = points
            return self
        }

        func greenPoints(_ points: Int) -> Builder {
            greenPoints = points
            return self
        }

        func yellowPoints(_ points: Int) -> Builder {
            yellowPoints = points
            return self
        }

        func purplePoints(_ points: Int) -> Builder {
            purplePoints = points
            return self
        }

        func pyramidPoints(_ points: Int) -> Builder {
            pyramidPoints = points
            return self
        }

        func tokenPoints(_ points: Int) -> Builder {
            tokenPoints = points
            return self
        }
        
        func coinPoints(_ points: Int) -> Builder {
            coinPoints = points
            return self
        }

        func militaryPoints(_ points: Int) -> Builder {
            militaryPoints = points
            return self
        }

        func militaryVictory(_ militaryVictory: Bool) -> Builder {
            self.militaryVictory = militaryVictory
            return self
        }

        func scientificVictory(_ scientificVictory: Bool) -> Builder {
            self.scientificVictory = scientificVictory
            return self
        }

        func build() throws -> Player {
            // validate player name
            guard let name = name, !name.isEmpty else {
                throw PlayerValidationError.emptyName
            }
            // validate victory type
            if militaryVictory && scientificVictory {
                throw PlayerValidationError.simultaneousVictoryCondition
            }
            return Player(name: name, bluePoints: bluePoints, greenPoints: greenPoints, yellowPoints: yellowPoints, purplePoints: purplePoints, pyramidPoints: pyramidPoints, tokenPoints: tokenPoints, coinPoints: coinPoints, militaryPoints: militaryPoints, militaryVictory: militaryVictory, scientificVictory: scientificVictory)
        }
    }
}
