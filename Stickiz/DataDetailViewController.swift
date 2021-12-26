//
//  DataDetailViewController.swift
//  Stickiz
//
//  Created by Jeremy Endratno on 12/26/21.
//

import UIKit

class DataDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var stick: StickModel?
    var stickDatas: [StickDataModel] = []
    @IBOutlet weak var detailTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetup()
        getStickData()
        initTableView()
    }
    
    func viewSetup() {
        self.navigationItem.title = stick?.name
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Delete", style: .plain, target: self, action: #selector(deleteStick))
    }
    
    func initTableView() {
        detailTableView.delegate = self
        detailTableView.dataSource = self
    }
    
    func getStickData() {
        stickDatas = StickDataCoreData().readByStickID(stick_id: stick!.id)
    }
    
    @objc func deleteStick() {
        StickCoreData().delete(id: stick!.id)
        navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        stickDatas.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = detailTableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath) as! DetailCell
        if indexPath.row == stickDatas.count {
            cell.nameLabel.text = "Add new data"
            cell.nameLabel.textAlignment = .center
            cell.arrowImageView.isHidden = true
        } else {
            cell.nameLabel.text = stickDatas[indexPath.row].name
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == stickDatas.count {
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
                StickDataCoreData().create(stickData: StickDataModel(id: UUID.init(), stick_id: self.stick!.id, name: name, value: value, created_at: Date.now))
                self.getStickData()
                self.detailTableView.reloadData()
            }
            addDataAlert.addAction(saveAction)
            self.present(addDataAlert, animated: true)
            
        } else {
            let currentStickData = self.stickDatas[indexPath.row]
            let alert = UIAlertController(title: "Edit \(stickDatas[indexPath.row].name)", message: "Change the value of \(stickDatas[indexPath.row].name)", preferredStyle: .alert)
            alert.addTextField { textField in
                textField.text = "\(self.stickDatas[indexPath.row].value)"
            }
            
            let ok = UIAlertAction(title: "Save", style: .default) { _ in
                let newValue = alert.textFields![0].text
                StickDataCoreData().update(stickData: StickDataModel(id: currentStickData.id, stick_id: currentStickData.stick_id, name: currentStickData.name, value: newValue ?? "No value was saved", created_at: currentStickData.created_at))
                self.getStickData()
                self.detailTableView.reloadData()
            }
            
            alert.addAction(ok)
            self.present(alert, animated: true)
        }
    }
}

class DetailCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var arrowImageView: UIImageView!
}
