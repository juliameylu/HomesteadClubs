//
//  Volunteer.swift
//  HomesteadClubs
//
//  Created by Julia Lu on 5/20/23.
//

import Foundation

struct Volunteer : Identifiable & Hashable {
    var contact: Contact
    var id: UUID
    var activities: [Activity]
    var totalCreditHours: Float
    
    init(contact: Contact, activities: [Activity]) {
        self.contact = contact
        self.activities = activities
        self.id = contact.id!
        self.totalCreditHours = activities.map{ $0.creditHours }.reduce(0, +)
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(contact)
    }
}
