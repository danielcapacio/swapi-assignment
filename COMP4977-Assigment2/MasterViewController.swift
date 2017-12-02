//
//  MasterViewController.swift
//  COMP4977-Assigment2
//
//  Created by Daniel Capacio on 2017-12-01.
//  Copyright © 2017 Daniel Capacio. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON

class MasterViewController: UITableViewController {

    let url = "https://swapi.co/api/films/"
    var detailViewController: DetailViewController? = nil
    var objects = [Any]()
    var movieTitles:[JSON] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "SWAPI"
        // Do any additional setup after loading the view, typically from a nib.
        // navigationItem.leftBarButtonItem = editButtonItem

        //let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertNewObject(_:)))
        //navigationItem.rightBarButtonItem = addButton
        //if let split = splitViewController {
        //    let controllers = split.viewControllers
        //    detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        //}
        
        var moviesList: [JSON] = []
        Alamofire.request(self.url).validate().responseJSON { response in
            switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    for (key, subJson):(String, JSON) in json {
                        if key == "results" {
                            moviesList.append(subJson)
                        }
                    }
                    for movie in moviesList {
                        for i in 0...(moviesList[0].count - 1) {
                            self.movieTitles.append(movie[i])
                        }
                    }
                    self.tableView.reloadData()
                case .failure(let error):
                    print(error)
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc
    func insertNewObject(_ sender: Any) {
        objects.insert(NSDate(), at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                //let object = objects[indexPath.row] as! NSDate
                //let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                //controller.detailItem = object
                //controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                //controller.navigationItem.leftItemsSupplementBackButton = true
                
                let movie = self.movieTitles[indexPath.row]
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.movieTitle = movie["title"].stringValue
                controller.openingCrawl = movie["opening_crawl"].stringValue
                controller.director = movie["director"].stringValue
                controller.producer = movie["producer"].stringValue
                controller.characters = movie["characters"].stringValue
                controller.releaseDate = movie["release_date"].stringValue
                controller.created = movie["created"].stringValue
                controller.edited = movie["edited"].stringValue
                controller.edited = movie["url"].stringValue
            }
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movieTitles.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        //let object = objects[indexPath.row] as! NSDate
        //cell.textLabel!.text = object.description
        
        let movie = self.movieTitles[indexPath.row]
        cell.textLabel!.text = movie["title"].stringValue
        
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        //if editingStyle == .delete {
        //    objects.remove(at: indexPath.row)
        //    tableView.deleteRows(at: [indexPath], with: .fade)
        //} else if editingStyle == .insert {
        //    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        //}
    }


}

