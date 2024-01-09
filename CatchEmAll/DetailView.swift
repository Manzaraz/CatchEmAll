//
//  DetailView.swift
//  CatchEmAll
//
//  Created by Christian Manzaraz on 08/01/2024.
//

import SwiftUI

struct DetailView: View {
    @StateObject var creatureDetailVM = CreaureDetailViewModel()
    var creature: Creature
    
    var body: some View {
        VStack (alignment: .leading, spacing: 3) {
            Text(creature.name.capitalized)
                .font(Font.custom("Avenir Next Condensed", size: 60))
                .bold()
                .minimumScaleFactor(0.5)
                .lineLimit(1)
            
            Rectangle()
                .frame(height: 1)
                .foregroundStyle(.gray)
                .padding()
            
            HStack {
                AsyncImage(url: URL(string: creatureDetailVM.imageUrl)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .background(.white)
                        .frame(maxWidth: 96)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .shadow(radius: 8, x: 5, y: 5)
                        .overlay {
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(.gray.opacity(0.5), lineWidth: 1)
                        }
                        .padding(.trailing)
                } placeholder: {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(.clear)
                        .frame(maxWidth: 96, maxHeight: 96)
                }
                
                VStack (alignment: .leading) {
                    HStack (alignment: .top) {
                        Text("Height:")
                            .font(.title2)
                            .bold()
                            .foregroundStyle(.red)
                        
                        Text(String(format: "%.1f", creatureDetailVM.height))
                            .font(.largeTitle)
                            .bold()
                    }
                    
                    HStack (alignment: .top) {
                        Text("Weight:")
                            .font(.title2)
                            .bold()
                            .foregroundStyle(.red)
                        
                        Text(String(format: "%.01f", creatureDetailVM.weight))
                            .font(.largeTitle)
                            .bold()
                    }
                }
            }
            Spacer()
        }
        .padding()
        .task {
            creatureDetailVM.urlString = creature.url
            await creatureDetailVM.getData()
        }
    }
}

#Preview {
    DetailView(creature: Creature(name: "bulbasaur", url: "https://pokeapi.co/api/v2/pokemon/1/"))
}
