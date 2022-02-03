import UIKit
import CoreData

final class ListNotesViewController: UIViewController {

    private var isRunning = false
    
    private let tableView = UITableView()
    lazy private var heightCell = (tableView.frame.height / 9) - 1
    
    lazy private var appDelegate = UIApplication.shared.delegate as! AppDelegate
    lazy private var context = appDelegate.persistentContainer.viewContext
    lazy private var controller = ListNotesController(context: context)
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        self.tableView.tableFooterView = UIView()
        setUpTableView()
    }
    
    //MARK: - viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        
        if !isRunning {
            controller.loadArray()
            isRunning = true
        }
        
        tableView.reloadData()
        NoteArray.numberSelectedCell = -1
    }
    
    //MARK: - setUpTableView
    private func setUpTableView() {
        
        tableView.layer.borderWidth = 0.2
        tableView.layer.cornerRadius = 8
        tableView.layer.borderColor = CGColor(red: 0.474, green: 0.475, blue: 0.486, alpha: 1.0)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(Cell.self, forCellReuseIdentifier: "Cell")
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20)
        ])

    }
}


extension ListNotesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NoteArray.notesArray.count
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightCell
    }
    
    //MARK: return cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? Cell {
            let note = NoteArray.notesArray[indexPath.row]
            if let nameNote = note.name {
                if let dateNote = note.date {
                    cell.set(name: nameNote, date: dateNote)
                    controller.getFontSize(name: cell.name, date: cell.date)
                    return cell
                }
                else {
                    print("error note's date")
                    return UITableViewCell()
                }
            }
            else {
                print("error note's name")
                return UITableViewCell()
            }
        }
        else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            controller.deleteNote(indexPath: indexPath, tableView: tableView)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NoteArray.numberSelectedCell = indexPath.row
        navigationController?.pushViewController(CreateNoteViewController(), animated: true)
    }
}

