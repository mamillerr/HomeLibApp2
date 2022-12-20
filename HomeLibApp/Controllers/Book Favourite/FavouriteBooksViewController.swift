//
//  FavouriteBooksViewController.swift
//  HomeLibApp
//
//  Created by Ma Millerr on 06.12.2022.
//

import UIKit
import RealmSwift

class FavouriteBooksViewController: UITableViewController {
    
    var books: Results<Book>!
    var favouriteBooks: Results<Book>!
    
    let predicate = NSPredicate(format: "isFavourite = true")
    
    var numOfFavourite = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 80
        books = StorageManager.shared.realm.objects(Book.self).filter(predicate)
        
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        books.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favouriteBook", for: indexPath)
        
        
        var content = cell.defaultContentConfiguration()
        content.text = books[indexPath.row].name
        content.secondaryText = books[indexPath.row].author
        
        if let bookImage = UIImage(named: books[indexPath.row].name) {
            content.image = bookImage
        } else {
            content.image = UIImage(named: "Заглушка")
        }
        cell.contentConfiguration = content
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        false
    }
    
    //        override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    //            let book = books[indexPath.row]
    //
    //            let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { _, _, _ in
    //                    StorageManager.shared.delete(book)
    //
    //                tableView.deleteRows(at: [indexPath], with: .automatic)
    //                tableView.reloadData()
    //            }
    //
    //            return UISwipeActionsConfiguration(actions: [deleteAction])
    //        }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let book = books[indexPath.row]
        let favouriteAction = UIContextualAction(style: .normal, title: "Favourite") {_, _, _ in
            StorageManager.shared.setFavourite(book)
            self.numOfFavourite -= 1
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.reloadData()
        }
        
        if book.isFavourite {
            favouriteAction.image = UIImage(systemName: "star.fill")
            favouriteAction.backgroundColor = .systemYellow
        } else {
            favouriteAction.image = UIImage(systemName: "star")
            favouriteAction.backgroundColor = .systemGray
            
        }
        
        
        return UISwipeActionsConfiguration(actions: [favouriteAction])
    }
    
    // MARK: - Navigation
    
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true)
    }
}


