//
//  CreatureViewModel.swift
//  CatchEmAll
//
//  Created by Christian Manzaraz on 08/01/2024.
//

import Foundation

@MainActor
class CreaureDetailViewModel: ObservableObject {
    
    private struct Returned: Codable { //MARK: VERY IMPORTANT JSON values are Codable!
        var height: Double
        var weight: Double
        var sprites: Sprite
    }
    
    struct Sprite: Codable {
        var front_default: String?
        var other: Other
    }
    
    struct Other: Codable {
        var officialArtwork: OfficialArtwork
        
        enum CodingKeys: String, CodingKey {
            case officialArtwork = "official-artwork"
        }
    }
    
    
    struct OfficialArtwork: Codable {
        var front_default: String?
    }
    
    var urlString = ""
    @Published var height = 0.0
    @Published var weight = 0.0
    @Published var imageUrl = ""
    
    
    func getData() async {
        print("🕸️ We are accessing the url \(urlString)")
        
        // Convert urlString to a special URL type
        guard let url =  URL(string: urlString) else {
            print("😡 ERROR: Could not create a URL from \(urlString).")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url) // We don't use a response into the tuple, I ignore with _
            
            // Try to decode JSON data into our own data structures
            guard let returned = try? JSONDecoder().decode(Returned.self, from: data) else {
                print("😡JSON ERROR: Could not decode returned JSON data.")
                return
            }
            
            self.height = returned.height
            self.weight = returned.weight
            self.imageUrl = (returned.sprites.other.officialArtwork.front_default ?? returned.sprites.front_default) ?? ""
            
        } catch {
            print("😡ERROR: Could not use URL at \(urlString) to get data and response.")
        }
        
    }
    
}
