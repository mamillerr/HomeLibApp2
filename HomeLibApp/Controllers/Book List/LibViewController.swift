//
//  LibViewController.swift
//  HomeLibApp
//
//  Created by Ma Millerr on 24.10.2022.
//

import UIKit
import RealmSwift

class LibViewController: UITableViewController {
    
    private var realm = try! Realm()
    private var books: Results<Book>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 80
        createTempData()
        books = realm.objects(Book.self)
        
        let swipeRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        swipeRecognizer.direction = .down
        view.addGestureRecognizer(swipeRecognizer)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
    }
    
    @objc func handleSwipe(gesture: UISwipeGestureRecognizer) {
        self.tableView.reloadData()
    }
    
    @objc func addButtonTapped() {
        
        
        let contactOption = AddBookTableViewController()
        navigationController?.pushViewController(contactOption, animated: true)
    }
    
    private func createTempData() {
        if !UserDefaults.standard.bool(forKey: "done") {
            DataManager.shared.createTempData { [unowned self] in
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "book", for: indexPath)
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
            
            StorageManager.shared.delete(book)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            
            self.tableView.reloadData()
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let book = books[indexPath.row]
        let favouriteAction = UIContextualAction(style: .normal, title: "Favourite") {_, _, _ in
            
            DispatchQueue.main.async {
                StorageManager.shared.setFavourite(book)
            }
            
            tableView.reloadData()
        }
        
        favouriteAction.backgroundColor = .systemGray
        favouriteAction.image = book.isFavourite ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let bookInfoVC = segue.destination as? BookInfoViewController else { return }
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        
        bookInfoVC.book = books[indexPath.row]
    }
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true)
    }
}
