//
//  CardAttribute.swift
//  Assignment3
//
//  Created by Zane Liao on 2025/7/8.
//

import SwiftUI

// Draw Triangle
struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let top = CGPoint(x: rect.midX, y: rect.midY)
        let bottomLeft = CGPoint(x: rect.minX, y: rect.maxY)
        let bottomRight = CGPoint(x: rect.minX, y: rect.maxY)
        
        path.move(to: top)
        path.addLine(to: bottomLeft)
        path.addLine(to: bottomRight)
        path.closeSubpath()
        
        return path
    }
}

// Draw Ellipse
struct CustomEllipse: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addEllipse(in: rect)
        return path
    }
}

// Draw Diamond
struct Diamond: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let top = CGPoint(x: rect.midX, y: rect.minY)
        let right = CGPoint(x: rect.maxX, y: rect.midY)
        let bottom = CGPoint(x: rect.midX, y: rect.maxY)
        let left = CGPoint(x: rect.minX, y: rect.midY)

        path.move(to: top)
        path.addLine(to: right)
        path.addLine(to: bottom)
        path.addLine(to: left)
        path.closeSubpath()

        return path
    }
}

// CardShape
struct CardShape {
    let triangle: Triangle
    let customellipse: CustomEllipse
    let diamond: Diamond
}

// Card

enum CardAttribute {
    case color(Color)
    case numberOfAttribute(Int)
    case simple(CardShape)
}
