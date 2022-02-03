import UIKit
import CoreData

final class CreateNoteViewController: UIViewController {
    
    private let textView = UITextView()

    lazy private var appDelegate = UIApplication.shared.delegate as! AppDelegate
    lazy private var context = appDelegate.persistentContainer.viewContext
    lazy private var controller = CreateNoteController(textView: textView, context: context)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UITraitCollection.current.userInterfaceStyle == .dark {
            view.backgroundColor = .black
        }
        else {
            view.backgroundColor = .white
        }
        
        setUpTableView()
        setUpSaveButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if NoteArray.numberSelectedCell != -1 {
            getNote()
        }
    }
    
    private func getNote() {
        controller.getNote()
    }

    private func setUpSaveButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "SAVE", style: .plain, target: self, action: #selector(saveButton))
    }

    
    private func setUpTableView() {
        textView.font = UIFont.init(name: "Arial", size: 23.0)
        view.addSubview(textView)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        textView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        textView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        textView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
    }
    
    @IBAction func saveButton(_ sender: UIBarButtonItem) {
        guard textView.text.trimmingCharacters(in: .whitespacesAndNewlines) != "" else {return }
        controller.saveNoteButton()
        navigationController?.popViewController(animated: true)
    }
    
}

