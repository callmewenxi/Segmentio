//
//  SegmentioCellWithImage.swift
//  Segmentio
//
//  Created by Dmitriy Demchenko
//  Copyright © 2016 Yalantis Mobile. All rights reserved.
//

import UIKit

final class SegmentioCellWithImage: SegmentioCell {
    
    override func setupConstraintsForSubviews() {
        guard let segmentImageView = segmentImageView else {
            return
        }
        
        let views = ["segmentImageView": segmentImageView]
        
        // main constraints
        
        let segmentImageViewlHorizontConstraint = NSLayoutConstraint.constraints(
            withVisualFormat: "|-[segmentImageView]-|",
            options: [],
            metrics: nil,
            views: views)
        NSLayoutConstraint.activate(segmentImageViewlHorizontConstraint)
        
        // custom constraints
        
        topConstraint = NSLayoutConstraint(
            item: segmentImageView,
            attribute: .top,
            relatedBy: .equal,
            toItem: contentView,
            attribute: .top,
            multiplier: 1,
            constant: padding
        )
        topConstraint?.isActive = true
        
        bottomConstraint = NSLayoutConstraint(
            item: contentView,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: segmentImageView,
            attribute: .bottom,
            multiplier: 1,
            constant: padding
        )
        bottomConstraint?.isActive = true
    }
    
}
