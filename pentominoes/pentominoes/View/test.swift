//
//  test.swift
//  pentominoes
//
//  Created by Zak Young on 2/4/24.
//

import SwiftUI

struct test: View {
    @EnvironmentObject var gameManager: GameManager
    var body: some View {
        HStack{
            Spacer()
            PentominoView(outline: gameManager.pentominoPieces[11], color: Color.red)
            Spacer()
        }
    }
}

#Preview {
    test()
        .environmentObject(GameManager(rows: 14, columns: 14, frameSizeX: 500, frameSizeY: 500))
}
