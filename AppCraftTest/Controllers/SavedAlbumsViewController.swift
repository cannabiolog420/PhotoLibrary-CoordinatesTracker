//
//  SavedAlbumsViewController.swift
//  AppCraftTest
//
//  Created by cannabiolog420 on 16.04.2021.
//

import UIKit
import RealmSwift

class SavedAlbumsViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    
    // Properties
    
    private let tableView = UITableView()
    private var savedAlbums:Results<SavedAlbum>!
    
    // Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        savedAlbums = realm.objects(SavedAlbum.self)
        
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
        return savedAlbums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: AlbumCell.identifier, for: indexPath) as! AlbumCell
//        cell.accessoryType = .disclosureIndicator
        let album = savedAlbums[indexPath.row]
        cell.set(with: album)
        
        return cell
    }
    
    //MARK: - Table View Delegate
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        performSegue(withIdentifier: "photosSegue", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)

    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete{
        
            let album = savedAlbums[indexPath.row]
        RealmDBManager.deleteObject(album)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
    }
    
    //MARK: - Navigation
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard segue.identifier == "photosSegue" else { return }
        let photosVC = segue.destination as! PhotosViewController
        guard let selectedPath = tableView.indexPathForSelectedRow else { return }
        let album = savedAlbums[selectedPath.row]
//        photosVC.albumId = album.id
        photosVC.title = album.title
    }
    
    
}
