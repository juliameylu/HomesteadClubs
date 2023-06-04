//
//  Activity+CoreDataProperties.swift
//  HomesteadClubs
//
//  Created by Julia Lu on 6/3/23.
//
//

import Foundation
import CoreData


extension Activity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Activity> {
        return NSFetchRequest<Activity>(entityName: "Activity")
    }

    @NSManaged public var beginDateTime: Date?
    @NSManaged public var creditHours: Int16
    @NSManaged public var endDateTime: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var notes: String?
    @NSManaged public var attendances: NSSet?
    @NSManaged public var sponsor: Contact?
    
    public var attendanceArray: [ActivityAttendance] {
        let attendanceSet = attendances as? Set<ActivityAttendance> ?? []
        
        return attendanceSet.sorted {
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

extension Activity : Identifiable {

}
