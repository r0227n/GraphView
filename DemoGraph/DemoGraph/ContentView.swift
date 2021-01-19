import SwiftUI

struct ContentView: View {
    var demo: [CGFloat] = [300.0, 200.0, 300]
    
    var body: some View {
        GraphView(data: demo,
                  graph: .bar,
                  color: .green)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
