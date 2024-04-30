//
//  Puzzle.swift
//  pentominoes
//
//  Created by Zak Young on 2/4/24.
//

import SwiftUI

struct Puzzle: Shape {
    let puzzOutline: PuzzleOutline
    let xFactor: CGFloat
    let yFactor: CGFloat
    func path(in rect: CGRect) -> Path {
        let scaleX = CGFloat(xFactor)
        let scaleY = CGFloat(yFactor)
        var combinedPath = Path()
        for outline in  puzzOutline.outlines{
            var path = Path()
            if let point = outline.first{
                path.move(to: CGPoint(x:CGFloat(point.x)*scaleX,y: CGFloat(point.y)*scaleY))
                for p in outline.dropFirst(){
                    path.addLine(to: CGPoint(x:CGFloat(p.x)*scaleX,y:CGFloat(p.y)*scaleY))
                }
            }
            combinedPath.addPath(path)
        }
        return combinedPath
    }
}

