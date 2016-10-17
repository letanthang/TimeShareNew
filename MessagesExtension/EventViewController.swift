//
//  EventViewController.swift
//  TimeShareNew
//
//  Created by Thang Le Tan on 10/14/16.
//  Copyright © 2016 Thang Le Tan. All rights reserved.
//

import UIKit
import Messages

class EventViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var dates = [Date]()
    var ourVotes = [Int]()
    var allVotes = [Int]()
    weak var delegate: MessagesViewController!
    
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
        return dates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Date", for: indexPath)
        
        let date = dates[indexPath.row]
        
        cell.textLabel?.text = DateFormatter.localizedString(from: date, dateStyle: .long, timeStyle: .short)
        
        if ourVotes[indexPath.row] == 1 {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        if allVotes[indexPath.row] > 0 {
            cell.detailTextLabel?.text = "Votes: \(allVotes[indexPath.row])"
        } else {
            cell.detailTextLabel?.text = ""
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let cell = tableView.cellForRow(at: indexPath) {
            if ourVotes[indexPath.row] == 1 {
                ourVotes[indexPath.row] = 0
                cell.accessoryType = .none
            } else {
                ourVotes[indexPath.row] = 1
                cell.accessoryType = .checkmark
            }

        }
        
                
    }
    
    func load(from message: MSMessage?) {
        
        guard let message = message else { return }
        guard let messageURL = message.url else { return }
        guard let components = URLComponents(url: messageURL, resolvingAgainstBaseURL: false) else { return }
        guard let queryItems = components.queryItems else { return }
        
        for item in queryItems {
            if item.name.hasPrefix("date-") {
                dates.append(date(from: item.value ?? ""))
            }
            if item.name.hasPrefix("vote-") {
                let voteCount = Int(item.value ?? "") ?? 0
                allVotes.append(voteCount)
                ourVotes.append(0)
            }
        }
        
        
    }
    
    func date(from string: String) -> Date {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        formatter.dateFormat = "yyyy-MM-dd-HH-mm"
        
        return formatter.date(from: string) ?? Date()
    }
    
    @IBAction func addDate(_ sender: AnyObject) {
        
        dates.append(datePicker.date)
        ourVotes.append(1)
        allVotes.append(0)
        
        let newIndexPath = IndexPath(row: dates.count-1, section: 0)
        
        tableView.insertRows(at: [newIndexPath], with: .automatic)
        
        tableView.scrollToRow(at: newIndexPath, at: .bottom, animated: true)
        
        tableView.flashScrollIndicators()
        
    }

    @IBAction func save(_ sender: AnyObject) {
        
        var finalVotes = [Int]()
        
        for (index, value) in allVotes.enumerated() {
            finalVotes.append(value + ourVotes[index])
        }
        delegate.createMessage(with: dates, votes: finalVotes)
    }
    
}
