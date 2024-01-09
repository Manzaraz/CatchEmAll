//
//  CreauresViewModel.swift
//  CatchEmAll
//
//  Created by Christian Manzaraz on 08/01/2024.
//

import Foundation

@MainActor
class CreauresViewModel: ObservableObject {
    
    private struct Returned: Codable { //MARK: VERY IMPORTANT JSON values are Codable!
        var count: Int
        var next: String?
        var results: [Creature]
    }
    
    @Published var creaturesArray: [Creature] = []
    @Published var urlString: String = "https://pokeapi.co/api/v2/pokemon/"
    @Published var count = 0
    @Published var isLoading = false
    
    
    func getData() async {
        print("🕸️ We are accessing the url \(urlString)")
        isLoading = true
        
        // Convert urlString to a special URL type
        guard let url =  URL(string: urlString) else {
            print("😡 ERROR: Could not create a URL from \(urlString).")
            isLoading = false
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
            self.urlString = returned.next ?? ""
            self.creaturesArray = self.creaturesArray + returned.results
            
            isLoading = false
        } catch {
            isLoading = false
            print("😡ERROR: Could not use URL at \(urlString) to get data and response.")
        }
        
    }
    
    func loadAll() async {
        guard urlString.hasPrefix("http") else { return }
        
        await getData() // get next page of data.        
        await loadAll() // call loadAll again - will stop when all pages are retrieved.
    }
    
}
