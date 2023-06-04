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

    @State private var isShowEditView = false
    @State private var isShowAttendeesView = false
    @State private var newAttendee: Contact?
    
    var activity: Activity

    init(activity: Activity) {
        self.activity = activity
    }
     
    var body: some View {
        // Picker needs to be inside a NavigationView or ScrollView
        // https://stackoverflow.com/questions/66275021/picker-appears-disabled-inside-a-form-bug/66275172
        // https://stackoverflow.com/questions/63854946/swiftui-form-picker-button-not-co-existing
//        NavigationStack {
                Form {
                    Section(header: Text("Activity")) {
                        VStack(alignment: .leading) {
                            HStack {
                                Image("park")
                                    .clipShape(Circle())
                                    .overlay(Circle().stroke(Color.gray, lineWidth: 2))
                                
                                Text(activity.name ?? "")
                                    .fontWeight(.semibold)
                                    .font(.headline)
                            }
                            
                        } // VStack
                    } // Section
                    
                    Section(header: Text("Time")) {
                        Grid(alignment: .leadingFirstTextBaseline) {
                            GridRow {
                                Text("From:")
                                Text(activity.beginDateTime ?? Date.now, style: .date)
                                Text(activity.beginDateTime ?? Date.now, style: .time)
                            }
                            GridRow {
                                Text("To:")
                                Text(activity.endDateTime ?? Date.now, style: .date)
                                Text(activity.endDateTime ?? Date.now, style: .time)
                            }
                            GridRow {
                                Text("Hours:")
                                Text(String(activity.creditHours))
                            }
                        }
                    } // Section
                    
                    Section(header: Text("Sponsor")) {
                        Text(activity.sponsor?.first_name ?? "")
                        Text(activity.sponsor?.last_name ?? "")
                    } // Section
                    
                    Section(header: Text("Notes")) {
                        Text(activity.notes ?? "")
                    } // Notes
                    
                    //                Section(header: Text("Add Attendees")) {
                    ////                    ScrollView {
                    //                        HStack {
                    //                            Picker(selection: $newAttendee, label: Text("Add New Attendee")) {
                    //                                ForEach(activityViewModel.fetchNonMembers(contacts: contactViewModel.contacts, attendances: activity.attendanceArray), id: \.self) { (contact: Contact) in
                    //                                    Text(contact.first_name!)
                    //                                        .tag(contact as Contact?)
                    //                                } // ForEach
                    //                            } // Picker
                    //                            // Need to set a new id so that the picker refreshes
                    //                            // https://www.hackingwithswift.com/forums/swiftui/swiftui-picker-desn-t-bind-with-observedobject/817
                    //                            .id(UUID())
                    //
                    //                            Button(action: {
                    //                                withAnimation {
                    //                                    activityViewModel.addAttendance(contact: newAttendee!, activity: activity)
                    //                                    setDefaultNewAttendee()
                    //                                }
                    //                            }) {
                    //                                Image(systemName: "plus.circle.fill")
                    //                                    .accessibilityLabel("Add attendee")
                    //                            }
                    //                            .disabled(newAttendee == nil)
                    //                            .buttonStyle(PlainButtonStyle())
                    //                        } // HStack
                    ////                    } // ScrollView
                    //                } // Section
                    //
                    //                Section(header: Text("Current Attendees")) {
                    //                    List {
                    //                        ForEach(activity.attendanceArray) { attendance in
                    //                            Text(attendance.attendedBy!.first_name ?? "not found")
                    //                        }
                    //                        .onDelete(perform: removeAttendance)
                    //                    } // List
                    //                } // Section
                } // Form
                .contentShape(Rectangle())
                .onTapGesture {
                    isShowEditView = true
                }
                .toolbar {
                    ToolbarItemGroup() {
                        Button("Edit", action: {
                            isShowAttendeesView = false
                            isShowEditView = true
                        })

                        Spacer()
                        
                        Button("Attendees", action: {
                            isShowAttendeesView = true
                            isShowEditView = false
                        })
                        .navigationDestination(isPresented: $isShowAttendeesView) {
                            AttendeeListView(activity: activity)
                        }
                    }
                }
                .sheet(isPresented: $isShowEditView) {
                    ActivityEditView(activity: activity)
                        .navigationTitle(activity.name ?? "")
                        .toolbar {
                            ToolbarItem(placement: .cancellationAction) {
                                Button("Cancel") {
                                    isShowEditView = false
                                }
                            }
                            ToolbarItem(placement: .confirmationAction) {
                                Button("Done") {
                                    isShowEditView = false
                                }
                            }
                        } // toolbar
                } // sheet
                .background(
                    NavigationLink(destination: ContactListView()) {
                        EmptyView()
                    }.hidden()
                ) // Form

                
//                Button() {
//                    isShowAttendeesView = true
//                } label: {
//                    Label("Usar Face ID", systemImage: "faceid")
//                }
//        } // NavigationStack
    } // body
    
//    func removeAttendance(at offsets: IndexSet) {
//        for index in offsets {
//            let attendance = activity.attendanceArray[index]
//            activityViewModel.removeAttendance(attendance: attendance)
//        }
//
//        setDefaultNewAttendee()
//    }
//
//    func setDefaultNewAttendee() {
//        let nonMembers = activityViewModel.fetchNonMembers(contacts: contactViewModel.contacts, attendances: activity.attendanceArray)
//        if nonMembers.isEmpty {
//            newAttendee = nil
//        } else {
//            newAttendee = nonMembers[0]
//        }
//    }
}
