import UIKit

class ZoomController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        let testView = TestWrapperView(frame: UIScreen.main.bounds)
        view.addSubview(testView)
    }

}
