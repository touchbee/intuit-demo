//
//  ReposTableViewController.swift
//  IntuitDemo
//
//  Created by Stefan Immich on 2/2/19.
//  Copyright © 2019 Stefan Immich. All rights reserved.
//

import UIKit
import Alamofire

class ReposTableViewController: UITableViewController {

    var useCaseRepoPaginator: UseCaseRepoListPaginated!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        useCaseRepoPaginator = UseCaseRepoListPaginated(pageSize: 20, repoRepository: appDelegate.repoRepository)
        useCaseRepoPaginator.reposChanged = { [weak self] (repos) in
            self?.tableView.reloadData()
        }
        
        useCaseRepoPaginator.firstPage()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return useCaseRepoPaginator.repos.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RepoCellIdentifier", for: indexPath)
        
        let repo = useCaseRepoPaginator.repos[indexPath.row]
        cell.textLabel?.text = repo.name
        cell.detailTextLabel?.text = repo.description

        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        // Check if the last row number is the same as the last current data element
        if indexPath.row == useCaseRepoPaginator.repos.count - 1 {
            useCaseRepoPaginator.nextPage()
        }
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "ShowRepoDetails" {
            
            if let index = tableView.indexPathForSelectedRow?.row {
                let detailsViewController = segue.destination as! RepoDetailsTableViewController
                detailsViewController.repo = useCaseRepoPaginator.repos[index]
            }
        }
    }
}
