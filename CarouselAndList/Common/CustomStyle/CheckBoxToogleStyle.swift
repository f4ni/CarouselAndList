//
//  CheckBoxToogleStyle.swift
//  MovieList
//
//  Created by Furkan ic on 11.11.2024.
//

import SwiftUI

struct CheckBoxToogleStyle: ToggleStyle {

    func makeBody(configuration: Configuration) -> some View {
        Button {
            withAnimation {
                configuration.isOn.toggle()
            }
        } label: {
            Image(
                systemName: configuration.isOn
                  ? "checkmark.circle"
                  : "circle"
            )
            .resizable()
            .scaledToFill()
        }
        .foregroundStyle(Color.gray.opacity(0.5))
        .frame(width: 34, height: 34)
    }
}
