//
//  ViewController.swift
//  test_project
//
//  Created by Mac Mini 2018 on 04.08.2021.
//

import UIKit
import SnapKit
import SDWebImage
import Moya

struct NewsStruct {
    var title: String
    var description: String
    var image: UIImage
}

final class ViewController: UIViewController {

    // MARK:- Public properties

    var tableView: UITableView!
    let newsProvider = MoyaProvider<News>()
    var page: Int = 1
    static var data: [NewsStruct] = []
    var info = [NewsResponseModel]() {
        didSet {
            self.tableView.reloadData()
        }
    }

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView = UITableView(frame: .zero)
        self.view.addSubview(tableView)
        tableView.register(NewsCell.self, forCellReuseIdentifier: "NewsCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        pagination(page: page)
    }

    // MARK:- Public metod

    func pagination(page: Int) {
        self.page += 1
        newsProvider.request(.readNews(page: page)) { result in
            switch result {
            	case let .success(response): do {
                    let result = try JSONDecoder().decode(Info.self, from: response.data)
                    for elem in 0..<result.articles.count {
                    	let model = NewsResponseModel(title: result.articles[elem].title, description: result.articles[elem].description, urlToImage: result.articles[elem].urlToImage)
                    	self.info.append(model) }
                    print(result)
                } catch { print(error.localizedDescription) }
            case let .failure(error): print(error) }
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == ViewController.data.count - 1 { pagination(page: page) }
        let vc = NewsViewController()
        vc.index = indexPath.row
        let myNavigation = UINavigationController(rootViewController: vc)
        myNavigation.modalPresentationStyle = .fullScreen
        present(myNavigation, animated: true, completion: nil)
    }
}

// MARK:- Extension

extension ViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.info.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let info = self.info[indexPath.row]
        if indexPath.row == self.info.count - 1 { pagination(page: page) }
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsCell
        guard let url = URL?(info.urlToImage!) else { return cell }
        cell._imgNews?.sd_setImage(with: url, completed: nil)
        cell.title?.text = info.title ?? ""
        cell.descript?.text = info.description ?? ""
        guard let img = cell._imgNews.image else { return cell }
        let newsStruct = NewsStruct(title: cell.title.text ?? "", description: cell.descript.text ?? "", image: img)
        ViewController.data.append(newsStruct)
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.white
        return cell
    }
}
