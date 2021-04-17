//
//  NotesListExtension.swift
//  StuNotes(Test)
//
//  Created by Сэнди Белка on 17.04.2021.
//

import UIKit

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

