//
//  ViewController.swift
//  NewsApiApp
//
//  Created by Yuliia Khrupina on 6/12/22.
//

import UIKit
import Alamofire


class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let cellReuseIdentifier = "ListItem"
    
    let parsingGroup = DispatchGroup()
        
    let childView = SpinnerViewController()
    
    let storeQueue = DispatchQueue.global(qos: .userInteractive)
    let parsingQueue = DispatchQueue.init(label: "parsing", attributes: .concurrent)
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as? ListItem else { return  UITableViewCell() }
         
            clearRow(cell)
         
            // Create group notify - when group is completed then cell get rows
            parsingGroup.notify(queue: .main) {
              //cell.icon.image = UIImage(named: self.icons[indexPath.row])
              //cell.message.text = self.messages[indexPath.row]
         
              // Stop spinner work
              self.stopIndicator()
            }
         
            return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 80
        }
    
    
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        
        checkStore()
        moveIndicator()
        
        
    }
    
    func stopIndicator() {
            self.childView.willMove(toParent: nil)
            self.childView.view.removeFromSuperview()
            self.childView.removeFromParent()
        }
        
    func moveIndicator() {
        addChild(childView)
        childView.view.frame = view.frame
        view.addSubview(childView.view)
        childView.didMove(toParent: self)
      }
    
    private func clearRow(_ cell: ListItem) {
        cell.icon = nil
        cell.message.text = ""
      }

    
    
    func checkStore() {
        storeQueue.async {
            if let path = Bundle.main.path(forResource: "UsersData", ofType:"plist"){
                let dict = NSDictionary(contentsOfFile: path) as! [String: Any]
                //self.appendDateFromPlistConcurrent(dict)
            }
        }
        //print("1...\(self.icons.count)")
    }

}

