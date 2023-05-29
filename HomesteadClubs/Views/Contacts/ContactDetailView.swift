//
//  PersonTileView.swift
//  HomesteadClubs
//
//  Created by Julia Lu on 4/26/23.
//

import SwiftUI

struct ContactDetailView: View {
    @ObservedObject var contactViewModel: ContactViewModel
    
    var contact: Contact
    
    @State private var isPresentingEditView = false
 
    var body: some View {
        NavigationStack {
            VStack {
                Text(contact.first_name ?? "")
                    .font(.custom("Roboto-Bold", size: 20))
                    .foregroundColor(Color.black)
                
                Text(contact.middle_name ?? "")
                    .font(.custom("Roboto-Bold", size: 20))
                    .foregroundColor(Color.black)
                
                Text(contact.last_name ?? "")
                    .font(.custom("Roboto-Bold", size: 20))
                    .foregroundColor(Color.black)
                
                Text(contact.email ?? "")
                    .font(.custom("Roboto-Bold", size: 20))
                    .foregroundColor(Color.black)
            } // VStack
            .toolbar {
                Button("Edit", action: { isPresentingEditView = true })
            } // toolbar
            .sheet(isPresented: $isPresentingEditView) {
                ContactEditView(contactViewModel: contactViewModel, contact: contact)
                    .navigationTitle(contact.first_name ?? "")
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") {
                                isPresentingEditView = false
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Done") {
                                isPresentingEditView = false
                            }
                        }
                    } // toolbar
            } // sheet
        } // NavigationStack
    }
}
