//
//  ViewController.swift
//  Assign1
//
//  Created by Nancy Jain on 08/03/22.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   

    @IBOutlet weak var tableView: UITableView!
    
    var modelData = [ModelData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        parseData()
        /*The "delegate" manages table row configuration and selection, row reordering, highlighting, accessory views, and editing operations. While the "data source" provides information that UITableView needs to construct tables and manages the data model when rows of a table are inserted, deleted, or reordered.*/
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modelData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = modelData[indexPath.row].country
        
        guard let receivedImage = try? Data(contentsOf: URL(string: modelData[indexPath.row].countryInfo.flag)!) else{ return cell! }
        cell?.imageView?.image = UIImage(data: receivedImage)
        //cell?.imageView?.image = UIImage(data: receivedImage)
        return cell!
        
        
        //      solution 2
        
        /*let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath) as! TableViewCell
        cell.imageCellLbl.image = modelData[indexPath.row].countryInfo.flag
        cell.imageCellLbl.image = modelData[UIImage(named:  indexPath.row)].countryInfo.flag
        var modelData1:ModelData?
        cell.imageCellLbl.image = UIImageView.URL((string: modelData1?.countryInfo.flag)!)
        cell.cellLbl.text = modelData[indexPath.row].country.capitalized
        return cell*/
        
        //      solution 1
        
        /*let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = modelData[indexPath.row].country.capitalized
        return cell*/
        
    }
    //pass data- use delegte method of tableview to know which row is selected
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //showCountryDetails is the identifies of segue - tablevoew to countrydetails page
        //tell teh viewcontroller to change the viewcontroller
        performSegue(withIdentifier: "showCountryDetails", sender: self)
    }
    
    //fun to pass data
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailsViewController {
            destination.modelData1 = modelData[(tableView.indexPathForSelectedRow?.row)!]
        }
    }
    
    func parseData() {
        let url = URL(string: "https://disease.sh/v2/countries")
        
        URLSession.shared.dataTask(with: url!) { data, response, error in   //method creates a task that retrieves the contents of at the URL
            
            guard let data = data else {
                return
            }

            //we'll moe further only when there is no error
            if error == nil {
                do {
                    let JSONData = try JSONDecoder().decode([ModelData].self, from: data)
                    self.modelData = JSONData
                    //self.modelData = try JSONDecoder().decode([ModelData].self, from: data)
                    //we need to reload the tableview once data is downloaded so for that i've used closures
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        //completed()
                    }
                }catch {
                    print("JSON error")
                }
            }
        }.resume()
    }
    
    
}

