//
//  RootViewController.swift
//  DemoProduct
//
//  Created by YANGSHENG ZOU on 2016-08-11.
//  Copyright © 2016 YANGSHENG ZOU. All rights reserved.
//

import UIKit
import TAPageControl

class RootViewController: UIViewController ,inputProcessDelegate {
    
    @IBOutlet weak var imageScrollView: UIScrollView!  //scrollview containing three imageviews
    @IBOutlet weak var scrollviewPageControl: TAPageControl! //page control for scrollView
    @IBOutlet weak var pageButton: UIButton! // change the page or present view controller
    
    let numberOfImages = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadScrollView()
        loadPageView()
       
        // Do any additional setup after loading the view.
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func processInputAfterClose(){
        // what to do after close the present view controller
    }
    
    
    func loadPageView() {
        // set the number of dots of page control
        
        scrollviewPageControl.numberOfPages = numberOfImages
        scrollviewPageControl.addObserver(self, forKeyPath: "currentPage", options: .New, context: nil) // add observer for page.currentPage
    }
    
    func loadScrollView(){
        
        // load the scrollview
        var contentWidth: CGFloat = 0; // content width of scrollview
        
        for i in 1...numberOfImages {   // load images
            
            let imageView = UIImageView.init(frame: CGRect(x: contentWidth, y: 0, width: view.bounds.width, height: view.bounds.height));
            imageView.backgroundColor = UIColor.clearColor()
            imageView.contentMode = .ScaleAspectFit
            imageView.image = UIImage(named: String(format: "intro-screen-img-%d.png", i))
            contentWidth = contentWidth + imageView.bounds.width
            
            imageScrollView.addSubview(imageView)
           
        }
        
        
        imageScrollView.contentSize = CGSize(width: contentWidth, height: imageScrollView.bounds.height)
    }
    
    
    func scrollViewDidEndDecelerating(scrollview: UIScrollView){
        
        scrollviewPageControl.currentPage = Int(scrollview.contentOffset.x/view.bounds.width)
        
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        // Implement reaction of kvo, change the buttion title
        
        if keyPath == "currentPage" {
            if scrollviewPageControl.currentPage == numberOfImages - 1 {
                pageButton.setTitle("DONE", forState: .Normal)
            }
            else {
                pageButton.setTitle(">", forState: .Normal)
            }
        }
    }
    
    deinit {
        scrollviewPageControl.removeObserver(self, forKeyPath: "currentPage", context: nil)
    }

    
    @IBAction func pageButtonTouched(sender: UIButton){
        // when button is touched
        switch scrollviewPageControl.currentPage {
        case numberOfImages - 1:   //present the controller containing the input view
            let inputViewController = InputViewController(nibName: "InputViewController", bundle: nil)
            inputViewController.delegate = self
            presentViewController(inputViewController, animated: false, completion: nil)
            
            
        default:  // go to next page
            scrollviewPageControl.currentPage += 1
            imageScrollView.setContentOffset(CGPoint(x:imageScrollView.contentOffset.x + view.bounds.width, y: 0) , animated: true)
            
        }
       
        
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
