//
//  ActivityView.swift
//  Challenge4HabitTrack
//
//  Created by Melissa Elliston-Boyes on 02/04/2025.
//

import SwiftUI

struct ActivityView: View {
    @Environment(\.dismiss) var dismiss
    
    var activity: Activity
    var activities: Activities

    var body: some View {
        NavigationStack {
            Form {
                Text(activity.description)
                HStack {
                    Text("Times completed: \(activity.timesCompleted)")
                    Spacer()
                    Button {
                        var activityCopy = activity
                        activityCopy.timesCompleted += 1
                        activities.activities[
                            activities.activities.firstIndex(of: activity)!] =
                            activityCopy
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
        .navigationTitle(activity.name)
    }
}

#Preview {
    let activity = Activity(
        name: "Test Activity", description: "This is a test activity")
    let activities = Activities()
    activities.activities.append(activity)
    return ActivityView(activity: activity, activities: activities)
}
