//
//  PersonTileView.swift
//  HomesteadClubs
//
//  Created by Julia Lu on 4/26/23.
//

import SwiftUI

struct ContactDetailView: View {
    @EnvironmentObject var contactViewModel: ContactViewModel
    
    var contact: Contact
    
    @State private var isPresentingEditView = false
 
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Name")) {
                    HStack {
                        Image("contact")
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.gray, lineWidth: 2))
                        
                        Text(contact.first_name ?? "")
                            .font(.custom("Roboto-Bold", size: 20))
                            .foregroundColor(Color.black)
                        
                        Text(contact.middle_name ?? "")
                            .font(.custom("Roboto-Bold", size: 20))
                            .foregroundColor(Color.black)
                        
                        Text(contact.last_name ?? "")
                            .font(.custom("Roboto-Bold", size: 20))
                            .foregroundColor(Color.black)
                    } // VStack
                } // Section
                
                Section(header: Text("Email")) {
                    Text(contact.email ?? "")
                        .font(.custom("Roboto-Bold", size: 20))
                        .foregroundColor(Color.black)
                } // Section
                
                Section(header: Text("Phone")) {
                    Text(contact.phone ?? "")
                        .font(.custom("Roboto-Bold", size: 20))
                        .foregroundColor(Color.black)
                } // Section
            } // VStack
            .toolbar {
                Button("Edit", action: { isPresentingEditView = true })
            } // toolbar
            .sheet(isPresented: $isPresentingEditView) {
                ContactEditView(
                    contact: contact)
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

//struct ContactDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContactDetailView()
//    }
//}
