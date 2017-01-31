import UIKit

class TextViewCell: UITableViewCell {
    static let identifier = "TextViewCell"
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var header: UILabel!

    func configure(message: Message) {
        textView.text = message.text
        backgroundColor = message.fromMe ? UIColor.white : UIColor(red: 0.95, green: 0.95, blue: 1, alpha: 1)
        var frame = textView.frame
        frame.size.height = textView.contentSize.height
        textView.frame = frame
        
        header.text = message.header
    }
}
