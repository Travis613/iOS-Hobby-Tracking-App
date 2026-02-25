import UIKit

class HobbyGroupsViewController: UIViewController, UITableViewDataSource {
    
    var hobbyProjects = ["MTG Life Counting Website", "Learn to play the piano", "Build this app"]
    
    @IBOutlet weak var HobbyGroupsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Hobby Projects"
        HobbyGroupsTableView.dataSource = self
    }
    
    @IBAction func addItem(_ sender: Any) {
        let container = UIView(frame: CGRect(x: 37.5, y: 125, width: 325, height: 130))
        container.layer.borderWidth = 0.5
        container.layer.cornerRadius = 10
        container.layer.borderColor = UIColor.lightGray.cgColor
        container.backgroundColor = UIColor.white
        
        let inputbox = UITextField(frame: CGRect(x: 10, y: 10, width: 300, height: 50))
        inputbox.placeholder = "Add A New Hobby Project"
        inputbox.borderStyle = .roundedRect
        inputbox.backgroundColor = UIColor.white
        container.addSubview(inputbox)
        
        let cancelBTN = UIButton(frame: CGRect(x: 10, y: 85, width: 100, height: 30))
        cancelBTN.backgroundColor = UIColor.systemRed
        cancelBTN.setTitle("Cancel", for: .normal)
        cancelBTN.layer.cornerRadius = 10
        cancelBTN.layer.borderWidth = 0.5
        cancelBTN.layer.borderColor = UIColor.lightGray.cgColor
        container.addSubview(cancelBTN)
        
        let addBTN = UIButton(frame: CGRect(x: 210, y: 85, width: 100, height: 30))
        addBTN.backgroundColor = UIColor.systemMint
        addBTN.setTitle("Add", for: .normal)
        addBTN.layer.cornerRadius = 10
        addBTN.layer.borderWidth = 0.5
        addBTN.layer.borderColor = UIColor.lightGray.cgColor
        container.addSubview(addBTN)
        
        view.addSubview(container)
    }
    
    // Returns the number of row based on the amount of rows in out hobbies array
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hobbyProjects.count
    }
    
    // Configures and returns each cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = HobbyGroupsTableView.dequeueReusableCell(withIdentifier: "HobbyProjectsCell", for:indexPath)
        cell.textLabel?.text = hobbyProjects[indexPath.row]
        return cell
    }
    
}
