//
//  ViewController.swift
//  Challenge_4
//
//  Created by Андрей Бородкин on 10.07.2021.
//

import UIKit

class ViewController: UITableViewController {

    let defaults = UserDefaults.standard
    let decoder = JSONDecoder()
    
    var photos = [Photo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPhoto))
        
        
        if let savedPhotos = defaults.object(forKey: "photos") as? Data{
            if let savedData = try? decoder.decode([Photo].self, from: savedPhotos) {
                photos = savedData
                //tableView.reloadData()
            }
        }
        
        tableView.reloadData()
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Photo", for: indexPath)
        
        cell.textLabel?.text = photos[indexPath.row].caption
        cell.detailTextLabel?.text = photos[indexPath.row].imageName
        cell.detailTextLabel?.textColor = .lightGray
        //var configuration = cell.defaultContentConfiguration()
        
        //configuration.text = photos[indexPath.row].caption
        //configuration.image = UIImage(named: photos[indexPath.row].imageName)
        
        //cell.contentConfiguration = configuration
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Detail") as! DetailViewController
        vc.title = photos[indexPath.row].caption
        vc.selectedImage = photos[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
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
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else {return}
       
        var caption = String()
        
        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
        
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: imagePath)
        }
        
//        let ac = UIAlertController(title: "Enter Photo Name", message: nil, preferredStyle: .alert)
//        ac.addTextField() {textfield in
//            textfield.placeholder = "Name"
//        }
//        ac.addAction(UIAlertAction(title: "Save", style: .default) { _ in
//            guard let inputText = ac.textFields?[0].text else {
//                caption = ""
//                return
//            }
//            caption = inputText
//        })
//        present(ac, animated: true)
        
        
        let photo = Photo(imageName: imageName, caption: "NoName")
        photos.append(photo)
        savePhotos()
        tableView.reloadData()
        dismiss(animated: true, completion: nil)
        
        
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func savePhotos() {
        let defaults = UserDefaults.standard
        let encoder = JSONEncoder()
        
        if let dataToSave = try? encoder.encode(photos) {
            defaults.set(dataToSave, forKey: "photos")
        }
    }
}
