import SwiftUI

public struct GraphView: View {
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

    public var body: some View {
        switch kindOfGraph {
        case .bar:
            BarGraph(originY: data.max() ?? 0.0, data: data)
        case .none:
            Text("none")
        }
    }
}

public enum CorrespondingGraph {
    case bar
}

public enum CorrespondingColor {
    case red
    case blue
    case green
}

protocol CatalogOfGraph {
    associatedtype Graph
    func BarGraph(originY: CGFloat, data: [CGFloat]) -> Graph
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
    func BarGraph(originY: CGFloat, data: [CGFloat]) -> some View {
        var graphWidth: CGFloat?
        var graphHeight: CGFloat?
        var reducedScaleY: CGFloat = 0.0
        let spacer: CGFloat = 10.0
        var bar: some View {
            GeometryReader { geometry in
                HStack(spacing: spacer) {
                    ForEach(0..<data.count){ row in
                        Rectangle()
                            .foregroundColor(ColorsGraphLow(color: kindOfColor ?? .blue))
                            .frame(width: graphWidth,
                                   height: graphHeight, alignment: .center)
                            .offset(x: 0.0, y: -data[row] / 2) // 表示位置をずらし、Y軸を揃る
                            .onAppear(perform:{
                                graphHeight = data[row] * reducedScaleY
                            })
                    }
                }
                .offset(x: 0.0, y: originY / 2)
                .clipped() // Viewの切り取り
                .onAppear(perform:{
                    graphWidth = geometry.size.width / CGFloat(data.count) - (spacer / CGFloat(data.count))
                    reducedScaleY = geometry.size.height / CGFloat(data.count)
                })
            }
        }
        return bar
    }
}


struct GraphView_Previews: PreviewProvider {
    static var previews: some View {
        GraphView(data: [300.0, 200.0])
            .frame(width: 300,height: 300)
    }
}
