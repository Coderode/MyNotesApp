//
//  Note.swift
//  RealmDemo
//
//  Created by Sandeep on 13/06/21.
//

import Foundation
import UIKit
import RealmSwift


class Note : Object{
    @objc dynamic var id : Int = 0
    @objc dynamic var title: String = ""
    @objc dynamic var content: String = ""
    @objc dynamic var dateCreated: Date?
    @objc dynamic var dateModified : Date?
    convenience init(title : String) {
        self.init()
        self.title = title
        self.dateCreated = Date()
        self.dateModified = Date()
    }
    override static func primaryKey() -> String? {
        return "id"
    }
    //Incrementa ID
    func IncrementaID() -> Int{
        let realm = try! Realm()
        if let retNext = realm.objects(Note.self).sorted(byKeyPath: "id").last?.id {
            return retNext + 1
        }else{
            return 1
        }
    }
}
