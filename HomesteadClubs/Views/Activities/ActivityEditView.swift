//
//  ActivityEditView.swift
//  HomesteadClubs
//
//  Created by Julia Lu on 5/6/23.
//

import SwiftUI

struct ActivityEditView: View {
    @EnvironmentObject var activityViewModel: ActivityViewModel
    @EnvironmentObject var contactViewModel: ContactViewModel
    
    @Environment (\.presentationMode) var presentationMode

    @State var name: String
    @State var notes: String
    @State var beginDateTime: Date
    @State var endDateTime: Date
    @State var creditHours: Float
    @State var sponsor: Contact?
    
    @State var readyToNavigate = false
    
    var activity: Activity
    
    init(activity: Activity) {
        self.activity = activity

        _name = State(initialValue: activity.name ?? "")
        _notes = State(initialValue: activity.notes ?? "")
        _beginDateTime = State(initialValue: activity.beginDateTime ?? Date.now)
        _endDateTime = State(initialValue: activity.endDateTime ?? Date.now)
        _creditHours = State(initialValue: activity.creditHours)
        
        _sponsor = State(initialValue: activity.sponsor)
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Image("park")
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.gray, lineWidth: 2))
                    
                    Text("Edit Activity")
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
                    
                    Section("Other") {
                        Picker("Sponsor", selection: $sponsor) {
                            ForEach(contactViewModel.contacts, id: \.self) { (contact: Contact) in
                                HStack {
                                    Text(contact.first_name!)
                                    Text(contact.last_name!)
                                    // .tag(contact as Contact?)
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
                        activity.name = name
                        activity.notes = notes
                        activity.beginDateTime = beginDateTime
                        activity.endDateTime = endDateTime
                        activity.creditHours = activityViewModel.computeCreditHours(beginDateTime: beginDateTime, endDateTime: endDateTime)
                        activity.sponsor = sponsor
                    
                        activityViewModel.editActivity(activity: activity)
                        self.readyToNavigate = true
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Done")
                    } // Button
                    .disabled(name.isEmpty)
            ) // navigationBarItems
       } // NavigationStack
    } // body
}
