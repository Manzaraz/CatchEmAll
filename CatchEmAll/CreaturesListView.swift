//
//  CreaturesListView.swift
//  CatchEmAll
//
//  Created by Christian Manzaraz on 08/01/2024.
//

import SwiftUI

struct CreaturesListView: View {
    var creatures = ["Picachu", "Squirtle", "Charzard", "Snorlax"]
    
    
    var body: some View {
        NavigationStack {
            List(creatures, id: \.self) { creature in
                Text(creature)
                    .font(.title2)
            }
            .listStyle(.plain)
            .navigationTitle("Pokemon")
        }
    }
}

#Preview {
    CreaturesListView()
}
