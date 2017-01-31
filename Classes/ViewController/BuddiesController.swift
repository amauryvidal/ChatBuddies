import UIKit

class BuddiesController: UITableViewController {
    var repository: Repository
    var buddies: [Buddy] = []

    init(repository:Repository) {
        self.repository = repository
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        self.title = "Buddies"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.buddies = self.repository.findBuddies()
        self.tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.buddies).count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let CellIdentifier: String = "BuddyCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier)
        cell = UITableViewCell(style: .subtitle, reuseIdentifier: CellIdentifier)
        cell!.accessoryType = .disclosureIndicator
        let buddy: Buddy = self.buddies[(indexPath as NSIndexPath).row]
        cell!.imageView!.image = UIImage(named: "\(buddy.name).jpg")
        cell!.textLabel!.text = buddy.name
        cell!.detailTextLabel?.text = buddy.lastMessage?.text
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let buddy: Buddy = (self.buddies)[(indexPath as NSIndexPath).row]
        let ctrl: ChatController = ChatController(buddy: buddy, repository: self.repository)
        self.navigationController!.pushViewController(ctrl, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 48
    }
    
}
