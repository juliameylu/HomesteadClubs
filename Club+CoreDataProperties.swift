//
//  Club+CoreDataProperties.swift
//  HomesteadClubs
//
//  Created by Julia Lu on 6/10/23.
//
//

import Foundation
import CoreData


extension Club {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Club> {
        return NSFetchRequest<Club>(entityName: "Club")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var members: NSSet?

}

// MARK: Generated accessors for members
extension Club {

    @objc(addMembersObject:)
    @NSManaged public func addToMembers(_ value: ClubMembership)

    @objc(removeMembersObject:)
    @NSManaged public func removeFromMembers(_ value: ClubMembership)

    @objc(addMembers:)
    @NSManaged public func addToMembers(_ values: NSSet)

    @objc(removeMembers:)
    @NSManaged public func removeFromMembers(_ values: NSSet)

}

extension Club : Identifiable {

}
