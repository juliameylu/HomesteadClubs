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
    
    init(contact: Contact, activities: [Activity]) {
        self.contact = contact
        self.activities = activities
        self.id = contact.id!
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(contact)
    }
}
