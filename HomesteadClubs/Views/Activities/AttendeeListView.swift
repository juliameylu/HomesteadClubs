//
//  AttendeeListView.swift
//  HomesteadClubs
//
//  Created by Julia Lu on 6/4/23.
//

import SwiftUI

struct AttendeeListView: View {
    @EnvironmentObject var activityViewModel : ActivityViewModel
    
    var activity: Activity
    
    @State var showNewAttendeeView: Bool = false
    
    var body: some View {
        List {
            ForEach(activity.attendanceArray, id: \.id) { attendance in
                NavigationLink {
                    ContactDetailView(contact: attendance.attendedBy!)
                } label: {
                    HStack {
                        Image("contact")
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.gray, lineWidth: 2))
                        
                        Text(attendance.attendedBy!.first_name ?? "")
                        
                        if let middleName = attendance.attendedBy!.middle_name {
                            Text(middleName)
                        }

                        Text(attendance.attendedBy!.last_name ?? "")
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.bottom)
                } // NavigationLink
            } // ForEach
            .onDelete(perform: deleteAttendance)
        } // List
        .navigationTitle("Current Attendees")
        //            .sheet(isPresented: $showNewAttendeeView) {
        //                AttendeeAddView(activity: activity)
        //            }
        .navigationBarItems(trailing:
                                Button (action: {
            showNewAttendeeView.toggle()
        }) {
            Image(systemName: "plus")
        } // Button
        )
        .navigationDestination(
            isPresented: $showNewAttendeeView, destination: {
                AttendeeAddView(activity: activity)
            }
        )
    }
    
    func deleteAttendance(at offsets: IndexSet) {
        for index in offsets {
            let attendance = activity.attendanceArray[index]
            activityViewModel.removeAttendance(attendance: attendance)
        }
    }
}
