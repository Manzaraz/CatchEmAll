//
//  Creature.swift
//  CatchEmAll
//
//  Created by Christian Manzaraz on 08/01/2024.
//

import Foundation

struct Creature: Codable, Identifiable{
    let id = UUID().uuidString
    var name: String
    var url: String // URL for detail on Pokemon
    
    enum CodingKeys: CodingKey {
        case name, url
    }
}
