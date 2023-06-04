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
    
    var activity: Activity
    
    @State private var selections = Set<Contact>()
    
    let myContacts = [
        MyContact(name: "John"),
        MyContact(name: "Alice"),
        MyContact(name: "Bob")
    ]
    
    var body: some View {
        
        VStack {
            List(activityViewModel.fetchNonMembers(contacts: contactViewModel.contacts, attendances: activity.attendanceArray), id: \.self, selection: $selections) { (contact: Contact) in
            
//            List(myContacts, selection: $selections) { myContact in
//                Text(myContact.name)
                HStack {
                    Text(contact.first_name ?? "")
                        .fontWeight(.semibold)
                        .font(.headline)

                    Text(contact.middle_name ?? "")
                        .font(.subheadline)

                    Text(contact.last_name ?? "")
                        .font(.subheadline)
                }
                //                .frame(maxWidth: .infinity, alignment: .leading)
                //                .padding(.horizontal)
                //                .padding(.bottom)
                //                    activityViewModel.addAttendance(contact: newAttendee!, activity: activity)
                } // List
            
//                Text("\(selections)")
            } // VStack
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

struct MyContact: Identifiable {
    let id = UUID()
    let name: String
}
