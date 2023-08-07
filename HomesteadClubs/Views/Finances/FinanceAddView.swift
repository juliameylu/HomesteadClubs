//
//  ActivityEditView.swift
//  HomesteadClubs
//
//  Created by Julia Lu on 5/6/23.
//

import SwiftUI

struct FinanceAddView: View {
    @EnvironmentObject var activityViewModel: ActivityViewModel
    @EnvironmentObject var contactViewModel: ContactViewModel
    @EnvironmentObject var financeViewModel: FinanceViewModel
    
    @Environment (\.presentationMode) var presentationMode
    
    @State var notes: String = ""
    @State var amount: Decimal = 0.0
    @State var activity: Activity?
    @State var person: Contact?
    @State var presentDate = Date.now
    
    @State private var chosenFinanceType: FinanceType = .addition
    
    @State var readyToNavigate = false
    
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
                    
                    Text("Add Payment")
                        .font(.headline)
                }
                
                Form {
                    Section("Type") {
                        Picker("Type", selection: $chosenFinanceType) {
                            ForEach(FinanceType.allCases) { option in
                                Text(String(describing: option))
                            }
                        }
                        .pickerStyle(.menu)
                    }
                    
                    Section("Activity") {
                        Picker("Activity", selection: $activity) {
                            ForEach(activityViewModel.activities, id: \.self) { (activity: Activity) in
                                HStack {
                                    Text(activity.name ?? "")
                                        .tag(activity as Activity?)
                                }.tag(activity as Activity?)
                            }
                        }
                        .pickerStyle(.menu)
                    }
                    
                    Section("Amount") {
                        VStack {
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
//                    Section("Person") {
//                        Picker("Contact", selection: $person) {
//                            ForEach(contactViewModel.contacts, id: \.self) { (contact: Contact) in
//                                HStack {
//                                    Text(contact.first_name ?? "")
//                                        .tag(contact as Contact?)
//                                }.tag(contact as Contact?)
//                            }
//                        }
//                        .pickerStyle(.menu)
//                    }
                    
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
                        financeViewModel.addPayment(amount: amount as NSDecimalNumber, type: String(describing: chosenFinanceType), date: presentDate, name: activity?.name ?? "", notes: notes, financer: person, pays: activity)
                        self.readyToNavigate = true
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Done")
                    } // Button
            ) // navigationBarItems
        } // NavigationStack
        .onAppear {
            if !contactViewModel.contacts.isEmpty {
                self.person = contactViewModel.contacts[0]
            }
        }
    } // body
}

private enum FinanceType : CaseIterable, Identifiable {
    case deduction
    case addition
    
    var description: String {
        
        switch self {
        case .deduction:
            return "Deduction"
        case .addition:
            return "Addition"
        }
    }
    
    var id: Self { self }
}
