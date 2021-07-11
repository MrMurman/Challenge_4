//
//  DetailViewController.swift
//  Challenge_4
//
//  Created by Андрей Бородкин on 10.07.2021.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    var selectedImage: Photo?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        if let selectedImage = selectedImage {
            title = selectedImage.caption
            let path = getImageURL(for: selectedImage.imageName)
            imageView.image = UIImage(contentsOfFile: path.path)
           // imageView.image = UIImage(named: selectedImage)
        }
    }
    
     func getDocumentsDirectory() -> URL {
           let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
           return paths[0]
       }

        func getImageURL(for imageName: String) -> URL {
           return getDocumentsDirectory().appendingPathComponent(imageName)
       }

}
