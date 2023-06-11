//
//  AttendeeAddView.swift
//  HomesteadClubs
//
//  Created by Julia Lu on 6/4/23.
//

import SwiftUI

struct AttendeeAddView: View {
    @EnvironmentObject var activityViewModel : ActivityViewModel
    @EnvironmentObject var contactViewModel: ContactViewModel
    
    @State private var selections = Set<Contact>()
    
    var activity: Activity
    
    var body: some View {
        List(activityViewModel.fetchNonMembers(contacts: contactViewModel.contacts, attendances: activity.attendanceArray), id: \.self, selection: $selections) { (contact: Contact) in
            HStack {
                Text(contact.first_name ?? "")

                if let middleName = contact.middle_name {
                    Text(middleName)
                }

                Text(contact.last_name ?? "")
            } // HStack
        } // List
        .navigationTitle("Add Attendees")
        .toolbar {
            ToolbarItemGroup() {
                EditButton()
                Spacer()
                Button("Add", action: {
                    activityViewModel.addAttendances(attendees: selections, activity: activity)
                })
            }
        }
    } // body
}
