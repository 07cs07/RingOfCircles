import UIKit
import PlaygroundSupport

class ViewController : UIViewController {
    
//    let ringOfCircles = RingOfCirclesView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
    let bgColor = UIColor(displayP3Red: 33/255.0, green: 28/255.0, blue: 26/255.0, alpha: 1)
    
    override func viewDidLayoutSubviews() {
        self.title = "CircleSquareView"
        self.view.backgroundColor = bgColor
//        addRingOfCirclesView()
//        startAnimatingRingOfCricles()
    }
    
//    private func addRingOfCirclesView() {
//        ringOfCircles.center = self.view.center
//        ringOfCircles.backgroundColor = bgColor
//        self.view.addSubview(ringOfCircles)
//    }
//
//    private func startAnimatingRingOfCricles() {
//        let timeBetweenDraw:CFTimeInterval = 0.001
//        Timer.scheduledTimer(withTimeInterval: timeBetweenDraw, repeats: true, block: { timer in
//            self.ringOfCircles.setNeedsDisplay()
//        })
//    }
}

let vc = ViewController()
let nav = UINavigationController(rootViewController: vc)

PlaygroundPage.current.liveView = nav
