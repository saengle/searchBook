//
//  DetailView.swift
//  SearchBook
//
//  Created by 쌩 on 5/7/24.
//

import UIKit

import SnapKit

class DetailView: UIViewController {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "세이노의 가르침"
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    let authorLabel: UILabel = {
        let label = UILabel()
        label.text = "세이노"
        label.textColor = .gray
        label.textAlignment = .center
        return label
    }()
    
    let scrollView: UIScrollView = {
       let view = UIScrollView()
        view.backgroundColor = .link
        return view
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .darkGray
        return imageView
    }()
    
    let priceLabel: UILabel = {
       let label = UILabel()
        label.text = "15000원"
        label.textAlignment = .center
        return label
    }()
    
    let textView: UITextView = {
        let view = UITextView()
        view.text = "임시로 쓰는 글이 엄ㅇ어어어어어어어어어어어엄청 길어야해 시작은 엠4는 3번째 세대이고 이거는 아주아주 얇고 엄청난 기술이 적용됨 컬러 밝기 등 디스플레이도 짱짱이야 엠포는 엄청나게 강력한 프로모델이야 새로운 씨피유는 엠투보다 엄청 좋고  쥐피유가 무려 10개, 디아블로 같은거 엄청 잘 돼. 엠투보다 4배는 빨라 엠포는 아니 근데 왜 계속 엠쓰리랑 비교 안하고 엠투랑 비교하니 ??? "
        view.backgroundColor = .lightGray
        return view
    }()
    
    
    let cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("x", for: .normal)
        button.backgroundColor = .lightGray
        return button
    }()
    
    let addListButton: UIButton = {
        let button = UIButton()
        button.setTitle("담기", for: .normal)
        button.backgroundColor = .green
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
}

extension DetailView {
    
    private func setUI() {
        addSubViews()
        setConstraints()
        self.scrollView.updateContentSize()
    }
    
    private func addSubViews() {
        [imageView, priceLabel, textView].forEach{scrollView.addSubview($0)}
        [titleLabel, authorLabel, scrollView, cancelButton, addListButton].forEach{self.view.addSubview($0)}
    }
    
    private func setConstraints() {
        titleLabelConstraints()
        authorLabelConstraints()
        scrollViewConstraints()
        imageViewConstraints()
        priceLabelConstraints()
        textViewConstraints()
        cancelButtonConstraints()
        addButtonConstraints()
    }
    
    private func titleLabelConstraints() {
        titleLabel.snp.makeConstraints{ make in
            make.top.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
            make.height.equalTo(30)
        }
        
    }
    
    private func authorLabelConstraints() {
        authorLabel.snp.makeConstraints{ make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
            make.height.equalTo(20)
        }
        
    }
    
    private func scrollViewConstraints() {
        scrollView.snp.makeConstraints{ make in
            make.top.equalTo(authorLabel.snp.bottom).offset(10)
            make.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
            make.bottom.equalTo(cancelButton.snp.top).offset(-10)
        }
        
    }
    
    private func imageViewConstraints() {
        imageView.snp.makeConstraints{ make in
            make.top.equalToSuperview()
            make.directionalHorizontalEdges.equalTo(self.view.safeAreaLayoutGuide)
            make.height.equalTo(300)
        }
    }
    
    private func priceLabelConstraints() {
        priceLabel.snp.makeConstraints{ make in
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.directionalHorizontalEdges.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
    
    private func textViewConstraints() {
        textView.snp.makeConstraints{ make in
            make.bottom.equalTo(cancelButton.snp.top).offset(15)
            make.top.equalTo(priceLabel.snp.bottom).offset(10)
            make.directionalHorizontalEdges.equalTo(self.view.safeAreaLayoutGuide)
            
        }
        
    }
    
    private func cancelButtonConstraints() {
        cancelButton.snp.makeConstraints{ make in
            make.bottom.leading.equalTo(self.view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(50)
            make.width.equalTo(70)
            
        }
    }
    
    private func addButtonConstraints() {
        addListButton.snp.makeConstraints{ make in
            make.bottom.trailing.equalTo(self.view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(cancelButton)
            make.leading.equalTo(cancelButton.snp.trailing).offset(20)
        }
    }
}

extension UIScrollView {
    // Mark: 스크롤뷰의 크기를 동적으로 계산하여 적용
    func updateContentSize() {
        let unionCalculatedTotalRect = recursiveUnionInDepthFor(view: self)
        
        // 계산된 크기로 컨텐츠 사이즈 설정
        self.contentSize = CGSize(width: self.frame.width, height: unionCalculatedTotalRect.height+50)
    }
    
    private func recursiveUnionInDepthFor(view: UIView) -> CGRect {
        var totalRect: CGRect = .zero
        
        // 모든 자식 View의 컨트롤의 크기를 재귀적으로 호출하며 최종 영역의 크기를 설정
        for subView in view.subviews {
            totalRect = totalRect.union(recursiveUnionInDepthFor(view: subView))
        }
        
        // 최종 계산 영역의 크기를 반환
        return totalRect.union(view.frame)
    }
}

#Preview {
    DetailView()
}
