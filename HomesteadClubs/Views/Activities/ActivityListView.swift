//
//  ActivitiesView.swift
//  HomesteadClubs
//
//  Created by Julia Lu on 5/4/23.
//

import SwiftUI

struct ActivityListView: View {
    @EnvironmentObject var activityViewModel : ActivityViewModel
    @EnvironmentObject var contactViewModel : ContactViewModel
    
    @State private var showActivityAddView = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(activityViewModel.activities, id: \.id) { activity in
                    NavigationLink {
                        ActivityDetailView(activity: activity)
                    } label: {
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
                            } // Grid
                        } // VStack
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                        .padding(.bottom) // VStack
                    } // label, NavigationLink
                } // ForEach
                .onDelete(perform: deleteActivity)
            } // List
            .navigationTitle("All Activites")
            .sheet(isPresented: $showActivityAddView) {
                ActivityAddView()
            }
            .navigationBarItems(trailing:
                                    Button (action: {
                showActivityAddView.toggle()
            }) {
                Image(systemName: "plus")
            }
            )
        } // NavigationStack
    } // body
    
    func deleteActivity(at offsets: IndexSet) {
        for index in offsets {
            let activity = activityViewModel.activities[index]
            activityViewModel.delete(activity: activity)
            activityViewModel.fetchActivities()
        }
    }
}
