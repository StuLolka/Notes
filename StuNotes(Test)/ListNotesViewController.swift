//
//  ViewController.swift
//  StuNotes(Test)
//
//  Created by Сэнди Белка on 23.11.2020.
//

import UIKit
import CoreData

final class ListNotesViewController: UIViewController {

    
    private let newView = UIView()
    private var isJustRun = true
    
    public let tableView = UITableView()
    lazy private var heightCell = (tableView.frame.height / 9) - 1
    
    lazy private var appDelegate = UIApplication.shared.delegate as! AppDelegate
    lazy private var context = appDelegate.persistentContainer.viewContext
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        self.tableView.tableFooterView = UIView()
        setUpTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if isJustRun {
            let fetchRequest: NSFetchRequest<Notes> = Notes.fetchRequest()
            
            do {
                NoteArray.notesArray = try context.fetch(fetchRequest).reversed()
            } catch {
            }
            
            isJustRun = false
        }
        
        tableView.reloadData()
        NoteArray.numberSelectedCell = -1
    }
    
    
    private func setUpTableView() {
        
        tableView.layer.borderWidth = 0.2
        tableView.layer.cornerRadius = 8
        tableView.layer.borderColor = CGColor(red: 0.474, green: 0.475, blue: 0.486, alpha: 1.0)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(Cell.self, forCellReuseIdentifier: "Cell")
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
    }
}


//           MARK: - UITableViewDelegate, UITableViewDataSource

extension ListNotesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NoteArray.notesArray.count
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightCell
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? Cell {
            let note = NoteArray.notesArray[indexPath.row]
            cell.set(name: note.name ?? "error", date: note.date ?? "error")
            return cell
        }
        else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            let noteNeedDelete = NoteArray.notesArray[indexPath.row]
            context.delete(noteNeedDelete)
            
            do {
                try context.save()
                NoteArray.notesArray.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            } catch {
                print("error delete")
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        NoteArray.numberSelectedCell = indexPath.row
        navigationController?.pushViewController(CreateNoteViewController(), animated: true)
    }
}


