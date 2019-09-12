//
//  AlbumsWireframe.swift
//  Viper
//
//  Created by Victor Alejandria on 30/08/2019.
//  Copyright (c) 2019 Victor Alejandria. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import UIKit
import RxCocoa

final class AlbumsWireframe: BaseWireframe<AlbumsViewController> {

    // MARK: - Private properties -
    private let storyboard = UIStoryboard(name: "Albums", bundle: nil)

    // MARK: - Module setup -
	init(user: ServicesUser) {
        let moduleViewController = storyboard.instantiateViewController(ofType: AlbumsViewController.self)
        super.init(viewController: moduleViewController)
        
        let interactor = AlbumsInteractor(services: Services())
		let presenter = AlbumsPresenter(view: moduleViewController, interactor: interactor, wireframe: self, user: user)
        moduleViewController.presenter = presenter
    }
}

// MARK: - Extensions -

extension AlbumsWireframe: AlbumsWireframeInterface {
	func willShowUser(album: Album) {
		navigationController?.pushWireframe(PhotosWireframe(album: album))
	}

	func willChange(user: BehaviorRelay<User>) {
		navigationController?.pushWireframe(ChangeUserWireframe(user: user))
	}
}
