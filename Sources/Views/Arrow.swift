import SwiftUI

struct Arrow: Shape {
    enum Constants {
        static let pointerLineLength: CGFloat = 15
        static let arrowAngle = CGFloat(Double.pi / 6)
        static let circularAngle: Angle = .degrees(45)
        static var circularRadius: CGFloat { pointerLineLength * 2 }
    }

    let start: CGPoint
    let end: CGPoint?
    let thickness: CGFloat
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let angle: CGFloat
        let lineEnd: CGPoint

        if let end {
            path.move(to: start)
            path.addLine(to: end)
            let delta = end - start
            angle = delta.angle
            lineEnd = end
        } else {
            path.move(to: start)
            let startAngle = Constants.circularAngle
            let endAngle = Constants.circularAngle + .degrees(45)
            let startPoint = CGPoint(
                cos(Constants.circularAngle.radians) * -Constants.circularRadius,
                sin(Constants.circularAngle.radians) * -Constants.circularRadius)
            + start
            
            path.addArc(
                center: startPoint,
                radius: Constants.circularRadius,
                startAngle: startAngle,
                endAngle: endAngle,
                clockwise: true)
            angle = (endAngle - .degrees(80)).radians
            lineEnd = path.currentPoint ?? start
        }

        let arrowLine1 = CGPoint(
            x: lineEnd.x + Constants.pointerLineLength * cos(CGFloat(Double.pi) - angle + Constants.arrowAngle),
            y: lineEnd.y - Constants.pointerLineLength * sin(CGFloat(Double.pi) - angle + Constants.arrowAngle))
        let arrowLine2 = CGPoint(
            x: lineEnd.x + Constants.pointerLineLength * cos(CGFloat(Double.pi) - angle - Constants.arrowAngle),
            y: lineEnd.y - Constants.pointerLineLength * sin(CGFloat(Double.pi) - angle - Constants.arrowAngle))
        
        path.move(to: arrowLine1)
        path.addLine(to: lineEnd)
        path.addLine(to: arrowLine2)
        
        return path.strokedPath(.init(lineWidth: thickness))
    }
}

struct Arrow_Previews: PreviewProvider {
    static let start = CGPoint(x: 120, y: 160)
    static let end = CGPoint(x: 300, y: 200)
    
    static let circular = CGPoint(x: 120, y: 400)
    
    static var previews: some View {
        ZStack {
            Arrow(start: start, end: end, thickness: 4)
            Arrow(start: circular, end: nil, thickness: 2)
        }
    }
}
