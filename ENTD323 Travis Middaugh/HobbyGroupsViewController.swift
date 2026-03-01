import UIKit

class HobbyGroupsViewController: UIViewController {
    
    let tableView: UITableView = {
        let HobbyGroupTableView = UITableView()
        HobbyGroupTableView.translatesAutoresizingMaskIntoConstraints = false
        HobbyGroupTableView.allowsSelection = true
        HobbyGroupTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return HobbyGroupTableView
    }()
    
    var hobbyProjects: [String] = []
    
    var fileURL: URL {
        let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        return documents.appendingPathComponent("hobbyProjects.json")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addItem)
        )
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .edit,
            target: self,
            action: #selector(editItem)
        )
        
        title = "Hobby Projects"
        view.backgroundColor = .white
        
        buildTableView()
        loadFromFile()
    }

    func buildTableView() {
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
    
    
    
    func saveToFile() {
        do {
            let data = try JSONEncoder().encode(hobbyProjects)
            try data.write(to: fileURL)
        } catch {
            print("Error saving file:", error)
        }
    }
    
    func loadFromFile() {
        do {
            let data = try Data(contentsOf: fileURL)
            hobbyProjects = try JSONDecoder().decode([String].self, from: data)
        } catch {
            print("No existing file found (first launch).")
        }
    }
    
    @objc func editItem(_ sender: Any) {
        tableView.setEditing(!tableView.isEditing, animated: true)
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
        container.addSubview(inputbox)
        
        let cancelBTN = UIButton(frame: CGRect(x: 10, y: 85, width: 100, height: 30), primaryAction: UIAction { _ in
            container.removeFromSuperview()
        })
        
        cancelBTN.backgroundColor = .systemRed
        cancelBTN.setTitle("Cancel", for: .normal)
        cancelBTN.layer.cornerRadius = 10
        container.addSubview(cancelBTN)
        
        let addBTN = UIButton(frame: CGRect(x: 210, y: 85, width: 100, height: 30), primaryAction: UIAction { _ in
            
            guard let newHobby = inputbox.text, !newHobby.isEmpty else { return }
            
            self.hobbyProjects.append(newHobby)
            self.saveToFile()
            self.tableView.reloadData()
            container.removeFromSuperview()
        })
        
        addBTN.backgroundColor = .systemMint
        addBTN.setTitle("Add", for: .normal)
        addBTN.layer.cornerRadius = 10
        container.addSubview(addBTN)
        
        view.addSubview(container)
    }
}

extension HobbyGroupsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hobbyProjects.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = hobbyProjects[indexPath.row]
        cell.textLabel?.font = UIFont.systemFont(ofSize: 18.0)
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        
        navigationController?.pushViewController(
            HobbyProjectViewController(
                hobbyProject: hobbyProjects[indexPath.row]
            ),
            animated: true
        )
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            hobbyProjects.remove(at: indexPath.row)
            saveToFile()
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}
