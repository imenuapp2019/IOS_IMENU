//
//  ButtonsDemoPresenter.swift
//  RHSideButtons
//
//  Created by Robert Herdzik on 17/07/16.
//  Copyright © 2016 Robert Herdzik. All rights reserved.
//

import Foundation

class ButtonsPresenter: NSObject {
    
    weak var mainViewController: HomeViewController?
    
    init(mainViewController: HomeViewController) {
        self.mainViewController = mainViewController
        
        super.init()
    }
    
    func start() {
        perform(#selector(delayShow), with: nil, afterDelay: 1)
        perform(#selector(delayHide), with: nil, afterDelay: 2)
    }
    
    @objc func delayShow() {
        mainViewController?.castView().sideButtonsView?.showButtons()
    }
    
    @objc func delayHide() {
        mainViewController?.castView().sideButtonsView?.hideButtons()
    }
}
