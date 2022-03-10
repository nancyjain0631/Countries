//
//  DetailsViewController.swift
//  Assign1
//
//  Created by Nancy Jain on 09/03/22.
//

import UIKit

// copied from stacksoverflow "https://stackoverflow.com/questions/24231680/loading-downloading-image-from-url-on-swift"
extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}

class DetailsViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var countryLbl: UILabel!
    
    @IBOutlet weak var continentLbl: UILabel!
    
    
    /*@IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var countryNameLbl: UILabel!
    @IBOutlet weak var continentLbl: UILabel!
    @IBOutlet weak var continentNameLbl: UILabel!*/
    
    var modelData1:ModelData?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        countryLbl.text = modelData1?.country
        continentLbl.text = modelData1?.continent
        
        let urlString = (modelData1?.countryInfo.flag)!
        let url = URL(string: urlString)
        imageView.downloaded(from: url!)
        
    }
    

}
