//
//  ModalType.swift
//  CalendarApp
//
//  Created by Игорь Никифоров on 19.03.2024.
//

import SwiftUI
enum ModalType: View, Identifiable, Equatable {
    case newActivity
    case updateActivity(Activity)
    case newWorkout(Activity)
    case updateWorkout(Workout)

    var id: String {
        switch self {
        case .newActivity:
            "newActivity"
        case .updateActivity:
            "updateActivity"
        case .newWorkout:
            "newWorkout"
        case .updateWorkout:
            "updateWorkout"
        }
    }

    var body: some View {
        switch self {
        case .newActivity:
            ActivityFormView(model: ActivityFormModel())
        case .updateActivity(let activity):
            ActivityFormView(model: ActivityFormModel(activity: activity))
        case .newWorkout(let activity):
            WorkoutFormView(model: WorkoutFormModel(activity: activity))
        case .updateWorkout(let workout):
            WorkoutFormView(model: WorkoutFormModel(workout: workout))
        }
    }
}

