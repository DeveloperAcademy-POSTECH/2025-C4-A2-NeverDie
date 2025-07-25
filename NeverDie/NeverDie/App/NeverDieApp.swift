//
//  NeverDieApp.swift
//  NeverDie
//
//  Created by theo on 7/17/25.
//

import SwiftUI
import SwiftData

@main
struct NeverDieApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
            UserProfile.self,
            WalkingSession.self,
            LifeSpan.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            SegmentsContainerView()
        }
        .modelContainer(sharedModelContainer)
    }
}
