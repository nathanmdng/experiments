import UIKit

class TestZoomView: UIView, UIScrollViewDelegate {

    var scrollView: UIScrollView = {
        var scrollView = UIScrollView()
        scrollView.backgroundColor = .blue
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 1.6
        return scrollView
    }()
    
    var imageView: UIImageView = {
        var imageView = UIImageView(image: #imageLiteral(resourceName: "square_test_zoom"))
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        scrollView.frame = frame
        imageView.frame = frame
        scrollView.contentSize = imageView.bounds.size
        scrollView.addSubview(imageView)
        scrollView.delegate = self
        addSubview(scrollView)
        setupGestureRecognizer()
    }
    
    func setupGestureRecognizer() {
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap))
        doubleTap.numberOfTapsRequired = 2
        scrollView.addGestureRecognizer(doubleTap)
    }
    
    func handleDoubleTap(recognizer: UITapGestureRecognizer) {
        let scale = min(scrollView.zoomScale * 2, scrollView.maximumZoomScale)
        if scale != scrollView.zoomScale {
            let point = recognizer.location(in: imageView)
            
            let scrollSize = scrollView.frame.size
            let size = CGSize(width: scrollSize.width / scale,
                              height: scrollSize.height / scale)
            let origin = CGPoint(x: point.x - size.width / 2,
                                 y: point.y - size.height / 2)
            scrollView.zoom(to: CGRect(origin: origin, size: size), animated: true)
        } else {
            scrollView.setZoomScale(scrollView.minimumZoomScale, animated: true)
        }
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
