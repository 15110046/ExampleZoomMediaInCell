
//  Created by NguyenHieu on 11/03/2020.
//  Copyright © 2020 Azibai. All rights reserved.
//

import UIKit

public class HImageView: UIImageView {
    
    //MARK: Delegate + Config
    weak var delegate: HImageViewDelegate?
    var config: HImageViewConfigure = HImageViewConfigure()
    
    //MARK: Varible
    var isZooming = false
    var originalImageCenter: CGPoint?
    var frameImageOriginal: CGRect = .zero
    var alphaComponent: ((CGFloat)->())?
        
    //MARK: UI
    var viewContainer: UIView? = nil
    var imageView: UIImageView? = UIImageView(frame: .zero)
    
    public func config(_ model: HImageViewConfigure) {
        self.config = model
    }
    
    //MARK: Set up
    private func initPanGesture() {
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(pinchGestureHandle(_:)))
        pinch.delegate = self
        self.addGestureRecognizer(pinch)
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(panGestureHandle(_:)))
        pan.delegate = self
        self.addGestureRecognizer(pan)
        
        self.isUserInteractionEnabled = true
        self.isMultipleTouchEnabled = true
    }
    
    private func listenHandleChangeAlpha() {
        alphaComponent = { [weak self] (newValue) in
            self?.viewContainer?.backgroundColor = self?.config.backgroundColor.withAlphaComponent(newValue)
        }
    }
    
    fileprivate func setUpViews() {
        
    }
    
    //MARK: Init
    public override func awakeFromNib() {
        super.awakeFromNib()
        initPanGesture()
        listenHandleChangeAlpha()
    }
    
    func prepareForReuse() {
        viewContainer?.removeFromSuperview()
        imageView = nil
        isZooming = false
        originalImageCenter = nil
        frameImageOriginal = .zero
    }
    
    //MARK: Action
    @objc private func panGestureHandle(_ sender: UIPanGestureRecognizer) {
        if isZooming, sender.state == .began {
            originalImageCenter = imageView!.center
        }
        else
            if isZooming, sender.state == .changed {
            let translation = sender.translation(in: self)
            if let view = imageView {
                view.center = CGPoint(x:view.center.x + translation.x,
                                      y:view.center.y + translation.y)
            }
            sender.setTranslation(CGPoint.zero, in: self)
        }
    }
    
    @objc private func pinchGestureHandle(_ sender: UIPinchGestureRecognizer) {
        switch sender.state {
        case .began:    setupUIWhenStartPinch(scale: sender.scale)
        case .changed:  reloadUIWhenPinchChanged(sender: sender)
        case .ended, .failed, .cancelled: stopZoom()
        default: break
        }
        acceptNewValueAlpha()
    }
    
    func dismiss() {
        UIView.animate(withDuration: config.durationDismissZoom, animations: {
            self.imageView?.center = self.originalImageCenter ?? CGPoint()
            self.imageView!.transform = CGAffineTransform.identity
            self.alphaComponent?(1)
        }) { (finished) in
            self.isZooming = false
            self.image = self.imageView?.image
            self.backgroundColor = .clear
            self.viewContainer?.removeFromSuperview()
            self.imageView?.removeFromSuperview()
            self.viewContainer = nil
            self.imageView = nil
            NotificationCenter.default.post(name: NSNotification.Name.CellStopZoom, object: nil)
        }
    }
    
    deinit {
        
    }
}
