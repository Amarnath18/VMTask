//
//  ViewExtension.swift
//  Task
//
//  Created by Amarnath B on 27/10/22.
//

import Foundation
import UIKit

extension UIView {
    
    func startLoading() {
        
        let loadingView = UIView(frame: CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height))
        loadingView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        
        let activityIndicatorView: UIActivityIndicatorView
        if #available(iOS 13.0, *) {
            activityIndicatorView = UIActivityIndicatorView(style: .large)
        } else {
            // Fallback on earlier versions
            activityIndicatorView = UIActivityIndicatorView(style: .whiteLarge)
        }
        activityIndicatorView.color = UIColor.red
        activityIndicatorView.startAnimating()
        
        loadingView.addSubview(activityIndicatorView)
        activityIndicatorView.center = loadingView.center
        
        loadingView.tag = 999
        loadingView.accessibilityIdentifier = "loading_view"
        
        insertSubview(loadingView, at: 999)
        
    }
    
    func stopLoading() {
        subviews.forEach {
            if $0.tag == 999 && $0.accessibilityIdentifier == "loading_view" {
                $0.removeFromSuperview()
            }
        }
    }
    
    func dropShadow(scale: Bool = true) {
      layer.masksToBounds = false
        layer.shadowColor = UIColor.black.withAlphaComponent(0.5).cgColor
      layer.shadowOpacity = 0.5
      layer.shadowOffset = CGSize(width: -1, height: 1)
      layer.shadowRadius = 50

      layer.shadowPath = UIBezierPath(rect: bounds).cgPath
      layer.shouldRasterize = true
      layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}

extension UIViewController {
    
    func startLoading() {
        view.startLoading()
    }
    
    func stopLoading() {
        view.stopLoading()
    }
}
