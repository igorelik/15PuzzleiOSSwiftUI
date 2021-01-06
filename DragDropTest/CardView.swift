import SwiftUI

struct CardView: View {
    let gapSize = 5

    @StateObject var model: TileModel
    var geometryProxy: GeometryProxy
    var boardDimensionsInTiles: CGPoint
    @State var offsetWidth = 10
    @State var offsetHeight = 10
    @State var cardOffset = CGSize.zero
    @State var cardPoistion = CGPoint.zero
    var dragStartLocation = CGPoint.zero
    
    var cardWidth: CGFloat {
        (geometryProxy.size.width-((boardDimensionsInTiles.x+1)*CGFloat(gapSize)))/boardDimensionsInTiles.x
    }
    
    var cardHeight: CGFloat {
        cardWidth
        // (geometryProxy.size.height - ((boardDimensionsInTiles.y+1) * CGFloat(gapSize))) / boardDimensionsInTiles.y
    }

    var cardOffsetByCardLocation: CGSize{
        CGSize(width: gapSize + (Int(cardWidth)+gapSize)*model.column, height: gapSize + (Int(cardHeight)+gapSize)*model.row)
    }
    
    var cardPositionByCardLocation: CGPoint{
        CGPoint(x: gapSize + Int(cardWidth)/2 + (Int(cardWidth)+gapSize)*model.column, y: gapSize + Int(cardHeight)/2 + (Int(cardHeight)+gapSize)*model.row)
    }
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10, style: .circular)
            .fill(Color.blue.opacity(0.2))
            .background(Color.white.opacity(0.5))
            .overlay(
                Text(model.label)
                    .font(.largeTitle)
            )
            .frame(width: cardWidth, height: cardHeight, alignment: .center)
            .offset(cardOffset)
            .position(cardPoistion)
            .onAppear(perform: {
                cardPoistion = cardPositionByCardLocation
            })
            .gesture(
                DragGesture()
                    .onChanged{ gesture in
                        cardOffset = gesture.translation
                    }
                    .onEnded { gesture in
                        model.row = 1
                        cardOffset = CGSize.zero
                        cardPoistion = cardPositionByCardLocation
                    }
            )
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader{g in
            CardView(model: TileModel(id: 1, label: "T", row: 0, column: 0), geometryProxy: g, boardDimensionsInTiles: CGPoint(x: 2, y: 2))
        }
    }
}
