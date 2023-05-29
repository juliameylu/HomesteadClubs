//
//  HomesteadClubsApp.swift
//  HomesteadClubs
//
//  Created by Julia Lu on 4/26/23.
//

import SwiftUI

@main
struct HomesteadClubsApp: App {
//    let persistenceController = PersistenceController.shared
    @StateObject var contactViewModel = ContactViewModel()

    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(contactViewModel)
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
