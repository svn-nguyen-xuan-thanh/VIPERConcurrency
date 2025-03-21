//
//  ProductCell.swift
//  VIPERConcurrency
//
//  Created by Thanh Nguyen Xuan on 21/3/25.
//

import UIKit
import Reusable

class ProductCell: UITableViewCell, NibReusable {
    @IBOutlet private var priceLabel: UILabel!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var thumbnailImageView: UIImageView!

    func configureCell(with product: Product) {
        titleLabel.text = product.title
        priceLabel.text = "$\(product.price)"
        thumbnailImageView.image = nil
        thumbnailImageView.kf.setImage(with: URL(string: product.thumbnail)!)
    }
}
