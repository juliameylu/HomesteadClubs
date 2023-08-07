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
        fetchPayments()
    }
    
    func fetchPayments() {
        let request = NSFetchRequest<Payment>(entityName: "Payment")

        do {
            payments = try viewContext.fetch(request)
            // Sort by most recent activities first
            payments = payments.sorted{ $0.date! > $1.date! }
            
        } catch {
            print("DEBUG: Some error occured while fetching")
        }
    }
    
    func editPayment(payment: Payment) {
        saveAndReinitialize()
    }
    
    func saveAndReinitialize() {
        save()
        fetchPayments()
    }
    
    func save() {
        do {
            try viewContext.save()
        } catch {
            print("Error saving")
        }
    }
    
    func addPayment(amount: NSDecimalNumber, type: String, date: Date, name: String, notes: String, financer: Contact?, pays: Activity?) {
        let payment = Payment(context: viewContext)
        
        payment.amount = amount
        payment.type = type
        payment.date = date
        payment.name = name
        payment.notes = notes
        payment.financer = financer
        payment.pays = pays
        
        save()
        fetchPayments()
    }
    
    func delete(payment: Payment) {
        viewContext.delete(payment)
        do {
            try viewContext.save()
        } catch {
            print("DEBUG: Some error occured while saving")
        }
    }
}
