//
//  MenuViewController.swift
//  imenu_ios
//
//  Created by Miguel Jaimes on 22/01/2020.
//  Copyright © 2020 Miguel Jaimes. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController{
        enum CardState {
        case collapsed
        case expanded
    }
    
    @IBOutlet weak var restaurantBodyView: UIView!
    
    @IBOutlet weak var pictureRestaurant: UIImageView!
    
    @IBOutlet weak var nameDetailRestaurant: UILabel!
    
    @IBOutlet weak var nameTypeRestaurant: UILabel!
    
    var restaurant:RestaurantElement? = nil
    let imageDownloader = ImageDownloader()
    
    var nextState:CardState {
        return cardVisible ? .collapsed : .expanded
    }
    
    var menuCardViewController:MenuCardViewController!
    
   
    
    var endCardHeight:CGFloat = 0
    var startCardHeight:CGFloat = 0
    var cardVisible = false
    var runningAnimations = [UIViewPropertyAnimator]()
    var animationProgressWhenInterrupted:CGFloat = 0
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCard()
self.menuCardViewController.arrowImageView.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
        setUpDetailRestaurant()
         restaurantBodyView.layer.cornerRadius = 15
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func setUpDetailRestaurant(){
        guard let urlImage = restaurant?.imageURL else {return}
        nameDetailRestaurant.text = restaurant?.name
        nameTypeRestaurant.text = restaurant?.type
        imageDownloader.downloader(URLString: urlImage, completion: { (image:UIImage?) in
            self.pictureRestaurant.image = image
        })
    }
    
    


   func setupCard() {
    
    endCardHeight = self.view.frame.height * 0.89
    startCardHeight = self.view.frame.height * 0.2
   
        

        menuCardViewController = MenuCardViewController(nibName:"MenuCardViewController", bundle:nil)
        self.view.addSubview(menuCardViewController.view)
        menuCardViewController.view.frame = CGRect(x: 0, y: self.view.frame.height - startCardHeight, width: self.view.bounds.width, height: endCardHeight)
        menuCardViewController.view.clipsToBounds = true
        
    let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleCardTap(recognzier:)))
    let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handleCardPan(recognizer:)))
    
    menuCardViewController.handleArea.addGestureRecognizer(tapGestureRecognizer)
    menuCardViewController.handleArea.addGestureRecognizer(panGestureRecognizer)
    }
    
    @objc
    func handleCardTap(recognzier:UITapGestureRecognizer) {
        switch recognzier.state {
            // Animate card when tap finishes
        case .ended:
            animateTransitionIfNeeded(state: nextState, duration: 0.9)
        default:
            break
        }
    }
    
    @objc
    func handleCardPan (recognizer:UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            startInteractiveTransition(state: nextState, duration: 0.9)
            
        case .changed:
            let translation = recognizer.translation(in: self.menuCardViewController.handleArea)
            var fractionComplete = translation.y / endCardHeight
            fractionComplete = cardVisible ? fractionComplete : -fractionComplete
            updateInteractiveTransition(fractionCompleted: fractionComplete)
        case .ended:
            continueInteractiveTransition()
        default:
            break
        }
    }
    
     func animateTransitionIfNeeded (state:CardState, duration:TimeInterval) {
         if runningAnimations.isEmpty {
            let frameAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
                 switch state {
                 case .expanded:
                     self.menuCardViewController.view.frame.origin.y = self.view.frame.height - self.endCardHeight
                    
                    // self.menuCardViewController.arrowImageView.isHidden = true
                    
                    
                     self.menuCardViewController.arrowImageView.transform = CGAffineTransform(rotationAngle: CGFloat(.pi - 3.14159))
    
                 case .collapsed:
                     self.menuCardViewController.view.frame.origin.y = self.view.frame.height - self.startCardHeight
                     
                    
                     self.menuCardViewController.arrowImageView.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
                 }
             }
             
             frameAnimator.addCompletion { _ in
                 self.cardVisible = !self.cardVisible
                 self.runningAnimations.removeAll()
             }
             
             frameAnimator.startAnimation()
             
             runningAnimations.append(frameAnimator)
             
             let cornerRadiusAnimator = UIViewPropertyAnimator(duration: duration, curve: .linear) {
                 switch state {
                 case .expanded:
                     self.menuCardViewController.view.layer.cornerRadius = 30
                     
                 case .collapsed:
                    self.menuCardViewController.view.layer.cornerRadius = 30
                 }
             }
             
             cornerRadiusAnimator.startAnimation()
             
             runningAnimations.append(cornerRadiusAnimator)
             
         }
     }
     
     func startInteractiveTransition(state:CardState, duration:TimeInterval) {
         
         if runningAnimations.isEmpty {
             animateTransitionIfNeeded(state: state, duration: duration)
         }
         
         for animator in runningAnimations {
             animator.pauseAnimation()
             animationProgressWhenInterrupted = animator.fractionComplete
         }
     }
     
     func updateInteractiveTransition(fractionCompleted:CGFloat) {
         for animator in runningAnimations {
             animator.fractionComplete = fractionCompleted + animationProgressWhenInterrupted
         }
     }
     
     func continueInteractiveTransition (){
         for animator in runningAnimations {
             animator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
         }
     }
    
}

