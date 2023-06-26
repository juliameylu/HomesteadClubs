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
            
            Section("Person") {
                VStack(alignment: .leading) {
                    Text(payment.financer?.first_name ?? "")
                    Text(payment.financer?.last_name ?? "")
                }
            }
            
            Section("Amount") {
                VStack(alignment: .leading) {
                    Text(payment.amount ?? "")
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
            FinanceEditView(
                payment: payment)
                .navigationTitle(payment.financer.first_name ?? "")
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
