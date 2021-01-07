import Foundation
import SwiftUI

class GameLogic{
    enum Direction: Int{
        case none
        case left
        case right
        case up
        case down
    }
    
    var board: [Int]
    let boardSize: Int
    
    init(board: [Int], size: Int) {
        self.board = board
        boardSize = size
    }
    
    func convertTileCoordinatesToIndex(_ coord: CGPoint) -> Int {
        Int(coord.x * CGFloat(boardSize) + coord.y)
    }
    
    func convertTileIndexToCoordinates(_ idx: Int) -> CGPoint {
        CGPoint(x: idx / boardSize, y: idx % boardSize)
    }
    
    func getMoveDirection(for tile: TileModel) -> Direction {
        if tile.column > 0 {
            // left
            let idx = convertTileCoordinatesToIndex(CGPoint(x: tile.row, y: tile.column - 1))
            if board[idx] == 0 {
                return .left
            }
        }
        if tile.column < boardSize - 1 {
            // right
            let idx = convertTileCoordinatesToIndex(CGPoint(x: tile.row, y: tile.column + 1))
            if board[idx] == 0 {
                return .right
            }
        }
        if tile.row > 0 {
            // up
            let idx = convertTileCoordinatesToIndex(CGPoint(x: tile.row - 1, y: tile.column))
            if board[idx] == 0 {
                return .up
            }
        }
        if tile.row < boardSize - 1 {
            // down
            let idx = convertTileCoordinatesToIndex(CGPoint(x: tile.row + 1, y: tile.column))
            if board[idx] == 0 {
                return .down
            }
        }
        return .none
    }
    
    func isMovable(tile: TileModel) -> Bool {
        return getMoveDirection(for: tile) != .none
    }
    
    func printBoard(prefix: String) {
        print("\(prefix) \(board)")
    }
    
    func makeMoveBy(tile: TileModel){
        printBoard(prefix: "Before move")
        let emptySpotIdx = board.firstIndex(where: { $0 == 0 })!
        let emptySpotCoordinates = convertTileIndexToCoordinates(emptySpotIdx)
        let tileIdx = convertTileCoordinatesToIndex(CGPoint(x: tile.row, y: tile.column))
        board[tileIdx] = 0
        board[emptySpotIdx] = tile.id
        tile.row = Int(emptySpotCoordinates.x)
        tile.column = Int(emptySpotCoordinates.y)
        printBoard(prefix: "After move")
    }
    
}
