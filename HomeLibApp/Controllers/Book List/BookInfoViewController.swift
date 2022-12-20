//
//  BookInfoViewController.swift
//  HomeLibApp
//
//  Created by Ma Millerr on 24.10.2022.
//

import UIKit

class BookInfoViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var pubHouseLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var translatorLabel: UILabel!
    
    var book: Book!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        authorLabel.text = book.author
        pubHouseLabel.text = book.pubHouse
        genreLabel.text = book.genre
        statusLabel.text = book.status
        locationLabel.text = book.location
        translatorLabel.text = book.translator
        
        
        if let bookImage = UIImage(named: book.name) {
            image.image = bookImage
        } else {
            image.image = UIImage(named: "Заглушка")
        }
        
        titleLabel.text = book.name
//        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editButtonTapped))
        let swipeRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        swipeRecognizer.direction = .down
        view.addGestureRecognizer(swipeRecognizer)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Редактировать", style: .done, target: self, action: #selector(editButtonTapped))
    }
    
    @objc func handleSwipe(gesture: UISwipeGestureRecognizer) {
        dismiss(animated: true)
    }
    
    @objc func editButtonTapped() {
        let contactOption = EditTableViewController()
        navigationController?.pushViewController(contactOption, animated: true)
        
        contactOption.bookModel = book
    }
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
}
