//
//  PhotosPresenter.swift
//  Viper
//
//  Created by Victor Alejandria on 30/08/2019.
//  Copyright (c) 2019 Victor Alejandria. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import UIKit
import RxSwift
import RxCocoa

final class PhotosPresenter {

	// MARK: - Private properties -

	private var privateAlbum = BehaviorRelay(value: Album())
	private var privatePhotos = BehaviorRelay(value: [Photo]())
	private var privateCache = BehaviorRelay(value: NSCache<NSString, UIImage>())
	private unowned let view: PhotosViewInterface
	private let interactor: PhotosInteractorInterface
	private let wireframe: PhotosWireframeInterface

	// MARK: - Lifecycle -

	init(view: PhotosViewInterface, interactor: PhotosInteractorInterface, wireframe: PhotosWireframeInterface, album: Album) {
		self.view = view
		self.interactor = interactor
		self.wireframe = wireframe
		self.privateAlbum.accept(album)
	}
}

// MARK: - Extensions -

extension PhotosPresenter: PhotosPresenterInterface {
	var album: BehaviorRelay<Album> {
		return privateAlbum
	}

	var photos: BehaviorRelay<[Photo]> {
		return privatePhotos
	}

	var localImageCache: BehaviorRelay<NSCache<NSString, UIImage>> {
		return privateCache
	}

	func downloadPhotoWith(url: String, completion: @escaping DownloadedImageCompletionBlock) {
		self.interactor.downloadPhotoWith(url: url, completion: completion)
	}
	
	func showPhotosWithAlbum(id: Int, completion: @escaping PhotosCompletionBlock) {
		self.interactor.getPhotosWithAlbum(id: id) { (photos) -> (Void) in
			self.privatePhotos.accept(photos)
			completion(photos)
		}
	}
}
