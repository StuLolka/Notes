//
//  CreateNoteViewController.swift
//  StuNotes(Test)
//
//  Created by Сэнди Белка on 23.11.2020.
//

import UIKit
import CoreData

final class CreateNoteViewController: UIViewController {
    
    private let textView = UITextView()
    private var defaultString = ""

    lazy private var appDelegate = UIApplication.shared.delegate as! AppDelegate
    lazy private var context = appDelegate.persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        crutch()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if NoteArray.numberSelectedCell != -1 {
            getNote()
        }
    }
    
//      MARK: - I want to be straight with you - it's a crutch.
    private func crutch() {
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "SAVE", style: .plain, target: self, action: #selector(saveButton))
    }
    
    private func getNote() {
        
        let text = NoteArray.notesArray[NoteArray.numberSelectedCell]
        textView.text = text.note ?? "error"
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
        
        defaultString = textView.text
        if NoteArray.numberSelectedCell == -1 {
            if let indexEnter = defaultString.firstIndex(of: "\n") {
                defaultString = String(defaultString.prefix(upTo: indexEnter))
            }
            
            saveNote(name: defaultString, note: textView.text, date: getDate())
        }
        else {

            saveNote(name: defaultString, note: textView.text, date: getDate())
            deleteNoteAfterEdit(with: NoteArray.numberSelectedCell + 1)
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    private func getDate() -> String {
        
        let date = Date()
        let formatter = DateFormatter()
        
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        return formatter.string(from: date)
    }
    
//     MARK: - save and dalete note
    private func saveNote(name: String, note: String, date: String) {
        
        let entity = NSEntityDescription.entity(forEntityName: "Notes", in: context)
        let notesObj = NSManagedObject(entity: entity!, insertInto: context) as! Notes
        
        notesObj.name = name
        notesObj.note = note
        notesObj.date = date
        
        do {
            try context.save()
            NoteArray.notesArray.insert(notesObj, at: 0)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func deleteNoteAfterEdit(with number: Int) {
        
        let noteNeedDelete = NoteArray.notesArray[number]
        context.delete(noteNeedDelete)
        
        do {
            try context.save()
            NoteArray.notesArray.remove(at: number)
        } catch {
            print("error delete")
        }
    }
    
}

