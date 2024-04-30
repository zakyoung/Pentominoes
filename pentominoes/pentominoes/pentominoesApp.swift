//
//  pentominoesApp.swift
//  pentominoes
//
//  Created by Zak Young on 1/31/24.
//

import SwiftUI

@main
struct pentominoesApp: App {
    @StateObject var gameManager: GameManager = GameManager(rows: 14, columns: 14, frameSizeX: 560, frameSizeY: 560)
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(gameManager)
        }
    }
}
