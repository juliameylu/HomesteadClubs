//
//  MainView.swift
//  HomesteadClubs
//
//  Created by Julia Lu on 5/28/23.
//

import SwiftUI
import CoreData

struct MainView: View {
    var body: some View {
        TabView {
            ContentView()
                .tabItem {
                    Label("Home", systemImage: "list.dash")
                }
            ContactListView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Contacts")
            }
            ActivityListView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Activities")
            }
            VolunteerListView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Hours")
            }
            FinanceListView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Finances")
            }
        } // TabView
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
//        MainView()
//            .preferredColorScheme(.dark)
        MainView()
            .preferredColorScheme(.light)
            .environmentObject(ActivityViewModel())
            .environmentObject(ContactViewModel())
            .environmentObject(VolunteerViewModel())
    }
}
