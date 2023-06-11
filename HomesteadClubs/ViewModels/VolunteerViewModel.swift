//
//  VolunteerViewModel.swift
//  HomesteadClubs
//
//  Created by Julia Lu on 5/20/23.
//

import Foundation
import CoreData

class VolunteerViewModel: ObservableObject {
    private let viewContext = PersistenceController.shared.viewContext
    @Published var volunteers: [Volunteer] = []
    
    init() {
        fetchVolunteers()
    }
    
    func fetchVolunteers() {
        let request = NSFetchRequest<Activity>(entityName: "Activity")
        
        do {
            var volunteerDict: Dictionary<Contact, Array<Activity>> = [:]
            
            do {
                let activities = try viewContext.fetch(request)
                activities.forEach {
                    let activity = $0
                    activity.attendanceArray.forEach {
                        let attendance = $0
                        
                        if let attendee = attendance.attendedBy, let attending = attendance.attending {
                            if (attendee.isMember) {
                                volunteerDict[attendee, default: []].append(attending)
                            }
                        }
                    } // forEach attendanceArray
                } // forEach activities
                
                volunteers = volunteerDict
                    .map{ Volunteer(contact: $0, activities: $1) }
                    .sorted{
                        $0.contact.first_name ?? "" <=  $1.contact.first_name ?? ""
                        || $0.contact.last_name ?? "" <= $1.contact.last_name ?? ""}
            } catch {
                print("DEBUG: Some error occured while fetching")
            }
        }
    }
}
