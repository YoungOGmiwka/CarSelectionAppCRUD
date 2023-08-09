//
//  CarSelectionAppCRUDApp.swift
//  CarSelectionAppCRUD
//
//  Created by Михаил on 09.08.2023.
//

import SwiftUI

@main
struct CarSelectionAppCRUDApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
