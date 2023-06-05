//
//  ActivityAddView.swift
//  HomesteadClubs
//
//  Created by Julia Lu on 5/6/23.
//

import SwiftUI

struct ActivityAddView: View {
    @EnvironmentObject var activityViewModel: ActivityViewModel
    @EnvironmentObject var contactViewModel: ContactViewModel
    
    @Environment (\.presentationMode) var presentationMode
    
    @State var name: String = ""
    @State var notes: String = ""
    @State var beginDateTime: Date = Date.now
    @State var endDateTime: Date = Date.now.addingTimeInterval(60 * 60)
    @State var sponsor: Contact?
    @State var showErrorMessage = false
    
    @State var readyToNavigate = false
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Image("park")
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.gray, lineWidth: 2))
                    
                    Text("Add Activity")
                        .font(.headline)
                }
                
                Form {
                    Section("Title") {
                        TextField("Name", text: $name)
                            .padding(20)
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                    }
                    
                    Section("Hours") {
                        DatePicker("Begin", selection: $beginDateTime, displayedComponents: [.date, .hourAndMinute])
                        
                        DatePicker("End", selection: $endDateTime, displayedComponents: [.date, .hourAndMinute])
                    }
                    
                    Section("Other") {
                        Picker("Sponsor", selection: $sponsor) {
                            ForEach(contactViewModel.contacts, id: \.self) { (contact: Contact) in
                                HStack {
                                    Text(contact.first_name!)
//                                        .tag(contact as Contact?)
                                    Text(contact.last_name!)
//                                        .tag(contact as Contact?)
                                }.tag(contact as Contact?)
                            }
                        }
                        .pickerStyle(.menu)
                        
                        TextField("Notes", text: $notes)
                            .padding(20)
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                    } // Section
                } // Form
            } // VStack
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(
                leading:
                    Button(action: { self.presentationMode.wrappedValue.dismiss() }) {
                        Text("Cancel")
                    },
                trailing:
                    Button(action: {
                        let creditHours = computeCreditHours()
                        if (creditHours <= 0) {
                            showErrorMessage = true
                        } else {
                            activityViewModel.addActivity(name: name, notes: notes, beginDateTime: beginDateTime, endDateTime: endDateTime, creditHours: creditHours, sponsor: sponsor!)
                            self.readyToNavigate = true
                            self.presentationMode.wrappedValue.dismiss()
                        }
                    }) {
                        Text("Done")
                    }
                    .disabled(name.isEmpty)
            ) // navigationBarItems
            .alert(isPresented: $showErrorMessage) { () -> Alert in
                Alert(title: Text("Check Dates"), message: Text("End Date should come after Begin Date"),
                      dismissButton: .default(Text("OK")))
            }
        } // NavigationStack
        // initialize state vars in onAppear because the EnvironmentObject is injected (created) after the view constructor
        .onAppear {
            let contacts = contactViewModel.contacts
            if !contacts.isEmpty {
                self.sponsor = contacts[0]
            }
        }
    } // body
    
    func computeCreditHours() -> Int16 {
        let deltaTimeInterval = beginDateTime.distance(to: endDateTime)
        return Int16(deltaTimeInterval / 3600)
    }
}
