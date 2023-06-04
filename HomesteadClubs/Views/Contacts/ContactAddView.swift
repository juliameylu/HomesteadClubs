//
//  NewContactView.swift
//  HomesteadClubs
//
//  Created by Julia Lu on 4/26/23.
//

import SwiftUI

struct ContactAddView: View {
    @EnvironmentObject var contactViewModel: ContactViewModel

    @Environment (\.presentationMode) var presentationMode

    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var middleName: String = ""
    @State var email: String = ""
    @State var phone: String = ""
    
    @State var readyToNavigate = false

    var body: some View {
        NavigationStack {
            VStack (spacing: 20) {
                Text("Add New Contact")
                    .font(.headline)
                Image("contact")
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.gray, lineWidth: 2))
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
                    }, // Button
                trailing:
                    Button(action: {
                        contactViewModel.addContact(firstName: firstName, middleName: middleName, lastName: lastName, email: email, phone: phone)
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
