//
//  ActivityIconSelectionView.swift
//  CalendarApp
//
//  Created by Игорь Никифоров on 28.03.2024.
//

import SwiftUI

struct ActivityIconSelectionView: View {
    @Binding var selectingIcon: Bool
    @Binding var selectedIcon: ActivitySymbol
    let columns = [GridItem(.adaptive(minimum: 40))]

    var body: some View {
        ZStack {
            Color.white.opacity(0.1)
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(.systemBackground))
                .shadow(radius: 10)
                .frame(width: 300, height: 420)
                .overlay(
                    VStack {
                        ScrollView(showsIndicators: true) {
                            LazyVGrid(columns: columns, spacing: 28) {
                                ForEach(ActivitySymbol.allCases, id: \.self) { symbol in
                                    Button {
                                        selectedIcon = symbol
                                        withAnimation {
                                            selectingIcon = false
                                        }
                                    } label: {
                                        Image (systemName: symbol.rawValue)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: 30)
                                            .tint(selectedIcon == symbol ? .red : .blue)
                                            .scaleEffect(selectedIcon == symbol ? 1.5 : 1)
                                    }
                                }
                            }
                            .padding()
                        }
                        .padding()
                        Spacer()
                    }
                    )
        }
    }
}

#Preview {
    struct Preview: View {
        @State private var selectedIcon:ActivitySymbol = .mixedCardio
        var body: some View {
            ActivityIconSelectionView(selectingIcon: .constant(true), selectedIcon: $selectedIcon)
        }
    }
    return Preview()
}
