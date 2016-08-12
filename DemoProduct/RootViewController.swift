//
//  RootViewController.swift
//  DemoProduct
//
//  Created by YANGSHENG ZOU on 2016-08-11.
//  Copyright © 2016 YANGSHENG ZOU. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    @IBOutlet weak var imageScrollView: UIScrollView!  //scrollview containing three imageviews
    @IBOutlet weak var scrollviewPageControl: UIPageControl! // pageControl showing current page

    @IBOutlet weak var pageButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        loadScrollView()
       
        // Do any additional setup after loading the view.
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func loadScrollView(){  // load the scrollview
        var contentWidth: CGFloat = 0; // content width of scrollview
        for i in 0...2 {   // load three images
            
            let imageView = UIImageView.init(frame: CGRect(x: contentWidth, y: 0, width: view.bounds.width, height: view.bounds.height));
            imageView.backgroundColor = UIColor.clearColor()
            imageView.contentMode = .ScaleAspectFit
            imageView.image = UIImage(named: String(format: "intro-screen-img-%d.png", i+1))
            contentWidth = contentWidth + imageView.bounds.width
            
            imageScrollView.addSubview(imageView)
           
        }
        
        
        imageScrollView.contentSize = CGSize(width: contentWidth, height: imageScrollView.bounds.height)
    }
    
    
    func scrollViewDidEndDecelerating(scrollview: UIScrollView){
        
        scrollviewPageControl.currentPage = Int(scrollview.contentOffset.x/view.bounds.width)
    }

    
    @IBAction func pageButtonTouched(sender: UIButton){ // when button is touched
        switch scrollviewPageControl.currentPage {
        case 2:   //
            let inputViewController = InputViewController(title: "let's quickly personalized your ", message: nil, preferredStyle: .Alert)
            
        default:  // go to next page
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
