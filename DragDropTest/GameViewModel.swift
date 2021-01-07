import Foundation
import SwiftUI

class GameViewModel: ObservableObject{
    let boardSize = 4
    let boardGenerator = RandomBoardGenerator()
    let gameLogic: GameLogic
    @Published var gameBoard: [Int]
    @Published var tiles: [TileModel]
    
    init() {
        let board = boardGenerator.generateBoard(size: boardSize)
        gameBoard = board
        gameLogic = GameLogic(board: board, size: boardSize)
        tiles = [TileModel]()
        for i in 0..<board.count {
            if board[i] != 0 {
                let tile = TileModel(id: board[i], label: "\(board[i])", row: i / boardSize, column: i % boardSize, gameLogic: gameLogic)
                tiles.append(tile)
            }
        }
        gameLogic.printBoard(prefix: "Initial state")
    }
    
    var boardDimensions: CGPoint{
        get {
            CGPoint(x: boardSize, y: boardSize)
        }
    }
}
