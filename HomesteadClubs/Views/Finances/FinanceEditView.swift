//
//  ActivityEditView.swift
//  HomesteadClubs
//
//  Created by Julia Lu on 5/6/23.
//

import SwiftUI

struct FinanceEditView: View {
    @EnvironmentObject var activityViewModel: ActivityViewModel
    @EnvironmentObject var contactViewModel: ContactViewModel
    @EnvironmentObject var financeViewModel: FinanceViewModel
    
    @Environment (\.presentationMode) var presentationMode

    @State var notes: String
    @State var amount: Decimal
    @State var activity: Activity
    
    @State private var selectedFinanceType: FinanceType = .addition
    
    @State var readyToNavigate = false
    
    var payment: Payment
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Image("payment")
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.gray, lineWidth: 2))
                    
                    Text("Edit Payment")
                        .font(.headline)
                }
                
                Form {
//                    Section("Type") {
//                        Picker("Type", selection: $selectedFinanceType) {
//                            // 1
//                                ForEach(FinanceType.allCases) { option in
//                                    // 2
//                                    Text(String(describing: option))
//                                }
//                        }
//                        .pickerStyle(.menu)
                 //   }
                    //change
//                    Section("Activity") {
//                        Picker("Activity", selection: $activity) {
//                            ForEach(activityViewModel.contacts, id: \.self) { (contact: Contact) in
//                                HStack {
//                                    Text(contact.first_name!)
//                                    Text(contact.last_name!)
//                                    // .tag(contact as Contact?)
//                                }.tag(contact as Contact?)
//                            }
//                        }
//                        .pickerStyle(.menu)
//                    }
                    
//                    Section("Amount") {
//                        VStack {
//                            TextField("Amount", text: $amount)
//                        }
//                    }
                    
                    Section("Other") {
                        TextField("Notes", text: $notes, axis: .vertical)
                            .padding(20)
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                    } // Section
                } // Form
            } // VStack
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(
                leading:
                    Button(action: { self.presentationMode.wrappedValue.dismiss() }) {
                        Text("Cancel")
                    },
                trailing:
                    Button(action: {
                        payment.type = "\(selectedFinanceType)"
                        payment.pays = activity
                        payment.amount = amount
                        payment.notes = notes
                    
                        financeViewModel.editPayment(payment: payment)
                        self.readyToNavigate = true
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Done")
                    } // Button
                    //.disabled(type.isEmpty)
            ) // navigationBarItems
       } // NavigationStack
    } // body
}

enum FinanceType : String {
    case deduction
    case addition
}
