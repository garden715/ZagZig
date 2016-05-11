//
//  ShoppingMallsTableViewController.swift
//  ZagZig
//
//  Created by seojungwon on 2016. 5. 8..
//  Copyright © 2016년 seojungwon. All rights reserved.
//

import UIKit

class ShoppingMallsTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    @IBOutlet weak var ShoppingMallsTableView: UITableView!
    
    // MARK : Properties
    var shoppinMalls = [ShoppingMall]()

    override func viewDidLoad() {
        super.viewDidLoad()

        loadShoppingMalls()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

     func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppinMalls.count
    }

    
    func loadShoppingMalls() {
        let filePath = NSBundle.mainBundle().pathForResource("pageList",ofType: "json")
        let data =  NSData(contentsOfFile:filePath!)
        
        do {
            let object = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
            if let dictionary = object as? [[String: AnyObject]] {
                readJSONObject(dictionary)
            }
        } catch {
            // Handle Error
        }
    }
    
    func readJSONObject(object: [[String: AnyObject]]) {
        for mall in object {
            guard let u = mall["u"] as? Int else { break }
            guard let baseUrl = mall["baseUrl"] as? String else { break }
            //print(u)
            print(baseUrl)
            shoppinMalls.append(ShoppingMall(name: "\(u)", photo: UIImage(named: "1.png"), url: baseUrl)!)
        }
    }
    
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "ShoppingMallCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! ShoppingMallCell
        
        let shoppingMall = shoppinMalls[indexPath.row]
        
        cell.name.text = shoppingMall.name
        cell.photo.image = shoppingMall.photo
        cell.tags.text = shoppingMall.url
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "PageDetail" {
            let indexPaths = ShoppingMallsTableView.indexPathsForSelectedRows!
            let indexPath = indexPaths[0] as NSIndexPath
            
            let vc = segue.destinationViewController as! PageDetailViewController
            
            vc.urlSource = "http://\(self.shoppinMalls[indexPath.row].url)"
        }
    }

 
}
