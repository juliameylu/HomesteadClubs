//
//  VolunteerListView.swift
//  HomesteadClubs
//
//  Created by Julia Lu on 5/20/23.
//

import SwiftUI

struct FinanceListView: View {
    @EnvironmentObject var financeViewModel : FinanceViewModel
    
    @State var showNewFinanceView: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(financeViewModel.payments, id: \.id) { payment in
                    NavigationLink {
                        FinanceDetailView(payment: payment)
                    } label: {
                        VStack(alignment: .leading) {
                            HStack {
                                Text(payment.type ?? "")
                            }
                            HStack {
                                Image("contact")
                                    .clipShape(Circle())
                                    .overlay(Circle().stroke(Color.gray, lineWidth: 2))
                                
                                Text(payment.financer.first_name ?? "")
                                
                                if let middleName = payment.financer.middle_name {
                                    Text(middleName)
                                }
                                
                                Text(payment.financer.last_name ?? "")
                            }
                            HStack {
                                Text("Amount:")
                                Text(String(payment.amount))
                            }
                        } // VStack
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                        .padding(.bottom)
                    } // label, NavigationLink
                } // ForEach
            } // List
            .navigationTitle("Finances")
        } // NavigationStack
        .onAppear {
            financeViewModel.fetchFinances()
        }
    }
}
