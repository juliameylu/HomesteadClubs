//
//  VolunteerListView.swift
//  HomesteadClubs
//
//  Created by Julia Lu on 5/20/23.
//

import SwiftUI

struct VolunteerListView: View {
    @EnvironmentObject var volunteerViewModel : VolunteerViewModel
    
    @State var showNewVolunteerView: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(volunteerViewModel.volunteers, id: \.id) { volunteer in
                    NavigationLink {
                        VolunteerActivitiesView(volunteer: volunteer)
                    } label: {
                        VStack(alignment: .leading) {
                            HStack {
                                Image("contact")
                                    .clipShape(Circle())
                                    .overlay(Circle().stroke(Color.gray, lineWidth: 2))
                                
                                Text(volunteer.contact.first_name ?? "")
                                
                                if let middleName = volunteer.contact.middle_name {
                                    Text(middleName)
                                }
                                
                                Text(volunteer.contact.last_name ?? "")
                            } //
                            
                            HStack {
                                Text("Hours:")
                                Text(String(volunteer.totalCreditHours))
                            }
                        } // VStack
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                        .padding(.bottom)
                    } // label, NavigationLink
                } // ForEach
            } // List
            .navigationTitle("Volunteer Hours")
        } // NavigationStack
        .onAppear {
            volunteerViewModel.fetchVolunteers()
        }
    }
}
