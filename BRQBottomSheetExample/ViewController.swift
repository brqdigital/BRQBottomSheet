//
//  ViewController.swift
//  BRQBottomSheetExample
//
//  Created by Bruno Faganello Neto on 17/07/19.
//  Copyright © 2019 Faganello. All rights reserved.
//

import UIKit
import BRQBottomSheet

class ViewController: UIViewController {
    @IBAction func presentBottomSheet(_ sender: Any) {
        let myViewController = BottomViewController()
        
        let bottomSheetViewModel = BRQBottomSheetViewModel(
            viewCornerRadius: 20,
            maxTopConstant: 40,
            animationTransitionDuration: 0.3,
            backgroundColor: .black
        )
        
        let bottomSheetVC = BRQBottomSheetViewController(
            viewModel: bottomSheetViewModel,
            childViewController: myViewController
        )
        
        presentBottomSheet(bottomSheetVC, completion: nil)
    }
}
