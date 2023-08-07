//
//  HomesteadClubsApp.swift
//  HomesteadClubs
//
//  Created by Julia Lu on 4/26/23.
//–

import SwiftUI

@main
struct HomesteadClubsApp: App {
    @StateObject var contactViewModel = ContactViewModel()
    @StateObject var activityViewModel = ActivityViewModel()
    @StateObject var volunteerViewModel = VolunteerViewModel()
    @StateObject var locationManager = LocationManager()
    @StateObject var financeViewModel = FinanceViewModel()

    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(contactViewModel)
                .environmentObject(activityViewModel)
                .environmentObject(volunteerViewModel)
                .environmentObject(locationManager)
                .environmentObject(financeViewModel)
        }
    }
}

