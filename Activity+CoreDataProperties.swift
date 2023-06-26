//
//  Activity+CoreDataProperties.swift
//  HomesteadClubs
//
//  Created by Julia Lu on 6/25/23.
//
//

import Foundation
import CoreData


extension Activity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Activity> {
        return NSFetchRequest<Activity>(entityName: "Activity")
    }

    @NSManaged public var beginDateTime: Date?
    @NSManaged public var city: String?
    @NSManaged public var creditHours: Float
    @NSManaged public var endDateTime: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var notes: String?
    @NSManaged public var state: String?
    @NSManaged public var street: String?
    @NSManaged public var zip: String?
    @NSManaged public var attendances: NSSet?
    @NSManaged public var sponsor: Contact?
    @NSManaged public var recieves: NSSet?
    
    public var attendanceArray: [ActivityAttendance] {
        let attendanceSet = attendances as? Set<ActivityAttendance> ?? []
        
        return attendanceSet
            .sorted {
            $0.attendedBy!.first_name! > $1.attendedBy!.first_name!
        }
    }
}

// MARK: Generated accessors for attendances
extension Activity {

    @objc(addAttendancesObject:)
    @NSManaged public func addToAttendances(_ value: ActivityAttendance)

    @objc(removeAttendancesObject:)
    @NSManaged public func removeFromAttendances(_ value: ActivityAttendance)

    @objc(addAttendances:)
    @NSManaged public func addToAttendances(_ values: NSSet)

    @objc(removeAttendances:)
    @NSManaged public func removeFromAttendances(_ values: NSSet)

}

// MARK: Generated accessors for recieves
extension Activity {

    @objc(addRecievesObject:)
    @NSManaged public func addToRecieves(_ value: Payment)

    @objc(removeRecievesObject:)
    @NSManaged public func removeFromRecieves(_ value: Payment)

    @objc(addRecieves:)
    @NSManaged public func addToRecieves(_ values: NSSet)

    @objc(removeRecieves:)
    @NSManaged public func removeFromRecieves(_ values: NSSet)

}

extension Activity : Identifiable {

}
