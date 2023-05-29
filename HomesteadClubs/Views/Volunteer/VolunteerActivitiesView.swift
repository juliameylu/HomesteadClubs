//
//  VolunteerDetailView.swift
//  HomesteadClubs
//
//  Created by Julia Lu on 5/20/23.
//

import SwiftUI

struct VolunteerActivitiesView: View {
    @ObservedObject var volunteerViewModel: VolunteerViewModel
    
    var volunteer: Volunteer
    
    @State private var isPresentingEditView = false
 
    var body: some View {
            ScrollView {
                ForEach(volunteer.activities, id: \.id) { activity in
                    VStack(alignment: .leading) {
                        Text(activity.name ?? "")
                            .fontWeight(.semibold)
                            .font(.headline)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.bottom)
                } // ForEach
            }
            .navigationTitle("Activities")
    }}

