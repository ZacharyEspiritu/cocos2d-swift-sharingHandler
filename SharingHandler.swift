//
//  SharingHandler.swift
//  ReactionLine
//
//  Created by Zachary Espiritu on 7/19/15.
//  Copyright (c) 2015 Zachary Espiritu. All rights reserved.
//

import UIKit
import Social

class SharingHandler: UIViewController {
    
    // MARK: Constants
    
    let defaultURL: String = "INSERT_YOUR_ITUNES_URL_HERE"
    
    
    // MARK: Singleton
    
    class var sharedInstance : SharingHandler {
        struct Static {
            static let instance : SharingHandler = SharingHandler()
        }
        return Static.instance
    }
    
    
    // MARK: Sharing Functions
    
    /**
    Opens the native iOS share screen for posting to Twitter.
    
    The `defaultURL` set in at the top of `SharingHandler.swift` will be appended to the end of the post automatically.
    
    :param: stringToPost        the `String` to post with your screenshot. See the README.md for more info.
    :param: postWithScreenshot  `true` if you want a screenshot to be appended to the post; otherwise, `false`.
    */
    func postToTwitter(#stringToPost: String, postWithScreenshot: Bool) {
        
        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeTwitter) {
        
            var twitterViewController: SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
            twitterViewController.setInitialText(stringToPost + " \(defaultURL)")
            
            if postWithScreenshot {
                twitterViewController.addImage(takeScreenshot())
            }
            
            // The `completionHandler` block is called when the `twitterViewController` is closed. In this scenario, the `completionHandler` checks to see if a post was successfully made, or if the user exited out of the view without making a tweet.
            twitterViewController.completionHandler = {
                (result:SLComposeViewControllerResult) in
                if result == .Done {
                    println("Sharing Handler: User posted to Twitter")
                }
                else {
                    println("Sharing Handler: User did not post to Twitter")
                }
            }
            
            CCDirector.sharedDirector().presentViewController(twitterViewController, animated: true, completion: nil)
        }
    }
    
    /**
    Opens the native iOS share screen for posting to Facebook.
    
    The `defaultURL` set in at the top of `SharingHandler.swift` will be appended to the end of the post automatically.
    
    **Note:** A known caveat with the native iOS "share sheet" for Facebook is that you are no longer able to "pre-fill" the content of the box. If you want to be able to do this, you'll need to integrate the Facebook SDK, which is an entirely different ballgame of its own.
    
    Actually, even if you wanted to do that, Facebook recently changed their Platform Policy such that "pre-filling" the user message parameter with any content that the user didn't enter themselves (even if they are able to edit or delete that content before posting) is against their rules, so you technically aren't allowed to do that anyways.
    
    :param: postWithScreenshot  `true` if you want a screenshot to be appended to the post; otherwise, `false`.
    */
    func postToFacebook(#postWithScreenshot: Bool) {
        
        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeFacebook) {
            
            var facebookViewController: SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
            // THIS DOES NOT WORK (SEE ABOVE!): facebookViewController.setInitialText("Testing facebook integration!")
            facebookViewController.addURL(NSURL(string: defaultURL))
            
            if postWithScreenshot {
                facebookViewController.addImage(takeScreenshot())
            }
            
            // The `completionHandler` block is called when the `facebookViewController` is closed. In this scenario, the `completionHandler` checks to see if a post was successfully made, or if the user exited out of the view without making a tweet.
            facebookViewController.completionHandler = {
                (result:SLComposeViewControllerResult) in
                if result == .Done {
                    println("Sharing Handler: User posted to Facebook")
                }
                else {
                    println("Sharing Handler: User did not post to Facebook")
                }
            }
            
            CCDirector.sharedDirector().presentViewController(facebookViewController, animated: true, completion: nil)
        }
    }
    
    /**
    Used to take a screenshot of the current cocos2d scene.
    
    :returns:  a screenshot in the form of a `UIImage`
    */
    func takeScreenshot() -> UIImage {
        CCDirector.sharedDirector().nextDeltaTimeZero = true
        
        let width = Int32(CCDirector.sharedDirector().viewSize().width)
        let height = Int32(CCDirector.sharedDirector().viewSize().height)
        let renderTexture: CCRenderTexture = CCRenderTexture(width: width, height: height)
        
        renderTexture.begin()
        CCDirector.sharedDirector().runningScene.visit()
        renderTexture.end()
        
        return renderTexture.getUIImage()
    }
}