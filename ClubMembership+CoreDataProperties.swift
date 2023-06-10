//
//  ClubMembership+CoreDataProperties.swift
//  HomesteadClubs
//
//  Created by Julia Lu on 6/10/23.
//
//

import Foundation
import CoreData


extension ClubMembership {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ClubMembership> {
        return NSFetchRequest<ClubMembership>(entityName: "ClubMembership")
    }

    @NSManaged public var joinDate: Date?
    @NSManaged public var leaveDate: Date?
    @NSManaged public var volunteerHours: Int32
    @NSManaged public var club: Club?
    @NSManaged public var member: Contact?

}

extension ClubMembership : Identifiable {

}
