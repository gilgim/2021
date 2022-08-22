//
//  Persistence.swift
//  CoreDataPreprare
//
//  Created by KimWooJin on 2021/10/24.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for _ in 0..<10 {
            let newItem = Order(context: viewContext)
            newItem.status = "pending"
            newItem.id = UUID()
            newItem.tableNumber = "12"
            newItem.nuberOfSlice = 4
            newItem.pizzaType = "bulgogi pizza"
        }
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()
    /* ---------------------------------------------------------------------
     * container는 Persistance 파일의 핵심부분이다. 데이터를 부르고 저장하는데 핵심적인 기능을 한다.
     * viewContent를 허용하는 역할도 한다.
     * viewContent are created, fetched, updated, deleted, and saved back to the persistent store of the device where the app runs on.
    ----------------------------------------------------------------------- */
    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        //container의 초기화 NSPersistentContainer는 CoreData의 스택쌓는 클래스
        container = NSPersistentContainer(name: "CoreDataPreprare")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                Typical reasons for an error here include:
                * The parent directory does not exist, cannot be created, or disallows writing.
                * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                * The device is out of space.
                * The store could not be migrated to the current model version.
                Check the error message to determine what the actual problem was.
                */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
}
