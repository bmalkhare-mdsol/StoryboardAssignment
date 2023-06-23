//
//  ImageViewController.swift
//  StoryboardAssignment
//
//  Created by Bhakti MALKHARE on 20/06/23.
//

import Foundation
import UIKit
import SQLite3
class ImageViewController: UIViewController {
    var clickedImage: UIImage?
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let image = clickedImage {
            imageView.image = image
        }
    }
}
