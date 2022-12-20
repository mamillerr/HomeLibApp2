//
//  AddNewBookViewController.swift
//  HomeLibApp
//
//  Created by Ma Millerr on 27.10.2022.
//

import UIKit

class AddNewBookViewController: UIViewController {
    
    var book: WRBook!

    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var authorTF: UITextField!

    
    @IBOutlet weak var saveButton: UIBarButtonItem!
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveButtonState()
    }
    
    private func saveButtonState() {
        let nameTF = nameTF.text ?? ""
        let authorTF = authorTF.text ?? ""
        
        saveButton.isEnabled = !nameTF.isEmpty && !authorTF.isEmpty


    }
    
    @IBAction func textFieldChanged(_ sender: UITextField) {
        saveButtonState()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "saveSegue" else { return }
        book = WRBook(value: [nameTF.text, authorTF.text])
        
    }

}
