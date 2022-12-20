//
//  AlertCellName.swift
//  HomeLibApp
//
//  Created by Ma Millerr on 12.12.2022.
//

import UIKit

extension UIViewController {
    
    func alertForCellName(label: UILabel, name: String, placeholder: String, completionHandler: @escaping (String) -> Void) {
        
        let alert = UIAlertController(title: name, message: nil, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "OK", style: .default) { (action) in
            
            let tfAlert = alert.textFields?.first
            guard let text = tfAlert?.text else { return }
            label.text = text
            completionHandler(text)
        }
        
        alert.addTextField { (tfAlert: UITextField) in
            tfAlert.placeholder = placeholder
        }
        
        let cancel = UIAlertAction(title: "Отмена", style: .default, handler: nil)
        
        
        alert.addAction(cancel)
        alert.addAction(ok)
        
        present(alert, animated: true, completion: nil)
    }
    
//    func alertForCellName2(label: String, name: String, placeholder: String, completionHandler: @escaping (String) -> Void) {
//        
//        let alert = UIAlertController(title: name, message: nil, preferredStyle: .alert)
//
//        let ok = UIAlertAction(title: "OK", style: .default) { (action) in
//
//            let tfAlert = alert.textFields?.first
//            guard let text = tfAlert?.text else { return }
//            var newlabel = label
//            newlabel = text
//            completionHandler(text)
//        }
//
//        alert.addTextField { (tfAlert: UITextField) in
//            tfAlert.placeholder = placeholder
//        }
//
//        let cancel = UIAlertAction(title: "CANCEL", style: .default, handler: nil)
//
//        alert.addAction(ok)
//        alert.addAction(cancel)
//
//        present(alert, animated: true, completion: nil)
//    }
}
