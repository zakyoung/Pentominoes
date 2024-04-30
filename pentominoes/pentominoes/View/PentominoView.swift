//
//  PentominoView.swift
//  pentominoes
//
//  Created by Zak Young on 2/4/24.
//

import SwiftUI

struct PentominoView: View {
    var outline: PentominoOutline
    var color: Color
    var body: some View {
        ZStack{
            Pentomino(outline: outline)
                .fill(color)
                .opacity(1)
                .frame(width: CGFloat(outline.size.width)*40, height: CGFloat(outline.size.height)*40)
            Grid(n: outline.size.width, m: outline.size.height)
                .stroke(Color.black, lineWidth: 2)
                .frame(width: CGFloat(outline.size.width)*40, height: CGFloat(outline.size.height)*40)
                .clipShape(Pentomino(outline: outline))
            Pentomino(outline: outline)
                .stroke(Color.black, lineWidth: 2)
                .frame(width: CGFloat(outline.size.width)*40, height: CGFloat(outline.size.height)*40)
        }
    }
}






