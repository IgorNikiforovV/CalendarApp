//
//  ActivityListView.swift
//  CalendarApp
//
//  Created by Игорь Никифоров on 19.03.2024.
//

import SwiftUI
import SwiftData

struct ActivityListView: View {
    @Environment(\.modelContext) private var modelContent
    @State private var modelType: ModalType?
    @Query(sort: \Activity.name) private var activities: [Activity]
    @State var path = NavigationPath()

    var body: some View {
        NavigationStack(path: $path) {
            Group {
                if activities.isEmpty {
                    ContentUnavailableView("Create your first Activity by tapping on the \(Image(systemName: "plus.circle.fill")) button at the top.", image: "launchScreen")
                } else {
                    List(activities) { activity in
                        NavigationLink(value: activity) {
                            HStack {
                                Image(systemName: activity.icon)
                                    .foregroundStyle(Color(hex: activity.hexColor)!)
                                    .font(.system(size: 30))
                                    .frame(width: 50)
                                Text(activity.name.capitalized)
                                Spacer()
                                Text("^[\(activity.workouts.count) workout](inflect: true)")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)

                            }
                        }
                        .swipeActions(edge: .trailing) {
                            Button(role: .destructive) {
                                modelContent.delete(activity)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                        .swipeActions {
                            Button(role: .destructive) {
                                modelType = .updateActivity(activity)
                            } label: {
                                Label("Edit", systemImage: "pencil")
                            }
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("Activities")
            .toolbar {
                Button {
                    modelType = .newActivity
                } label: {
                    Image(systemName: "plus.circle.fill")
                }
                .sheet(item: $modelType) { sheet in
                    sheet.presentationDetents([.height(450)])
                }
            }
            .navigationDestination(for: Activity.self) { activity in
                //WorkoutsListView(activity: activity)
            }
        }
    }
}

#Preview {
    ActivityListView()
}
