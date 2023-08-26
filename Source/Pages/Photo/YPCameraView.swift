//
//  YPCameraView.swift
//  YPImgePicker
//
//  Created by Sacha Durand Saint Omer on 2015/11/14.
//  Copyright © 2015 Yummypets. All rights reserved.
//

import UIKit
import Stevia

internal class YPCameraView: UIView, UIGestureRecognizerDelegate {
    let focusView = UIView(frame: CGRect(x: 0, y: 0, width: 90, height: 90))
    let previewViewContainer = UIView()
//    let buttonsContainer = UIView()
    let flipButton = UIButton()
    let shotButton = UIButton()
    let flashButton = UIButton()
    let timeElapsedLabel = UILabel()
    let progressBar = UIProgressView()
    
    let recentMedia = UIButton()
    
    let bottomPadding = 60
    
    convenience init(overlayView: UIView? = nil) {
        self.init(frame: .zero)
        
        if let overlayView = overlayView {
            // View Hierarchy
            subviews(
                previewViewContainer,
                overlayView,
                progressBar,
                timeElapsedLabel,
                flashButton,
                flipButton,
                shotButton
            )
        } else {
            // View Hierarchy
            subviews(
                previewViewContainer,
                progressBar,
                timeElapsedLabel,
                flashButton,
                recentMedia,
                shotButton,
                flipButton

            )
        }
        
        // Layout
        let isIphone4 = UIScreen.main.bounds.height == 480
        let sideMargin: CGFloat = isIphone4 ? 20 : 0
        previewViewContainer.height(UIScreen.main.bounds.height)
        shotButton.Bottom == previewViewContainer.Bottom - bottomPadding
        flashButton.Bottom == previewViewContainer.Bottom - bottomPadding
        flipButton.Bottom == previewViewContainer.Bottom - bottomPadding
        recentMedia.Bottom == previewViewContainer.Bottom - bottomPadding
        
        if YPConfig.onlySquareImagesFromCamera {
            layout(
                0,
                |-sideMargin-previewViewContainer-sideMargin-|,
                -2,
                |progressBar|,
                0
            )
            
//            previewViewContainer.heightEqualsWidth()
            
        } else {
            layout(
                0,
                |-sideMargin-previewViewContainer-sideMargin-|,
                -2,
                |progressBar|,
                0
            )
            previewViewContainer.height(UIScreen.main.bounds.width)
//            previewViewContainer.fillContainer()
            
        }
        
        overlayView?.followEdges(previewViewContainer)
        
        |-(15+sideMargin)-flashButton.size(42)
        flashButton.Bottom == previewViewContainer.Bottom - 15
        
        flipButton.size(42)-(15+sideMargin)-|
        flipButton.Bottom == previewViewContainer.Bottom - 15
        
        |-(15+sideMargin)-recentMedia.size(42)
        recentMedia.Bottom == previewViewContainer.Bottom - 15
        
        timeElapsedLabel-(15+sideMargin)-|
        timeElapsedLabel.Top == safeAreaLayoutGuide.Top
        
        //shotButton.centerVertically()
        shotButton.size(84).centerHorizontally()
        
        // Style
        backgroundColor = YPConfig.colors.photoVideoScreenBackgroundColor
        previewViewContainer.backgroundColor = UIColor.ypLabel
        timeElapsedLabel.style { l in
            l.textColor = .white
            l.text = "00:00"
            l.isHidden = true
            l.font = YPConfig.fonts.cameraTimeElapsedFont
        }
        progressBar.style { p in
            p.trackTintColor = .clear
            p.tintColor = .ypSystemRed
        }
        flashButton.setImage(YPConfig.icons.flashOffIcon, for: .normal)
        flipButton.setImage(YPConfig.icons.loopIcon, for: .normal)
        recentMedia.backgroundColor = .systemRed
        shotButton.setImage(YPConfig.icons.capturePhotoImage, for: .normal)
    }
    
    public func configureRecentMediaImage(_ image: UIImage?) {
        guard let image = image else { return }
        recentMedia.setImage(image, for: .normal)
    }
}
