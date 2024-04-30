//
//  vm.swift
//  pentominoes
//
//  Created by Zak Young on 2/2/24.
//

import Foundation

class GameManager: ObservableObject{
    @Published var pentominoPieces : [PentominoOutline] = []
    @Published var puzzleOutlines: [PuzzleOutline] = []
    @Published var boardInfo: Board
    @Published var currentPuzzle: PuzzleState = .sixTen
    @Published var factor: CGFloat = 40.0
    @Published var solutions: puzzleSolutions?
    @Published var finalPieces:[PentominoPieces:Piece] = [:]
    @Published var puzzleSolved: Bool = false
    init(rows: Int, columns : Int, frameSizeX: Int, frameSizeY: Int){
        boardInfo = Board(rows: rows, columns: columns, frameSizeX: CGFloat(frameSizeX), frameSizeY: CGFloat(frameSizeY))
        self.solutions = nil
        loadPentominoOutlines()
        loadPuzzleOutlines()
        loadSolutions()
        setFinalPieces()
    }
    func loadPentominoOutlines()->Void{
        var outlines : [PentominoOutline] = []
        let bundle = Bundle.main
        if let url = bundle.url(forResource: "PentominoOutlines", withExtension: "json"){
            do {
                let content = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                outlines = try decoder.decode([PentominoOutline].self, from: content)
            }
            catch{
                print("ERROR")
            }
        }
        else{
            print("ERROR")
        }
        pentominoPieces = outlines
    }
    func loadPuzzleOutlines()->Void{
        var outlines : [PuzzleOutline] = []
        let bundle = Bundle.main
        if let url = bundle.url(forResource: "PuzzleOutlines", withExtension: "json"){
            do {
                let content = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                outlines = try decoder.decode([PuzzleOutline].self, from: content)
            }
            catch{
                print("ERROR")
            }
        }
        else{
            print("ERROR")
        }
        let emptyPuzzleOutline = PuzzleOutline(name: "Empty", size: Size(width: 0, height: 0), outlines: [])
        outlines.insert(emptyPuzzleOutline, at: 0)
        puzzleOutlines = outlines
    }
    func updateCurrentPuzzle(eVal:Int){
        currentPuzzle =  PuzzleState(rawValue: eVal)!
        setFinalPieces()
    }
    func loadSolutions() {
        guard let url = Bundle.main.url(forResource: "Solutions", withExtension: "json"),
              let jsonData = try? Data(contentsOf: url) else {
            print("Error")
            return
        }
        
        let decoder = JSONDecoder()
        
        do {
            solutions = try decoder.decode(puzzleSolutions.self, from: jsonData)
        } catch {
            print("Error")
        }
    }
    func setFinalPieces()->Void{
        let columns = 4
        let pieceSize: CGFloat = 140
        let vSpacing: CGFloat = 45
        var arr:[PentominoPieces:Piece] = [:]
        for i in 0..<pentominoPieces.count{
            let row = i / columns
            let column = i % columns
            let yStart = CGFloat(boardInfo.frameSizeY)
            let xPosition = (boardInfo.frameSizeX / CGFloat(columns)) * CGFloat(column) + pieceSize / 2
            let yPosition = yStart + CGFloat(row) * (pieceSize + vSpacing) + pieceSize / 2
            let position = Position(x: Int(xPosition), y: Int(yPosition))
            let name = getEnumName(name: pentominoPieces[i].name)
            arr[name] = Piece(position: position, outline: pentominoPieces[i], orientation: .up, oDataStruct: orientationDataStruct(x: 0,y:0, z: 0))
        }
        finalPieces = arr
    }
    func getEnumName(name:String) -> PentominoPieces{
        switch name{
        case "X":
            return .X
        case "I":
            return .I
        case "Y":
            return .Y
        case "Z":
            return .Z
        case "L":
            return .L
        case "T":
            return .T
        case "U":
            return .U
        case "F":
            return .F
        case "N":
            return .N
        case "V":
            return .V
        case "W":
            return .W
        default:
            return .P
        }
    }
    func reset()->Void{
        setFinalPieces()
        puzzleSolved = false
    }
    func convertToGrid(x: CGFloat, y: CGFloat,pieceName:PentominoPieces) -> Position {
        let yVal: Int = finalPieces[pieceName]!.outline.size.height
        let threshold: CGFloat = yVal >= 4 ? 0 : 0.3
        let gridXFraction = (x / factor).truncatingRemainder(dividingBy: 1)
        let gridYFraction = (y / factor).truncatingRemainder(dividingBy: 1)
        var gridX = Int(x / factor)
        var gridY = Int(y / factor)
        if gridXFraction > threshold {
            gridX += 1
        }
        if gridYFraction > threshold{
            gridY += 1
        }
        
        return Position(x: gridX, y: gridY)
    }
    func convertToCoordinates(gridX: Int, gridY: Int) -> Position {
        let x = CGFloat(gridX * Int(factor))
        let y = CGFloat(gridY * Int(factor))
        return Position(x:Int(x), y:Int(y))
    }
    func computeSolutionCenter(pieceName: PentominoPieces) -> Position{
        // 1. get the center of the piece
        // 2. get the solution for the puzzle given the piece
        // 3. add center to solution
        let solution = currentPuzzle.getPuzzlePieceSolution(from: solutions!)
        let solutionInfo = pieceName.getSolutionInfo(from: solution!)
        let rotationCount = getRotoStatus(ori: solutionInfo.orientation)
        let isOddRotation = rotationCount % 2 != 0
        let outline: PentominoOutline = finalPieces[pieceName]!.outline
        let pieceWidth = isOddRotation ? outline.size.height : outline.size.width
        let pieceHeight = isOddRotation ? outline.size.width : outline.size.height
        let offsetX = CGFloat(CGFloat(pieceWidth) * factor) / 2
        let offsetY = CGFloat(CGFloat(pieceHeight) * factor) / 2
        let centeredSolutionX = CGFloat(CGFloat(solutionInfo.x)*factor) + offsetX
        let centeredSolutionY = CGFloat(CGFloat(solutionInfo.y)*factor) + offsetY
        return Position(x: Int(centeredSolutionX),y: Int(centeredSolutionY))
    }
    func adjustPositionForCenter(gridPosition: Position, pieceName: PentominoPieces) -> Position {
        guard let piece = finalPieces[pieceName] else { return gridPosition }
        let pieceWidth = piece.outline.size.width
        let pieceHeight = piece.outline.size.height
        let isRotated = piece.oDataStruct.z % 2 != 0
        let widthAdjustment = isRotated ? CGFloat(pieceHeight) / 2.0 : CGFloat(pieceWidth) / 2.0
        let heightAdjustment = isRotated ? CGFloat(pieceWidth) / 2.0 : CGFloat(pieceHeight) / 2.0
        let centerX = CGFloat(gridPosition.x) * factor + factor
        let centerY = CGFloat(gridPosition.y) * factor + factor
        let adjustedX = centerX - widthAdjustment * factor // This value here will be equal to the centered solution X above
        let adjustedY = centerY - heightAdjustment * factor //
        return Position(x: Int(adjustedX), y: Int(adjustedY))
    }
    func checkIfCorrectPosition(pieceName:PentominoPieces) -> Bool{
        let neededPiece = finalPieces[pieceName]
            let solutionLocationCorrect = computeSolutionCenter(pieceName: pieceName)
            let solutionX = solutionLocationCorrect.x
            let solutionY = solutionLocationCorrect.y
            let currentX = neededPiece!.position.x
            let currentY = neededPiece!.position.y
            if (solutionX == currentX) && (solutionY == currentY){
                return true
        }
        return false
    }
    func allPiecesCorrect() {
        for piece in finalPieces.keys {
            if !checkIfCorrectPosition(pieceName: piece) {
                puzzleSolved = false
                return
            }
        }
        puzzleSolved = true
    }
    func getZOrientation(zValue: Int) -> Orientation{
        switch zValue % 4{
        case 0:
            return .up
        case 1:
            return .left
        case 2:
            return .down
        case 3:
            return .right
        default:
            return .up
            
        }
    }
    func setOrientation(pieceName: PentominoPieces){
        let neeededPiece = finalPieces[pieceName]!
        let neededPieceOrientation = neeededPiece.oDataStruct
        let zValueOrientation = getZOrientation(zValue: neededPieceOrientation.z)
        if neededPieceOrientation.y % 2 == 0{
            // These are the cases when we are not reflecting across y
            finalPieces[pieceName]!.orientation =  zValueOrientation
        }
        else{
            switch zValueOrientation{
            case .up:
                finalPieces[pieceName]!.orientation = .upMirrored
            case .left:
                finalPieces[pieceName]!.orientation = .leftMirrored
            case .down:
                finalPieces[pieceName]!.orientation = .downMirrored
            case .right:
                finalPieces[pieceName]!.orientation = .rightMirrored
            default:
                finalPieces[pieceName]!.orientation = .upMirrored
            }
        }
    }
    func getRotoStatus(ori: Orientation) -> Int {
        switch ori {
        case .up:
            return 0
        case .right, .leftMirrored:
            return 1
        case .down, .upMirrored:
            return 2
        case .left, .rightMirrored:
            return 3
        default:
            return 0
        }
    }
    func solveThatThang(){
        for pieceName in finalPieces.keys {
            if let solution = currentPuzzle.getPuzzlePieceSolution(from: solutions!){
                let solutionInfo = pieceName.getSolutionInfo(from: solution)
                let solutionLocationCorrect = computeSolutionCenter(pieceName: pieceName)
                let solutionX = solutionLocationCorrect.x
                let solutionY = solutionLocationCorrect.y
                let solutionOrientation = solutionInfo.orientation
                finalPieces[pieceName]!.position = Position(x: solutionX,y: solutionY)
                finalPieces[pieceName]!.oDataStruct.z = getZOrientationOpposite(zValue: solutionOrientation)
                finalPieces[pieceName]!.oDataStruct.y = getYOrientation(yValue: solutionOrientation)
            }
        }
    }
    func getZOrientationOpposite(zValue: Orientation) -> Int{
        switch zValue{
            case .up:
                    return 0
            case .left:
                    return 3
            case .down:
                    return 2
            case .right:
                    return 1
            case .upMirrored:
                    return 0
            case .leftMirrored:
                    return 1
            case .downMirrored:
                    return 2
            case .rightMirrored:
                    return 3
            }
    }
    func getYOrientation(yValue: Orientation)-> Int{
        switch yValue{
            case .up:
                    return 0
            case .left:
                    return 0
            case .down:
                    return 0
            case .right:
                    return 0
            case .upMirrored:
                    return 1
            case .leftMirrored:
                    return 1
            case .downMirrored:
                    return 1
            case .rightMirrored:
                    return 1
            }
    }
}
