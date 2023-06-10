//
//  ActivityViewModel.swift
//  HomesteadClubs
//
//  Created by Julia Lu on 4/23/23.
//

import Foundation

import CoreData

class ActivityViewModel: ObservableObject {
    private let viewContext = PersistenceController.shared.viewContext
    @Published var activities: [Activity] = []
    @Published var upcomingActivities: [Activity] = []

    init() {
        fetchActivities()
    }

    func fetchActivities() {
        let request = NSFetchRequest<Activity>(entityName: "Activity")

        do {
            activities = try viewContext.fetch(request)
            // Sort by most recent activities first
            activities = activities.sorted{ $0.beginDateTime! > $1.beginDateTime! }
            
            let now = NSDate.now
            // TODO: Fix optional
            upcomingActivities = activities.filter{ $0.endDateTime! >= now }.sorted{ $0.beginDateTime! < $1.beginDateTime! }
            
        } catch {
            print("DEBUG: Some error occured while fetching")
        }
    }
    
    func fetchNonMembers(contacts: [Contact], attendances: [ActivityAttendance]) -> [Contact] {
        let activityMembers = attendances.map { $0.attendedBy }
        return contacts.filter{ !activityMembers.contains($0) }
    }
    
    func addActivity(name: String, notes: String, beginDateTime: Date, endDateTime: Date, creditHours: Int16, sponsor: Contact) {
        let activity = Activity(context: viewContext)
        
        activity.id = UUID()
        activity.name = name
        activity.notes = notes
        activity.beginDateTime = beginDateTime
        activity.endDateTime = endDateTime
        activity.creditHours = creditHours
        activity.sponsor = sponsor
        
        saveAndReinitialize()
    }
    
    func addAttendance(contact: Contact, activity: Activity) {
        let attendance = ActivityAttendance(context: viewContext)
        attendance.attendedBy = contact
        attendance.attending = activity

        activity.addToAttendances(attendance)
        
        saveAndReinitialize()
    }

    func addAttendances(attendees: Set<Contact>, activity: Activity) {
        let attendances = Set(attendees.map {
            let attendance = ActivityAttendance(context: viewContext)
            attendance.attendedBy = $0
            attendance.attending = activity
            return attendance
        })

        activity.addToAttendances(attendances as NSSet)
        
        saveAndReinitialize()
    }

    func removeAttendance(attendance: ActivityAttendance) {
        attendance.attending!.removeFromAttendances(attendance)
        attendance.attendedBy!.removeFromAttending(attendance)
        
        saveAndReinitialize()
    }

    func editActivity(activity: Activity) {
        saveAndReinitialize()
    }
    
    func save() {
        do {
            try viewContext.save()
        } catch {
            print("Error saving")
        }
    }
    
    func delete(activity: Activity) {
        viewContext.delete(activity)
        do {
            try viewContext.save()
        } catch {
            print("DEBUG: Some error occured while saving")
        }
    }
    
    func saveAndReinitialize() {
        save()
        fetchActivities()
    }
    
    func computeCreditHours(beginDateTime: Date, endDateTime: Date) -> Int16 {
        let deltaTimeInterval = beginDateTime.distance(to: endDateTime)
        let deltaHours = (deltaTimeInterval / 3600).truncatingRemainder(dividingBy: 3600)
        return Int16(deltaHours)
    }
}
