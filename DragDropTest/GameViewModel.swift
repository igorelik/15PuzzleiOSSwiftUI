import Foundation
import SwiftUI

class GameViewModel: ObservableObject{
    let boardSize = 4
    let boardGenerator = RandomBoardGenerator()
    @Published var gameBoard: [Int]
    
    init() {
        gameBoard = boardGenerator.generateBoard(size: boardSize)
    }
    
    func getTileModelForBoardCell(_ idx: Int) -> TileModel {
        TileModel(id: idx, label: "\(gameBoard[idx])", row: idx / boardSize, column: idx % boardSize)
    }
    
    var boardDimensions: CGPoint{
        get {
            CGPoint(x: boardSize, y: boardSize)
        }
    }
}
