//
//  AddBookTableViewController.swift
//  HomeLibApp
//
//  Created by Ma Millerr on 12.12.2022.
//

import UIKit

class AddBookTableViewController: UITableViewController {
    
    let idOptionsCell = "idOptionsContactCell"
    let idOptionsHeader = "idOptionsContactHeader"
    
    let cellNameArray = ["Название", "Автор", "Жанр", "Издатель", "Переводчик", "Статус", "Расположение", ""]
    let headerNameArray = ["НАЗВАНИЕ","АВТОР","ЖАНР","ИЗДАТЕЛЬ","ПЕРЕВОДЧИК","СТАТУС","РАСПОЛОЖЕНИЕ","ОБЛОЖКА"]
    
    var bookModel = Book()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Новая книга"
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.97, alpha: 1.00)
        tableView.separatorStyle = .none
        tableView.bounces = false
        
        tableView.register(OptionsTableViewCell.self, forCellReuseIdentifier: idOptionsCell)
        tableView.register(HeaderOptionsTableViewCell.self, forHeaderFooterViewReuseIdentifier: idOptionsHeader)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Назад", style: .done, target: self, action: #selector(backButtonTapped))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Сохранить", style: .done, target: self, action: #selector(saveButtonTapped))
    }
    
    @objc private func saveButtonTapped() {
        StorageManager.shared.save(self.bookModel)
        bookModel = Book()
        print(bookModel)
        dismiss(animated: true)        
    }
    
    @objc private func backButtonTapped() {
        dismiss(animated: true)
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
            alertForCellName(label: cell.nameCellLabel, name: "Название", placeholder: "Введите название") { [self] text in
                bookModel.name = text}
        case 1:
            alertForCellName(label: cell.nameCellLabel, name: "Автор", placeholder: "Введите имя автора") {[self] text in
                bookModel.author = text}
        case 2:
            alertForCellName(label: cell.nameCellLabel, name: "Жанр", placeholder: "Введите жанр") { [self]text in
                self.bookModel.genre = text}
        case 3:
            alertForCellName(label: cell.nameCellLabel, name: "Издатель", placeholder: "Введите название идательства") { [self]text in
                bookModel.pubHouse = text}
            
        case 4:
            alertForCellName(label: cell.nameCellLabel, name: "Переводчик", placeholder: "Название переводчика") { [self]text in
                bookModel.translator = text}
            
        case 5:
            alertForCellName(label: cell.nameCellLabel, name: "Статус", placeholder: "Статус") { [self]text in
                bookModel.status = text}
            
        case 6:
            alertForCellName(label: cell.nameCellLabel, name: "Местополжение", placeholder: "") { [self]text in
                bookModel.location = text}
        case 7:
            alertPhoto { [self] source in
                chooseImagePicker(source: source)
            }
        default:
            print("asd")
        }
        
        func pushControllers(vc: UIViewController) {
            
            let viewController = vc
            navigationController?.navigationBar.topItem?.title = "Options"
            navigationController?.pushViewController(viewController, animated: true)
            
        }
    }
}

extension AddBookTableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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
