//
//  CoreDataPreprareApp.swift
//  CoreDataPreprare
//
//  Created by KimWooJin on 2021/10/24.
//

import SwiftUI

@main
struct CoreDataPreprareApp: App {
    /*
     --------------------------------------------
     persitenceController는 Persistence에서 할당한다.
     .environment가 하는 것 
     --------------------------------------------
     */
    
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
