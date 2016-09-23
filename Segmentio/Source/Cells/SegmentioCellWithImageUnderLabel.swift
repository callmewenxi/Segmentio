//
//  SegmentioCellWithImageUnderLabel.swift
//  Segmentio
//
//  Created by Dmitriy Demchenko
//  Copyright © 2016 Yalantis Mobile. All rights reserved.
//

import UIKit

class SegmentioCellWithImageUnderLabel: SegmentioCell {
    
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
        
        let segmentImageViewHorizontConstraint = NSLayoutConstraint.constraints(
            withVisualFormat: "|-[segmentImageView]-|",
            options: [],
            metrics: nil,
            views: views)
        NSLayoutConstraint.activate(segmentImageViewHorizontConstraint)
        
        let segmentTitleLabelHorizontConstraint = NSLayoutConstraint.constraints(
            withVisualFormat: "|-[segmentTitleLabel]-|",
            options: [],
            metrics: nil,
            views: views)
        NSLayoutConstraint.activate(segmentTitleLabelHorizontConstraint)
        
        let contentViewVerticalConstraints = NSLayoutConstraint.constraints(
            withVisualFormat: "V:[segmentTitleLabel(labelHeight)]-[segmentImageView]",
            options: [],
            metrics: metrics,
            views: views)
        NSLayoutConstraint.activate(contentViewVerticalConstraints)
        
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
            toItem: segmentImageView,
            attribute: .bottom,
            multiplier: 1,
            constant: padding
        )
        bottomConstraint?.isActive = true
    }
    
}
