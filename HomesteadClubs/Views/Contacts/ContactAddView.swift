//
//  NewContactView.swift
//  HomesteadClubs
//
//  Created by Julia Lu on 4/26/23.
//

import SwiftUI

struct ContactAddView: View {
    @ObservedObject var contactViewModel: ContactViewModel

//    @Environment(\.managedObjectContext) private var viewContext
    @Environment (\.presentationMode) var presentationMode

    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var middleName: String = ""
    @State var email: String = ""
    
    @State var readyToNavigate = false

    var body: some View {
        NavigationStack {
            VStack (spacing: 20) {
                
                Text("Add a New Contact:")
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
            } // VStack
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(
                leading:
                    Button(action: { self.presentationMode.wrappedValue.dismiss() }) {
                        Text("Cancel")
                    }, // Button
                trailing:
                    Button(action: {
                        contactViewModel.addContact(firstName: firstName, middleName: middleName, lastName: lastName, email: email)
                        self.readyToNavigate = true
                        self.presentationMode.wrappedValue.dismiss()
                        } // action
                          ) {
                              Text("Add")
                    } // Button
            ) // navigationBarItems
       } // NavigationStack
    } // body
}
