//
//  SearchViewController.swift
//  HomeLibApp
//
//  Created by Grigory Don on 06.12.2022.
//

import UIKit
import RealmSwift

class SearchViewController: UITableViewController {

    var booksInRealm: Results<Book>!
    var books: [Book]!
    var filteredData = [Book]()
    
    
    let searchController = UISearchController(searchResultsController: .none)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Поиск"
        
        searchController.searchBar.placeholder = "Поиск"
        navigationItem.searchController = searchController
        booksInRealm = StorageManager.shared.realm.objects(Book.self)
        books = booksInRealm.toArray()
        tableView.rowHeight = 80
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchedCell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        let book = filteredData[indexPath.row]
        
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

extension SearchViewController: UISearchBarDelegate {
        
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        self.filteredData.removeAll()
        
        guard searchText != "" || searchText != " " else {
            print("Error")
            return }
        
        for book in books {
            if book.name.uppercased().contains(searchText.uppercased()) {
                filteredData.append(book)
            }
        }
        
        self.tableView.reloadData()
        
        print(filteredData)
    }
}

extension Results {
    func toArray() -> [Element] {
      return compactMap {
        $0
      }
    }
 }

