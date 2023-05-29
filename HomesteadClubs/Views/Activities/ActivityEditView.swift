//
//  ActivityEditView.swift
//  HomesteadClubs
//
//  Created by Julia Lu on 5/6/23.
//

import SwiftUI

struct ActivityEditView: View {
    var activity: Activity
    
    @EnvironmentObject var activityViewModel: ActivityViewModel
    @EnvironmentObject var contactViewModel: ContactViewModel
    
    @Environment (\.presentationMode) var presentationMode

    @State var name: String
    @State var notes: String
    @State var beginDateTime: Date
    @State var endDateTime: Date
    @State var creditHours: Int16
    @State var sponsor: Contact?
    
    init(activity: Activity) {
        self.activity = activity

        _name = State(initialValue: activity.name ?? "")
        _notes = State(initialValue: activity.notes ?? "")
        _beginDateTime = State(initialValue: activity.beginDateTime ?? Date.now)
        _endDateTime = State(initialValue: activity.endDateTime ?? Date.now)
        _creditHours = State(initialValue: activity.creditHours)
        
        _sponsor = State(initialValue: activity.sponsor)
    }
    
    @State var readyToNavigate = false

    var body: some View {

        NavigationStack {
            VStack (spacing: 20) {
                Text("Edit Activity:")
                    .font(.headline)
                
                TextField("Name", text: $name)
                    .padding(20)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                
                TextField("Notes", text: $notes)
                    .padding(20)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                
                DatePicker("Start Date Time", selection: $beginDateTime, displayedComponents: [.date, .hourAndMinute])
                
                DatePicker("Finish Date Time", selection: $endDateTime, displayedComponents: [.date, .hourAndMinute])
                
                TextField("Credit Hours", value: $creditHours, format: .number)
                    .textFieldStyle(.roundedBorder)
                    .padding(20)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                
                Picker("Sponsor", selection: $sponsor) {
                    ForEach(contactViewModel.contacts, id: \.self) { (contact: Contact) in
                        Text(contact.first_name!)
                            .tag(contact as Contact?)
                    }
                } // Picker
            } // VStack
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(
                leading:
                    Button(action: { self.presentationMode.wrappedValue.dismiss() }) {
                        Text("Cancel")
                    },
                trailing:
                    Button(action: {
                        activity.name = name
                        activity.notes = notes
                        activity.beginDateTime = beginDateTime
                        activity.endDateTime = endDateTime
                        activity.creditHours = Int16((beginDateTime.distance(to: endDateTime) / 3600).truncatingRemainder(dividingBy: 3600))
                        activity.sponsor = sponsor
                    
                        activityViewModel.editActivity(activity: activity)
                        self.readyToNavigate = true
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Done")
                    } // Button
            ) // navigationBarItems
       } // NavigationStack
    } // body
}
