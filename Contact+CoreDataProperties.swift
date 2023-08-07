//
//  Contact+CoreDataProperties.swift
//  HomesteadClubs
//
//  Created by Julia Lu on 8/6/23.
//
//

import Foundation
import CoreData


extension Contact {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Contact> {
        return NSFetchRequest<Contact>(entityName: "Contact")
    }

    @NSManaged public var email: String?
    @NSManaged public var first_name: String?
    @NSManaged public var id: UUID?
    @NSManaged public var isMember: Bool
    @NSManaged public var last_name: String?
    @NSManaged public var middle_name: String?
    @NSManaged public var phone: String?
    @NSManaged public var attending: NSSet?
    @NSManaged public var finances: NSSet?
    @NSManaged public var membership: NSSet?
    @NSManaged public var sponsor: NSSet?
    
    public var membershipArray: [ActivityAttendance] {
        let attendanceSet = attending as? Set<ActivityAttendance> ?? []
        
        return attendanceSet.sorted {
            $0.attendedBy!.first_name! > $1.attendedBy!.first_name!
        }
    }
}

// MARK: Generated accessors for attending
extension Contact {

    @objc(addAttendingObject:)
    @NSManaged public func addToAttending(_ value: ActivityAttendance)

    @objc(removeAttendingObject:)
    @NSManaged public func removeFromAttending(_ value: ActivityAttendance)

    @objc(addAttending:)
    @NSManaged public func addToAttending(_ values: NSSet)

    @objc(removeAttending:)
    @NSManaged public func removeFromAttending(_ values: NSSet)

}

// MARK: Generated accessors for finances
extension Contact {

    @objc(addFinancesObject:)
    @NSManaged public func addToFinances(_ value: Payment)

    @objc(removeFinancesObject:)
    @NSManaged public func removeFromFinances(_ value: Payment)

    @objc(addFinances:)
    @NSManaged public func addToFinances(_ values: NSSet)

    @objc(removeFinances:)
    @NSManaged public func removeFromFinances(_ values: NSSet)

}

// MARK: Generated accessors for membership
extension Contact {

    @objc(addMembershipObject:)
    @NSManaged public func addToMembership(_ value: ClubMembership)

    @objc(removeMembershipObject:)
    @NSManaged public func removeFromMembership(_ value: ClubMembership)

    @objc(addMembership:)
    @NSManaged public func addToMembership(_ values: NSSet)

    @objc(removeMembership:)
    @NSManaged public func removeFromMembership(_ values: NSSet)

}

// MARK: Generated accessors for sponsor
extension Contact {

    @objc(addSponsorObject:)
    @NSManaged public func addToSponsor(_ value: Activity)

    @objc(removeSponsorObject:)
    @NSManaged public func removeFromSponsor(_ value: Activity)

    @objc(addSponsor:)
    @NSManaged public func addToSponsor(_ values: NSSet)

    @objc(removeSponsor:)
    @NSManaged public func removeFromSponsor(_ values: NSSet)

}

extension Contact : Identifiable {

}
