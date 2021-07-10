//
//  ViewController.swift
//  Challenge_4
//
//  Created by Андрей Бородкин on 10.07.2021.
//

import UIKit

class ViewController: UITableViewController {

    var photos = [Photo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPhoto))
        
        
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Photo", for: indexPath)
        var configuration = cell.defaultContentConfiguration()
        
        configuration.text = photos[indexPath.row].caption
        configuration.image = UIImage(named: photos[indexPath.row].name)
        
        cell.contentConfiguration = configuration
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Detail") as! DetailViewController
        vc.title = photos[indexPath.row].caption
        vc.selectedImage = photos[indexPath.row].name
    }
    
    
  
}



extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @objc func addPhoto() {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    
}
