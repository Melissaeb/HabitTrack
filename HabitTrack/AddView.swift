//
//  AddView.swift
//  Challenge4HabitTrack
//
//  Created by Melissa Elliston-Boyes on 02/04/2025.
//

import SwiftUI

struct AddView: View {
    @Environment(\.dismiss) var dismiss

    @State private var name: String = ""
    @State private var description: String = ""
    @State private var timesCompleted: Int = 0
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""

    var activities: Activities

    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)
                TextField("Description", text: $description)
                HStack {
                    Text("Times completed:")
                    TextField(
                        "Times completed", value: $timesCompleted,
                        formatter: NumberFormatter()
                    )
                    .keyboardType(.numberPad)
                }
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Error"), message: Text(alertMessage))
            }
            .navigationTitle("Add new activity")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        saveActivity()
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
            .navigationBarBackButtonHidden()
        }
    }
    
    func saveActivity() {
        if name.isEmpty {
            alertMessage = "Please enter a name for your activity"
            showAlert = true
            return
        }

        if timesCompleted < 0 {
            alertMessage = "Please enter a valid number of times you have completed your activity"
            showAlert = true
            return
        }

        let activity = Activity(name: name, description: description, timesCompleted: timesCompleted)
        activities.activities.append(activity)
        dismiss()
    }
}

#Preview {
    AddView(activities: Activities())
}
