//
//  ViewController.swift
//  worker
//
//  Created by Common Room Bangi on 01/10/2023.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workermain.count
    }
    @IBOutlet weak var workerTableView: UITableView!
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! employeeTableViewCell
           
           // Configure the cell’s contents.
        cell.emailLabel.text! = workermain[indexPath.row].email
        cell.nameLabel.text! = workermain[indexPath.row].name
        cell.nophoneLabel.text! = workermain[indexPath.row].numberphone
        cell.workerImageView.image = UIImage(data: workermain[indexPath.row].imageData)
           
               
           return cell
    }
    
    var workermain : [Worker] = []

   
    override func viewDidLoad() {
        super.viewDidLoad()
        startLoad()
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 299
    }
    
    func startLoad() {
        let url = URL(string: "https://dlfmdnzjrhvhclzravmi.supabase.co/rest/v1/employee?select=*")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImRsZm1kbnpqcmh2aGNsenJhdm1pIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTYxNTY5MjUsImV4cCI6MjAxMTczMjkyNX0.o9fDrIsYLEm_jQTbBD6Sw5spOA0UqtXf_3gfcdcLPRc", forHTTPHeaderField: "apikey")
        request.setValue("Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImRsZm1kbnpqcmh2aGNsenJhdm1pIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTYxNTY5MjUsImV4cCI6MjAxMTczMjkyNX0.o9fDrIsYLEm_jQTbBD6Sw5spOA0UqtXf_3gfcdcLPRc", forHTTPHeaderField: "Authorization")
        
        
        
        let task = URLSession.shared.dataTask(with: request ) { data, response, error in
            if let error = error {
                print(error)
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
              print(error)
                return
            }
            
            let json = data
           
            do{
                let decoder = JSONDecoder()
                let work = try decoder.decode([Worker].self, from: json!)
                
                self.workermain = work
                
                DispatchQueue.main.async {
                    self.workerTableView.reloadData()
                            }
            }
            catch{
                print(error)
            }
            
        }
        task.resume()
    }
    


}

