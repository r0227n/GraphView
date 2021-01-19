import SwiftUI

struct GraphView: View {
    let data: [CGFloat]
    let row: Int
    let kindOfGraph: CorrespondingGraph?
    let kindOfColor: CorrespondingColor?
    
    public init(data: [CGFloat]){
        self.data = data
        self.kindOfGraph = .bar
        self.kindOfColor = .blue
        self.row = data.count
    }
    
    public init(data: [CGFloat], graph: CorrespondingGraph){
        self.data = data
        self.kindOfGraph = graph
        self.kindOfColor = .blue
        self.row = data.count
    }
    
    public init(data: [CGFloat], graph: CorrespondingGraph, color: CorrespondingColor){
        self.data = data
        self.kindOfGraph = graph
        self.kindOfColor = color
        self.row = data.count
    }

    var body: some View {
        switch kindOfGraph {
        case .bar:
            BarGraph(originY: data.max() ?? 0.0, data: data, item: row)
        case .none:
            Text("none")
        }
    }
}

enum CorrespondingGraph {
    case bar
}

enum CorrespondingColor {
    case red
    case blue
    case green
}

protocol CatalogOfGraph {
    associatedtype Graph
    func BarGraph(originY: CGFloat, data: [CGFloat], item: Int) -> Graph
}

protocol CatalogOfColor {
    func ColorsGraphLow(color: CorrespondingColor) -> Color
}

extension GraphView: CatalogOfColor {
    func ColorsGraphLow(color: CorrespondingColor) -> Color {
        switch color {
        case .red:
            return .red
        case .blue:
            return .blue
        case .green:
            return.green
        }
    }
}

extension GraphView: CatalogOfGraph {
    func BarGraph(originY: CGFloat, data: [CGFloat], item: Int) -> some View {
        var bar: some View {
            HStack {
                ForEach(0..<item){ row in
                    Rectangle()
                        .foregroundColor(ColorsGraphLow(color: kindOfColor ?? .blue))
                        .frame(width: 30.0,
                               height: data[row], alignment: .center)
                        .offset(x: 0.0, y: -data[row] / 2) // 表示位置をずらし、Y軸を揃る
                }
            }
            .offset(x: 0.0, y: originY / 2)
            .clipped() // Viewの切り取り
        }
        return bar
    }
}


struct GraphView_Previews: PreviewProvider {
    static var previews: some View {
        GraphView(data: [300.0, 200.0])
    }
}
