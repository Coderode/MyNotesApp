//
//  RealmDatabase.swift
//  RealmDemo
//
//  Created by Sandeep on 13/06/21.
//

import Foundation
import RealmSwift

class RealmDataBase : NSObject {
    static let shared = RealmDataBase()
    var realm : Realm!
    
    override init(){
        do{
            self.realm = try Realm()
        }catch {
            print("space not available")
        }
    }
    
    func fetchDataForObject() -> Results<Note>{
        let objects =  realm.objects(Note.self).sorted(byKeyPath: "dateModified", ascending: false)
        return objects
    }
    func addDataForObject(object : Note) {
        realm.beginWrite()
        realm.add(object)
        try! realm.commitWrite()
    }
    func updateDataForObject(id : Int, title : String, content : String) {
        let object = realm.object(ofType: Note.self, forPrimaryKey: id)
        realm.beginWrite()
        if let object = object {
            object.title = title
            object.content = content
            object.dateModified = Date()
        }
        try! realm.commitWrite()
    }
    func deleteDataForObject(id : Int) {
        let objectsToDelete = realm.object(ofType: Note.self, forPrimaryKey: id)
        realm.beginWrite()
        if let objectsToDelete = objectsToDelete {
            realm.delete(objectsToDelete)
        }
        try! realm.commitWrite()
    }
}



extension Results {
    func toArray<T>(ofType: T.Type) -> [T] {
        var array = [T]()
        for i in 0 ..< count {
            if let result = self[i] as? T {
                array.append(result)
            }
        }

        return array
    }
}
