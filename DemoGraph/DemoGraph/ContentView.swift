import SwiftUI

struct ContentView: View {
    var demo: [CGFloat] = [300.0, 250.0, 200.0, 150.0]
    
    var body: some View {
        GraphView(data: demo,
                  graph: .bar,
                  color: .red)
            .frame(width: 400, height: 200, alignment: .center)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
