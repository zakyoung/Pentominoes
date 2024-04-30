//
//  Pentomino.swift
//  pentominoes
//
//  Created by Zak Young on 2/4/24.
//

import SwiftUI

struct Pentomino: Shape {
    let outline: PentominoOutline
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let scaleX = rect.width / CGFloat(outline.size.width)
        let scaleY = rect.height / CGFloat(outline.size.height)
        if let point = outline.outline.first{
            path.move(to: CGPoint(x:CGFloat(point.x)*scaleX,y: CGFloat(point.y)*scaleY))
            for p in outline.outline.dropFirst(){
                path.addLine(to: CGPoint(x:CGFloat(p.x)*scaleX,y:CGFloat(p.y)*scaleY))
            }
        }
        return path
    }
}
