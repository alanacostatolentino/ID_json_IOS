//
//  ViewController.swift
//  JOSNSwiftDemo
//
//  Created by Alan Tolentino on 14/6/17.
//  Copyright © 2017 alt. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    let jsonURL = "http://randominteractive.net/TEST/data.json"
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var nameArray = [String]()
    var dobArray = [String]()
    var imgURLArray = [String]()
    var tituloArray = [String]()
    var textoArray = [String]()
    var detalleArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.downloadJsonData()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func downloadJsonData(){
        let url = NSURL(string: jsonURL)
        URLSession.shared.dataTask(with: (url as URL?)!, completionHandler: {(data, response, error) -> Void in
            if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSArray {
                //print(jsonObj!)
                
                
                for elemento in jsonObj!{  //start for
                    if let elementoDict = elemento as? NSDictionary {  //Start if
                        if let titulo = elementoDict.value(forKey: "titutlo") {
                            self.tituloArray.append(titulo as! String)
                        }
                        if let texto = elementoDict.value(forKey: "texto") {
                            self.textoArray.append(texto as! String)
                        }
                        if let imagen = elementoDict.value(forKey: "url") {
                            self.imgURLArray.append(imagen as! String)
                        }
                        if let detalle = elementoDict.value(forKey: "detalle") {
                            self.detalleArray.append(detalle as! String)
                        }
                        
                        OperationQueue.main.addOperation({
                            self.tableView.reloadData()
                        })
                        
                    }//end if
                }//end for
                print(self.tituloArray)
                print(self.textoArray)
                print(self.imgURLArray)
                print(self.detalleArray)
                
                
            }//end if let jsonObj
            
            
        }).resume()
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tituloArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
        cell.nameLabel.text = tituloArray[indexPath.row]
        cell.descTextView.text = textoArray[indexPath.row]
        
        let imgURL = NSURL(string: imgURLArray[indexPath.row])
  
        
        
        
        if imgURL != nil {
            let data = NSData(contentsOf: (imgURL as URL?)!)
            cell.imgView.image = UIImage(data: data! as Data)
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        vc.imageString = imgURLArray[indexPath.row]
        vc.tituloString = tituloArray[indexPath.row]
        vc.detalleString = detalleArray[indexPath.row]
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

