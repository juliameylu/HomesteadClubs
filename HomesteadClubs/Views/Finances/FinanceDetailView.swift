//
//  ActivityDetailView.swift
//  HomesteadClubs
//
//  Created by Julia Lu on 5/6/23.
//

import SwiftUI

struct FinanceDetailView: View {
    @EnvironmentObject var activityViewModel: ActivityViewModel
    @EnvironmentObject var contactViewModel: ContactViewModel
    @EnvironmentObject var locationManager: LocationManager
    
    @State private var isPresentingEditView = false
    
    var payment: Payment
    
    let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    var body: some View {
        Form {
            Section(header: Text("Type")) {
                VStack(alignment: .leading) {
                    HStack {
                        Image("activity")
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.gray, lineWidth: 2))
                        
                        Text(payment.type ?? "")
                            .fontWeight(.semibold)
                            .font(.headline)
                    }
                    
                } // VStack
            } // Section
            
            Section(header: Text("Activity")) {
                VStack(alignment: .leading) {
                    HStack {
                        Image("activity")
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.gray, lineWidth: 2))
                        
                        Text(payment.name ?? "")
                            .fontWeight(.semibold)
                            .font(.headline)
                    }
                } // VStack
            } // Section
            
            Section("Amount") {
                VStack(alignment: .leading) {
                    Text("\((payment.amount ?? 0.0) as NSDecimalNumber, formatter: numberFormatter)")
                }
            }
            
            Section("Person") {
                VStack(alignment: .leading) {
                    Text(payment.financer?.first_name ?? "")
                    Text(payment.financer?.last_name ?? "")
                }
            }
            
            //Date
            Section("Date") {
                VStack(alignment: .leading) {
                    Text(payment.date ?? Date.now, style: .date)
                }
            }
            
            Section(header: Text("Notes")) {
                ScrollView {
                    VStack {
                        Text(payment.notes ?? "")
                            .lineLimit(nil)
                    }.frame(maxWidth: .infinity, alignment: .leading)
                }
            } // Notes
        } // Form
        .toolbar {
            Button("Edit", action: { isPresentingEditView = true })
        } // toolbar
        .sheet(isPresented: $isPresentingEditView) {
            FinanceEditView(payment: payment)
            .navigationTitle(payment.name ?? "")
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
