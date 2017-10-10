import UIKit

class ConvertController: UIViewController {

    let boardView = TestBoardView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .white
        view.addSubview(boardView)
        boardView.clipsToBounds = false
        boardView.anchor(top: view.topAnchor, left: view.leftAnchor, topConstant: 100, leftConstant: 3)
        let rackView = TestRackView(frame: CGRect(x: 0, y: 0, width: 300, height: 30), delegate: self)
        view.addSubview(rackView)
        rackView.anchor(top: boardView.bottomAnchor, left: view.leftAnchor, topConstant: 10)
    }
    
    func dropped(_ letterView: TestLetterView) {
        let converted = letterView.convert(letterView.bounds, to: boardView)
        print("converted to \(converted)")
    }
    
}

class TestBoardView: UIView, UIGestureRecognizerDelegate {

    override init(frame: CGRect) {
        super.init(frame: frame)
        render()
    }
    
    func render() {
        let size = 18
        for i in 0 ... 14 {
            let xValue = Int(round(Double(i * size) * 1.1))
            for j in 0 ... 14 {
                let yValue = Int(round(Double(j * size) * 1.1))
                let cellView = UIView(frame: CGRect(x: xValue, y: yValue, width: size, height: size))
                cellView.backgroundColor = .red
                addSubview(cellView)
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

class TestRackView: UIView {
    
    var delegate: ConvertController
    
    init(frame: CGRect, delegate: ConvertController) {
        self.delegate = delegate
        super.init(frame: frame)
        render()
    }
    
    func render() {
        let size = 30
        for i in 0 ... 8 {
            let xValue = Int(round(Double(i * size) * 1.1))
            let letterView = TestLetterView(frame: CGRect(x: xValue, y: 0, width: size, height: size))
            letterView.addDrag()
            letterView.delegate = delegate
            addSubview(letterView)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

protocol TestDelegate {
    func dropped(_ view: TestLetterView)
}

class TestLetterView: UIView, UIGestureRecognizerDelegate {
    
    var delegate: ConvertController?
    var dragShadow: TestLetterView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .blue
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return gestureRecognizers?.contains(gestureRecognizer) == true &&
            gestureRecognizers?.contains(otherGestureRecognizer) == true
    }

    func addDrag() {
        let dragGesture = UIPanGestureRecognizer(target: self, action: #selector(dragged))
        addGestureRecognizer(dragGesture)
    }
    
    func pressed() {
        isHidden = true
        let globalFrame = self.convert(bounds, to: nil)
        print("local frame is \(frame), global frame is \(globalFrame)")
        let dragShadow = TestLetterView(frame: globalFrame)
        dragShadow.backgroundColor = .lightGray
        dragShadow.delegate = delegate
        delegate?.view.addSubview(dragShadow)
        dragShadow.layer.zPosition = 0.5
    }
    
    func dragged(_ gesture: UIPanGestureRecognizer) {
        if gesture.state == .began {
            let globalFrame = self.convert(bounds, to: nil)
            dragShadow = TestLetterView(frame: globalFrame)
            dragShadow!.backgroundColor = .lightGray
            dragShadow!.delegate = delegate
            dragShadow!.addDrag()
            delegate?.view.addSubview(dragShadow!)
            dragShadow!.layer.zPosition = 0.5
        }
        if gesture.state == .changed {
            let translation = gesture.translation(in: self)
            dragShadow!.center = CGPoint(x: dragShadow!.center.x + translation.x, y: dragShadow!.center.y + translation.y)
            gesture.setTranslation(CGPoint.zero, in: self)
        } else if gesture.state == .ended {
            delegate?.dropped(self)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
