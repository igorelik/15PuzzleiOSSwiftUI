import SwiftUI

struct CardView: View {
    let gapSize: CGFloat = 5
    @StateObject var model: TileModel
    var geometryProxy: GeometryProxy
    var boardDimensionsInTiles: CGPoint
    @State var cardOffset = CGSize.zero
    @State var cardPoistion = CGPoint.zero
    var dragStartLocation = CGPoint.zero
    
    var cardWidth: CGFloat {
        (geometryProxy.size.width-((boardDimensionsInTiles.x+1)*CGFloat(gapSize)))/boardDimensionsInTiles.x
    }
    
    var cardHeight: CGFloat {
        cardWidth
    }

    func cardOffsetByCardLocation(_ tileCoord: CGPoint) -> CGSize{
        CGSize(width: gapSize + ((cardWidth+gapSize) * tileCoord.x), height: gapSize + ((cardHeight+gapSize) * tileCoord.y))
    }
    
    var cardPositionByCardLocation: CGPoint{
        CGPoint(x: gapSize + cardWidth/2 + ((cardWidth+gapSize) * CGFloat(model.column)), y: gapSize + cardHeight/2 + ((cardHeight+gapSize) * CGFloat(model.row)))
    }
    
    func canMoveToNewOffset(_ offset: CGSize) -> Bool {
        if abs(offset.height) > 0 {
            return abs(offset.height) <= cardHeight + 2*gapSize
        }
        return abs(offset.width) <= cardWidth + 2*gapSize
    }
    
    func shouldPerformMoveByOffset(_ offset: CGSize) -> Bool {
        if abs(offset.height) > 0 {
            return abs(offset.height) > cardHeight/2
        }
        return abs(offset.width) > cardWidth/2
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
                        var newOffset = CGSize.zero
                        let direction = model.possibleDirection
                        switch direction{
                            case .none:
                                return
                            case .left:
                                if gesture.translation.width < 0 {
                                    newOffset = CGSize(width: gesture.translation.width, height: cardOffset.height)
                                }
                            case .right:
                                if gesture.translation.width > 0 {
                                    newOffset = CGSize(width: gesture.translation.width, height: cardOffset.height)
                                }
                            case .up:
                                if gesture.translation.height < 0 {
                                    newOffset = CGSize(width: cardOffset.width , height: gesture.translation.height)
                                }
                            case .down:
                                if gesture.translation.height > 0 {
                                    newOffset = CGSize(width: cardOffset.width , height: gesture.translation.height)
                                }
                        }
                        if canMoveToNewOffset(newOffset){
                            cardOffset = newOffset
                        }
                     }
                    .onEnded { gesture in
                        if model.isMovable{
                            if shouldPerformMoveByOffset(cardOffset){
                                model.move()
                            }
                            cardOffset = CGSize.zero
                            cardPoistion = cardPositionByCardLocation
                        }
                    }
            )
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader{g in
            CardView(model: TileModel(id: 1, label: "T", row: 0, column: 0, gameLogic: GameLogic(board: [Int](0...15), size: 4)), geometryProxy: g, boardDimensionsInTiles: CGPoint(x: 2, y: 2))
        }
    }
}
