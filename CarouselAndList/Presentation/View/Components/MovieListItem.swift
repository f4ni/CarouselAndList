//
//  MovieListItem.swift
//  MovieList
//
//  Created by Furkan ic on 11.11.2024.
//

import SwiftUI

struct MovieListItem: View {
    let id = UUID()
    let movie: Movie
    
    var body: some View {
        HStack {
            if let imageURL = movie.imageURL {
                AsyncImage(url: imageURL)
                    .frame(width: 64, height: 64)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .padding(6)
            }
            VStack(alignment: .leading) {
                if let name = movie.name {
                    Text(name)
                        .bold()
                        .multilineTextAlignment(.leading)
                }
                if let explanation = movie.explanation {
                    Text(explanation)
                }
            }
            .foregroundStyle(Color.black)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.listbackground)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

#Preview {
    MainView()
}
