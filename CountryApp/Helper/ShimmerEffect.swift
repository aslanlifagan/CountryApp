//
//  ShimmerEffect.swift
//  CountryApp
//
//  Created by Fagan Aslanli on 03.08.23.
//

import Foundation
import UIKit

protocol ShimmerEffect {
    var animationDuration: TimeInterval { set get }
    var animationDelay: TimeInterval {set get }

    var gradientTint: UIColor { set get }
    var gradientHighlight: UIColor { set get }

    var gradientHighlightRatio: Double { set get }
    var gradientLayer: CAGradientLayer { get }
}

extension ShimmerEffect {

    func addShimmerAnimation() {

        let startLocations = [NSNumber(value: -gradientHighlightRatio), NSNumber(value: -gradientHighlightRatio/2), 0.0]
        let endLocations = [1, NSNumber(value: 1+(gradientHighlightRatio/2)), NSNumber(value: 1+gradientHighlightRatio)]
        let gradientColors = [gradientTint.cgColor, gradientHighlight.cgColor, gradientTint.cgColor]
        gradientLayer.startPoint = CGPoint(x: -gradientHighlightRatio, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1+gradientHighlightRatio, y: 0.5)
        gradientLayer.locations = startLocations
        gradientLayer.colors = gradientColors

        let animationKeyPath = "locations"

        let shimmerAnimation = CABasicAnimation(keyPath: animationKeyPath)
        shimmerAnimation.fromValue = startLocations
        shimmerAnimation.toValue = endLocations
        shimmerAnimation.duration = animationDuration
        shimmerAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)

        let animationGroup = CAAnimationGroup()
        animationGroup.duration = animationDuration + animationDelay
        animationGroup.repeatCount = .infinity
        animationGroup.animations = [shimmerAnimation]
        gradientLayer.removeAnimation(forKey: animationKeyPath)
        gradientLayer.add(animationGroup, forKey: animationKeyPath)
    }
}
