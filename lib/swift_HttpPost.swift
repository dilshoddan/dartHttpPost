//
//  ViewController.swift
//  medsoftuz
//
//  Created by Admin on 28/01/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    @IBOutlet weak var personID: UITextField!

    @IBAction func GetPersonInfo(_ sender: Any) {
        let pID = personID.text ?? "3333"
        let session = URLSession.shared
        let url = URL(string: "http://rscu.gx.uz/app")!

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("mainToken", forHTTPHeaderField: "Authorization")


        let json = [
            "id": 123,
            "jsonrpc": "2.0",
            "method" : "person.info",
            "params" : [
                "person_id" : "\(pID)",
                "token" : "customToken"
            ]
            ] as [String : Any]

        let jsonData = try! JSONSerialization.data(withJSONObject: json, options: [])



        let task = session.uploadTask(with: request, from: jsonData) { data, response, error in
            if let data = data, let dataString = String(data: data, encoding: .utf32) {
                //print(String(dataString["result"]["person"]["lastname"]))
                print(dataString)

                do {
                    let encoder = JSONEncoder()
                    let decoder = JSONDecoder()
                    let person = try decoder.decode(PersonInfo.self, from: data)
                    let jsonObject = try JSONSerialization.jsonObject(with: data)
                    if let dictionary = jsonObject as? [String: Any],
                        let results = dictionary["results"] as? [[String: Any]] {

                    }
                } catch {
                    print("JSONSerialization error:", error)
                }



            }
        }

        task.resume()

        print(pID)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

/*
curl -X POST \
http://rscu.gx.uz/app \
-H 'Authorization: mainToken' \
-H 'Content-Type: application/json' \
-d '{
  "id": 123,
  "jsonrpc": "2.0",
  "method": "person.info",
  "params":{
      "person_id":"3333",
      "token":"CustomToken"
  }
}'
 */
