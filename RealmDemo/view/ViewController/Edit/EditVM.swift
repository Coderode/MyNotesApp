//
//  EditVM.swift
//  RealmDemo
//
//  Created by Sandeep on 13/06/21.
//

import UIKit
import RealmSwift

class EditVM: NSObject {
    weak var view : EditView! {
        didSet{
            setupButton()
        }
    }
    func setupButton(){
        self.view.noteSaveButton.addTarget(self, action: #selector(didTapOnSaveButon), for: .touchUpInside)
        self.view.noteDeleteButton.addTarget(self, action: #selector(didTapOnDeleteButton), for: .touchUpInside)
    }
    @objc func didTapOnSaveButon(){
        let title = self.view.titleTextField.text ?? ""
        let trimmedtitle = title.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let content = self.view.textView.text ?? ""
        let trimmedcontent = content.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if trimmedtitle.count > 0 || trimmedcontent.count > 0 {
            if let data = self.view.data {
                /// modifiy notte in realm only if there is change in content
                if data.title != title || data.content != content {
                    RealmDataBase.shared.updateDataForObject(id: data.id, title: title, content: content)
                }
            }else {
                /// create new note in realm
                let note = Note(title: title)
                note.content = content
                note.id = note.IncrementaID()
                RealmDataBase.shared.addDataForObject(object: note)
            }
        }
        
        (self.view as? UIViewController)?.navigationController?.popViewController(animated: true)
    }
    @objc func didTapOnDeleteButton(){
        let alert = UIAlertController(title: "Delete Note!", message: "Are you sure to delete the note?",         preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
            //Cancel Action
        }))
        alert.addAction(UIAlertAction(title: "Delete",style: .destructive,handler: {(_: UIAlertAction!) in
            /// delte note
            if let data = self.view.data {
                /// perfom delete on realm
                RealmDataBase.shared.deleteDataForObject(id: data.id)
            }
            (self.view as? UIViewController)?.navigationController?.popViewController(animated: true)
        }))
        (self.view as! UIViewController).present(alert, animated: true, completion: nil)
        
    }
    
}
