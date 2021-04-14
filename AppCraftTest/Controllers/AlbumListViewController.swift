//
//  AlbumListViewController.swift
//  AppCraftTest
//
//  Created by cannabiolog420 on 14.04.2021.
//

import UIKit

class AlbumListViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    
    let tableView = UITableView()
    var albums = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        setupTableView()
        
    }
    
    //MARK: - Setup Table View
    
    func setupTableView(){
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AlbumCell.self, forCellReuseIdentifier: AlbumCell.identifier)
        tableView.pin(to: view)
    }

    //MARK: - Table View Data Source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: AlbumCell.identifier, for: indexPath) as! AlbumCell
        cell.accessoryType = .disclosureIndicator
        cell.albumTitleLabel.text = String(indexPath.row)
        
        return cell
    }
    
    //MARK: - Table View Delegate
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }


}
