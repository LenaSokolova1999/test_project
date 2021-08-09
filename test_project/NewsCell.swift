//
//  NewsCell.swift
//  test_project
//
//  Created by Mac Mini 2018 on 04.08.2021.
//

import UIKit
import SnapKit
import SDWebImage
import Moya

final class NewsCell: UITableViewCell {

    // MARK:- Public properties

    var title: UILabel!
    var descript: UILabel!
    var _imgNews: UIImageView!
    let identifier: String = "news_cell_identifier"

    // MARK:- Initialization

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        _imgNews = UIImageView(frame: .zero)
        self.contentView.addSubview(_imgNews)
        _imgNews.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(12)
            make.width.equalTo(60)
            make.height.equalTo(60)
            make.centerY.equalToSuperview()
         }

        title = UILabel(frame: .zero)
        self.contentView.addSubview(title)
        title.snp.makeConstraints {
            $0.left.equalTo(_imgNews).offset(72)
            $0.right.equalToSuperview().offset(-12)
            $0.top.equalToSuperview().offset(4)
        }

        descript = UILabel(frame: .zero)
        self.contentView.addSubview(descript)
        descript.textColor = UIColor.gray
        descript.lineBreakMode = .byWordWrapping
        descript.numberOfLines = 2
        descript.snp.makeConstraints {
            $0.left.equalTo(_imgNews).offset(72)
            $0.right.equalToSuperview().offset(-12)
            $0.top.equalTo(title).offset(21)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
