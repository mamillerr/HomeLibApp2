//
//  wannaReadBooks.swift
//  HomeLibApp
//
//  Created by Ma Millerr on 13.12.2022.
//

import Foundation
import RealmSwift

class WRBook: Object {
    
    @Persisted var name: String = ""
    @Persisted var author: String = ""
}
