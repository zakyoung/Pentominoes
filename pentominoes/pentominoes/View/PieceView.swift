//
//  PieceView.swift
//  pentominoes
//
//  Created by Zak Young on 2/4/24.
//
import SwiftUI
struct PieceView: View {
    @EnvironmentObject var gameManager: GameManager
    @State private var offset = CGSize.zero
    @State private var scale = 1.0
    @State var rotations: Double = 0.0
    var pieceName: PentominoPieces
    var body: some View {
        let dragGesture = DragGesture()
            .onChanged { value in
                withAnimation(.smooth()) {
                    offset = value.translation
                    scale = 1.2
                }
            }
            .onEnded { value in
                withAnimation(.smooth()) {
                    let originalPosition = gameManager.finalPieces[pieceName]!.position
                    let translatedX = CGFloat(originalPosition.x) + value.translation.width
                    let translatedY = CGFloat(originalPosition.y) + value.translation.height
                    let gridPosition = gameManager.convertToGrid(x: translatedX, y: translatedY, pieceName: pieceName)
                    let adjustedPosition = gameManager.adjustPositionForCenter(gridPosition: gridPosition, pieceName: pieceName)
                    gameManager.finalPieces[pieceName]!.position = adjustedPosition
                    gameManager.allPiecesCorrect()
                    offset = .zero
                    scale = 1.0
                }
            }
        let tapGesture = TapGesture()
                    .onEnded {
                        withAnimation(.smooth()) {
                            gameManager.finalPieces[pieceName]!.oDataStruct.z += 1
                            gameManager.setOrientation(pieceName: pieceName)
                        }
                    }
        let longPressGesture = LongPressGesture(minimumDuration: 0.5)
                    .onEnded { _ in
                        gameManager.finalPieces[pieceName]?.oDataStruct.y += 1
                        gameManager.setOrientation(pieceName: pieceName)
                    }
                
        PentominoView(outline: gameManager.finalPieces[pieceName]!.outline, color: Color(for: pieceName))
                    .rotation3DEffect(
                        .degrees(Double(gameManager.finalPieces[pieceName]!.oDataStruct.z*90)),
                        axis: (x: 0.0, y: 0.0, z: 1.0),
                        anchor: .center
                    )
                    .rotation3DEffect(
                        .degrees(Double(gameManager.finalPieces[pieceName]!.oDataStruct.y*180)),
                        axis: (x: 0.0, y: 1.0, z: 0.0),
                        anchor: .center
                    )
                    .position(CGPoint(x: gameManager.finalPieces[pieceName]!.position.x, y: gameManager.finalPieces[pieceName]!.position.y))
                    .offset(offset)
                    .scaleEffect(CGSize(width: scale, height: scale))
                    .gesture(dragGesture)
                    .gesture(tapGesture)
                    .gesture(longPressGesture)
    }
}

