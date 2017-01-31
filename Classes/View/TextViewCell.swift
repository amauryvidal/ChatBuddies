import UIKit

private let ident: String = "TextViewCell"

class TextViewCell: UITableViewCell {
    var textView: UITextView!

    init() {
        super.init(style: .default, reuseIdentifier: ident)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    class func cellForTableView(_ tableView: UITableView) -> TextViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: ident) as! TextViewCell?
        if cell == nil {
            cell = TextViewCell()
            cell!.textView = UITextView(frame: CGRect(x: 10, y: 0, width: 300, height: 30))
            cell!.textView.returnKeyType = .send
            cell!.textView.delegate = tableView.delegate as! UITextViewDelegate
            cell!.textView.isEditable = false
            cell!.textView.backgroundColor = UIColor.clear
            cell!.addSubview(cell!.textView)
        }
        return cell!
    }
}
