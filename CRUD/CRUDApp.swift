//
//  CRUDApp.swift
//  CRUD
//
//  Created by 寒河江功悟 on 2023/05/11.
//

import SwiftUI

@main
struct CRUDApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
