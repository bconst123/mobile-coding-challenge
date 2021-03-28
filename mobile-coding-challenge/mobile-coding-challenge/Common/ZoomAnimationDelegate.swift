//
//  ZoomAnimationDelegate.swift
//  mobile-coding-challenge
//
//  Created by Bruno Augusto Constantino on 3/28/21.
//  Copyright © 2021 Bruno Augusto Constantino. All rights reserved.
//

import UIKit

protocol ZoomViewController {
    func zoomImageView(for transition: ZoomAnimationDelegate) -> UIImageView?
    func zoomBackgroundView(for transition: ZoomAnimationDelegate) -> UIView?
}

enum TransitionState {
    case initial
    case final
}

class ZoomAnimationDelegate: NSObject {
    var transitionDuration = 0.5
    var operation: UINavigationControllerOperation = .none
    private let zoomScale: CGFloat = 15
    private let backgroundScale: CGFloat = 0.7
    
    typealias ZoomingViews = (otherView: UIView, imageView: UIView)
    
    func configureViews(for state: TransitionState, containerView: UIView, backgroundViewController: UIViewController, viewsInBackground: ZoomingViews, viewsInForeground: ZoomingViews, snapshotViews: ZoomingViews) {
        switch state {
        case .initial:
            backgroundViewController.view.transform = CGAffineTransform.identity
            backgroundViewController.view.alpha = 1
            
            snapshotViews.imageView.frame = containerView.convert(viewsInBackground.imageView.frame, from: viewsInBackground.imageView.superview)
        case .final:
            backgroundViewController.view.transform = CGAffineTransform(scaleX: backgroundScale, y: backgroundScale)
            backgroundViewController.view.alpha = 0
            
            snapshotViews.imageView.frame = containerView.convert(viewsInForeground.imageView.frame, from: viewsInForeground.imageView.superview)
        }
    }
}

extension ZoomAnimationDelegate: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return transitionDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let duration = transitionDuration(using: transitionContext)
        let fromViewController = transitionContext.viewController(forKey: .from)!
        let toViewController = transitionContext.viewController(forKey: .to)!
        let containerView = transitionContext.containerView
        
        var backgroundViewController = fromViewController
        var foregroundViewController = toViewController
        
        if operation == .pop {
            backgroundViewController = toViewController
            foregroundViewController = fromViewController
        }
        
        let maybeBackgroungImageView = (backgroundViewController as? ZoomViewController)?.zoomImageView(for: self)
        let maybeForegrounfController = (foregroundViewController as? ZoomViewController)?.zoomImageView(for: self)
        
        assert(maybeBackgroungImageView != nil, "Cannot find imageView in backgroundVC")
        assert(maybeForegrounfController != nil, "Cannot find imageView in foregroundVC")
        
        let backgroundImageView = maybeBackgroungImageView!
        let foregroundImageView = maybeForegrounfController!
        
        let imageViewSnapshot = UIImageView(image: backgroundImageView.image)
        imageViewSnapshot.contentMode = .scaleAspectFit
        imageViewSnapshot.layer.masksToBounds = true
        
        backgroundImageView.isHidden = true
        foregroundImageView.isHidden = true
        let foregroundViewBackgroundColor = foregroundViewController.view.backgroundColor
        foregroundViewController.view.backgroundColor = UIColor.clear
        containerView.backgroundColor = UIColor.white
        
        containerView.addSubview(backgroundViewController.view ?? UIImageView())
        containerView.addSubview(foregroundViewController.view ?? UIView())
        containerView.addSubview(imageViewSnapshot)
        
        var preTransitionState = TransitionState.initial
        var posTransitionState = TransitionState.final
        
        if operation == .pop {
            preTransitionState = TransitionState.final
            posTransitionState = TransitionState.initial
        }
        
        configureViews(for: preTransitionState, containerView: containerView, backgroundViewController: backgroundViewController, viewsInBackground: (backgroundImageView, backgroundImageView), viewsInForeground: (foregroundImageView, foregroundImageView), snapshotViews: (imageViewSnapshot, imageViewSnapshot))
        
        foregroundViewController.view.layoutIfNeeded()
        
        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.0, options: [], animations: {
            self.configureViews(for: posTransitionState, containerView: containerView, backgroundViewController: backgroundViewController, viewsInBackground: (backgroundImageView, backgroundImageView), viewsInForeground: (foregroundImageView, foregroundImageView), snapshotViews: (imageViewSnapshot, imageViewSnapshot))
        }) { (finished) in
            backgroundViewController.view.transform = CGAffineTransform.identity
            imageViewSnapshot.removeFromSuperview()
            backgroundImageView.isHidden = false
            foregroundImageView.isHidden = false
            foregroundViewController.view.backgroundColor = foregroundViewBackgroundColor
            
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}

extension ZoomAnimationDelegate: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if fromVC is ZoomViewController && toVC is ZoomViewController {
            self.operation = operation
            return self
        } else {
            return nil
        }
    }
}
