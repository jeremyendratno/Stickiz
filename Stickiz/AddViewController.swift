//
//  AddViewController.swift
//  Stickiz
//
//  Created by Jeremy Endratno on 12/26/21.
//

import UIKit

class AddViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var DataLabel: UILabel!
    
    var newStickID = UUID.init()
    var newStickDatas: [StickDataModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetup()
    }
    
    func viewSetup() {
        navigationItem.title = "Add Stick"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(done))
        nameTextField.delegate = self
    }
    
    func reloadDataLabel() {
        var datas = ""
        for stickData in newStickDatas {
            datas += "\(stickData.name): \(stickData.value)\n"
        }
        DataLabel.text = datas
    }
    
    func addData() {
        let addDataAlert = UIAlertController(title: "Add Data", message: "Add your data by filling the name and the value", preferredStyle: .alert)
        addDataAlert.addTextField { textField in
            textField.placeholder = "Name"
        }
        
        addDataAlert.addTextField { textField in
            textField.placeholder = "Value"
        }
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
            let name = addDataAlert.textFields?[0].text ?? "No name was saved"
            let value = addDataAlert.textFields?[1].text ?? "No value was saved"
            self.newStickDatas.append(StickDataModel(id: UUID.init(), stick_id: self.newStickID, name: name, value: value, created_at: Date.now))
            self.reloadDataLabel()
        }
        
        addDataAlert.addAction(saveAction)
        
        self.present(addDataAlert, animated: true)
    }
    
    @objc func done() {
        StickCoreData().create(stick: StickModel(id: newStickID, name: nameTextField.text ?? "No name was saved", created_at: Date.now))
        for stickData in newStickDatas {
            StickDataCoreData().create(stickData: stickData)
        }
        navigationController?.popViewController(animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func doneButton(_ sender: Any) {
        addData()
    }
}
