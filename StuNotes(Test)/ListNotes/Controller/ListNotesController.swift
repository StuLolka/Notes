//
//  ListNotesModel.swift
//  StuNotes(Test)
//
//  Created by Сэнди Белка on 17.04.2021.
//

import UIKit
import CoreData

final public class ListNotesController {
    
    private let context: NSManagedObjectContext
    private let view: UIView
    
    init(context: NSManagedObjectContext, view: UIView) {
        self.context = context
        self.view = view
    }
    
    public func getFontSize(name: UILabel, date: UILabel) {
        name.font = .systemFont(ofSize: view.frame.height / 30.3)
        date.font = .systemFont(ofSize: view.frame.height / 50)
        print(view.frame.height)
        
    }
    
    public func loadArray() {
        let fetchRequest: NSFetchRequest<Notes> = Notes.fetchRequest()
        
        do {
            NoteArray.notesArray = try context.fetch(fetchRequest).reversed()
        } catch {
            print("Error")
        }
    }
    
    public func deleteNote(indexPath: IndexPath, tableView: UITableView) {
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
