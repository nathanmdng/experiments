import UIKit

class TestWrapperView: UIView {

    let zoomView: TestZoomView
    
    override init(frame: CGRect) {
        zoomView = TestZoomView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        super.init(frame: frame)
        addSubview(zoomView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
