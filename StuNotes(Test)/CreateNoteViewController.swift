//
//  CreateNoteViewController.swift
//  StuNotes(Test)
//
//  Created by Сэнди Белка on 23.11.2020.
//

import UIKit

final class CreateNoteViewController: UIViewController {
    
    private let textView = UITextView()
    private let fontName = "Arial"
    private let fontSize: CGFloat = 23.0
    private var defaultString = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        forTextView()
        crutch()
    }
    
//      MARK: - I want to be straight with you - it's a crutch.
    private func crutch() {
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "SAVE", style: .plain, target: self, action: #selector(saveButton))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if NoteArray.numberSelectedCell != -1 {
            getNote()
        }
    }
    

    private func getNote() {
        
        textView.text = NoteArray.wholeNote[NoteArray.numberSelectedCell]
    }
    
    private func forTextView(){
        
        textView.font = UIFont.init(name: fontName, size: fontSize)
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
            
            NoteArray.wholeNote.insert(defaultString, at: 0)
            NoteArray.dateArray.insert(getDate(), at: 0)
            if let indexEnter = defaultString.firstIndex(of: "\n") {
                defaultString = String(defaultString.prefix(upTo: indexEnter))
            }
            NoteArray.nameArray.insert(defaultString, at: 0)
        }
        else {
            
            NoteArray.wholeNote[NoteArray.numberSelectedCell] = defaultString
            NoteArray.dateArray[NoteArray.numberSelectedCell] = getDate()
            if let indexEnter = defaultString.firstIndex(of: "\n") {
                defaultString = String(defaultString.prefix(upTo: indexEnter))
            }
            NoteArray.nameArray[NoteArray.numberSelectedCell] = defaultString
            
            NoteArray.nameArray.insert(NoteArray.nameArray[NoteArray.numberSelectedCell], at: 0)
            NoteArray.wholeNote.insert(NoteArray.wholeNote[NoteArray.numberSelectedCell], at: 0)
            NoteArray.dateArray.insert(NoteArray.dateArray[NoteArray.numberSelectedCell], at: 0)
            
            NoteArray.nameArray.remove(at: NoteArray.numberSelectedCell + 1)
            NoteArray.wholeNote.remove(at: NoteArray.numberSelectedCell + 1)
            NoteArray.dateArray.remove(at: NoteArray.numberSelectedCell + 1)
        }
        navigationController?.popViewController(animated: true)
    }
    
    private func getDate() -> String {
        
        let date = Date()
        let formatter = DateFormatter()
        
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        return formatter.string(from: date)
    }
    
}

