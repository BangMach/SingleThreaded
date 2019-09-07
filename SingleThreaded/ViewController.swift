//
//  ViewController.swift
//  SingleThreaded
//
//  Created by Rodney Cocker on 07/09/19.
//  Copyright © 2019 RMIT. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {

    var value = 1
    @IBOutlet weak var countdown: UITextView!
    
    var stringCounter = ""
    @IBOutlet weak var firstButton: UIButton!
    
    @IBOutlet weak var secondButton: UIButton!
    
    @IBOutlet weak var thirdButton: UIButton!
    
    
    // Notice the UI does not get updated until
    // this function has finished executing because
    // the UI runs on a seperate thread and is waiting
    // for this thread to complete so it can send back
    // the results.
    
    // Also notice that once this begins the UI is locked
    // the button remains depressed and the user cannot 
    // interact with the UI.

    // First button (Locks the UI)
    @IBAction func mainThread(_ sender: Any) {
    
        countdown.text = ""
        countdown.text = "Counter begins\n\n"
        for i in 0...500
        {
            self.countdown.text = self.countdown.text + " " + String(i) + "\n"
        }
        if let text = firstButton.titleLabel?.text {
            self.firstButton.setTitle("\(text) - Updated", for: .normal)
        }
    }
    
    /* Dispatching work to a queue  either synchronously
     * or asynchronously will affect how the code runs
     * if sync it must finish before the next line of 
     * code is executed.  If async it will start running
     * the code and then move onto the next statement 
     * immediately.*/
    
    // Second Button 
    //(Locks the UI because it is dispatched
    // synchronously)
    // NEVER EVER DO THIS
    @IBAction func mainSync(_ sender: Any) {
    
       clearText()
        // Serial Queue by default.
         let queue1 = DispatchQueue(label: "Serial Queue 1")
        
        //let queue1 = DispatchQueue(label: "Serial Queue 1", attributes: .concurrent)
        
        // Execute code block and continue executing this method.
        queue1.sync {
            // This is on a serial queue so it will completed
            // before the 151 range code is executed below.
            for i in 0...150
            {
                print("Async on Serial Queue 1 - \(i)")
            }
            
            self.count(onThread: "SyncThread", start: 0, upto: 150)
        }
        
        queue1.sync {
            for j in 151...300
            {
                print("Async on Serial Queue 1 - \(j)")
            }
            
            self.count(onThread: "SyncThread", start: 151, upto: 300)
        }
        if let text = secondButton.titleLabel?.text {
             self.secondButton.setTitle("\(text) - Updated", for: .normal)
        }
    }
    
    // Creates a seperate thread, but processes
    // asynchronously
    
    // Third Button (Doesn't Lock the UI)
    @IBAction func mainAsync(_ sender: Any) {
        
        // preferred method of using queues, but these are 
        // concurrent.
//        DispatchQueue.global(qos: .userInitiated).async {
//            self.countdown.text = self.stringCounter
//        }
        
        clearText()
        // Serial Queue by default.
        let queue2 = DispatchQueue(label: "Serial Queue 2")
        
        // Serial Queue by default.
        // let queue2 = DispatchQueue(label: "Serial Queue 2", attributes: .concurrent)
        
        // Execute code block and continue executing this method.
        queue2.async {
            // This is on a serial queue so it will completed
            // before the 151 range code is executed below.
            for i in 0...150
            {
                print("Async on Serial Queue 2 - \(i)")
            }
            
            self.count(onThread: "SyncThread", start: 0, upto: 150)
        }
        
        queue2.async {
            for i in 151...300
            {
                print("Async on Serial Queue 2 - \(i)")
            }
            
            self.count(onThread: "SyncThread", start: 151, upto: 300)
        }
        if let text = thirdButton.titleLabel?.text {
            self.thirdButton.setTitle("\(text) - Updated", for: .normal)
        }
    }
    
    // Fourth Button
    @IBAction func priority(_ sender: Any) {
        
        clearText()

        // Close to Equal Priority
        let unequal1 = DispatchQueue(label: "Unequal 1", qos: DispatchQoS.userInteractive, attributes: .concurrent)
        let unequal2 = DispatchQueue(label: "Unequal 2", qos: DispatchQoS.utility, attributes: .concurrent)
        
        // Low vs High Priority
//        let unequal1 = DispatchQueue(label: "Unequal 1", qos: DispatchQoS.userInitiated, attributes: .concurrent)
//        let unequal2 = DispatchQueue(label: "Unequal 2", qos: DispatchQoS.background, attributes: .concurrent)
        
        unequal1.async {
            self.countPriority(onThread: "Unequal ❤️", start: 0, upto: 150)
        }
        
        unequal2.async {
            self.countPriority(onThread: "Unequal 💚", start: 151, upto: 300)
        }
    }
    
    // Fifth Button
    @IBAction func singleQueue(_ sender: Any)
    {
        clearText()

        let single = DispatchQueue(label: "Single", qos: DispatchQoS.userInitiated)
        
        single.async {
            self.count(onThread: "Single ❤️", start: 0, upto: 150)
        }
        
        single.async {
            self.count(onThread: "Single 💚", start: 151, upto: 300)
        }
    }
    
    // Sixth Button
    @IBAction func singleConcurrent(_ sender: Any)
    {
        clearText()

        let single = DispatchQueue(label: "Single", qos: DispatchQoS.userInitiated, attributes: .concurrent)
        
        single.async {
            self.count(onThread: "Single ❤️", start: 0, upto: 150)
        }
        
        single.async {
            self.count(onThread: "Single 💚", start: 151, upto: 300)
        }
    }
    
    // Seventh Button
    @IBAction func delayExecution(_ sender: Any)
    {
        clearText()

        // Name | Priority | Execution type
        let single = DispatchQueue(label: "Single", qos: DispatchQoS.userInitiated, attributes: .concurrent)
        
        let additionalTime: DispatchTimeInterval = .seconds(5)
        
        single.asyncAfter(deadline: .now() + additionalTime) {
            self.count(onThread: "Single ❤️", start: 0, upto: 150)
        }
        
        single.async {
            self.count(onThread: "Single 💚", start: 151, upto: 300)
        }

    }
    
    func count(onThread: String, start: Int, upto: Int)
    {
        var counter = start
        let symbol = onThread
        
        if start == 151{
            print()
        }
        for _ in start...upto
        {
           
             //print(onThread + " " + String(counter) + "\n")
                
            if counter % 20 == 0
            {
                 sleep(1)
                stringCounter.append("\(symbol) - \(String(counter)) \n")
            }
            
            counter = counter + 1
        }
        DispatchQueue.main.async {
            self.countdown.text = self.stringCounter
        }
    }
    
    func countPriority(onThread: String, start: Int, upto: Int)
    {
        var counter = start
        let symbol = onThread
        
        if start == 151{
            print()
        }
        for _ in start...upto
        {
            
            //print(onThread + " " + String(counter) + "\n")
            
            if counter % 20 == 0
            {
                stringCounter.append("\(symbol) - \(String(counter)) \n")
            }
            
            counter = counter + 1
        }
        DispatchQueue.main.async {
            self.countdown.text = self.stringCounter
        }
    }
    
    func clearText()
    {
        DispatchQueue.main.async {
            self.countdown.text = ""
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
}

