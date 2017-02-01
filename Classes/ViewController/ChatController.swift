import UIKit

class ChatController: UITableViewController {
    
    var viewModel: ChatViewModel!
    var botClient = APIClient()
    
    deinit {
        botClient.cancelBotResponseRequest()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if viewModel == nil {
            fatalError("The view model is mandatory for this controller to work")
        }
        
        navigationItem.title = viewModel.buddy.name
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 76
        
        botClient.startBot()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        scrollToLastMessage()
        requestBotResponse()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        botClient.cancelBotResponseRequest()
    }
    
    
    // MARK: - Table View
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.nbMessages
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TextViewCell.identifier, for: indexPath) as! TextViewCell
        if let message = viewModel.message(at: indexPath.row) {
            cell.configure(message: message)
        }
        return cell
    }
    
    
    // MARK: - Bot
    
    func addMessage(_ text: String, fromMe: Bool) {
        viewModel.addMessage(text: text, fromMe: fromMe)
        if fromMe { requestBotResponse() }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.scrollToLastMessage()
        }
    }
    
    func requestBotResponse() {
        botClient.requestBotResponse(lastMessage: viewModel.lastMessageContent) { response in
            self.addMessage(response, fromMe: false)
        }
    }
    
    // MARK: - UI
    
    func scrollToLastMessage() {
        let row = viewModel.nbMessages
        if row > 0 {
            tableView.scrollToRow(at: IndexPath(row: row-1, section: 0), at: .bottom, animated: false)
        }
    }
    
    
    // MARK: - Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sendMessage",
            let vc = (segue.destination as? UINavigationController)?.viewControllers.first as? SendController {
            vc.delegate = self
        }
    }
}

extension ChatController: SendControllerDelegate {
    func didSend(message text: String) {
        addMessage(text, fromMe: true)
    }
}
