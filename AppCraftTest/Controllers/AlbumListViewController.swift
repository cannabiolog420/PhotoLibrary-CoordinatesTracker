//
//  AlbumListViewController.swift
//  AppCraftTest
//
//  Created by cannabiolog420 on 14.04.2021.
//

import UIKit

class AlbumListViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {    
    
    
    // Properties
    
    private let tableView = UITableView()
    private var albums:Albums = []
    let segueIdentifier = "photosSegue"
    let urlString = "https://jsonplaceholder.typicode.com/albums"

    // Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        
        AlamofireFetcherService.fetchAlbums(urlString:urlString ) { (album) in
                self.albums = album
                self.tableView.reloadData()
            
        }
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    //MARK: - UI Setup
    
    //Setup Table View
    
    private func setupTableView(){
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AlbumCell.self, forCellReuseIdentifier: AlbumCell.identifier)
        tableView.pin(to: view)
    }
    
    //MARK: - Table View Data Source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: AlbumCell.identifier, for: indexPath) as! AlbumCell
        cell.accessoryType = .disclosureIndicator
        let album = albums[indexPath.row]
        cell.set(with: album)
        
        return cell
    }
    
    //MARK: - Table View Delegate
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: segueIdentifier, sender: self)
        tableView.deselectRow(at: indexPath, animated: true)


        
    }
    
    //MARK: - Navigation
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard segue.identifier == segueIdentifier else { return }
        let photosVC = segue.destination as! PhotosViewController
        guard let selectedPath = tableView.indexPathForSelectedRow else { return }
        let album = albums[selectedPath.row]
        photosVC.albumId = album.id
        photosVC.title = album.title
    }
    
    
}
