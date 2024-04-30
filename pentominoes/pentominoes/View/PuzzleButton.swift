//
//  PuzzleButton.swift
//  pentominoes
//
//  Created by Zak Young on 2/4/24.
//

import SwiftUI

struct PuzzleButton: View {
    let imageName: String
    let buttonAction: () -> Void
    var body: some View {
        Button(action: buttonAction){
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
    }
}

#Preview {
    PuzzleButton(imageName: "Board0", buttonAction: {})
}
