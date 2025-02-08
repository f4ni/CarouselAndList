//
//  ActivityIndicatorView.swift
//  MovieList
//
//  Created by Furkan ic on 11.11.2024.
//


import SwiftUI

struct ActivityIndicatorView: View {
    var body: some View {
        ProgressView("Movies are loading...")
            .progressViewStyle(.circular)
            .foregroundStyle(Color.white)
            .tint(.white)
            .padding()
            .background(Color.gray.opacity(0.3))
            .cornerRadius(8)
    }
}

#Preview {
    ActivityIndicatorView()
}
