import SwiftUI

struct GameView: View {
    
    let boardSize = CGPoint(x: 2, y: 2)
    
    @StateObject var viewModel = GameViewModel()
    
    var body: some View {
        GeometryReader{ g in
            ForEach(0 ..< viewModel.gameBoard.count) {
                //Text(selectionSet[$0])
                if viewModel.gameBoard[$0] != 0 {
                    CardView(model: viewModel.getTileModelForBoardCell($0), geometryProxy: g, boardDimensionsInTiles: viewModel.boardDimensions)
                }
            }
//            CardView(model: TileModel(id: 1, label: "1", row: 0, column: 0), geometryProxy: g, boardDimensionsInTiles: boardSize)
//            CardView(model: TileModel(id: 2, label: "2", row: 0, column: 1), geometryProxy: g, boardDimensionsInTiles: boardSize)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
