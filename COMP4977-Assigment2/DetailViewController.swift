//
//  DetailViewController.swift
//  COMP4977-Assigment2
//
//  Created by Daniel Capacio on 2017-12-01.
//  Copyright © 2017 Daniel Capacio. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    var movieTitle:String = ""
    var openingCrawl:String = ""
    var director:String = ""
    var producer:String = ""
    var characters:String = ""
    var releaseDate:String = ""
    var created:String = ""
    var edited:String = ""
    var url:String = ""
    
    @IBOutlet weak var label_title: UILabel!
    @IBOutlet weak var label_openingCrawl: UILabel!
    
    func configureView() {
        // Update the user interface for the detail item.
        if let detail = detailItem {
            if let label = detailDescriptionLabel {
                label.text = detail.description
            }
        }
    }
    
    func loadMovieDetails() {
        self.label_title.text = self.movieTitle
        self.label_openingCrawl.text = self.openingCrawl
        //self.label_director.text = self.director
        //self.label_producer.text = self.producer
        //self.label_characters.text = self.characters
        //self.label_releaseDate.text = self.releaseDate
        //self.label_edited.text = self.edited
        //self.label_url.text = self.url
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.title = self.movieTitle
        configureView()
        loadMovieDetails()
        Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }
    
    @objc func timerAction() {
        var yOffSet = 600
        yOffSet += 1;
        DispatchQueue.main.async() {
            UIView.animate(withDuration: 1, delay: 1, options: UIViewAnimationOptions.curveLinear, animations: {
                self.scrollView.contentOffset.y = CGFloat(yOffSet)
            }, completion: nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var detailItem: NSDate? {
        didSet {
            // Update the view.
            configureView()
        }
    }
}






