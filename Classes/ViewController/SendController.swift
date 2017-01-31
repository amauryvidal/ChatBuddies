import UIKit

@objc protocol SendControllerDelegate {
    func didSendMessage(_ text: String)
}

class SendController: UIViewController {
    var textView: UITextView!
    var text: String = ""
    weak var delegate: SendControllerDelegate?
    
    init(delegate:SendControllerDelegate?) {
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        self.delegate = nil
    }
    
    override func loadView() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Send", style: .done, target: self, action: #selector(SendController.send(_:)))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(SendController.cancel(_:)))
        self.textView = UITextView(frame: CGRect(x: 0, y: 0, width: 320, height: 200))
        //textView.font=[LayoutConstants detailSmallFont];
        textView.text = text
        self.view = UIView(frame: UIScreen.main.bounds)
        self.view!.addSubview(textView)
        textView.becomeFirstResponder()
    }
    
    func send(_ sender: AnyObject) {
        self.textView.resignFirstResponder()
        // apply pending auto corrections
        delegate?.didSendMessage(self.textView.text!)
        self.dismiss(animated: true, completion: nil)
    }
    
    func cancel(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
}
