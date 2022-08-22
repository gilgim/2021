//
//  HealthScheduleApp.swift
//  HealthSchedule
//
//  Created by KimWooJin on 2021/10/24.
//

import SwiftUI

@main
struct HealthScheduleApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
