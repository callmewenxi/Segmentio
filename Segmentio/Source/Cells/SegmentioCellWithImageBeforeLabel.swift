//
//  SegmentioCellWithImageBeforeLabel.swift
//  Segmentio
//
//  Created by Dmitriy Demchenko
//  Copyright © 2016 Yalantis Mobile. All rights reserved.
//

import UIKit

class SegmentioCellWithImageBeforeLabel: SegmentioCell {
    
    override func setupConstraintsForSubviews() {
        guard let segmentImageView = segmentImageView else {
            return
        }
        guard let segmentTitleLabel = segmentTitleLabel else {
            return
        }
        
        let metrics = ["labelHeight": segmentTitleLabelHeight]
        let views = [
            "segmentImageView": segmentImageView,
            "segmentTitleLabel": segmentTitleLabel
        ]
        
        // main constraints
        
        let segmentImageViewVerticalConstraint = NSLayoutConstraint.constraints(
            withVisualFormat: "V:[segmentImageView(labelHeight)]",
            options: [.alignAllCenterY],
            metrics: metrics,
            views: views)
        NSLayoutConstraint.activate(segmentImageViewVerticalConstraint)
        
        let contentViewHorizontalConstraints = NSLayoutConstraint.constraints(
            withVisualFormat: "|-[segmentImageView(labelHeight)]-[segmentTitleLabel]-|",
            options: [.alignAllCenterY],
            metrics: metrics,
            views: views)
        NSLayoutConstraint.activate(contentViewHorizontalConstraints)
        
        // custom constraints
        
        topConstraint = NSLayoutConstraint(
            item: segmentTitleLabel,
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
            toItem: segmentTitleLabel,
            attribute: .bottom,
            multiplier: 1,
            constant: padding
        )
        bottomConstraint?.isActive = true
    }
    
}
