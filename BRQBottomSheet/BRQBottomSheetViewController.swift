//
//  BRQBottomSheetViewController.swift
//  BRQBottomSheet
//
//  Created by Bruno Faganello Neto on 17/07/19.
//  Copyright © 2019 Faganello. All rights reserved.
//

import UIKit

public protocol BRQBottomSheetPresentable {
    var cornerRadius: CGFloat { get set }    
    var animationTransitionDuration: TimeInterval { get set }
    var backgroundColor: UIColor { get set }
}

public class BRQBottomSheetViewController: UIViewController {

    //-----------------------------------------------------------------------------
    // MARK: - Outlets
    //-----------------------------------------------------------------------------
    
    @IBOutlet weak private var contentView: UIView!
    @IBOutlet weak private var contentViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak private var contentViewHeight: NSLayoutConstraint!
    
    //-----------------------------------------------------------------------------
    // MARK: - Private properties
    //-----------------------------------------------------------------------------
   
    private let viewModel: BRQBottomSheetPresentable
    private let childViewController: UIViewController
    private var originBeforeAnimation: CGRect = .zero
    
    //-----------------------------------------------------------------------------
    // MARK: - Initialization
    //-----------------------------------------------------------------------------
    
    public init(viewModel: BRQBottomSheetPresentable, childViewController: UIViewController) {
        self.viewModel = viewModel
        self.childViewController = childViewController
        super.init(
            nibName: String(describing: BRQBottomSheetViewController.self),
            bundle: Bundle(for: BRQBottomSheetViewController.self)
        )
        modalPresentationStyle = .overFullScreen
        modalTransitionStyle = .crossDissolve
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//-----------------------------------------------------------------------------
// MARK: - Lifecycle
//-----------------------------------------------------------------------------

 extension BRQBottomSheetViewController {
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        contentView.alpha = 1
        configureChild()
        
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(BRQBottomSheetViewController.panGesture))
        contentView.addGestureRecognizer(gesture)
        gesture.delegate = self
        
        contentViewBottomConstraint.constant = -childViewController.view.frame.height
        view.layoutIfNeeded()
    }
    
    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let tableView = containsTableView() {
            contentViewHeight.constant = tableView.contentSize.height
            view.layoutIfNeeded()
        } else {
            contentViewHeight.isActive = false
        }
        
        contentViewBottomConstraint.constant = 0
        UIView.animate(withDuration: viewModel.animationTransitionDuration) {
            self.view.backgroundColor = self.viewModel.backgroundColor
            self.view.layoutIfNeeded()
        }
    }
    
    override public func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        contentView.roundCorners([.topLeft, .topRight], radius: viewModel.cornerRadius)
        originBeforeAnimation = contentView.frame
    }
}

//-----------------------------------------------------------------------------
// MARK: - Public Methods
//-----------------------------------------------------------------------------

extension BRQBottomSheetViewController {
    public func dismissViewController() {
        contentViewBottomConstraint.constant = -childViewController.view.frame.height
        UIView.animate(withDuration: viewModel.animationTransitionDuration, animations: {
            self.view.layoutIfNeeded()
            self.view.backgroundColor = .clear
        }, completion: { _ in
            self.dismiss(animated: false, completion: nil)
        })
    }
}

//-----------------------------------------------------------------------------
// MARK: - Private Methods
//-----------------------------------------------------------------------------

private extension BRQBottomSheetViewController {
    
    private func configureChild() {
        addChild(childViewController)
        contentView.addSubview(childViewController.view)
        childViewController.didMove(toParent: self)
        
        guard let childSuperView = childViewController.view.superview else { return }

        NSLayoutConstraint.activate([
            childViewController.view.bottomAnchor.constraint(equalTo: childSuperView.bottomAnchor),
            childViewController.view.topAnchor.constraint(equalTo: childSuperView.topAnchor),
            childViewController.view.leftAnchor.constraint(equalTo: childSuperView.leftAnchor),
            childViewController.view.rightAnchor.constraint(equalTo: childSuperView.rightAnchor)
            ])
        
        childViewController.view.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func shouldDismissWithGesture(_ recognizer: UIPanGestureRecognizer) -> Bool {
        return recognizer.state == .ended
    }
    
    @objc private func panGesture(_ recognizer: UIPanGestureRecognizer) {
        let point = recognizer.location(in: view)
        
        if shouldDismissWithGesture(recognizer) {
            dismissViewController()
        } else {
            if point.y <= originBeforeAnimation.origin.y {
                recognizer.isEnabled = false
                recognizer.isEnabled = true
                return
            }
            contentView.frame = CGRect(x: 0, y: point.y, width: view.frame.width, height: view.frame.height)
        }
    }
    
    private func containsTableView() -> UITableView? {
        for view in childViewController.view.subviews {
            if let tableView = view as? UITableView {
                return tableView
            }
        }
        return nil
    }
}

//-----------------------------------------------------------------------------
// MARK: - Event handling
//-----------------------------------------------------------------------------

extension BRQBottomSheetViewController: UIGestureRecognizerDelegate {
    
    public func gestureRecognizer(
        _ gestureRecognizer: UIGestureRecognizer,
        shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer
        ) -> Bool {
        
        return false
    }
    
    @IBAction private func topViewTap(_ sender: Any) {
        dismissViewController()
    }
}
