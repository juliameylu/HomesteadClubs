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
    
    @State private var isShowAttendeesView = false
    @State private var isShowEditView = false
    
    var activity: Activity
    
    var body: some View {
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
                HStack {
                    Text(activity.sponsor?.first_name ?? "")
                    
                    Text(activity.sponsor?.last_name ?? "")
                }
            } // Section
            
            Section(header: Text("Notes")) {
                ScrollView {
                    VStack {
                        Text(activity.notes ?? "")
                            .lineLimit(nil)
                    }.frame(maxWidth: .infinity)
                }
            } // Notes
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
    } // body
}
