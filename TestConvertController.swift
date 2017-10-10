import UIKit

class TestConvertController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        
        // Main view
        self.view.backgroundColor = .black
        self.view.frame = CGRect(x: 0, y: 0, width: 500, height: 500)
        
        // Red view
        let redView = UIView(frame: CGRect(x: 20, y: 20, width: 460, height: 460))
        redView.backgroundColor = .red
        self.view.addSubview(redView)
        
        // Blue view
        let blueView = UIView(frame: CGRect(x: 20, y: 20, width: 420, height: 420))
        blueView.backgroundColor = .blue
        redView.addSubview(blueView)
        
        // Orange view
        let orangeView = UIView(frame: CGRect(x: 20, y: 20, width: 380, height: 380))
        orangeView.backgroundColor = .orange
        blueView.addSubview(orangeView)
        
        // Yellow view
        let yellowView = UIView(frame: CGRect(x: 20, y: 20, width: 340, height: 100))
        yellowView.backgroundColor = .yellow
        orangeView.addSubview(yellowView)
        
        
        // Let's try to convert now
        var resultFrame = CGRect.zero
        let randomRect: CGRect = CGRect(x: 0, y: 0, width: 100, height: 50)
        
        /*
         func convert(CGRect, from: UIView?)
         Converts a rectangle from the coordinate system of another view to that of the receiver.
         */
        
        // The following line converts a rectangle (randomRect) from the coordinate system of yellowView to that of self.view:
        // resultFrame = self.view.convert(randomRect, from: yellowView)
        
        // Try also one of the following to get a feeling of how it works:
        // resultFrame = self.view.convert(randomRect, from: orangeView)
        // resultFrame = self.view.convert(randomRect, from: redView)
        // resultFrame = self.view.convert(randomRect, from: nil)
        // resultFrame = self.view.convert(randomRect, from: orangeView)
        
        
        /*
         func convert(CGRect, to: UIView?)
         Converts a rectangle from the receiver’s coordinate system to that of another view.
         */
        
        // The following line converts a rectangle (randomRect) from the coordinate system of yellowView to that of self.view
        // resultFrame = yellowView.convert(randomRect, to: self.view)
        // Same as what we did above, using "from:"
        // resultFrame = self.view.convert(randomRect, from: yellowView)
        
        // Also try:
        // resultFrame = orangeView.convert(randomRect, to: self.view)
        // resultFrame = redView.convert(randomRect, to: self.view)
        // resultFrame = orangeView.convert(randomRect, to: nil)
        // where is yellow in relation to red?
        resultFrame = yellowView.convert(randomRect, to: redView)
        
        
        // Add an overlay with the calculated frame to self.view
        let overlay = UIView(frame: resultFrame)
        overlay.backgroundColor = UIColor(white: 1.0, alpha: 0.9)
        overlay.layer.borderColor = UIColor.black.cgColor
        overlay.layer.borderWidth = 1.0
        self.view.addSubview(overlay)
    }
}

// var ctrl = MyViewController()
// PlaygroundPage.current.liveView = ctrl.view
