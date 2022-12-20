//
//  WannaReadTableViewController.swift
//  HomeLibApp
//
//  Created by Ma Millerr on 12.12.2022.
//

import UIKit
import RealmSwift

class WannaReadTableViewController: UITableViewController {
    
    private var books: Results<WRBook>!
    private let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 80
        createTempData()
        books = realm.objects(WRBook.self)
    }
    
    
    private func createTempData() {
        if !UserDefaults.standard.bool(forKey: "done") {
            DataManager2.shared.createTempData { [unowned self] in
                UserDefaults.standard.set(true, forKey: "done")
                tableView.reloadData()
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        books.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell3", for: indexPath)
        var content = cell.defaultContentConfiguration()
        let book = books[indexPath.row]
        
        content.text = book.name
        content.secondaryText = book.author
        
        if let bookImage = UIImage(named: book.name) {
            content.image = bookImage
        } else {
            content.image = UIImage(named: "Заглушка")
        }
        
        
        cell.contentConfiguration = content
        
        
        return cell
    }
    
    //    override func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
    //        false
    //    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let book = books[indexPath.row]
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Удалить") { _, _, _ in
            
            StorageManager.shared.delete2(book)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            
            self.tableView.reloadData()
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    
    // MARK: - Navigation
    
    @IBAction func unwindSegue(segue: UIStoryboardSegue) {
        guard segue.identifier == "saveSegue" else { return }
        guard let addVC = segue.source as? AddNewBookViewController else { return }
        let newBook = addVC.book
        
        let indexPath = IndexPath(row: books.count, section: 0)
        
        StorageManager.shared.save2(newBook!)
        tableView.insertRows(at: [indexPath], with: .fade)
        
    }
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true)
    }
}
