//
//  ViewController.swift
//  FireBaseAssignment
//
//  Created by MASON BARTELL on 2/16/24.
//

import UIKit
import FirebaseDatabase
import FirebaseCore
class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
  
    var name = [String]()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textFieldAge: UITextField!
    @IBOutlet weak var textField: UITextField!
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    ref = Database.database().reference()
        tableView.dataSource = self
        tableView.delegate = self
        ref.child("students").observe(.childAdded, with: { (snapshot) in
            let n = snapshot.value as! String
            self.name.append(n)
            self.tableView.reloadData()
        })
    }

    
    
    @IBAction func ButtonAction(_ sender: UIButton) {
        name.append(textField.text ?? "")
        ref.child("students").childByAutoId().setValue(name)
        var age = textFieldAge.text
        ref.child("students").childByAutoId().setValue(age)
        
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return name.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell")
        cell?.textLabel?.text = name[indexPath.row]
        return cell!
    }
    

}

