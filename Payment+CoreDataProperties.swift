//
//  Payment+CoreDataProperties.swift
//  HomesteadClubs
//
//  Created by Julia Lu on 6/25/23.
//
//

import Foundation
import CoreData


extension Payment {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Payment> {
        return NSFetchRequest<Payment>(entityName: "Payment")
    }

    @NSManaged public var amount: NSDecimalNumber?
    @NSManaged public var type: String?
    @NSManaged public var date: Date?
    @NSManaged public var name: String?
    @NSManaged public var notes: String?
    @NSManaged public var financer: Contact?
    @NSManaged public var pays: Activity?

}

extension Payment : Identifiable {

}
