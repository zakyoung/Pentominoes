//
//  gridWithPieces.swift
//  pentominoes
//
//  Created by Zak Young on 2/4/24.
//

import SwiftUI

struct gridWithPieces: View {
    @EnvironmentObject var gameManager: GameManager
    var body: some View {
                ZStack(alignment: .topLeading) {
                    gridWOverlay()
                    ForEach(Array(gameManager.finalPieces), id: \.key) { key, piece in
                        PieceView(pieceName: key)
                            .opacity(gameManager.checkIfCorrectPosition(pieceName: key) ? 0.7 : 1)
                    }
                }
    }
}
#Preview {
    gridWithPieces()
        .environmentObject(GameManager(rows: 14, columns: 14, frameSizeX: 560, frameSizeY: 560))
}
