//
//  ViewController.swift
//  iOS-Pratice-App
//
//  Created by Fernando on 05/03/22.
//

import UIKit
import FirebaseDatabase

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var elements = [AppInfo]()
    var databaseRef : DatabaseReference!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "appCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! AppTableViewCell
        let appInfo = elements[indexPath.row]
        
        cell.nameApp.text = appInfo.name
        cell.priceApp.text = formatPrice(price: appInfo.price)
        cell.imageApp.image = UIImage(named: "star")
        cell.imageApp.downloadedFrom(link: appInfo.imageUrl, contentMode: UIView.ContentMode.scaleAspectFill)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastItem = elements.count - 1
        if indexPath.row == lastItem {
            loadData()
        }
    }
        
    func loadData(){
        let appRef = self.databaseRef.child("apps")
        
        appRef.queryOrderedByKey()
        appRef.queryStarting(atValue: self.elements.count)
        appRef.queryEnding(atValue: self.elements.count + 4)
        
        appRef.observeSingleEvent(of: DataEventType.value) { (snapShot) in
            for item in snapShot.children {
                let appInfo = AppInfo(snapShot: item as! DataSnapshot)
                self.elements.append(appInfo)
            }
            self.tableView.reloadData()
        }
    }
    
    func formatPrice(price : Int) -> String {
        if price == 0 {
            return "FREE"
        } else {
            return "$\(price)"
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.databaseRef = Database.database().reference()
        
        loadData()
        tableView.dataSource = self
        tableView.delegate = self
    }


}

