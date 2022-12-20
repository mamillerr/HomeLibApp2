//
//  EditTableViewController.swift
//  HomeLibApp
//
//  Created by Ma Millerr on 14.12.2022.
//

import UIKit
import RealmSwift

class EditTableViewController: UITableViewController {
    
    let idOptionsCell = "idOptionsContactCell"
    let idOptionsHeader = "idOptionsContactHeader"
    
    var cellNameArray = ["", "author", "genre", "publishment", "traslator", "status", "location", ""]
    let headerNameArray = ["НАЗВАНИЕ","АВТОР","ЖАНР","ИЗДАТЕЛЬ","ПЕРЕВОДЧИК","СТАТУС","РАСПОЛОЖЕНИЕ","ОБЛОЖКА"]
    
    var bookModel: Book!
    
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Редактирование"
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.97, alpha: 1.00)
        tableView.separatorStyle = .none
        tableView.bounces = false
        
        tableView.register(OptionsTableViewCell.self, forCellReuseIdentifier: idOptionsCell)
        tableView.register(HeaderOptionsTableViewCell.self, forHeaderFooterViewReuseIdentifier: idOptionsHeader)
        
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonTapped))
        
        cellNameArray = [bookModel.name, bookModel.author, bookModel.genre, bookModel.pubHouse, bookModel.translator, bookModel.status, bookModel.location, ""]
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Назад", style: .done, target: self, action: #selector(backButtonTapped))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Сохранить", style: .done, target: self, action: #selector(saveButtonTapped))
    }
    
    @objc private func backButtonTapped() {
        dismiss(animated: true)
    }
    
    @objc private func saveButtonTapped() {
        StorageManager.shared.edit(book: self.bookModel, newValueName: bookModel.name, newValueAuthor: bookModel.author, newValueGenre: bookModel.genre, newValuePubhouse: bookModel.pubHouse, newValueTranslator: bookModel.translator, newValueStatus: bookModel.status, newValueLocation: bookModel.location, newValueImage: "")
        bookModel = Book()
        //        dismiss(animated: true)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        8
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idOptionsCell, for: indexPath) as! OptionsTableViewCell
        cell.cellContactCofiguration(nameArray: cellNameArray, indexPath: indexPath)
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        indexPath.section == 7 ? 200 : 44
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        15
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: idOptionsHeader) as! HeaderOptionsTableViewCell
        header.headerConfiguration(nameArray: headerNameArray, section: section)
        return header
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! OptionsTableViewCell
        
        switch indexPath.section {
        case 0:
            alertForCellName(label: cell.nameCellLabel, name: "Название", placeholder: "Введите имя") { [self] text in
                try! realm.write{
                    bookModel.name = text
                }
            }
        case 1:
            alertForCellName(label: cell.nameCellLabel, name: "Автор", placeholder: "Автор") {[self] text in
                try! realm.write{
                    bookModel.author = text
                }
            }
        case 2:
            alertForCellName(label: cell.nameCellLabel, name: "Жанр", placeholder: "") { [self]text in
                try! realm.write{
                    self.bookModel.genre = text}
                
            }
        case 3:
            alertForCellName(label: cell.nameCellLabel, name: "Издательство", placeholder: "") { [self]text in
                try! realm.write{
                    bookModel.pubHouse = text} }
        case 4:
            alertForCellName(label: cell.nameCellLabel, name: "Переводчик", placeholder: "") { [self]text in
                try! realm.write{
                    bookModel.translator = text}}
            
            
        case 5:
            alertForCellName(label: cell.nameCellLabel, name: "Статус", placeholder: "") { [self]text in
                try! realm.write{
                    bookModel.status = text}}
            
        case 6:
            alertForCellName(label: cell.nameCellLabel, name: "Местополжение", placeholder: "") { [self]text in
                try! realm.write{
                    bookModel.location = text}}
        case 7:
            alertPhoto { [self] source in
                chooseImagePicker(source: source)
            }
        default:
            print("asd")
        }
        
//        func pushControllers(vc: UIViewController) {
//
//            let viewController = vc
//            navigationController?.navigationBar.topItem?.title = "Options"
//            navigationController?.pushViewController(viewController, animated: true)
//
//        }
    }
    
    
}

extension EditTableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func chooseImagePicker(source: UIImagePickerController.SourceType) {
        if UIImagePickerController.isSourceTypeAvailable(source) {
            let ip = UIImagePickerController()
            ip.delegate = self
            ip.allowsEditing = true
            ip.sourceType = source
            present(ip, animated: true)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let cell = tableView.cellForRow(at: [7,0]) as! OptionsTableViewCell
        
        cell.backgroundViewCell.image = info[.editedImage] as? UIImage
        cell.backgroundViewCell.contentMode = .scaleAspectFill
        cell.backgroundViewCell.clipsToBounds = true
        dismiss(animated: true)
    }
}
