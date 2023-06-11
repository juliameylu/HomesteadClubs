//
//  VolunteerDetailView.swift
//  HomesteadClubs
//
//  Created by Julia Lu on 5/20/23.
//

import SwiftUI

struct VolunteerActivitiesView: View {
    @EnvironmentObject var volunteerViewModel: VolunteerViewModel
    
    var volunteer: Volunteer
    
    @State private var isPresentingEditView = false
 
    var body: some View {
            List {
                ForEach(volunteer.activities, id: \.id) { activity in
                    VStack(alignment: .leading) {
                        HStack {
                            Image("activity")
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.gray, lineWidth: 2))

                            Text(activity.name ?? "")
                                .fontWeight(.semibold)
                                .font(.headline)
                        } // HStack
                        
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
                        } // Grid
                    } // VStack
                } // ForEach
            }
            .navigationTitle("Activities")
    }}

