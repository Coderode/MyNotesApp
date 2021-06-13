//
//  MyNotesVC.swift
//  RealmDemo
//
//  Created by Sandeep on 13/06/21.
//

import UIKit
import RealmSwift
protocol MyNotesVeiw : class {
    var tableView: UITableView! { get }
    var addNoteButton: UIBarButtonItem! { get }
    var notes : Results<Note>? { get set }
}

class MyNotesVC: UIViewController,MyNotesVeiw {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addNoteButton: UIBarButtonItem!
    var vm : MyNotesVM!
    var uivc : MyNotesUIVC!
    var notes : Results<Note>?
    private var notificationToken : NotificationToken?
    override func viewDidLoad() {
        super.viewDidLoad()
        vm = MyNotesVM()
        uivc = MyNotesUIVC()
        vm.view = self
        vm.delegate = self
        uivc.view = self
        vm.fetchNotesFromDatabase()
    }
}

extension MyNotesVC : MyNotesVMDelegate {
    func updateObserver() {
        self.notificationToken = notes?.observe({ (changes) in
            switch changes {
            case .initial:
                self.tableView.reloadData()
            case .update(_, let deletions, let insertions, let modifications):
                self.vm.updateTableView(deletions: deletions, insertions: insertions, updates: modifications)
            case .error(let error):
                // An error occurred while opening the Realm file on the background worker thread
                print(error.localizedDescription)
            }
        })
    }
}
