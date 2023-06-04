//
//  ActivityAddView.swift
//  HomesteadClubs
//
//  Created by Julia Lu on 5/6/23.
//

import SwiftUI

struct ActivityAddView: View {
    @ObservedObject var activityViewModel: ActivityViewModel
    @ObservedObject var contactViewModel: ContactViewModel

    @Environment (\.presentationMode) var presentationMode

    @State var name: String = ""
    @State var notes: String = ""
    @State var beginDateTime: Date = Date.now
    @State var endDateTime: Date = Date.now
    @State var creditHours: Int16 = 0
    @State var sponsor: Contact?

    @State var readyToNavigate = false
    
    var contacts: [Contact]
    
    init(activityViewModel: ActivityViewModel, contactViewModel: ContactViewModel) {
        self.activityViewModel = activityViewModel
        self.contactViewModel = contactViewModel
        
        self.contacts = contactViewModel.contacts
        
        if !contacts.isEmpty {
            self._sponsor = State(initialValue: contacts[0])
        }
    }

    var body: some View {
        NavigationStack {
            VStack (spacing: 20) {
                Text("Add New Activity")
                    .font(.headline)
                
                Image("park")
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.gray, lineWidth: 2))
                
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
                }
                .pickerStyle(.menu)
            } // VStack
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(
                leading:
                    Button(action: { self.presentationMode.wrappedValue.dismiss() }) {
                        Text("Cancel")
                    },
                trailing:
                    Button(action: {
                        activityViewModel.addActivity(name: name, notes: notes, beginDateTime: beginDateTime, endDateTime: endDateTime, creditHours: creditHours, sponsor: sponsor!)
                        self.readyToNavigate = true
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Add")
                    }
            ) // navigationBarItems
        } // NavigationStack
    } // body
}
