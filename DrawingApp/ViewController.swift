//
//  ViewController.swift
//  DrawingApp
//
//  Created by Prateek Sharma on 8/29/18.
//  Copyright © 2018 Prateek Sharma. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let canvas = CanvasView.createNdAdd(in: view)
        canvas.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(canvas)
        
        view.addConstraint(NSLayoutConstraint(item: canvas, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 100))
        view.addConstraint(NSLayoutConstraint(item: canvas, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: -100))
        view.addConstraint(NSLayoutConstraint(item: canvas, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 50))
        view.addConstraint(NSLayoutConstraint(item: canvas, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: -50))
    }
    
}

