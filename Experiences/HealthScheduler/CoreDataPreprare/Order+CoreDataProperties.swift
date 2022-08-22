//
//  Order+CoreDataProperties.swift
//  CoreDataPreprare
//
//  Created by KimWooJin on 2021/10/24.
//
//

import Foundation
import CoreData


extension Order{

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Order> {
        return NSFetchRequest<Order>(entityName: "Order")
    }
    @NSManaged public var id: UUID?
    @NSManaged public var status: String
    var orderStatus : Status {
        set{
            status = newValue.rawValue
        }
        get{
            Status(rawValue: status) ?? .pending
        }
    }
    
    @NSManaged public var nuberOfSlice: Int16
    @NSManaged public var pizzaType: String?
    @NSManaged public var tableNumber: String?

}

extension Order : Identifiable {

}
enum Status : String {
    case pending = "Pending"
    case preparing = "Preparing"
    case completed = "Completed"
}
