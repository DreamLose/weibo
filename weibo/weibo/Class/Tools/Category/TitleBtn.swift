//
//  TitleBtn.swift
//  weibo
//
//  Created by 2020 on 2020/7/26.
//  Copyright © 2020 2020. All rights reserved.
//

import UIKit

class TitleBtn: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
       setImage(UIImage(named: "navigationbar_arrow_down"), for: .normal)
       setImage(UIImage(named: "navigationbar_arrow_up"), for: .selected)
       setTitleColor(UIColor.black, for: .normal)
       sizeToFit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //调整文字图片位置
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel!.frame.origin.x = 0
        imageView!.frame.origin.x = titleLabel!.frame.size.width + 5
    }
}
