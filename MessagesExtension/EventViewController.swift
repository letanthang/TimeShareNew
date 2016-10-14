//
//  EventViewController.swift
//  TimeShareNew
//
//  Created by Thang Le Tan on 10/14/16.
//  Copyright © 2016 Thang Le Tan. All rights reserved.
//

import UIKit

class EventViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var datePicker: UIDatePicker!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Date", for: indexPath)
        cell.textLabel?.text = "Date Event 1"
        return cell
    }
    
    @IBAction func addDate(_ sender: AnyObject) {
    }

    @IBAction func save(_ sender: AnyObject) {
    }
    
}
