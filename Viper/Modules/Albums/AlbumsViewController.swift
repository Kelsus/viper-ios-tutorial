//
//  AlbumsViewController.swift
//  Viper
//
//  Created by Victor Alejandria on 30/08/2019.
//  Copyright (c) 2019 Victor Alejandria. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import UIKit

final class AlbumsViewController: UIViewController {

    // MARK: - Public properties -
	var presenter: AlbumsPresenterInterface!

	// MARK: - Private properties -
	@IBOutlet private weak var name: UILabel!
	@IBOutlet private weak var username: UILabel!
	@IBOutlet private weak var email: UILabel!
	@IBOutlet private weak var address: UILabel!
	@IBOutlet private weak var phone: UILabel!
	@IBOutlet private weak var website: UILabel!
	@IBOutlet private weak var tableview: UITableView!
	@IBOutlet private weak var tableView: UITableView!

    // MARK: - Lifecycle -
    override func viewDidLoad() {
        super.viewDidLoad()

		name.text = presenter.user.name
		username.text = presenter.user.username
		email.text = presenter.user.email
		address.text = presenter.user.address
		phone.text = presenter.user.phone
		website.text = presenter.user.website

		showUserAlbums()
    }
	
}

// MARK: - UITableView Delegate -
extension AlbumsViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let selectedAlbum = self.presenter.albums[indexPath.row]
		showSelectedAlbumWith(album: selectedAlbum)
	}
}

// MARK: - UITableView DataSource -
extension AlbumsViewController: UITableViewDataSource {
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return presenter.albums.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let item = presenter.albums[indexPath.row]
		var cell = tableView.dequeueReusableCell(withIdentifier: "albumCell")
		if (cell == nil)
		{
			cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "albumCell")
		}
		cell?.textLabel?.text = item.title
		return cell ?? UITableViewCell()
	}
}

// MARK: - Extensions -

extension AlbumsViewController: AlbumsViewInterface {
	func showUserAlbums() {
		presenter.showUserAlbums { (albums) -> (Void) in
			DispatchQueue.main.async { [weak self] in
				self?.tableView.reloadData()
			}
		}
	}

	func showSelectedAlbumWith(album: Album) {
		presenter.show(album: album)
	}

}