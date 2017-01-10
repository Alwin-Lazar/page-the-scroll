//
//  ViewController.swift
//  SwipeGestureRecognizer
//
//  Created by Alwin Lazar on 10/01/17.
//  Copyright © 2017 Xeoscript Technologies. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    var images = [UIImageView]()
    let MAX_PAGE = 2
    let MIN_PAGE = 0
    var currentPage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        var contentWidth: CGFloat = 0.0
        let scrollWidth = scrollView.frame.size.width
        
        // the below code for creation of Swipe Gusture Recognizer in programatically
        let right = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.detectSwipe(_:)))
        let left = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.detectSwipe(_:)))
        
        right.direction = .right
        left.direction = .left
        
        view.addGestureRecognizer(right)
        view.addGestureRecognizer(left)
        
        for x in 0...2{
            // get all images and append that to images array
            let image = UIImage(named: "icon\(x).png")
            let imageView = UIImageView(image: image)
            images.append(imageView)
            
            var newX: CGFloat = 0.0
            newX = scrollWidth / 2 + scrollWidth * CGFloat(x)
            
            contentWidth += newX
            
            scrollView.addSubview(imageView)
            
            imageView.frame = CGRect(x: newX - 75, y: (scrollView.frame.size.height / 2) - 75, width: 150, height: 150)
        }
        
        // to scale the other images in the screen not the orginal one
        self.images[self.currentPage].transform = CGAffineTransform.init(scaleX: 1.4, y: 1.4)
        
        // to show the images which are clipped out
        scrollView.clipsToBounds = false
        
        scrollView.contentSize = CGSize(width: contentWidth, height: view.frame.size.height)
    }
    
    // swipe function take place here
    @IBAction func detectSwipe (_ sender: UISwipeGestureRecognizer) {
        if (currentPage < MAX_PAGE && sender.direction == UISwipeGestureRecognizerDirection.left) {
            moveScrollView(direction: 1)
            
        }
        
        if (currentPage > MIN_PAGE && sender.direction == UISwipeGestureRecognizerDirection.right) {
            moveScrollView(direction: -1)
        }
    }
    
    func moveScrollView(direction: Int){
        currentPage = currentPage + direction
        let point: CGPoint = CGPoint(x: scrollView.frame.size.width * CGFloat(currentPage), y: 0.0)
        scrollView.setContentOffset(point, animated: true)
        
        // Create a animation to increase the actual icon on screen
        UIView.animate(withDuration: 0.4){
            self.images[self.currentPage].transform = CGAffineTransform.init(scaleX: 1.4, y: 1.4)
            
            // Revert icon size of the non-active pages
            for x in 0..<self.images.count {
                if (x != self.currentPage) {
                    self.images[x].transform = CGAffineTransform.identity
                }
            }
        }
    }
    
}






















