//
//  PersnalData+CoreDataProperties.swift
//  HealthSchedule
//
//  Created by KimWooJin on 2021/10/27.
//
//

import Foundation
import CoreData


extension PersnalData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PersnalData> {
        return NSFetchRequest<PersnalData>(entityName: "PersnalData")
    }
    @NSManaged public var name: String
    @NSManaged public var age: Int16
    @NSManaged public var height: Double
    @NSManaged public var weight: Double


}

extension PersnalData : Identifiable {

}
