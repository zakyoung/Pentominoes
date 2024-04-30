//
//  PuzzleButtons.swift
//  pentominoes
//
//  Created by Zak Young on 2/4/24.
//

import SwiftUI

struct PuzzleButtons: View {
    @EnvironmentObject var gameManager: GameManager
    let boardNumberMax: Int
    var body: some View {
        VStack{
            ForEach(boardNumberMax-4..<boardNumberMax, id:\.self){val in
                PuzzleButton(imageName: "Board\(val)", buttonAction: {gameManager.updateCurrentPuzzle(eVal: val)})
                    .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/,height: 100)
            }
        }
    }
}

#Preview {
    PuzzleButtons(boardNumberMax: 4)
}
