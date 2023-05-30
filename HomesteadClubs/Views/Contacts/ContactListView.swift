//
//  NewContactView.swift
//  HomesteadClubs
//
//  Created by Julia Lu on 4/26/23.
//

import SwiftUI

struct ContactListView: View {
    @EnvironmentObject var contactViewModel : ContactViewModel
    
    @State var showNewContactView: Bool = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                ForEach(contactViewModel.contacts, id: \.id) { contact in
                    NavigationLink {
                        ContactDetailView(contactViewModel: contactViewModel, contact: contact)
                    } label: {
//                        VStack(alignment: .leading) {
                        HStack {
                            Image("contact")
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.gray, lineWidth: 2))
                            Text(contact.first_name ?? "")
                                .fontWeight(.semibold)
                                .font(.headline)
                            Text(contact.last_name ?? "")
                                .font(.subheadline)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                        .padding(.bottom)
                    }
                    .contextMenu {
                        Button(role: .destructive, action: {
                            contactViewModel.delete(contact: contact)
                            contactViewModel.fetchContacts()
                        }) {
                            Text("Delete")
                        }
                    }
                }
            }
            .navigationTitle("My Contacts")
            .sheet(isPresented: $showNewContactView) {
                ContactAddView(contactViewModel: contactViewModel)
            }
            .navigationBarItems(trailing:
                                    Button (action: {
                showNewContactView.toggle()
            }) {
                Image(systemName: "plus")
            }
            )
        } // NavigationStack
    }
}
