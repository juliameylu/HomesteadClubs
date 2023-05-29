//
//  VolunteerListView.swift
//  HomesteadClubs
//
//  Created by Julia Lu on 5/20/23.
//

import SwiftUI

struct VolunteerListView: View {
    @ObservedObject var volunteerViewModel : VolunteerViewModel
    
    @State var showNewVolunteerView: Bool = false
    
    var body: some View {
            ScrollView {
                ForEach(volunteerViewModel.volunteers, id: \.id) { volunteer in
                    NavigationLink {
                        VolunteerActivitiesView(volunteerViewModel: volunteerViewModel, volunteer: volunteer)
                    } label: {
                        VStack(alignment: .leading) {
                            Text(volunteer.contact.first_name ?? "")
                                .fontWeight(.semibold)
                                .font(.headline)
                            Text(volunteer.contact.last_name ?? "")
                                .font(.subheadline)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                        .padding(.bottom)
                    }
                }
            }
            .navigationTitle("My Volunteers")
//            .sheet(isPresented: $showNewVolunteerView) {
//                VolunteerAddView(contactViewModel: contactViewModel)
//            }
//            .navigationBarItems(trailing:
//                Button (action: {
//                    showNewVolunteerView.toggle()
//                }) {
//                    Image(systemName: "plus")
//                }
//            )
    }
}
