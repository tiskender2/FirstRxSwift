//
//  SubtitleTableViewCell.swift
//  FirstRxSwift
//
//  Created by Tolga İskender on 3.10.2020.
//  Copyright © 2020 Tolga İskender. All rights reserved.
//

import UIKit

class SubtitleTableViewCell: UITableViewCell {
    
    override init(style: CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
