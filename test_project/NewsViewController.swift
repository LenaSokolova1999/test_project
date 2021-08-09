//
//  NewsViewController.swift
//  test_project
//
//  Created by Mac Mini 2018 on 05.08.2021.
//

import UIKit
import SnapKit
import SDWebImage
import Moya

final class NewsViewController: UIViewController {

    // MARK:- Public properties

    var titl: UILabel!
    var diccription: UILabel!
    var _imgNews = UIImageView()
    var news = ViewController()
    var index: Int?
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView(frame: .zero)
        view.backgroundColor = .white
        view.frame = self.view.bounds
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        navigation()
        title()
    }

    // MARK:- Public metod

    func title() {
        guard let index = index else { fatalError() }

        _imgNews = UIImageView(frame: .zero)
        self.view.addSubview(_imgNews)
        _imgNews.image = ViewController.data[index].image
        _imgNews.frame = CGRect(x: 0, y: 20, width: view.frame.width, height: 300)
        _imgNews.contentMode = .scaleAspectFit

        titl = UILabel(frame: .zero)
        self.view.addSubview(titl)
        titl.text = ViewController.data[index].title
        titl.numberOfLines = 0
        titl.lineBreakMode = .byTruncatingTail
        titl.minimumScaleFactor = 0.8
        titl.textAlignment = .center
        titl.font = titl.font.withSize(25)
        titl.frame = CGRect(x: 0, y: 320, width: view.frame.width, height: 80)

        diccription = UILabel(frame: .zero)
        self.view.addSubview(diccription)
        diccription.text = ViewController.data[index].description
        diccription.numberOfLines = 0
        diccription.lineBreakMode = .byTruncatingTail
        diccription.minimumScaleFactor = 0.8
        diccription.frame = CGRect(x: 0, y: 400, width: view.frame.width, height: 200)
    }

   func navigation() {
        navigationController?.navigationBar.barTintColor = UIColor.systemGray6
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: UIBarButtonItem.Style.plain, target: self, action: #selector(back))
        self.title = "News"
    }

    @objc func back() {
        self.dismiss(animated: true)
    }

    func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.addSubview(view)

        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        view.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        view.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        view.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
    }
}
