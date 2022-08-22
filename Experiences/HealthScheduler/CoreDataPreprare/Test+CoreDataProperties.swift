//
//  Test+CoreDataProperties.swift
//  CoreDataPreprare
//
//  Created by KimWooJin on 2021/11/06.
//
//

import Foundation
import CoreData


extension Test {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Test> {
        return NSFetchRequest<Test>(entityName: "Test")
    }

    @NSManaged public var stringA: String?
    @NSManaged public var intA: Int16
    @NSManaged public var doubleA: Double

}

extension Test : Identifiable {

}
