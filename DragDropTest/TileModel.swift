import Foundation

class TileModel: ObservableObject {
    @Published var row: Int
    @Published var column: Int
    let label: String
    let id: Int
    let gameLogic: GameLogic
    
    init(id: Int, label: String, row: Int, column: Int, gameLogic: GameLogic) {
        self.label = label
        self.row = row
        self.column = column
        self.id = id
        self.gameLogic = gameLogic
    }
    
    var isMovable: Bool{
        get {
            gameLogic.isMovable(tile: self)
        }
    }
    
    var possibleDirection: GameLogic.Direction{
        get{
            gameLogic.getMoveDirection(for: self)
        }
    }
    
    func move(){
        gameLogic.makeMoveBy(tile: self)
    }
}
