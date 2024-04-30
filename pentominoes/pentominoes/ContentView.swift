//
//  ContentView.swift
//  pentominoes
//
//  Created by Zak Young on 1/31/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var gameManager: GameManager
    var body: some View {
        ZStack{
            Color(red: 215/255, green: 186/255, blue: 156/255)
                .ignoresSafeArea(edges:.all)
            VStack{
                HStack{
                    PuzzleButtons(boardNumberMax: 4)
                    gridWithPieces()
                        .frame(width: 560, height: 560)
                    PuzzleButtons(boardNumberMax: 8)
                }
                HStack {
                    gameButtons(text: "Reset", fun: {withAnimation(.smooth()){gameManager.reset()}},color: Color.red)
                        Spacer()
                    gameButtons(text: "Solve", fun: {withAnimation(.smooth()) {gameManager.solveThatThang()}}, color:gameManager.currentPuzzle != .noPuzzle ? Color.red : Color.gray)
                        .disabled(gameManager.currentPuzzle == .noPuzzle)
                    }
                    .frame(width: 750)

                Spacer()
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(GameManager(rows: 14, columns: 14, frameSizeX: 560, frameSizeY: 560))
}
