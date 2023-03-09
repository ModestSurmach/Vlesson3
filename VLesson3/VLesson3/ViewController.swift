//
//  ViewController.swift
//  VLesson3
//
//  Created by Modest Surmach on 07.03.2023.
//

import UIKit

class ViewController: UIViewController {
    
    var mainView = UIView()
    var myView = UIView()
    var animator = UIViewPropertyAnimator()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        createSlider()
        createView()

    }
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        view.addSubview(mainView)
        
        mainView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([mainView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
                                     mainView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
                                     mainView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
                                     mainView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)])
        animate()
    }
    

    
    @IBAction func didSlide(_ sender: UISlider) {
        animator.fractionComplete = CGFloat(sender.value) / 100
    }
    
    @IBAction func touchUpInsideSlider(_ sender: UISlider) {
        animator.pausesOnCompletion = true
        sender.setValue(100, animated: true)
        animator.startAnimation()
    }
    
    
    func animate() {
        
        let dx = mainView.frame.width - (myView.frame.width * 1.5)
        animator = UIViewPropertyAnimator(duration: 0.3, curve: .linear, animations:  {
            
            self.myView.transform = CGAffineTransform(rotationAngle: .pi / 2).scaledBy(x: 1.5, y: 1.5)
            self.myView.frame.origin.x = dx

    })
}
    
    func createView() {
        
        mainView.addSubview(myView)
        
        myView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([myView.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 0),
                                     myView.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 150),
                                     myView.heightAnchor.constraint(equalToConstant: 100),
                                     myView.widthAnchor.constraint(equalToConstant: 100)])
        myView.backgroundColor = .systemPink
        myView.layer.cornerRadius = 15
        
    }

    
    func createSlider() {
        
        let slider = UISlider()
        mainView.addSubview(slider)
        
        slider.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([slider.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
                                     slider.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 300),
                                     slider.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 0),
                                     slider.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: 0)])
        
        slider.minimumValue = 0
        slider.maximumValue = 100
        slider.center = view.center
        
        slider.addTarget(self, action: #selector(didSlide), for: .allEvents)
        slider.addTarget(self, action: #selector(touchUpInsideSlider), for: .touchUpInside)
    }

}

