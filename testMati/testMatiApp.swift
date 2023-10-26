//
//  testMatiApp.swift
//  testMati
//
//  Created by Anantachai Kulson on 12/10/2566 BE.
//

import SwiftUI

@main
struct testMatiApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            MatiView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
