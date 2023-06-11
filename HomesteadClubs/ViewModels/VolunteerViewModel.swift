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
                        volunteerDict[attendance.attendedBy!, default: []].append($0.attending!)
                    } // forEach
                } // forEach
                
                volunteers = volunteerDict.map{ Volunteer(contact: $0, activities: $1) }
            } catch {
                print("DEBUG: Some error occured while fetching")
            }
        }
    }
}
