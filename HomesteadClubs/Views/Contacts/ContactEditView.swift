//
//  EditContactView.swift
//  HomesteadClubs
//
//  Created by Julia Lu on 5/5/23.
//

import SwiftUI

struct ContactEditView: View {
    @ObservedObject var contactViewModel: ContactViewModel
    
    var contact: Contact
    
    @Environment (\.presentationMode) var presentationMode

    @State var firstName: String
    @State var lastName: String
    @State var middleName: String
    @State var email: String
    
    init(contactViewModel: ContactViewModel, contact: Contact) {
        self.contactViewModel = contactViewModel
        self.contact = contact
        
        _firstName = State(initialValue: contact.first_name ?? "")
        _middleName = State(initialValue: contact.middle_name ?? "")
        _lastName = State(initialValue: contact.last_name ?? "")
        _email = State(initialValue: contact.email ?? "")
    }
    
    @State var readyToNavigate = false

    var body: some View {

        NavigationStack {
        VStack (spacing: 20) {
            
            Text("Edit Contact:")
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
                        
        }
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
                    
                    contactViewModel.editContact(contact: contact)
                    self.readyToNavigate = true
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Done")
        })
//        .navigationDestination(isPresented: $readyToNavigate) {
//           ContactListView(contactViewModel: contactViewModel)
        
                
//          Button {
              //Code here before changing the bool value
              //                    viewModel.addContact(firstName: name, lastName: name, middleName: name)
              //                guard self.name != "" else {
              //                    return
              //                }
              //                let newPerson = Contact(context: viewContext)
              //                newPerson.name = self.name
              //                newPerson.id = UUID()
              //                do {
              //                    try viewContext.save()
              //                    presentationMode.wrappedValue.dismiss()
              //                } catch {
              //                    print(error.localizedDescription)
              //                }
//                      readyToNavigate = true
//                  } label: {
//                      Text("Save")
//                  }
//           .navigationDestination(isPresented: $readyToNavigate) {
//               ContactListView()
//          }
       }
//        }
//        .padding()
    
    }
}
