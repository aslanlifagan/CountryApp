//
//  UIView+Customs.swift
//  CountryApp
//
//  Created by Fagan Aslanli on 19.12.22.
//
import UIKit

extension UIEdgeInsets {
    init(all value: CGFloat) {
        self = .init(top: value, left: value, bottom: -value, right: -value)
    }
    
    init(top: CGFloat = 0, leading: CGFloat = 0, bottom: CGFloat = 0, trailing: CGFloat = 0) {
        self = .init(top: top, left: leading, bottom: bottom, right: trailing)
    }
    
    init(y: CGFloat = 0, x: CGFloat = 0) {
        self = .init(top: y, left: x, bottom: -y, right: -x)
    }
    
    init(top: CGFloat = 0, x: CGFloat, bottom: CGFloat = 0) {
        self = .init(top: top, left: x, bottom: bottom, right: -x)
    }
}

extension UIView {
    
    open func anchor(top: NSLayoutYAxisAnchor? = nil,
                     leading: NSLayoutXAxisAnchor? = nil,
                     bottom: NSLayoutYAxisAnchor? = nil,
                     trailing: NSLayoutXAxisAnchor? = nil,
                     padding: UIEdgeInsets = .zero,
                     size: CGSize = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }
        
        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: padding.bottom).isActive = true
        }
        
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: padding.right).isActive = true
        }
        
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
    
    open func anchorSuperview(top: Bool = false,
                              leading: Bool = false,
                              bottom: Bool = false,
                              trailing: Bool = false,
                              padding: UIEdgeInsets = .zero,
                              size: CGSize = .zero) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if top {
            topAnchor.constraint(equalTo: superview!.topAnchor, constant: padding.top).isActive = true
        }
        
        if leading {
            leadingAnchor.constraint(equalTo: superview!.leadingAnchor, constant: padding.left).isActive = true
        }
        
        if bottom {
            bottomAnchor.constraint(equalTo: superview!.bottomAnchor, constant: padding.bottom).isActive = true
        }
        
        if trailing {
            trailingAnchor.constraint(equalTo: superview!.trailingAnchor, constant: padding.right).isActive = true
        }
        
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
    
    open func fillSuperview(padding: UIEdgeInsets = .zero) {
        anchor(top: superview?.topAnchor,
               leading: superview?.leadingAnchor,
               bottom: superview?.bottomAnchor,
               trailing: superview?.trailingAnchor,
               padding: padding)
    }
    
    open func fillSuperviewSafeAreaLayoutGuide(padding: UIEdgeInsets = .zero) {
        if #available(iOS 11.0, *) {
            anchor(top: superview?.safeAreaLayoutGuide.topAnchor,
                   leading: superview?.safeAreaLayoutGuide.leadingAnchor,
                   bottom: superview?.safeAreaLayoutGuide.bottomAnchor,
                   trailing: superview?.safeAreaLayoutGuide.trailingAnchor,
                   padding: padding)
        }
    }
    
    open func anchorSize(_ size: CGSize) {
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
    
    open func anchorSize(to view: UIView) {
        widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    }
    
    open func anchorWidth(to view: UIView) {
        widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    }
    
    open func anchorHeight(to view: UIView) {
        heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    }
    
    open func centerInSuperview(size: CGSize = .zero, xConstant: CGFloat = 0, yConstant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        if let superviewCenterXAnchor = superview?.centerXAnchor {
            centerXAnchor.constraint(equalTo: superviewCenterXAnchor, constant: xConstant).isActive = true
        }
        
        if let superviewCenterYAnchor = superview?.centerYAnchor {
            centerYAnchor.constraint(equalTo: superviewCenterYAnchor, constant: yConstant).isActive = true
        }
        
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
    
    open func centerToView(to view: UIView, size: CGSize = .zero, xConstant: CGFloat = 0, yConstant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        
        centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: xConstant).isActive = true
        centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: yConstant).isActive = true
        
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
    
    open func centerXToSuperview(constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        if let superviewCenterXAnchor = superview?.centerXAnchor {
            centerXAnchor.constraint(equalTo: superviewCenterXAnchor, constant: constant).isActive = true
        }
    }
    
    open func centerYToSuperview(constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        if let superviewCenterYAnchor = superview?.centerYAnchor {
            centerYAnchor.constraint(equalTo: superviewCenterYAnchor, constant: constant).isActive = true
        }
    }
    
    
    open func setupShadow(opacity: Float = 0, radius: CGFloat = 0, offset: CGSize = .zero, color: UIColor = .black) {
        layer.shadowOpacity = opacity
        layer.shadowRadius = radius
        layer.shadowOffset = offset
        layer.shadowColor = color.cgColor
    }
    
    open func setupBorder(width: CGFloat = 1, color: UIColor = .black) {
        layer.borderWidth = width
        layer.borderColor = color.cgColor
    }
    
    open func setGradientBackground(colorTop: UIColor, colorBottom: UIColor) {
        layoutIfNeeded()
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorBottom.cgColor, colorTop.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.locations = [0, 1]
        gradientLayer.frame = bounds
        //print("log: ", bounds, frame)
        
        layer.insertSublayer(gradientLayer, at: 0)
    }
}
