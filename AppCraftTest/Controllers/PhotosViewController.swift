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
    
    //MARK: - Methods
    
    @objc func saveAlbum(){
        
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
        print("didselect")
    }
}
