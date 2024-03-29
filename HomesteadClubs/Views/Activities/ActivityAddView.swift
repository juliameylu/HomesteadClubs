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
    
    @State var name = ""
    @State var notes = ""
    @State var beginDateTime = Date.now
    @State var endDateTime = Date.now
    @State var sponsor: Contact?
    @State var creditHours: Float = 0
    @State var street = ""
    @State var city = ""
    @State var state = ""
    @State var zip = ""
    
    @State var readyToNavigate = false
    @State var showErrorMessage = false

    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Image("activity")
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
                    
                    Section("Time") {
                        DatePicker("Begin", selection: $beginDateTime, displayedComponents: [.date, .hourAndMinute])
                        .onChange(of: beginDateTime) { _ in
                            if (endDateTime < beginDateTime) {
                                endDateTime = activityViewModel.hoursFrom(date: beginDateTime, hours: 1)
                            }
                            creditHours = activityViewModel.computeCreditHours(beginDateTime: beginDateTime, endDateTime: endDateTime)
                        }
                        
                        DatePicker("End", selection: $endDateTime, displayedComponents: [.date, .hourAndMinute])
                        .onChange(of: endDateTime) { _ in
                            if (beginDateTime > endDateTime) {
                                beginDateTime = activityViewModel.hoursFrom(date: endDateTime, hours: -1)
                            }

                            creditHours = activityViewModel.computeCreditHours(beginDateTime: beginDateTime, endDateTime: endDateTime)
                        }

                        HStack {
                            Text("Hours")
                            Spacer()
                            TextField("Credit Hours", value: $creditHours, format: .number)
                                .textFieldStyle(.roundedBorder)
                                .padding(5)
                                .background(Color(.systemGray6))
                                .cornerRadius(8)
                                .disabled(true)
                        }
                    }
                    
                    Section("Address") {
                        VStack {
                            TextField("Street", text: $street)
                            TextField("City", text: $city)
                            TextField("State", text: $state)
                            TextField("Zip", text: $zip)
                        }
                    }
                    
                    Section("Other") {
                        Picker("Sponsor", selection: $sponsor) {
                            ForEach(contactViewModel.contacts, id: \.self) { (contact: Contact) in
                                HStack {
                                    Text(contact.first_name!)
                                    Text(contact.last_name!)
                                }.tag(contact as Contact?)
                            }
                        }
                        .pickerStyle(.menu)
                        
                        TextField("Notes", text: $notes, axis: .vertical)
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
                        let creditHours = activityViewModel.computeCreditHours(beginDateTime: beginDateTime, endDateTime: endDateTime)
                        if (creditHours <= 0) {
                            showErrorMessage = true
                        } else {
                            activityViewModel.addActivity(name: name, notes: notes, beginDateTime: beginDateTime, endDateTime: endDateTime, creditHours: creditHours, sponsor: sponsor,
                                                          street: street, city: city, state: state, zip: zip)
                            self.readyToNavigate = true
                            self.presentationMode.wrappedValue.dismiss()
                        }
                    }) {
                        Text("Done")
                    }
                    .disabled(name.isEmpty || street.isEmpty || city.isEmpty || state.isEmpty)
            ) // navigationBarItems
            .alert(isPresented: $showErrorMessage) { () -> Alert in
                Alert(title: Text("Check Dates"), message: Text("End Date should come after Begin Date"),
                      dismissButton: .default(Text("OK")))
            }
        } // NavigationStack
        // initialize state vars in onAppear because the EnvironmentObject is injected (created) after the view constructor
        .onAppear {
            self.name = ""
            self.notes = ""
            
            self.beginDateTime = activityViewModel.hoursFrom(date: Date.now, hours: 1)
            self.endDateTime = self.beginDateTime.addingTimeInterval(60 * 60)
            self.creditHours = activityViewModel.computeCreditHours(beginDateTime: self.beginDateTime, endDateTime: self.endDateTime)


            let contacts = contactViewModel.contacts
            if !contacts.isEmpty {
                self.sponsor = contacts[0]
            }
            
            self.readyToNavigate = false
            self.showErrorMessage = false
        }
    } // body
}
