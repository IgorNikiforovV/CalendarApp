//
//  StartTab.swift
//  CalendarApp
//
//  Created by Игорь Никифоров on 19.03.2024.
//

import SwiftUI

struct StartTab: View {
    var body: some View {
        TabView {
            ActivityListView()
                .tabItem {
                    Label("Activities", systemImage: "figure.mixed.cardio")
                }
            CalendarHeaderView()
                .tabItem {
                    Label("Calendar", systemImage: "calendar")
                }
        }
    }
}

#Preview {
    StartTab()
        .modelContainer(Activity.preview)
}
