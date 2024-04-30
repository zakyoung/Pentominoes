import Foundation
import SwiftUI
//Mark:- Shapes models
struct Point:Decodable {
    let x : Int
    let y : Int
}

struct Size : Decodable {
    let width : Int
    let height : Int
}

typealias Outline = [Point]

struct PentominoOutline:Decodable {
    let name : String
    let size : Size
    let outline : Outline
}

struct PuzzleOutline: Decodable {
    let name : String
    let size : Size
    let outlines : [Outline]
}

//Mark:- Pieces Model

// specifies the complete position of a piece using unit coordinates
struct Position: Codable  {
    var x : Int = 0
    var y : Int = 0
}

// a Piece is the model data that the view uses to display a pentomino
struct Piece  {
    var position : Position = Position()
    var outline : PentominoOutline
    var orientation: Orientation
    var oDataStruct: orientationDataStruct
}
struct Solution{
    var sixTen: [PentominoPieces:Piece]
    var fiveTwelve: [PentominoPieces:Piece]
    var oneHold: [PentominoPieces:Piece]
    var fourNotches: [PentominoPieces:Piece]
    var fourHoles: [PentominoPieces:Piece]
    var thirteenHoles: [PentominoPieces:Piece]
    var flower: [PentominoPieces:Piece]
}
struct Board{
    var rows: Int
    var columns: Int
    var frameSizeX: CGFloat
    var frameSizeY: CGFloat
}
enum PentominoPieces: Int, CaseIterable, Codable {
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
}
extension PentominoPieces {
    func getSolutionInfo(from solutions: puzzlePieceSolutions) -> solutionInfoForPiece {
        switch self {
        case .X:
            return solutions.X
        case .I:
            return solutions.I
        case .Y:
            return solutions.Y
        case .Z:
            return solutions.Z
        case .L:
            return solutions.L
        case .T:
            return solutions.T
        case .U:
            return solutions.U
        case .F:
            return solutions.F
        case .N:
            return solutions.N
        case .V:
            return solutions.V
        case .W:
            return solutions.W
        case .P:
            return solutions.P
        }
    }
}
enum Orientation : String, Codable {
    case up, left, down, right
    case upMirrored, leftMirrored, downMirrored, rightMirrored
}
struct orientationDataStruct{
    var x: Int = 0
    var y: Int = 0
    var z: Int = 0
}
struct solutionInfoForPiece: Codable {
    var x: Int
    var y: Int
    var orientation: Orientation
}
struct puzzlePieceSolutions: Codable{
    var X : solutionInfoForPiece
    var I : solutionInfoForPiece
    var Y : solutionInfoForPiece
    var Z : solutionInfoForPiece
    var L : solutionInfoForPiece
    var T : solutionInfoForPiece
    var U : solutionInfoForPiece
    var F : solutionInfoForPiece
    var N : solutionInfoForPiece
    var V : solutionInfoForPiece
    var W : solutionInfoForPiece
    var P : solutionInfoForPiece
}
struct puzzleSolutions: Codable{
    var sixTen : puzzlePieceSolutions
    var fiveTwelve : puzzlePieceSolutions
    var oneHold : puzzlePieceSolutions
    var fourNotches : puzzlePieceSolutions
    var fourHoles : puzzlePieceSolutions
    var thirteenHoles : puzzlePieceSolutions
    var flower : puzzlePieceSolutions
    
    enum CodingKeys: String, CodingKey{
        case sixTen = "6x10"
        case fiveTwelve = "5x12"
        case oneHold = "OneHole"
        case fourNotches = "FourNotches"
        case fourHoles = "FourHoles"
        case thirteenHoles = "13Holes"
        case flower = "Flower"
    }
}

enum PuzzleState: Int, CaseIterable {
    case noPuzzle = 0
    case sixTen = 1
    case fiveTwelve = 2
    case oneHold = 3
    case fourNotches = 4
    case fourHoles = 5
    case thirteenHoles = 6
    case flower = 7
}
extension PuzzleState {
    func getPuzzlePieceSolution(from solutions: puzzleSolutions) -> puzzlePieceSolutions? {
        switch self {
        case .sixTen:
            return solutions.sixTen
        case .fiveTwelve:
            return solutions.fiveTwelve
        case .oneHold:
            return solutions.oneHold
        case .fourNotches:
            return solutions.fourNotches
        case .fourHoles:
            return solutions.fourHoles
        case .thirteenHoles:
            return solutions.thirteenHoles
        case .flower:
            return solutions.flower
        case .noPuzzle:
            return nil
        }
    }
}
