import UIKit
import PlaygroundSupport

final class RingOfCirclesView: UIView {
    private let noOfCiricles = 12
    private let PERIOD1 = -10000.0
    private let PERIOD2 = -500.0

    private var ringRadius: CGFloat {
        return CGFloat(min(self.frame.width, self.frame.height) * 0.35)
    }
    
    private var waveRadius: CGFloat {
        return CGFloat(min(self.frame.width, self.frame.height) * 0.10)
    }
    
    private var ballRadius: CGFloat {
        return waveRadius / 4.0
    }

    private var gap: CGFloat {
        return ballRadius / 2
    }
    
    override func draw(_ rect: CGRect) {

        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.saveGState()
        context.translateBy(x: self.frame.width / 2, y: self.frame.height / 2)

        let now = Date.currentTimeMillis()
        for i in 0...noOfCiricles {
            drawCircle(context: context, i: i, now: now, above: false)
        }

        drawOuterRing(context: context, radius: ringRadius, color: .black, lineWidth: ballRadius + gap * 2)
        drawOuterRing(context: context, radius: ringRadius, color: .white, lineWidth: ballRadius)
        
        for i in 0...noOfCiricles {
            drawCircle(context: context, i: i, now: now, above: true)
        }
        context.restoreGState()
    }
    
    private func drawOuterRing(context: CGContext, radius: CGFloat, color: UIColor, lineWidth: CGFloat) {
        let ringPath = UIBezierPath(arcCenter: CGPoint(x: 0, y: 0), radius: radius, startAngle: 0, endAngle: CGFloat(2 * Double.pi), clockwise: true)
        ringPath.lineWidth = lineWidth
        color.setStroke()
        ringPath.stroke()
    }
    
    private func drawCircle(context: CGContext, i: Int, now: TimeInterval, above: Bool ) {
        
        let angle0 = (Double(i) / Double(noOfCiricles) + now / PERIOD1).truncatingRemainder(dividingBy: 1.0) * (2 * Double.pi)
        let angle1 = angle0 + (now / PERIOD2)
        
        if ((cos(angle1) < 0.0) == above) {
            return
        }
        
        context.saveGState()
        context.rotate(by: CGFloat(angle0))
        context.translateBy(x: CGFloat(ringRadius + CGFloat(sin(angle1)) * waveRadius), y: 0.0)
        
        let innerWhiteCircle = UIBezierPath(arcCenter: CGPoint(x: 0, y: 0), radius: ballRadius, startAngle: 0, endAngle: CGFloat(2 * Float.pi), clockwise: true)
        innerWhiteCircle.lineWidth = gap * 2
        UIColor.black.setStroke()
        innerWhiteCircle.stroke()

        let blackCircle = UIBezierPath(arcCenter: CGPoint(x: 0, y: 0), radius: ballRadius, startAngle: 0, endAngle: CGFloat(2 * Float.pi), clockwise: true)
        UIColor.white.setFill()
        blackCircle.fill()
        context.restoreGState()
    }
}

class RingOfCirclesViewController : UIViewController {
    
    let ringOfCircles = RingOfCirclesView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
    let bgColor = UIColor(displayP3Red: 33/255.0, green: 28/255.0, blue: 26/255.0, alpha: 1)
    
    override func viewDidLayoutSubviews() {
        self.title = "😍 Awesome"
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
        let timeBetweenDraw:CFTimeInterval = 0.001
        Timer.scheduledTimer(withTimeInterval: timeBetweenDraw, repeats: true, block: { timer in
            self.ringOfCircles.setNeedsDisplay()
        })
    }
}

let vc = RingOfCirclesViewController()
let nav = UINavigationController(rootViewController: vc)

PlaygroundPage.current.liveView = nav
