import UIKit
import CoreData

final public class CreateNoteController {
    
    private let textView: UITextView
    private let context: NSManagedObjectContext
    
    init(textView: UITextView, context: NSManagedObjectContext) {
        self.textView = textView
        self.context = context
    }
    
    func getNote() {
        
        let text = NoteArray.notesArray[NoteArray.numberSelectedCell]
        guard let textNote = text.note else {return }
        textView.text = textNote
    }
    
    func saveNoteButton() {
        var defaultString = ""
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
