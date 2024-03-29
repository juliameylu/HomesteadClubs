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
    
    @State var notes: String = ""
    @State var amount: Decimal = 0.0
    @State var activity: Activity?
    @State var person: Contact?
    @State var presentDate = Date.now
    
    @State private var selectedFinanceType: FinanceType = .addition
    
    @State var readyToNavigate = false
    
    var payment: Payment
    
    let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Image("finance")
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.gray, lineWidth: 2))
                    
                    Text("Edit Payment")
                        .font(.headline)
                }
                
                Form {
                    Section("Type") {
                        Picker("Type", selection: $selectedFinanceType) {
                            ForEach(FinanceType.allCases) { option in
                                Text(String(describing: option))
                            }
                        }
                        .pickerStyle(.menu)
                    }
                    
                    Section("Activity") {
                        Picker("Activity", selection: $activity) {
                            ForEach(activityViewModel.activities, id: \.self) { (activity: Activity) in
                                Text(activity.name ?? "")
                                    .tag(activity as Activity?)
                            }
                        }
                        .pickerStyle(.menu)
                    }
                    
                    Section("Amount") {
                        VStack {
//                            TextField("Amount", value: $amount, formatter: numberFormatter)
//                            Text("\((amount) as NSDecimalNumber, formatter: numberFormatter)")
                            TextField("Amount", value: $amount, format: .currency(code: "USD"))
                                .onChange(of: amount) { newValue in
                                    print ("value is \(newValue)")
                                }
                        }
                    }
                    
                    Section("Person") {
                        Picker("Contact", selection: $person) {
                            ForEach(contactViewModel.contacts, id: \.self) { (contact: Contact) in
                                Text(contact.first_name ?? "")
                                    .tag(contact as Contact?)
                            }
                        }
                        .pickerStyle(.menu)
                    }
                    
                    Section("Date") {
                        DatePicker("Date", selection: $presentDate, displayedComponents: [.date])
                    }
                    
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
                        payment.amount = amount as NSDecimalNumber
                        payment.notes = notes
                        payment.financer = person
                        payment.name = activity?.name
                        payment.date = presentDate
                        
                        financeViewModel.editPayment(payment: payment)
                        self.readyToNavigate = true
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Done")
                    } // Button
            ) // navigationBarItems
        } // NavigationStack
        .onAppear {
            if (payment.type == nil) {
                self.selectedFinanceType = FinanceType.deduction
            } else {
                self.selectedFinanceType =
                FinanceType(rawValue: payment.type!) ?? FinanceType.deduction
            }
            
            if payment.pays == nil && !activityViewModel.activities.isEmpty {
                self.activity = activityViewModel.activities[0]
            } else {
                self.activity = payment.pays
            }
            
            if (payment.amount == nil) {
                self.amount = 0.0
            } else {
                self.amount = payment.amount! as Decimal
            }
            
            self.notes = payment.notes ?? ""
            
            if payment.financer == nil && !contactViewModel.contacts.isEmpty {
                self.person = contactViewModel.contacts[0]
            } else {
                self.person = payment.financer
            }
            
            self.presentDate = payment.date ?? Date.now
        }
    } // body
}

private enum FinanceType : String, CaseIterable, Identifiable {
    case deduction
    case addition
    
    var id: Self { self }
}
