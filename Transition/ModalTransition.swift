//
//  ModalTransition.swift
//  SampleTwitterTransition
//
//  Created by nagisa-kosuge on 2015/06/22.
//  Copyright (c) 2015年 RyoKosuge. All rights reserved.
//

import UIKit

class ModalTransition: NSObject {
}

extension ModalTransition: UIViewControllerTransitioningDelegate {
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
}

extension ModalTransition: UIViewControllerAnimatedTransitioning {
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let destination: UIViewController! = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
        if destination.isBeingPresented() {
            animatePresentedTransition(transitionContext: transitionContext)
        } else {
            animateDismissedTransition(transitionContext: transitionContext)
        }
    }
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        return 0.5
    }
}

// MARK : transition

extension ModalTransition {
    
    private func animatePresentedTransition(#transitionContext: UIViewControllerContextTransitioning) {
        let duration = transitionDuration(transitionContext)
        let fromViewController: UIViewController! = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
        let toViewController: UIViewController! = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
        let containerView = transitionContext.containerView()
        
        fromViewController.view.frame = containerView.bounds
        toViewController.view.frame = containerView.bounds
        
        containerView.insertSubview(toViewController.view, belowSubview: fromViewController.view)
        
        toViewController.view.frame = presentingControllerFrame(transitionContext: transitionContext)
        toViewController.beginAppearanceTransition(true, animated: true)
        
        UIView.animateKeyframesWithDuration(duration, delay: 0.0, options: .CalculationModeCubic, animations: {
            UIView.addKeyframeWithRelativeStartTime(0.0, relativeDuration: 1.0, animations: {
                toViewController.view.frame = containerView.bounds
            })
            UIView.addKeyframeWithRelativeStartTime(0.0, relativeDuration: 1.0, animations: {
                var perspectiveTransform = fromViewController.view.layer.transform
                perspectiveTransform.m34 = 1.0 / -1000.0
                perspectiveTransform = CATransform3DTranslate(perspectiveTransform, 0, 0, -100)
                fromViewController.view.layer.transform = perspectiveTransform
            })
        }) { finished in
            fromViewController.view.layer.transform = CATransform3DIdentity
            toViewController.endAppearanceTransition()
            transitionContext.completeTransition(true)
        }
        
    }
    
    private func animateDismissedTransition(#transitionContext: UIViewControllerContextTransitioning) {
        let duration = transitionDuration(transitionContext)
        let fromViewController: UIViewController! = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
        let toViewController: UIViewController! = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
        let containerView = transitionContext.containerView()
        
        fromViewController.view.frame = containerView.bounds
        toViewController.view.frame = containerView.bounds
        
        containerView.superview?.sendSubviewToBack(containerView)
        containerView.addSubview(toViewController.view)
        
        let originalTransform = toViewController.view.layer.transform
        var perspectiveTransform = originalTransform
        perspectiveTransform.m34 = 1.0 / -1000.0
        perspectiveTransform = CATransform3DTranslate(perspectiveTransform, 0, 0, -100)
        toViewController.view.layer.transform = perspectiveTransform
        
        fromViewController.beginAppearanceTransition(false, animated: true)
        let frame = presentingControllerFrame(transitionContext: transitionContext)
        
        UIView.animateKeyframesWithDuration(duration, delay: 0.0, options: .CalculationModeCubic, animations: {
            UIView.addKeyframeWithRelativeStartTime(0.0, relativeDuration: 1.0, animations: {
                fromViewController.view.frame = frame
            })
            UIView.addKeyframeWithRelativeStartTime(0.2, relativeDuration: 0.8, animations: {
                toViewController.view.layer.transform = originalTransform
            })
        }) { finished in
            fromViewController.endAppearanceTransition()
            toViewController.view.layer.transform = originalTransform
            toViewController.view.transform = CGAffineTransformIdentity
            transitionContext.completeTransition(true)
        }
        
    }
    
    private func presentingControllerFrame(#transitionContext: UIViewControllerContextTransitioning) -> CGRect {
        let bounds = transitionContext.containerView().bounds
        if floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_7_1 {
            return CGRect(origin: CGPoint(x: 0, y: bounds.height), size: bounds.size)
        }
        let orientation = UIApplication.sharedApplication().statusBarOrientation
        switch orientation {
        case .LandscapeLeft:
            return CGRect(origin: CGPoint(x: bounds.width, y: 0), size: bounds.size)
        case .LandscapeRight:
            return CGRect(origin: CGPoint(x: -bounds.width, y: 0), size: bounds.size)
        case .Portrait:
            return CGRect(origin: CGPoint(x: 0, y: bounds.height), size: bounds.size)
        case .PortraitUpsideDown:
            return CGRect(origin: CGPoint(x: 0, y: -bounds.height), size: bounds.size)
        case .Unknown:
            return CGRectZero
        }
    }
}