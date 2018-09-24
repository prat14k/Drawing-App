//
//  Canvas.swift
//  DrawingApp
//
//  Created by Prateek Sharma on 8/29/18.
//  Copyright © 2018 Prateek Sharma. All rights reserved.
//

import UIKit

class CanvasView: UIView {
    
    private var lineColor: UIColor = .black
    private var lineWidth: CGFloat = 10.0
    private var opacity: CGFloat = 1.0
    
    @IBOutlet private var tempImageView: UIImageView!
    @IBOutlet private var mainImageView: UIImageView!
    static private let nibIdentifier = "CanvasView"
    
    private var lastPoint = CGPoint.zero
    private var swiped = false
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        swiped = false
        lastPoint = touches.first?.location(in: self) ?? .zero
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        swiped = true
        guard let touch = touches.first  else { return }
        let currentPoint = touch.location(in: self)
        drawLineFrom(fromPoint: lastPoint, toPoint: currentPoint)
        lastPoint = currentPoint
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        !swiped ? drawLineFrom(fromPoint: lastPoint, toPoint: lastPoint) : ()
        UIGraphicsBeginImageContext(mainImageView.frame.size)
        mainImageView.image?.draw(in: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height), blendMode: .normal, alpha: 1.0)
        tempImageView.image?.draw(in: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height), blendMode: .normal, alpha: opacity)
        mainImageView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        tempImageView.image = nil
    }

    private func drawLineFrom(fromPoint: CGPoint, toPoint: CGPoint) {
        UIGraphicsBeginImageContext(frame.size)
        let context = UIGraphicsGetCurrentContext()
        tempImageView.image?.draw(in: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        context?.move(to: CGPoint(x: fromPoint.x, y: fromPoint.y))
        context?.addLine(to: CGPoint(x: toPoint.x, y: toPoint.y))
        context?.setLineCap(CGLineCap.round)
        context?.setLineWidth(lineWidth)
        context?.setStrokeColor(lineColor.cgColor)
        context?.setBlendMode(.normal)
        context?.strokePath()
        tempImageView.image = UIGraphicsGetImageFromCurrentImageContext()
        tempImageView.alpha = opacity
        UIGraphicsEndImageContext()
    }
    
}

extension CanvasView {
    
    static func createNdAdd(in view: UIView) -> CanvasView {
        guard let canvasView = Bundle.main.loadNibNamed(CanvasView.nibIdentifier, owner: self, options: nil)?.first as? CanvasView
            else { fatalError("No such Result view found") }
        canvasView.frame = view.bounds
        canvasView.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        canvasView.backgroundColor = .clear
        view.addSubview(canvasView)
        return canvasView
    }
    
}
