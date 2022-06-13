//
//  ViewController.swift
//  NewsApiApp
//
//  Created by Yuliia Khrupina on 6/12/22.
//

import UIKit
import Alamofire
import ObjectMapper


class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let cellReuseIdentifier = "ListItem"
    
    let parsingGroup = DispatchGroup()
        
    let childView = SpinnerViewController()
    
    var articles: Array<NewsItem> = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as? ListItem else { return  UITableViewCell() }
        
        let data = self.articles[indexPath.row]
            
        /*AF.request(data.iconUrl as! URLConvertible, method: .get).responseData { responseData in
                if let responseData = responseData.data {
                    cell.icon.image = UIImage(data: responseData)
                }
              }*/
            
        cell.message.text = data.message
     
          // Stop spinner work
          self.stopIndicator()
         
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
        
        //checkStore()
        moveIndicator()
        
        AF.request("https://newsapi.org/v2/everything?q=education&apiKey=e75a9f9799954cc5bccc39df14de4189", method: .get).responseJSON { (responce) in
                    switch responce.result {
                    case .success(let value):
                        guard let castingValue = value as? [String: Any] else { return }
                        guard let userData = Mapper<NewsListRestObjects>().map(JSON: castingValue) else { return }
                        self.articles = (userData.articles)!
                        print(self.articles.count)
                        self.table.reloadData()
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
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
}

