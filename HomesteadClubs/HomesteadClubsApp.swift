//
//  HomesteadClubsApp.swift
//  HomesteadClubs
//
//  Created by Julia Lu on 4/26/23.
//–

import SwiftUI

@main
struct HomesteadClubsApp: App {
//    let persistenceController = PersistenceController.shared
    @StateObject var contactViewModel = ContactViewModel()
    @StateObject var activityViewModel = ActivityViewModel()
    @StateObject var volunteerViewModel = VolunteerViewModel()

    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(contactViewModel)
                .environmentObject(activityViewModel)
                .environmentObject(volunteerViewModel)
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

