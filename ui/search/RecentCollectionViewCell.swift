//
//  RecentCollectionViewCell.swift
//  SearchBook
//
//  Created by 쌩 on 5/8/24.
//

import UIKit

class RecentCollectionViewCell: UICollectionViewCell {
    static let identifier = String(describing: RecentCollectionViewCell.self)
    
    let bgImageView = UIImageView()
    let nameLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RecentCollectionViewCell {
    private func setUI() {
        self.contentView.addSubview(bgImageView)
        self.contentView.addSubview(nameLabel)
        setConstraints()
    }
    
    private func setConstraints() {
        bgImageConstraints()
        nameLabelConstraints()
    }
    
    private func bgImageConstraints() {
        bgImageView.snp.makeConstraints{ make in
            make.centerX.centerY.equalToSuperview()
            make.width.equalToSuperview()
            make.bottom.equalTo(nameLabel.snp.top).offset(-5)
        }
    }
    
    private func nameLabelConstraints() {
        nameLabel.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-5)
        }
    }
}
