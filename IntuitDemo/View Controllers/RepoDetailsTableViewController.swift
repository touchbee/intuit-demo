//
//  RepoDetailsTableViewController.swift
//  IntuitDemo
//
//  Created by Stefan Immich on 2/2/19.
//  Copyright © 2019 Stefan Immich. All rights reserved.
//

import UIKit

class RepoDetailsTableViewController: UITableViewController {

    typealias DetailInfo = (label: String, content: String)
    
    var repo: Repo!
    var detailsInfo: [DetailInfo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.title = repo.name
        
        prepareDetailsInfo()
    }
    
    func prepareDetailsInfo() {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        
        detailsInfo.append((label:"Full Name", content:repo.fullName))
        detailsInfo.append((label:"Language", content:repo.language))
        detailsInfo.append((label:"Created", content:dateFormatter.string(from: repo.created)))
        detailsInfo.append((label:"Watcher count", content:String(repo.watchersCount)))
        detailsInfo.append((label:"Fork count", content:String(repo.forkCount)))
   
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return repo.issuesCount > 0 ? 2 : 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return detailsInfo.count
        }
        
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 1 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "IssueCellIdentifier", for: indexPath)
            
            // Configure the cell...
            cell.textLabel?.text = "Issues (\(repo.issuesCount))"
            
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RepoDetailIdentifier", for: indexPath)
        
        // Configure the cell...
        let detailInfo = detailsInfo[indexPath.row]
        cell.textLabel?.text = detailInfo.label
        cell.detailTextLabel?.text = detailInfo.content
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "ShowIssues" {
            
            let detailsViewController = segue.destination as! IssuesTableViewController
            detailsViewController.repo = repo
        }
    }
}
