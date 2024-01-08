//
//  CreauresViewModel.swift
//  CatchEmAll
//
//  Created by Christian Manzaraz on 08/01/2024.
//

import Foundation

class CreauresViewModel: ObservableObject {
    
    private struct Returned: Codable { //MARK: VERY IMPORTANT JSON values are Codable!
        var count: Int
        var next: String  // This url shoud really be an optional. Will show why in a while
        var results: [Result]
    }
    
    struct Result: Codable, Hashable {
        var name: String
        var url: String // URL for detail on Pokemon
    }
    
    @Published var creaturesArray: [Result] = []
    
    @Published var urlString: String = "https://pokeapi.co/api/v2/pokemon/"
    @Published var count = 0
    
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
            
            self.count = returned.count
            self.urlString = returned.next
            self.creaturesArray = returned.results
            
        } catch {
            print("😡ERROR: Could not use URL at \(urlString) to get data and response.")
        }
        
    }
    
}
