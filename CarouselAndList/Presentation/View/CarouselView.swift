//
//  CarouselView.swift
//  CarouselAndList
//
//  Created by Furkan ic on 8.02.2025.
//

import SwiftUI

struct CarouselView: View {
    
    let movies: [Movie]
    @Binding var selectedIndex: Movie?
    
    var body: some View {
        LazyVStack {
            TabView(selection: $selectedIndex) {
                ForEach(movies) { movie in
                    if let imageURL = movie.imageURL {
                        AsyncImage(url: imageURL) { image in
                            image.image?
                                .resizable()
                                .scaledToFit()
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                        }
                        .padding(.bottom, 40)
                        .containerRelativeFrame(.horizontal)
                        .tag(movie)
                    }
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .always))
            .onAppear {
                setupPageControlAppearance()
            }
            .frame(height: 260)
        }
    }
    private func setupPageControlAppearance() {
        UIPageControl.appearance().currentPageIndicatorTintColor = .blue
        UIPageControl.appearance().pageIndicatorTintColor = .black.withAlphaComponent(0.3)
    }
}
