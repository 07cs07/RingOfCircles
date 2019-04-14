import UIKit
import PlaygroundSupport
import Foundation

private let PERIOD: Float = 2500.00
private let PI = Float.pi
private let HALF_PI = PI / 2

final class CircleSquareView: UIView {

    private var circleRadius: CGFloat {
        let twoSquareRoot: CGFloat = CGFloat(2.0.squareRoot())
        return min(self.frame.width, self.frame.height) / 4.00 / twoSquareRoot
    }

    private var circlePadding: CGFloat {
        return circleRadius / 16.00
    }

    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.saveGState()
        context.translateBy(x: self.frame.width / 2, y: self.frame.height / 2)

        let now = Date.currentTimeMillis()
        let t: Float = (Float(now).truncatingRemainder(dividingBy: PERIOD)) / PERIOD
        UIColor.yellow.setStroke()

        if (t <= 0.5) {
            let tt = map(value: t, start1: 0, stop1: 0.5, start2: 0, stop2: 1.0)
            let rotation: Float = 90.0 * ease(tt, 3.0)
            print("when t <= 0.5,  rotation = \(rotation)")
            context.saveGState()
            context.rotate(by: CGFloat(rotation))
            drawCircle(in: context, 270.0, -360.0 * ease(tt, 3.0))
            context.restoreGState()
        } else {
            let tt = map(value: t, start1: 0.5, stop1: 1.0, start2: 0, stop2: 1.0)
            let rotation: Float = -90.0 * ease(tt, 3.0)
            print("when t > 0.5,  rotation = \(rotation)")
            context.saveGState()
            context.rotate(by: CGFloat(rotation))
            drawCircle(in: context, 360.0, 0.0)
            context.restoreGState()
            
            context.saveGState()
            context.rotate(by: CGFloat(-rotation))

            let rectangle = CGRect(x: -circleRadius, y: -circleRadius, width: circleRadius, height: circleRadius)
            context.addRect(rectangle)
            context.strokePath()
            context.restoreGState()
        }

        context.restoreGState()
    }

    private func drawCircle( in context: CGContext, _ sweepAngle: Float, _ rotation: Float) {

        for i in 0...4 {
            let r = circleRadius * CGFloat(2.0.squareRoot())
            let theta = (HALF_PI + PI * Float(i)) / 2.0

            let tx = r * CGFloat(cos(theta))
            let ty = r * CGFloat(sin(theta))
            context.saveGState()
            context.translateBy(x: -tx, y: -ty)
            context.rotate(by: CGFloat(rotation))
            let center = CGPoint(x: -circleRadius + circlePadding, y: -circleRadius + circlePadding)
            context.addArc(center: center, radius: circleRadius, startAngle: CGFloat(Float(90.0) * Float(i + 1)), endAngle: CGFloat(sweepAngle), clockwise: true)
            context.strokePath()
            context.restoreGState()
        }
    }

    private func map(value: Float, start1: Float, stop1: Float, start2: Float, stop2: Float) -> Float {
        return start2 + (stop2 - start2) * ((value - start1) / (stop1 - start1))
    }

    private func ease(_ p: Float, _ g: Float) -> Float {
        if (p < 0.5) {
            return 0.5 * powf((2.0 * p), g)
        } else {
            return 1.0 - 0.5 * powf(2.0 * (1 - p), g)
        }
    }
}

class ViewController : UIViewController {

    let ringOfCircles = CircleSquareView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
    let bgColor = UIColor(displayP3Red: 33/255.0, green: 28/255.0, blue: 26/255.0, alpha: 1)

    override func viewDidLayoutSubviews() {
        self.title = "CircleSquareView"
        self.view.backgroundColor = bgColor
        addRingOfCirclesView()
        startAnimatingRingOfCricles()
    }

    private func addRingOfCirclesView() {
        ringOfCircles.center = self.view.center
        ringOfCircles.backgroundColor = bgColor
        self.view.addSubview(ringOfCircles)
    }

    private func startAnimatingRingOfCricles() {
        let timeBetweenDraw:CFTimeInterval = 0.05
        Timer.scheduledTimer(withTimeInterval: timeBetweenDraw, repeats: true, block: { timer in
            self.ringOfCircles.setNeedsDisplay()
//            PlaygroundPage.current.finishExecution()
        })
    }
}

let vc = ViewController()
let nav = UINavigationController(rootViewController: vc)
let ringOfCircles = CircleSquareView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))

PlaygroundPage.current.liveView = nav
