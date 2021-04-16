//
//  PhotosViewController.swift
//  AppCraftTest
//
//  Created by cannabiolog420 on 15.04.2021.
//

import UIKit


class PhotosViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
    
    // Properties
    
    private var collectionView:UICollectionView!
    private var photos:Photos = []
    var albumId:Int!
    
    // Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        setupNavigatonbar()
        
        AlamofireFetcherService.fetchPhotos(albumId: albumId) { (photos) in
            self.photos = photos
            self.collectionView.reloadData()
        }
        saveButtonStatus()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Возвращаем навигейшн бар в исходное значение
        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        navigationController?.navigationBar.shadowImage = nil
    }
    
    
    //MARK: - UI Setup
    
    
    // Setup Collection View
    private func setupCollectionView(){
        
        // Layout
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        layout.itemSize = CGSize(width: (view.frame.width - 2) / 3, height: (view.frame.width - 2) / 3)
        
        // Collection View
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: PhotoCell.identifier)
        collectionView.pin(to: view)
        
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        
    }
    
    // Setup Navigation Bar
    
    private func setupNavigatonbar(){
        
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveAlbum))
        // Делаем навигейшн бар прозрачным
        self.navigationItem.rightBarButtonItem?.titleTextAttributes(for: .normal)
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    //MARK: - Actions
    
    @objc private func saveAlbum(){
        
        guard let albumTitle = self.title else { return }
        let album = SavedAlbum(title: albumTitle,id: albumId!)
        UserDefaults.standard.setValue(true, forKey: "\(album.id)")
        RealmDBManager.saveObject(album)
        saveButtonStatus()
    }
    
    private func presentFullScreenImage(image:UIImage){
        
        let newImageView = UIImageView(image: image)
        newImageView.frame = UIScreen.main.bounds
        newImageView.backgroundColor = .black
        newImageView.contentMode = .scaleAspectFit
        newImageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissFullScreenImage(_:)))
        newImageView.addGestureRecognizer(tap)
        newImageView.enableZoom()
        self.view.addSubview(newImageView)
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }
    
    
    
    @objc private func dismissFullScreenImage(_ sender: UITapGestureRecognizer) {
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = false
        sender.view?.removeFromSuperview()
    }
    
    func saveButtonStatus(){
        
        if UserDefaults.standard.bool(forKey: "\(albumId!)"){
            navigationItem.rightBarButtonItem?.isEnabled = false
            navigationItem.rightBarButtonItem?.title = "Saved"
        }
        
    }
    
    //MARK: - Collection View Data Source
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.identifier, for: indexPath) as! PhotoCell
        
        let photo = photos[indexPath.row]
        cell.set(with: photo)
        
        return cell
    }
    
    
    //MARK: - Collection View Delegate
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let cell = collectionView.cellForItem(at: indexPath) as! PhotoCell
        let indexPath = collectionView.indexPath(for: cell)
        let photoURL = photos[indexPath!.item].url
        AlamofireFetcherService.fetchImage(from: photoURL) { (image) in
            self.presentFullScreenImage(image: image)
        }
    }
    
}
