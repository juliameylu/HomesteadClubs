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
    
    @State var showActivityAddView: Bool = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                ForEach(activityViewModel.activities, id: \.id) { activity in
                    NavigationLink {
                        ActivityDetailView(activity: activity)
                    } label: {
                        VStack(alignment: .leading) {
                            HStack {
                                Image("park")
                                    .clipShape(Circle())
                                    .overlay(Circle().stroke(Color.gray, lineWidth: 2))

                                Text(activity.name ?? "")
                                    .fontWeight(.semibold)
                                    .font(.headline)
                            }
                            
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
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                        .padding(.bottom)
                    } // label
                    .contextMenu {
                        Button(role: .destructive, action: {
                            activityViewModel.delete(activity: activity)
                            activityViewModel.fetchActivities()
                        }) {
                            Text("Delete")
                        } // Button
                    } // contextMenu
                } // ForEach
                //                .onDelete(perform: deleteActivity)
            } // ScrollView
            .navigationTitle("All Activites")
            .sheet(isPresented: $showActivityAddView) {
                ActivityAddView(
//                    activityViewModel: activityViewModel, contactViewModel: contactViewModel
                )
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
}
