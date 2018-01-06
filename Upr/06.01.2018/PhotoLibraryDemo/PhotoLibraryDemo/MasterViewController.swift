//
//  MasterViewController.swift
//  PhotoLibraryDemo
//
//  Created by Dragomir Ivanov on 6.01.18.
//  Copyright © 2018 Swift FMI. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        PhotoLibrary.library.loadAlbums { [weak self] in
            self?.tableView.reloadData()
        }
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }
    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let object = PhotoLibrary.library.albums?[indexPath.row]
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = object
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PhotoLibrary.library.albums?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? AlbumCell else { return UITableViewCell() }
        
        guard let album = PhotoLibrary.library.albums?[indexPath.row] else {
            return cell
        }
        
        cell.titleLabel.text = album.title
        cell.subtitleLabel.text = String(album.photos.count)
        
        cell.albumThumbnailImageView.image = nil
        
        PhotoLibrary.requestThumbnail(for: album) { [weak cell] (image, info) in
            cell?.albumThumbnailImageView.image = image
        }

        return cell
    }
}

