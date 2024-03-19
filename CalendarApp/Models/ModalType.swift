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
            AnyView(_fromValue: 1)
            //ActivityFormView(model: ActivityFormModel())
        case .updateActivity(let activity):
            AnyView(_fromValue: 2)
            //ActivityFormView(model: ActivityFormModel(activity: activity))
        case .newWorkout(let activity):
            AnyView(_fromValue: 3)
            //WorkoutFormView(model: WorkoutFormModel(activity: activity))
        case .updateWorkout(let workout):
            AnyView(_fromValue: 5)
            //WorkoutFormView(model: WorkoutFormModel(workout: workout))
        }
    }
}
