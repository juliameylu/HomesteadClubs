//
//  ActivityDetailView.swift
//  HomesteadClubs
//
//  Created by Julia Lu on 5/6/23.
//

import SwiftUI

struct ActivityDetailView: View {
    @EnvironmentObject var activityViewModel: ActivityViewModel
    @EnvironmentObject var contactViewModel: ContactViewModel

    @State private var isPresentingEditView = false
    @State private var newAttendee: Contact?
    
    var activity: Activity

    let dateFormatter = DateFormatter()

    init(activity: Activity) {
        self.activity = activity

        dateFormatter.dateFormat = "YY/MM/dd hh::mm"
    }
     
    var body: some View {
        // Picker needs to be inside a NavigationView or ScrollView
        // https://stackoverflow.com/questions/66275021/picker-appears-disabled-inside-a-form-bug/66275172
        // https://stackoverflow.com/questions/63854946/swiftui-form-picker-button-not-co-existing
        NavigationStack {
            Form {
                Section(header: Text("Activity Info")) {
                    VStack {
                        Text(activity.name ?? "")
                            .font(.custom("Roboto-Bold", size: 20))
                            .foregroundColor(Color.black)
                        
                        Text(activity.notes ?? "")
                            .font(.custom("Roboto-Bold", size: 20))
                            .foregroundColor(Color.black)
                        
                        Text(dateFormatter.string(from: activity.beginDateTime ?? Date.now))
                            .font(.custom("Roboto-Bold", size: 20))
                            .foregroundColor(Color.black)
                        
                        Text(dateFormatter.string(from: activity.endDateTime ?? Date.now))
                            .font(.custom("Roboto-Bold", size: 20))
                            .foregroundColor(Color.black)
                        
                        Text(String(activity.creditHours))
                            .font(.custom("Roboto-Bold", size: 20))
                            .foregroundColor(Color.black)
                        
                        Text(activity.sponsor?.first_name ?? "")
                            .font(.custom("Roboto-Bold", size: 20))
                            .foregroundColor(Color.black)
                    } // VStack
                    .contentShape(Rectangle())
                    .onTapGesture {
                        isPresentingEditView = true
                    }
                    .toolbar {
                        Button("Edit", action: { isPresentingEditView = true })
                    }
                    .sheet(isPresented: $isPresentingEditView) {
                        ActivityEditView(activity: activity)
                            .navigationTitle(activity.name ?? "")
                            .toolbar {
                                ToolbarItem(placement: .cancellationAction) {
                                    Button("Cancel") {
                                        isPresentingEditView = false
                                    }
                                }
                                ToolbarItem(placement: .confirmationAction) {
                                    Button("Done") {
                                        isPresentingEditView = false
                                    }
                                }
                            } // toolbar
                    } // sheet
                } // Section
                
                Section(header: Text("Add Attendees")) {
//                    ScrollView {
                        HStack {
                            Picker(selection: $newAttendee, label: Text("Add New Attendee")) {
                                ForEach(activityViewModel.fetchNonMembers(contacts: contactViewModel.contacts, attendances: activity.attendanceArray), id: \.self) { (contact: Contact) in
                                    Text(contact.first_name!)
                                        .tag(contact as Contact?)
                                } // ForEach
                            } // Picker
                            // Need to set a new id so that the picker refreshes
                            // https://www.hackingwithswift.com/forums/swiftui/swiftui-picker-desn-t-bind-with-observedobject/817
                            .id(UUID())
                            
                            Button(action: {
                                withAnimation {
                                    activityViewModel.addAttendance(contact: newAttendee!, activity: activity)
                                    setDefaultNewAttendee()
                                }
                            }) {
                                Image(systemName: "plus.circle.fill")
                                    .accessibilityLabel("Add attendee")
                            }
                            .disabled(newAttendee == nil)
                            .buttonStyle(PlainButtonStyle())
                        } // HStack
//                    } // ScrollView
                } // Section
                
                Section(header: Text("Current Attendees")) {
                    List {
                        ForEach(activity.attendanceArray) { attendance in
                            Text(attendance.attendedBy!.first_name ?? "not found")
                        }
                        .onDelete(perform: removeAttendance)
                    } // List
                } // Section
            } // Form
        } // NavigationStack
    } // body
    
    func removeAttendance(at offsets: IndexSet) {
        for index in offsets {
            let attendance = activity.attendanceArray[index]
            activityViewModel.removeAttendance(attendance: attendance)
        }
        
        setDefaultNewAttendee()
    }
    
    func setDefaultNewAttendee() {
        let nonMembers = activityViewModel.fetchNonMembers(contacts: contactViewModel.contacts, attendances: activity.attendanceArray)
        if nonMembers.isEmpty {
            newAttendee = nil
        } else {
            newAttendee = nonMembers[0]
        }
    }
}
