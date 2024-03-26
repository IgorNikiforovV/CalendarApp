//
//  WorkoutsListView.swift
//  CalendarApp
//
//  Created by Игорь Никифоров on 20.03.2024.
//

import SwiftUI
import SwiftData

struct WorkoutsListView: View {
    @Environment(\.modelContext) private var modelContent
    @Environment(\.dismiss) private var dismiss
    @State private var modelType: ModalType?
    var activity: Activity

    var body: some View {
        @Bindable var activity = activity
        Group {
            if activity.workouts.isEmpty {
                ContentUnavailableView("Create your first \(activity.name) workout by tapping on the \(Image(systemName: "plus.circle.fill")) button at the top.", systemImage: "\(activity.icon)")
            } else {
                List(activity.workouts.sorted(
                    using: KeyPathComparator(\Workout.date, order: .reverse)
                )
                ) { workout in
                    HStack {
                        Image(systemName: activity.icon)
                            .foregroundColor(Color(hex: activity.hexColor)!)
                        VStack(alignment: .leading) {
                            Text(workout.date.formatted(date: .abbreviated, time: .shortened))
                            Text(workout.comment)
                                .foregroundStyle(.secondary)
                        }
                    }
                    .swipeActions(edge: .trailing) {
                        Button(role: .destructive) {
                            if let index = activity.workouts
                                .firstIndex(where: { $0.id == workout.id }) {
                                activity.workouts.remove(at: index)
                            }
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
                    .swipeActions(edge: .leading) {
                        Button {
                            if let index = activity.workouts
                                .firstIndex(where: { $0.id == workout.id }) {
                                modelType = .updateWorkout(activity.workouts[index])
                            }
                        } label: {
                            Label("Edit", systemImage: "pencil")
                        }
                    }
                }
                .listStyle(.plain)
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("\(Image(systemName: activity.icon)) \(activity.name)")
                    .font(.title)
                    .foregroundStyle(Color(hex: activity.hexColor)!)
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    modelType = .newWorkout(activity)
                } label: {
                    Image(systemName: "plus.circle.fill")
                }
                .sheet(item: $modelType) { sheet in
                    sheet.presentationDetents([.height(300)])
                }
            }
        }
    }
}

#Preview {
    let container = Activity.preview
    var fetchDescriptor = FetchDescriptor<Activity>()
    fetchDescriptor.sortBy = [SortDescriptor(\.name)]
    let activity = try! container.mainContext.fetch(fetchDescriptor)[0]
    return NavigationStack {
        WorkoutsListView(activity: activity)
    }
    .modelContainer(Activity.preview)
}
