import UIKit

class HobbyProjectViewController: UIViewController {
    
    var hobbyProject: String;
    
    init(hobbyProject: String) {
        self.hobbyProject = hobbyProject
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = hobbyProject
    }

}
