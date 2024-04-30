//
//  Grid.swift
//  pentominoes
//
//  Created by Zak Young on 1/31/24.
//

import SwiftUI

struct Grid: Shape {
    var n: Int // Col
    var m: Int // Row
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let x : Int = Int(rect.size.width)/n
        let y : Int = Int(rect.size.height)/m
        for i in stride(from:0,to: x*(1+n), by: x){
            path.move(to:CGPoint(x:CGFloat(i),y:0))
            path.addLine(to: CGPoint(x:CGFloat(i),y: rect.size.height))
        }
        for j in stride(from:0,to: y*(1+m), by: y){
            path.move(to:CGPoint(x:0,y:CGFloat(j)))
            path.addLine(to: CGPoint(x:rect.size.width, y: CGFloat(j)))
        }
        return path
    }
    
}

#Preview {
    Grid(n:5,m:3)
        .stroke(lineWidth: 2)
        .frame(width: 200, height: 200)
        .background(Color.white)
}
