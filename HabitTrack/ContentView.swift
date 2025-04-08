//
//  ContentView.swift
//  Challenge4HabitTrack
//
//  Created by Melissa Elliston-Boyes on 02/04/2025.
//

import SwiftUI

struct Activity: Identifiable, Codable, Equatable {
    var id: UUID = UUID()
    let name: String
    let description: String
    var timesCompleted: Int = 0
}

@Observable
class Activities: Codable {
    var activities: [Activity] = [Activity]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(activities) {
                UserDefaults.standard.set(encoded, forKey: "Activities")
            }
        }
    }

    init() {
        if let savedActivities = UserDefaults.standard.data(
            forKey: "Activities")
        {
            if let decodedActivities = try? JSONDecoder().decode(
                [Activity].self, from: savedActivities)
            {
                activities = decodedActivities
                return
            }
        }

        activities = []
    }
}

struct ContentView: View {
    @State private var activities: Activities = Activities()
    @State private var showAddView: Bool = false

    var body: some View {
        NavigationStack {
            ScrollView {
                List {
                    ForEach(activities.activities) { activity in
                        NavigationLink {
                            ActivityView(activity: activity, activities: activities)
                        } label: {
                            HStack {
                                Text(activity.name)
                                Spacer()
                                Text("Completed ^[\(activity.timesCompleted) time](inflect: true)")
                            }
                        }
                    }
                }
                .containerRelativeFrame(.vertical) { height, axis in
                    height * 1
                }
            }
            .navigationTitle("Activity Tracker")
            .sheet(isPresented: $showAddView) {
                AddView(activities: activities)
            }
            .toolbar {
                Button("Add Activity", systemImage: "plus") {
                    showAddView.toggle()
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
