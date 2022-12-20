//
//  DataManager.swift
//  HomeLibApp
//
//  Created by Ma Millerr on 06.12.2022.
//

import Foundation
import RealmSwift

class DataManager {
    static let shared = DataManager()
    private init() {}
    
    let realm = try! Realm()
    
    func createTempData(completion: @escaping () -> Void) {
        
        let testTask1 = Book(value: ["Name", "Author"]) // дефолтный экзепляр книги
        
        
        DispatchQueue.main.async {
            StorageManager.shared.save(testTask1)
            completion()
        }
    }
}

class DataManager2 {
    static let shared = DataManager2()
    private init() {}
    
    let realm = try! Realm()
    
    func createTempData(completion: @escaping () -> Void) {
        
        let testTask2 = WRBook(value: ["Name", "Author"])
        
        DispatchQueue.main.async {
            StorageManager.shared.save2(testTask2)
            completion()
        }
    }
}
