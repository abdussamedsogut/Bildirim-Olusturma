//
//  ViewController.swift
//  Bildirim Olusturma
//
//  Created by Abdüssamed Söğüt on 1.03.2023.
//

import UIKit
import UserNotifications


class ViewController: UIViewController {

    var izinKontrol = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        UNUserNotificationCenter.current().delegate = self
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.badge,.sound] , completionHandler: {
                (granted,error) in
            self.izinKontrol = granted
            
            if granted {
                print("izin alma başarılı")
            }else {
                print("izin alma başarısız")
            }
        })
    }

    @IBAction func bildirimOlustur(_ sender: Any) {
        
            if izinKontrol {
                
                let evet  = UNNotificationAction(identifier: "evet", title: "Evet")
                let hayir  = UNNotificationAction(identifier: "hayir", title: "Hayır")
                let sil  = UNNotificationAction(identifier: "sil", title: "Sil", options: .destructive)

                let kategori = UNNotificationCategory(identifier: "ktg", actions: [evet,hayir,sil], intentIdentifiers: [])
                
                UNUserNotificationCenter.current().setNotificationCategories([kategori])
                
                let icerik = UNMutableNotificationContent()
                icerik.title = "Başlık"
                icerik.subtitle = "Alt Başlık"
                icerik.body = "5 4'ten büyüktür "
                icerik.badge = 1
                icerik.sound = UNNotificationSound.default
                
                icerik.categoryIdentifier = "ktg"
               
                /* var date = DateComponents()
                    date.minute = 30
                    date.hour = 8
                    let tetikleme = UNCalendarNotificationTrigger(dateMatching: date, repeats: true) */
                    
                let tetikleme = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
                
                let bildirimIstegi = UNNotificationRequest(identifier: "Bildirim Olusturma", content: icerik, trigger: tetikleme)
                
                UNUserNotificationCenter.current().add(bildirimIstegi)
            
        }
    
        
    }
    
}

extension ViewController: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
       
        completionHandler([.banner,.badge,.sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        if response.actionIdentifier == "evet" {
            print("Doğru Cevap")
        }
        
        if response.actionIdentifier == "hayir" {
            print("Yanlış Cevap")
        }
        
        if response.actionIdentifier == "sil" {
            print("Cevap Verilmedi")
        }
        
        completionHandler()
        
    }
    
}
