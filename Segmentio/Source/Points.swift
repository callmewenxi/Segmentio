//
//  Points.swift
//  Segmentio
//
//  Created by Serhii Butenko
//  Copyright © 2016 Yalantis Mobile. All rights reserved.
//

import Foundation

struct Points {
    
    var startPoint: CGPoint
    var endPoint: CGPoint
    
    init(context: Context, item: ItemInSuperview, pointY: CGFloat) {
        let cellWidth = item.cellFrameInSuperview.width
        
        var startX = item.startX
        var endX = item.endX
        
        if !context.isFirstCell && !context.isLastCell {
            if context.isLastOrPrelastVisibleCell {
                let updatedStartX = item.collectionViewWidth - (cellWidth * 2) + ((cellWidth - item.shapeLayerWidth) / 2)
                startX = updatedStartX
                let updatedEndX = updatedStartX + item.shapeLayerWidth
                endX = updatedEndX
            }
            
            if context.isFirstOrSecondVisibleCell {
                let updatedEndX = (cellWidth * 2) - ((cellWidth - item.shapeLayerWidth) / 2)
                endX = updatedEndX
                let updatedStartX = updatedEndX - item.shapeLayerWidth
                startX = updatedStartX
            }
        }
        
        if context.isFirstCell {
            startX = (cellWidth - item.shapeLayerWidth) / 2
            endX = startX + item.shapeLayerWidth
        }
        
        if context.isLastCell {
            startX = item.collectionViewWidth - cellWidth + (cellWidth - item.shapeLayerWidth) / 2
            endX = startX + item.shapeLayerWidth
        }
        
        startPoint = CGPoint(x: startX, y: pointY)
        endPoint = CGPoint(x: endX, y: pointY)
    }
    
}
