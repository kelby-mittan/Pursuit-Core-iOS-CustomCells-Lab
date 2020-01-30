//
//  RanUserCell.swift
//  ProgrammaticUserCells
//
//  Created by Kelby Mittan on 1/29/20.
//  Copyright © 2020 Benjamin Stone. All rights reserved.
//

import UIKit
import ImageKit

class RanUserCell: UICollectionViewCell {
   
    @IBOutlet var userImage: UIImageView!
    
    @IBOutlet var nameLabel: UILabel!
    
    @IBOutlet var numberLabel: UILabel!
    
    public func configureCell(user: User) {
        nameLabel.text = "\(user.name.first) \(user.name.last)"
        numberLabel.text = user.cell
        
        userImage.getImage(with: user.picture.medium) { (result) in
            switch result {
            case .failure:
                self.userImage.image = UIImage(systemName: "person.fill")
            case .success(let image):
                DispatchQueue.main.async {
                    self.userImage.image = image
                }
            }
        }
    }
}
