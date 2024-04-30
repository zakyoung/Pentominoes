//
//  gridWOverlay.swift
//  pentominoes
//
//  Created by Zak Young on 2/4/24.
//

import SwiftUI

struct gridWOverlay: View {
    @EnvironmentObject var gameManager: GameManager
    var body: some View {
        ZStack{
            Grid(n:gameManager.boardInfo.rows,m:gameManager.boardInfo.columns)
                .stroke(lineWidth: 2)
                .background(Color.white)
                .frame(width: gameManager.boardInfo.frameSizeX, height: gameManager.boardInfo.frameSizeY)
            Puzzle(puzzOutline: gameManager.puzzleOutlines[gameManager.currentPuzzle.rawValue],xFactor: gameManager.factor, yFactor: gameManager.factor)
                .stroke(Color.black, lineWidth: 2)
                .fill(Color(red: 0.25, green: 0.25, blue: 0.25).opacity(0.5), style: FillStyle(eoFill: true))
                .frame(width: CGFloat(gameManager.puzzleOutlines[gameManager.currentPuzzle.rawValue].size.width*40), height: CGFloat(gameManager.puzzleOutlines[gameManager.currentPuzzle.rawValue].size.height)*40)
        }
        .clipped()
    }
}
#Preview {
    gridWOverlay()
        .environmentObject(GameManager(rows: 14, columns: 14, frameSizeX: 560, frameSizeY: 560))
}
