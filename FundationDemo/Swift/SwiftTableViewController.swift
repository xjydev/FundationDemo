//
//  SwiftTableViewController.swift
//  FundationDemo
//
//  Created by jingyuan5 on 2020/10/30.
//

import UIKit

class SwiftTableViewController: UITableViewController {
    let mainArray = [["title":"方法调用","selector":"functionPerform","class":""],["title":"","selector":"","class":""],["title":"","selector":"","class":""],]
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainArray.count;
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "swiftcell", for: indexPath)
        let dict = mainArray[indexPath.row]
        cell.textLabel?.text = dict["title"]
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    func functionPerform() {
        
    }

}
