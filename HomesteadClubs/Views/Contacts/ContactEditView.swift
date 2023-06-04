//
//  EditContactView.swift
//  HomesteadClubs
//
//  Created by Julia Lu on 5/5/23.
//

import SwiftUI

struct ContactEditView: View {
    @EnvironmentObject var contactViewModel: ContactViewModel
    @Environment (\.presentationMode) var presentationMode

    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var middleName: String = ""
    @State var email: String = ""
    @State var phone: String = ""

    @State var readyToNavigate = false

    var contact: Contact
    
    init(contact: Contact) {
        self.contact = contact
    }
    
    var body: some View {
        NavigationStack {
            VStack (spacing: 20) {
                Image("contact")
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.gray, lineWidth: 10))
                
                Text("Edit Contact")
                    .font(.headline)
                
                TextField("First Name", text: $firstName)
                    .padding(20)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                
                TextField("Middle Name or Initial", text: $middleName)
                    .padding(20)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                
                TextField("Last Name", text: $lastName)
                    .padding(20)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                
                TextField("Email", text: $email)
                    .padding(20)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                
                TextField("Phone", text: $phone)
                    .padding(20)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
            } // VStack
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(
                leading:
                    Button(action: { self.presentationMode.wrappedValue.dismiss() }) {
                        Text("Cancel")
                    },
                trailing:
                    Button(action: {
                        contact.first_name = firstName
                        contact.middle_name = middleName
                        contact.last_name = lastName
                        contact.email = email
                        contact.phone = phone
                        
                        contactViewModel.editContact(contact: contact)
                        
                        self.readyToNavigate = true
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Done")
                    }) // navigationBarItems
        } // NavigationStack
        // initialize state vars in onAppear because the EnvironmentObject is injected (created) after the view constructor
        .onAppear {
            self.firstName = contact.first_name ?? ""
            self.middleName = contact.middle_name ?? ""
            self.lastName = contact.last_name ?? ""
            self.email = contact.email ?? ""
            self.phone = contact.phone ?? ""
        }
    } // var body
}
