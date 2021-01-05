import Foundation

class TileModel: ObservableObject {
    @Published var row: Int
    @Published var column: Int
    let label: String
    let id: Int
    
    init(id: Int, label: String, row: Int, column: Int) {
        self.label = label
        self.row = row
        self.column = column
        self.id = id
    }
}
