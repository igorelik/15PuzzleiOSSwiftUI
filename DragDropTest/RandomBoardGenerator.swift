import Foundation
// http://www.cs.bham.ac.uk/~mdr/teaching/modules04/java2/TilesSolvability.html

class RandomBoardGenerator{
    
    func generateBoard(size: Int) -> [Int] {
        var res = generateRandomBoardUnchecked(boardSize: size)
        while (!isBoardSolvable(board: res, size: size))
        {
            res = generateRandomBoardUnchecked(boardSize: size);
        }
        return res;
    }
    
    func isBoardSolvable(board: [Int], size: Int) -> Bool {
        var cntInv = 0;
        var zeroLoc = -1;
        let arrSize = size*size;
        for loc in 0..<arrSize {
            if (board[loc] == 0)
            {
                zeroLoc = loc;
                continue;
            }
            for loc2 in (loc+1)..<arrSize
            {
                if(board[loc2] == 0)
                {
                    continue;
                }
                if(board[loc] > board[loc2])
                {
                    cntInv += 1;
                }
            }
        }
        if(size % 2 == 1)
        {
            return cntInv % 2 != 1;
        }
        let zeroRow = size - zeroLoc/size;
        return (zeroRow%2 == 1) == (cntInv%2 == 0);
    }
    
    func generateRandomBoardUnchecked(boardSize: Int) -> [Int] {
        var board = [Int]()
        for i in 0..<boardSize*boardSize {
            board.append(i)
        }
        for i in (0..<board.count).reversed() {
            let idx = Int.random(in: 0..<board.count)
            let tmp = board[i]
            board[i] = board[idx]
            board[idx] = tmp
        }
        return board
    }
    
}
