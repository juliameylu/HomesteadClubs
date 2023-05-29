//
//  ActivitiesView.swift
//  HomesteadClubs
//
//  Created by Julia Lu on 5/4/23.
//

import SwiftUI

struct ActivityListView: View {
//    @ObservedObject var activityViewModel : ActivityViewModel
//    @ObservedObject var contactViewModel : ContactViewModel
    @EnvironmentObject var activityViewModel : ActivityViewModel
    @EnvironmentObject var contactViewModel : ContactViewModel
    
    @State var showActivityAddView: Bool = false
    
    let dateFormatter = DateFormatter()

//    init(activityViewModel: ActivityViewModel, contactViewModel: ContactViewModel) {
    init() {
        dateFormatter.dateFormat = "YY/MM/dd hh::mm"
    }
    
    var body: some View {
            ScrollView {
                ForEach(activityViewModel.activities, id: \.id) { activity in
                    NavigationLink {
                        ActivityDetailView(activity: activity, activityViewModel: activityViewModel, contactViewModel: contactViewModel)
                    } label: {
                        VStack(alignment: .leading) {
                            Text(activity.name ?? "")
                                .fontWeight(.semibold)
                                .font(.headline)
                            
                            Text(activity.notes ?? "")
                                .font(.subheadline)
                            
                            Text(dateFormatter.string(from: activity.beginDateTime ?? Date.now))
                                .font(.subheadline)
                            
                            Text(dateFormatter.string(from: activity.endDateTime ?? Date.now))
                                .font(.subheadline)
                            
                            Text(String(activity.creditHours))
                                .font(.subheadline)
                            
                            Text(String(activity.sponsor?.first_name ?? ""))
                                .font(.subheadline)
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
            .navigationTitle("Activites")
            .sheet(isPresented: $showActivityAddView) {
                ActivityAddView(activityViewModel: activityViewModel, contactViewModel: contactViewModel)
            }
            .navigationBarItems(trailing:
                Button (action: {
                    showActivityAddView.toggle()
                }) {
                    Image(systemName: "plus")
                }
            )
    } // body
    
//    func deleteActivity(at offsets: IndexSet) {
//        activityViewModel.delete(activity: <#T##Activity#>)
//    }
}

