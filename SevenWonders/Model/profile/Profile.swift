//
//  Profile.swift
//  SevenWonders
//
//  Created by Tom Bintener on 27/09/2024.
//

import Foundation
import SwiftData

@Model
class Profile {
    @Attribute(.unique) var id: UUID
    var name: String
    var profileImageData: Data?

    init(name: String, profileImage: Data? = nil) {
        self.id = UUID()
        self.name = name
        self.profileImageData = profileImage
    }
}
