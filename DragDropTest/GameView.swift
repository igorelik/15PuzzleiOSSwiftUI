import SwiftUI

struct GameView: View {
    
    let boardSize = CGPoint(x: 2, y: 2)
    
    @StateObject var viewModel = GameViewModel()
    
    var body: some View {
        GeometryReader{ g in
            ForEach(viewModel.tiles, id: \.id) { tile in
                CardView(model: tile, geometryProxy: g, boardDimensionsInTiles: viewModel.boardDimensions)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
