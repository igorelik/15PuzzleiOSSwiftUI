import SwiftUI

struct ContentView: View {
    
    let boardSize = CGPoint(x: 2, y: 2)
    
    var body: some View {
        GeometryReader{ g in
            CardView(model: TileModel(id: 1, label: "1", row: 0, column: 0), geometryProxy: g, boardSizeInTiles: boardSize)
            CardView(model: TileModel(id: 2, label: "2", row: 0, column: 1), geometryProxy: g, boardSizeInTiles: boardSize)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
