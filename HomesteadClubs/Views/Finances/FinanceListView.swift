//
//  VolunteerListView.swift
//  HomesteadClubs
//
//  Created by Julia Lu on 5/20/23.
//

import SwiftUI

struct FinanceListView: View {
    @EnvironmentObject var financeViewModel : FinanceViewModel
    
    @State var showFinanceAddView: Bool = false
    
    let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
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
                                Image("finance")
                                    .clipShape(Circle())
                                    .overlay(Circle().stroke(Color.gray, lineWidth: 2))
                                Text(payment.date ?? Date.now, style: .date)
                            }
                            HStack {
                                Text(payment.financer?.first_name ?? "")

                                if let middleName = payment.financer?.middle_name {
                                    Text(middleName)
                                }

                                Text(payment.financer?.last_name ?? "")
                            }
                            HStack {
                                Text("Amount:")
                                Text("\((payment.amount ?? 0.0) as NSDecimalNumber, formatter: numberFormatter)")
                            }
                        } // VStack
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                        .padding(.bottom)
                    } // label, NavigationLink
                } // ForEach
                .onDelete(perform: deletePayments)
            } // List
            .navigationTitle("Finances")
            .sheet(isPresented: $showFinanceAddView) {
                FinanceAddView()
            }
            .navigationBarItems(trailing:
                                    Button (action: {
                showFinanceAddView.toggle()
            }) {
                Image(systemName: "plus")
            }
            )
        } // NavigationStack
    }
    
    func deletePayments(at offsets: IndexSet) {
        for index in offsets {
            let payment = financeViewModel.payments[index]
            financeViewModel.delete(payment: payment)
            financeViewModel.fetchPayments()
        }
    }
}
