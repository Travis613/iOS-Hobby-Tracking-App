import UIKit

class HobbyGroupsViewController: UIViewController{
    
    let tableView: UITableView = {
        let HobbyGroupTableView = UITableView()
        HobbyGroupTableView.translatesAutoresizingMaskIntoConstraints = false
        HobbyGroupTableView.allowsSelection = true
        HobbyGroupTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return HobbyGroupTableView
    }()
    
    var hobbyProjects = ["MTG Life Counting Website", "Learn to play the piano", "Build this app"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItem))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editItem))
        title = "Hobby Projects"
        view.backgroundColor = .white
        buildTableView()
    }
    
    func buildTableView (){
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor)
        ])
    }
    
    @objc func editItem(_ sender: Any) {
        print("I have been clikced")
    }
    
    @objc func addItem(_ sender: Any) {
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
        
        let addBTN = UIButton(frame: CGRect(x: 210, y: 85, width: 100, height: 30), primaryAction: UIAction(title: "Tap Me", handler: { action in
            let newHobby: String = inputbox.text!
            self.hobbyProjects.append(newHobby)
            self.tableView.reloadData()
            container.removeFromSuperview()
        }))
        
        addBTN.backgroundColor = UIColor.systemMint
        addBTN.setTitle("Add", for: .normal)
        addBTN.layer.cornerRadius = 10
        addBTN.layer.borderWidth = 0.5
        addBTN.layer.borderColor = UIColor.lightGray.cgColor
        container.addSubview(addBTN)
        
        view.addSubview(container)
        
    }
    
}

extension HobbyGroupsViewController: UITableViewDataSource, UITableViewDelegate{
    // Returns the number of row based on the amount of rows in out hobbies array
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hobbyProjects.count
    }
    
    // Configures and returns each cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for:indexPath)
        cell.textLabel?.text = hobbyProjects[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    // Load the individual hobby project view contoller
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(HobbyProjectViewController(hobbyProject: hobbyProjects[indexPath.row]), animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
