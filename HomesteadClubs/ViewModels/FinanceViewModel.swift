//
//  FinanceViewModel.swift
//  HomesteadClubs
//
//  Created by Julia Lu on 6/25/23.
//

import Foundation
import CoreData

class FinanceViewModel: ObservableObject {
    private let viewContext = PersistenceController.shared.viewContext
    @Published var payments: [Payment] = []
    
    init() {
        fetchFinances()
    }
    
    func fetchFinances() {
        let request = NSFetchRequest<Payment>(entityName: "Payment")

        do {
            payments = try viewContext.fetch(request)
            // Sort by most recent activities first
            payments = payments.sorted{ $0.date! > $1.date! }
            
        } catch {
            print("DEBUG: Some error occured while fetching")
        }
    }
}
