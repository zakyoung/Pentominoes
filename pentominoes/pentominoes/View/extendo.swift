//
//  extendo.swift
//  pentominoes
//
//  Created by Zak Young on 2/4/24.
//

import SwiftUI

extension Color {
    init(for piece: PentominoPieces) {
        switch piece {
        case .X:
            self = Color(red: 1.0, green: 0.0, blue: 1.0)
        case .I:
            self = Color(red: 0.68, green: 0.85, blue: 0.9)
        case .Y:
            self = .red
        case .Z:
            self = Color(red: 0.0, green: 0.5, blue: 0.5)
        case .L:
            self = .purple
        case .T:
            self = .yellow
        case .U:
            self = Color(red: 0.4, green: 0.0, blue: 0.4)
        case .F:
            self = .orange
        case .N:
            self = .green
        case .V:
            self = Color(red: 0.0, green: 0.5, blue: 0.7)
        case .W:
            self = Color(red: 1.0, green: 0.5, blue: 1.0)
        case .P:
            self = .blue
        }
    }
}
/*
 case X = 0
 case I
 case Y
 case Z
 case L
 case T
 case U
 case F
 case N
 case V
 case W
 case P
 */
