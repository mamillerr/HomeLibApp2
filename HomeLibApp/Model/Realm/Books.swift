//
//  Books.swift
//  HomeLibApp
//
//  Created by Ma Millerr on 24.10.2022.
//

import Foundation
import RealmSwift

class Book: Object {
    
    @Persisted var name: String = ""
    @Persisted var author: String = ""
    @Persisted var genre: String = ""
    @Persisted var translator: String = ""
    @Persisted var status: String = ""
    @Persisted var pubHouse: String = ""
    @Persisted var location: String = ""
    @Persisted var image: String = ""
    @Persisted var isFavourite: Bool = false
    
}
