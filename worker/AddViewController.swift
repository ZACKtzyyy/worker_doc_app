//
//  AddViewController.swift
//  worker
//
//  Created by Common Room Bangi on 01/10/2023.
//

import UIKit
import CoreImage

class AddViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var workerImageView: UIImageView!
    @IBOutlet weak var nophoneTextfield: UITextField!
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var nameTextfield: UITextField!
    override func viewDidLoad() {
        
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func buttonPressed(_ sender: Any) {
        
        let imageData = workerImageView.image?.jpegData(compressionQuality: 0.2)
        let employee = Worker(name: nameTextfield.text!, email: emailTextfield.text!, numberphone: nophoneTextfield.text!, imageData: imageData!)
        guard let uploadData = try? JSONEncoder().encode(employee) else {
            return
        }

        
        let url = URL(string: "https://dlfmdnzjrhvhclzravmi.supabase.co/rest/v1/employee")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImRsZm1kbnpqcmh2aGNsenJhdm1pIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTYxNTY5MjUsImV4cCI6MjAxMTczMjkyNX0.o9fDrIsYLEm_jQTbBD6Sw5spOA0UqtXf_3gfcdcLPRc", forHTTPHeaderField: "apikey")
        request.setValue("Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImRsZm1kbnpqcmh2aGNsenJhdm1pIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTYxNTY5MjUsImV4cCI6MjAxMTczMjkyNX0.o9fDrIsYLEm_jQTbBD6Sw5spOA0UqtXf_3gfcdcLPRc", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("return=minimal", forHTTPHeaderField: "Prefer")
        
        let task = URLSession.shared.uploadTask(with: request, from: uploadData) { data, response, error in
            if let error = error {
                print ("error: \(error)")
                return
            }
            guard let response = response as? HTTPURLResponse,
                (200...299).contains(response.statusCode) else {
                print ("server error")
                return
            }
            
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
                       }
            
            if let mimeType = response.mimeType,
                mimeType == "application/json",
                let data = data,
                let dataString = String(data: data, encoding: .utf8) {
                print ("got data: \(dataString)")
                
                
            }
        }
        task.resume()
    }
    
    @IBAction func uploadImage(_ sender: Any) {
        let alert = UIAlertController(title: "Woi", message: "saje je alert", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "add camera", style: .default, handler: { UIAlertAction in
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                let imagepicker = UIImagePickerController()
                imagepicker.sourceType = .camera
                imagepicker.delegate = self
                self.present(imagepicker, animated: true)
            }
        }))
        alert.addAction(UIAlertAction(title: "Add Galery", style: .default, handler: { UIAlertAction in
            let librarypicker = UIImagePickerController()
            librarypicker.sourceType = .photoLibrary
            librarypicker.delegate = self
            self.present(librarypicker, animated: true)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        self.present(alert, animated: true)
        
        
        
        
        
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage]
        workerImageView.image = image as? UIImage
        self.dismiss(animated: true)
    }
    
    /*
     @IBAction func buttonPressed(_ sender: Any) {
     }
     // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
