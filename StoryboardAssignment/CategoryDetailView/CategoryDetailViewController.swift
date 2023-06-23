//
//  CategoryDetailViewController.swift
//  StoryboardAssignment
//
//  Created by Bhakti MALKHARE on 19/06/23.
//

import Foundation
import UIKit
import PDFKit
import AVKit
class CategoryDetailViewController: BaseViewController {
    @IBOutlet weak var categoryDetailTable: UITableView!
    var configurator: CategoryDetailViewConfigurator?
    var presenter: CategoryDetailPresenter!
    var pdfView:PDFView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.categoryDetailTable.register(UINib(nibName: CategoryListTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: CategoryListTableViewCell.identifier)
        categoryDetailTable.separatorStyle = .none
        self.navigationItem.title = presenter.getNavigationHeaderTitle()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter.viewWillAppear()
    }
    
    override func leftTapped() {
        if pdfView != nil {
            self.pdfView?.removeFromSuperview()
            self.pdfView = nil
        }
        else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func loadPDF(){
        pdfView = PDFView()
        pdfView?.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pdfView ?? PDFView())
        pdfView?.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        pdfView?.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        pdfView?.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        pdfView?.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    
}
extension CategoryDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRows(in: section)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.numberOfSection()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerview = UIView(frame: CGRect(x: 0, y: 0, width: self.categoryDetailTable.frame.width, height: 45))
        let titleLabel = UILabel(frame: CGRect(x: 20, y: 0, width: headerview.frame.width - 32, height: headerview.frame.height))
        titleLabel.text = CategoryType.getCategoryType(index: section)?.getCategoryNames()
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        headerview.addSubview(titleLabel)
        headerview.backgroundColor = Colors.header.uiColor
        return headerview
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = presenter.getCategoryDetailModel(index: indexPath)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CategoryListTableViewCell.identifier) as! CategoryListTableViewCell
        cell.configure(model: model)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let model = presenter.getCategoryDetailModel(index: indexPath) else { return }
        guard let type = CategoryType(rawValue: model.type) else { return }
        switch type {
        case .image:
            presenter.updateCategoryDetailModel(index: indexPath)
            self.showImage(name: model.category_slug)
        case .pdf:
            presenter.updateCategoryDetailModel(index: indexPath)
            self.loadPDF(name: model.category_slug)
        case .video:
            presenter.updateCategoryDetailModel(index: indexPath)
            self.playVideo(name: model.category_slug)
        }
    }
}


extension CategoryDetailViewController {
    func showImage(name: String) {
        guard let image = UIImage(named: name) else { return }
        guard let vc =  CommonUtility.getViewController(storyboardName: StoryBordIds.main, bundleID: StoryBordIds.imageViewController) as? ImageViewController else { return }
        vc.clickedImage = image
        self.reloadTable()
        present(vc, animated: true, completion: nil)
    }
    
    func loadPDF(name: String) {
        loadPDF()
        guard let path = Bundle.main.url(forResource: name, withExtension: WithExtension.pdf.rawValue) else { return }
        self.reloadTable()
        if let document = PDFDocument(url: path) {
            pdfView?.document = document
        }
    }
    
    func playVideo(name: String) {
        guard let videoURL = Bundle.main.url(forResource: name, withExtension: WithExtension.mp4.rawValue) else { return }
        let player = AVPlayer(url: videoURL)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        self.present(playerViewController, animated: true) {
            playerViewController.player!.play()
        }
    }
}

extension CategoryDetailViewController: CategoryDetailView {
    func reloadTable() {
        self.categoryDetailTable.reloadData()
    }
}
