//
//  HomesteadKeyAppViewModel.swift
//  HomesteadClubs
//
//  Created by Julia Lu on 4/23/23.
//

import Foundation
import CoreData

class ContactViewModel: ObservableObject {
    private let viewContext = PersistenceController.shared.viewContext
    @Published var contacts: [Contact] = []

    init() {
        fetchContacts()
    }

    func fetchContacts() {
        let request = NSFetchRequest<Contact>(entityName: "Contact")

        do {
            contacts = try viewContext.fetch(request)
        } catch {
            print("DEBUG: Some error occured while fetching")
        }
    }

    func addContact(firstName: String, middleName: String, lastName: String, email: String) {
        let contact = Contact(context: viewContext)
        
        contact.id = UUID()
        contact.first_name = firstName
        contact.middle_name = middleName
        contact.last_name = lastName
        contact.email = email

        save()
        fetchContacts()
    }

    func editContact(contact: Contact) {
        save()
        fetchContacts()
    }
    
    func save() {
        do {
            try viewContext.save()
        } catch {
            print("Error saving")
        }
    }
    
    func delete(contact: Contact) {
        viewContext.delete(contact)
        do {
            try viewContext.save()
        } catch {
            print("DEBUG: Some error occured while saving")
        }
    }
}
