//
//  CalendarAppApp.swift
//  CalendarApp
//
//  Created by Игорь Никифоров on 12.03.2024.
//

import SwiftUI

@main
struct CalendarAppApp: App {
    var body: some Scene {
        WindowGroup {
            ActivityListView()
                .modelContainer(for: Activity.self)
        }
    }
}
