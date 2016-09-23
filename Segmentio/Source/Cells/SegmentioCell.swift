//
//  SegmentioCell.swift
//  Segmentio
//
//  Created by Dmitriy Demchenko
//  Copyright © 2016 Yalantis Mobile. All rights reserved.
//

import UIKit

class SegmentioCell: UICollectionViewCell {
    
    let padding: CGFloat = 8
    let segmentTitleLabelHeight: CGFloat = 22
    
    var verticalSeparatorView: UIView?
    var segmentTitleLabel: UILabel?
    var segmentImageView: UIImageView?
    
    var topConstraint: NSLayoutConstraint?
    var bottomConstraint: NSLayoutConstraint?
    var cellSelected = false
    
    fileprivate var options = SegmentioOptions()
    fileprivate var style = SegmentioStyle.ImageOverLabel
    fileprivate let verticalSeparatorLayer = CAShapeLayer()
    
    override var isHighlighted: Bool {
        get {
            return super.isHighlighted
        }
        
        set {
            if newValue != isHighlighted {
                super.isHighlighted = newValue
                
                let highlightedState = options.states.highlightedState
                let defaultState = options.states.defaultState
                let selectedState = options.states.selectedState
                
                if style.isWithText() {
                    let highlightedTitleTextColor = cellSelected ? selectedState.titleTextColor : defaultState.titleTextColor
                    let highlightedTitleFont = cellSelected ? selectedState.titleFont : defaultState.titleFont
                    
                    segmentTitleLabel?.textColor = isHighlighted ? highlightedState.titleTextColor : highlightedTitleTextColor
                    segmentTitleLabel?.font = isHighlighted ? highlightedState.titleFont : highlightedTitleFont
                }
                
                backgroundColor = isHighlighted ? highlightedState.backgroundColor : defaultState.backgroundColor
            }
        }
    }
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        segmentImageView = UIImageView(frame: CGRect.zero)
        if let segmentImageView = segmentImageView {
            contentView.addSubview(segmentImageView)
        }
        
        segmentTitleLabel = UILabel(frame: CGRect.zero)
        if let segmentTitleLabel = segmentTitleLabel {
            contentView.addSubview(segmentTitleLabel)
        }
        
        segmentImageView?.translatesAutoresizingMaskIntoConstraints = false
        segmentTitleLabel?.translatesAutoresizingMaskIntoConstraints = false
        
        segmentImageView?.layer.masksToBounds = true
        segmentTitleLabel?.font = UIFont.systemFont(ofSize: UIFont.smallSystemFontSize)
        
        setupConstraintsForSubviews()
        addVerticalSeparator()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        verticalSeparatorLayer.removeFromSuperlayer()
        super.prepareForReuse()
        
        switch style {
        case .OnlyLabel:
            segmentTitleLabel?.text = nil
        case .OnlyImage:
            segmentImageView?.image = nil
        default:
            segmentTitleLabel?.text = nil
            segmentImageView?.image = nil
        }
    }
    
    // MARK: - Configure
    
    func configure(content: SegmentioItem, style: SegmentioStyle, options: SegmentioOptions, isLastCell: Bool) {
        self.options = options
        self.style = style
        setupContent(content: content)
        
        if let indicatorOptions = self.options.indicatorOptions {
            setupConstraint(indicatorOptions: indicatorOptions)
        }
        
        if let _ = options.verticalSeparatorOptions {
            if isLastCell == false {
                setupVerticalSeparators()
            }
        }
    }
    
    func configure(selected: Bool) {
        cellSelected = selected
        
        let selectedState = options.states.selectedState
        let defaultState = options.states.defaultState
        
        if style.isWithText() {
            segmentTitleLabel?.textColor = selected ? selectedState.titleTextColor : defaultState.titleTextColor
            segmentTitleLabel?.font = selected ? selectedState.titleFont : defaultState.titleFont
        }
    }
    
    func setupConstraintsForSubviews() {
        return // implement in subclasses
    }
    
    // MARK: - Private functions
    
    fileprivate func setupContent(content: SegmentioItem) {
        if style.isWithImage() {
            segmentImageView?.contentMode = options.imageContentMode
            segmentImageView?.image = content.image
        }
        
        if style.isWithText() {
            segmentTitleLabel?.textAlignment = options.labelTextAlignment
            let defaultState = options.states.defaultState
            segmentTitleLabel?.textColor = defaultState.titleTextColor
            segmentTitleLabel?.font = defaultState.titleFont
            segmentTitleLabel?.text = content.title
        }
    }
    
    fileprivate func setupConstraint(indicatorOptions: SegmentioIndicatorOptions) {
        switch indicatorOptions.type {
        case .top:
            topConstraint?.constant = padding + indicatorOptions.height
        case .bottom:
            bottomConstraint?.constant = padding + indicatorOptions.height
        }
    }
    
    // MARK: - Vertical separator
    
    fileprivate func addVerticalSeparator() {
        let contentViewWidth = contentView.bounds.width
        let rect = CGRect(
            x: contentView.bounds.width - 1,
            y: 0,
            width: 1,
            height: contentViewWidth
        )
        verticalSeparatorView = UIView(frame: rect)
        
        guard let verticalSeparatorView = verticalSeparatorView else {
            return
        }
        
        if let lastView = contentView.subviews.last {
            contentView.insertSubview(verticalSeparatorView, aboveSubview: lastView)
        } else {
            contentView.addSubview(verticalSeparatorView)
        }
        
        // setup constraints
        
        verticalSeparatorView.translatesAutoresizingMaskIntoConstraints = false
        
        let widthConstraint = NSLayoutConstraint(
            item: verticalSeparatorView,
            attribute: .width,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: 1
        )
        widthConstraint.isActive = true
        
        let trailingConstraint = NSLayoutConstraint(
            item: verticalSeparatorView,
            attribute: .trailing,
            relatedBy: .equal,
            toItem: contentView,
            attribute: .trailing,
            multiplier: 1,
            constant: 0
        )
        trailingConstraint.isActive = true
        
        let topConstraint = NSLayoutConstraint(
            item: verticalSeparatorView,
            attribute: .top, relatedBy: .equal,
            toItem: contentView, attribute: .top,
            multiplier: 1,
            constant: 0
        )
        topConstraint.isActive = true
        
        let bottomConstraint = NSLayoutConstraint(
            item: contentView,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: verticalSeparatorView,
            attribute: .bottom,
            multiplier: 1,
            constant: 0
        )
        bottomConstraint.isActive = true
    }
    
    fileprivate func setupVerticalSeparators() {
        guard let verticalSeparatorOptions = options.verticalSeparatorOptions else {
            return
        }
        
        guard let verticalSeparatorView = verticalSeparatorView else {
            return
        }
        
        let heightWithRatio = bounds.height * CGFloat(verticalSeparatorOptions.ratio)
        let difference = (bounds.height - heightWithRatio) / 2
        
        let startY = difference
        let endY = bounds.height - difference
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: verticalSeparatorView.frame.width / 2, y: startY))
        path.addLine(to: CGPoint(x: verticalSeparatorView.frame.width / 2, y: endY))
        
        verticalSeparatorLayer.path = path.cgPath
        verticalSeparatorLayer.lineWidth = 1
        verticalSeparatorLayer.strokeColor = verticalSeparatorOptions.color.cgColor
        verticalSeparatorLayer.fillColor = verticalSeparatorOptions.color.cgColor
        
        verticalSeparatorView.layer.addSublayer(verticalSeparatorLayer)
    }
    
}
