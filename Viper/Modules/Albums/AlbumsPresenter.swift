//
//  AlbumsPresenter.swift
//  Viper
//
//  Created by Victor Alejandria on 30/08/2019.
//  Copyright (c) 2019 Victor Alejandria. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import UIKit

final class AlbumsPresenter {

    // MARK: - Private properties -
	private var privateUser = ServicesUser()
	private var privateAlbums = [Album]()

    private unowned let view: AlbumsViewInterface
    private let interactor: AlbumsInteractorInterface
    private let wireframe: AlbumsWireframeInterface

    // MARK: - Lifecycle -

	init(view: AlbumsViewInterface, interactor: AlbumsInteractorInterface, wireframe: AlbumsWireframeInterface, user: ServicesUser) {
		self.privateUser = user
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
    }
}

// MARK: - Extensions -

extension AlbumsPresenter: AlbumsPresenterInterface {
	func showUserAlbums(completion: @escaping AlbumsCompletionBlock) {
		interactor.getAlbumsBy(user: privateUser.id ?? 0) { [weak self] (albums) -> (Void) in
			self?.privateAlbums = albums
			completion(albums)
		}
	}

	func showAlbumWith(id: Int) {
		interactor.getAlbumBy(id: id) { [weak self] (album) -> (Void) in
			DispatchQueue.main.async {
				self?.wireframe.willShowUser(album: album)
			}
		}
	}

	func show(album: Album) {
		self.wireframe.willShowUser(album: album)
	}

	var user: User {
		return User(user: privateUser)
	}
	
	var albums: [Album] {
		return privateAlbums
	}
}
