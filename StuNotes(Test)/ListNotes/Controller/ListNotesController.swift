import UIKit
import CoreData

final class ListNotesController {
    
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func getFontSize(name: UILabel, date: UILabel) {
        name.font = .systemFont(ofSize: UIScreen.main.bounds.height / 30.3)
        date.font = .systemFont(ofSize: UIScreen.main.bounds.height / 50)
    }
    
    func loadArray() {
        let fetchRequest: NSFetchRequest<Notes> = Notes.fetchRequest()
        
        do {
            NoteArray.notesArray = try context.fetch(fetchRequest).reversed()
        } catch {
            print("Error")
        }
    }
    
    func deleteNote(indexPath: IndexPath, tableView: UITableView) {
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
