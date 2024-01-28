//
//  LaunchViewController.swift
//  IntroToRx
//
//  Created by Mina Eid on 28/01/2024.
//

import UIKit
import Lottie

class LaunchViewController: UIViewController {
    @IBOutlet weak var lottieView: LottieAnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAnimation()
        scheduleNavigation()
    }
    
    private func setupAnimation() {
        
        lottieView.backgroundBehavior = .pauseAndRestore
        lottieView.contentMode = .scaleAspectFit
        lottieView.loopMode = .loop
        lottieView.animationSpeed = 2
        lottieView.play()
    }
    
    private func scheduleNavigation() {
           DispatchQueue.main.asyncAfter(deadline: .now() + 4) { [weak self] in
               self?.navigateToOtherViewController()
           }
       }

       private func navigateToOtherViewController() {
           
          
           
           let vc = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
           let navController = UINavigationController(rootViewController: vc)
           navController.modalPresentationStyle = .fullScreen
           present(navController, animated: true, completion: nil)
       }

}
