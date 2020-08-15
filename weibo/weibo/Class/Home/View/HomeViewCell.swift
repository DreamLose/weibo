//
//  HomeViewCell.swift
//  weibo
//
//  Created by 2020 on 2020/8/15.
//  Copyright © 2020 2020. All rights reserved.
//

import UIKit
import SDWebImage
fileprivate let edgeMargin : CGFloat = 15
class HomeViewCell: UITableViewCell {
    //MARK: ------- 控件属性
    
    
    @IBOutlet weak var contentLabelWcon: NSLayoutConstraint!
    
    @IBOutlet weak var iconImg: UIImageView!
    
    @IBOutlet weak var verifiedView: UIImageView!
    
    @IBOutlet weak var screenNameLabel: UILabel!
    
    @IBOutlet weak var vipView: UIImageView!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var sourceLabel: UILabel!
    
    @IBOutlet weak var contentLabel: UILabel!
    
    var viewModel : StatusViewModel? {
        didSet {
            guard let viewModel = viewModel else {
                return
            }
            iconImg.sd_setImage(with: viewModel.profileUrl, placeholderImage:UIImage(named: "avatar_default_small"))
            verifiedView.image = viewModel.verifiedImage
            screenNameLabel.text = viewModel.status?.user?.screen_name
            screenNameLabel.textColor = viewModel.vipImage == nil ? UIColor.black : UIColor.orange
            vipView.image = viewModel.vipImage
            timeLabel.text = viewModel.creatAtStr
            sourceLabel.text = viewModel.sourceText
            contentLabel.text = viewModel.status?.text
            
        }
    }
    //MARK: ------- <#注释#>
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        contentLabelWcon.constant = UIScreen.main.bounds.width - 2 * edgeMargin
        
    }

  

}
