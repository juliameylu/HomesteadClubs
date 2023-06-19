//
//  ActivityAttendance+CoreDataProperties.swift
//  HomesteadClubs
//
//  Created by Julia Lu on 6/18/23.
//
//

import Foundation
import CoreData


extension ActivityAttendance {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ActivityAttendance> {
        return NSFetchRequest<ActivityAttendance>(entityName: "ActivityAttendance")
    }

    @NSManaged public var attendedBy: Contact?
    @NSManaged public var attending: Activity?

}

extension ActivityAttendance : Identifiable {

}
