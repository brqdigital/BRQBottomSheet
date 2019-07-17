//
//  BRQBottomSheetViewModel.swift
//  BRQBottomSheet
//
//  Created by Bruno Faganello Neto on 17/07/19.
//  Copyright © 2019 Faganello. All rights reserved.
//

import Foundation

public struct BRQBottomSheetViewModel: BRQBottomSheetViewControllerPresentable {
   
    public var viewCornerRadius: CGFloat
    public var maxTopConstant: CGFloat
    public var animationTransitionDuration: TimeInterval
    public var backgroundColor: UIColor
    
    public init(viewCornerRadius: CGFloat,
                maxTopConstant: CGFloat,
                animationTransitionDuration: TimeInterval,
                backgroundColor: UIColor ) {
        
        self.viewCornerRadius = viewCornerRadius
        self.maxTopConstant = maxTopConstant
        self.animationTransitionDuration = animationTransitionDuration
        self.backgroundColor = backgroundColor
    }
}
