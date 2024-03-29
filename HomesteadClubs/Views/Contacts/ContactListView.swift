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
            List {
                ForEach(contactViewModel.contacts, id: \.id) { contact in
                    NavigationLink {
                        ContactDetailView(contact: contact)
                    } label: {
                        HStack {
                            Image("contact")
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.gray, lineWidth: 2))
                            
                            Text(contact.first_name ?? "")
                            
                            if let middleName = contact.middle_name {
                                Text(middleName)
                            }
                            
                            Text(contact.last_name ?? "")
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                        .padding(.bottom)
                    } // label, NavigationLink
                } // ForEach
                .onDelete(perform: deleteContacts)
            } // List
            .navigationTitle("Club Contacts")
            .sheet(isPresented: $showNewContactView) {
                ContactAddView()
            }
            .navigationBarItems(trailing:
                                    Button (action: {
                showNewContactView.toggle()
            }) {
                Image(systemName: "plus")
            }
            ) // navigationBarItems, List
        } // NavigationStack
    }
    
    func deleteContacts(at offsets: IndexSet) {
        for index in offsets {
            let contact = contactViewModel.contacts[index]
            contactViewModel.delete(contact: contact)
            contactViewModel.fetchContacts()
        }
    }
}
