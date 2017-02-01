import UIKit

protocol SendControllerDelegate: class {
    func didSend(message text: String)
}

class SendController: UIViewController {
    @IBOutlet weak var textView: UITextView!
    
    var text: String = ""
    weak var delegate: SendControllerDelegate?

    deinit {
        delegate = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.becomeFirstResponder()
    }
    
    @IBAction func send(_ sender: AnyObject) {
        textView.resignFirstResponder()
        delegate?.didSend(message: textView.text)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancel(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
}
