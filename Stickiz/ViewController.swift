//
//  ViewController.swift
//  Stickiz
//
//  Created by Jeremy Endratno on 12/26/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var stickTableView: UITableView!
    var sticks: [StickModel] = []
    var segueStick: StickModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetup()
        initTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getStick()
        stickTableView.reloadData()
    }
    
    func viewSetup() {
        self.navigationItem.title = "Stickiz"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addStick))
    }
    
    func initTableView() {
        stickTableView.delegate = self
        stickTableView.dataSource = self
    }
    
    func getStick() {
        sticks = StickCoreData().read()
    }
    
    @objc func addStick() {
        performSegue(withIdentifier: "Add", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sticks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = stickTableView.dequeueReusableCell(withIdentifier: "StickCell", for: indexPath) as! StickCell
        cell.nameLabel.text = sticks[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        segueStick = sticks[indexPath.row]
        performSegue(withIdentifier: "DataDetail", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dataDetailVC = segue.destination as? DataDetailViewController
        dataDetailVC?.stick = segueStick
    }
}

class StickCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
}

