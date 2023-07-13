//
//  AppDelegate.swift
//  ConnectionTesting
//
//  Created by Ahmed Ibrahim on 12/07/2023.
//

import UIKit
import BackgroundTasks

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        BGTaskScheduler.shared.register(forTaskWithIdentifier: "com.refresh.me", using: DispatchQueue.global()) {
            (task) in self.handleAppRefresh(task: task as! BGAppRefreshTask)
        }
        
        return true
    }
    
    func handleAppRefresh(task: BGAppRefreshTask){
        print("Handel refresh app function starts")

        scheduleAppRefresh()
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 1
                
        let operation = BlockOperation {
            let currentIteration = UserDefaults.standard.integer(forKey: "time")
            
            UserDefaults.standard.set(Date.now.description, forKey: "date")
            UserDefaults.standard.set(currentIteration+1, forKey: "time")
            
        }
        
        queue.addOperation(operation)
        // Create operation
        
        
        task.expirationHandler = {
            queue.cancelAllOperations()
        }
        
        task.setTaskCompleted(success: true)
        
    }
    
    func scheduleAppRefresh(){
        print("Schdule app refresh function started")
        let request = BGProcessingTaskRequest(identifier: "com.refresh.me")
        request.earliestBeginDate = Date(timeIntervalSinceNow: 60)
        do {
            try BGTaskScheduler.shared.submit(request)
            print("Submitted")
        } catch {
            print("Could not schedule app refresh \(error)")
        }
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    
    


}

