import UIKit

class HobbyProjectViewController: UIViewController, UITextViewDelegate {
    
    var hobbyProject: String
    
    private let notesView = UITextView()
    
    var fileURL: URL {
        let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        
        let safeName = hobbyProject.replacingOccurrences(of: " ", with: "_")
        
        return documents.appendingPathComponent("\(safeName)_note.txt")
    }
    
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
        
        setupNotesView()
        loadNote()
    }
    
    private func setupNotesView() {
        notesView.frame = CGRect(x: 26, y: 110, width: 350, height: 650)
        notesView.textColor = .label
        notesView.font = UIFont.systemFont(ofSize: 18)
        notesView.layer.cornerRadius = 8
        notesView.layer.borderWidth = 2
        notesView.backgroundColor = .systemGray4
        
        notesView.delegate = self
        
        view.addSubview(notesView)
    }
    
    func saveNote() {
        do {
            try notesView.text.write(to: fileURL, atomically: true, encoding: .utf8)
        } catch {
            print("Error saving note:", error)
        }
    }
    
    func loadNote() {
        do {
            let savedText = try String(contentsOf: fileURL, encoding: .utf8)
            notesView.text = savedText
        } catch {
            print("No existing note file (first launch).")
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        saveNote()
    }
}
