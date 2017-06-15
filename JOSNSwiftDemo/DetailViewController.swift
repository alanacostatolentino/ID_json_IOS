//
//  DetailViewController.swift
//  JOSNSwiftDemo
//
//  Created by Alan Tolentino on 14/6/17.
//  Copyright © 2017 alt. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
   
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dobLabel: UILabel!
    @IBOutlet weak var completoTextView: UITextView!
    
    
    
    //data from previous controller
    var tituloString:String!
    var detalleString:String!
    var imageString:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateUI() {
        self.nameLabel.text = tituloString
        self.completoTextView.text = detalleString
        
        let imgURL = URL(string:imageString)
        
        let data = NSData(contentsOf: (imgURL)!)
        self.imageView.image = UIImage(data: data! as Data)
    }
}
