//
//  FirstStart.swift
//  WaterReminder
//
//  Created by Rémy on 15/02/2022.
//

import SwiftUI
import UIKit
import UserNotifications
import HealthKit



struct FirstStart: View {
    var body: some View {
        ZStack {
            TabView {
                        Welcome()
                        NotificationAccess()
                        HealthAccess()
                    }
            .tabViewStyle(.page)
        }
        .background(Color("iOS BG"))
    }
}
struct Welcome: View {
    var body: some View {
        VStack (alignment: .center) {
            Spacer()
                .frame(width: UIScreen.main.bounds.width - 40, height: 80, alignment: .center)
            Text("Welcome !")
                .font(.largeTitle)
                .fontWeight(.bold)
                .lineLimit(1)
                .frame(width: UIScreen.main.bounds.width - 40, height: 0, alignment: .center)
            Spacer()
                .frame(width: 10, height: 30, alignment: .center)
            Text("Welcome to WaterReminder! Thank you for choosing our application! Before we start we will do a first configuration! Don't worry, it will only take a minute!")
                .font(.callout)
                .multilineTextAlignment(.center)
                .frame(width: UIScreen.main.bounds.width - 40, alignment: .center)
            Spacer()
                .frame(width: UIScreen.main.bounds.width - 40, height: 40, alignment: .center)
            Image("SalyHello")
                .resizable(resizingMode: .stretch)
                .frame(width: 300, height: 300, alignment: .center)
            Spacer()
            HStack {
                Text("Swipe to continue")
                Image(systemName: "chevron.right")
                    .imageScale(.large)
                    .frame(height: 40, alignment: .center)
            }
            .frame(height: 40, alignment: .center)
            Spacer()
                .frame(width: UIScreen.main.bounds.width - 40, height: 60, alignment: .center)
        }

    }
}
struct NotificationAccess: View {
    @State var NotifAllowed = false
    @State var AlertNotif = false
    
    var body: some View {
        VStack (alignment: .center) {
            Spacer()
                .frame(width: UIScreen.main.bounds.width - 40, height: 80, alignment: .center)
            Text("Need notification !")
                .font(.largeTitle)
                .fontWeight(.bold)
                .lineLimit(1)
                .frame(width: UIScreen.main.bounds.width - 40, height: 0, alignment: .center)
            Spacer()
                .frame(width: 10, height: 30, alignment: .center)
            Text("WaterReminder should be able to send you notifications to remind you to drink! These can remind you to drink, encourage you to drink, or annotate your trophies! You can manage the notifications in the application settings.")
                .font(.callout)
                .multilineTextAlignment(.center)
                .frame(width: UIScreen.main.bounds.width - 40, height: 125, alignment: .center)
            Spacer()
                .frame(width: UIScreen.main.bounds.width - 40, height: 30, alignment: .center)
            Image("NotifAccess")
                .resizable(resizingMode: .stretch)
                .frame(width: 300, height: 300, alignment: .center)
            Spacer()
            HStack {
                if NotifAllowed == false {
                    Button("Allow access") {
                        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                            if success {
                                print("All set!")
                                NotifAllowed = true
                            } else if let error = error {
                                print(error.localizedDescription)
                                AlertNotif.toggle()
                            }
                        }
                    }
                    Button("or cheat !") {
                        AlertNotif.toggle()
                        NotifAllowed = true
                    }
                }
                if NotifAllowed == true {
                    Text("Swipe to continue")
                    Image(systemName: "chevron.right")
                        .imageScale(.large)
                        .frame(height: 40, alignment: .center)
                }
                }
            .frame(height: 40, alignment: .center)
            Spacer()
                .frame(width: UIScreen.main.bounds.width - 40, height: 60, alignment: .center)
    }
        .alert(isPresented: $AlertNotif) {
            Alert(title: Text("Unauthorized access to notifications !"), message: Text("You have denied access to the notification! If you want to be reminded to drink, this feature is essential! If you don't want the notification, you can slide to the left, once this alert is closed."), dismissButton: .default(Text("I understand and I close this alert")))
        }
    
    }
}

struct HealthAccess: View {
    @State var HealthAllowed = false
    @State var AlertHealth = false
    
    var body: some View {
        VStack (alignment: .center) {
            Spacer()
                .frame(width: UIScreen.main.bounds.width - 40, height: 80, alignment: .center)
            Text("Sync with Health")
                .font(.largeTitle)
                .fontWeight(.bold)
                .lineLimit(1)
                .frame(width: UIScreen.main.bounds.width - 40, height: 0, alignment: .center)
            Spacer()
                .frame(width: 10, height: 30, alignment: .center)
            Text("WaterReminder can use the Health application to save data! If you authorize, your water consumption tracking will be available in the Health application, and our application will store the consumption on this application.")
                .font(.callout)
                .multilineTextAlignment(.center)
                .frame(width: UIScreen.main.bounds.width - 40, height: 125, alignment: .center)
            Spacer()
                .frame(width: UIScreen.main.bounds.width - 40, height: 30, alignment: .center)
            Image("NotifAccess")
                .resizable(resizingMode: .stretch)
                .frame(width: 300, height: 300, alignment: .center)
            Spacer()
            HStack {
                if HealthAllowed == false {
                    Button("Allow access") {
                        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                            if success {
                                print("All set!")
                                HealthAllowed = true
                            } else if let error = error {
                                print(error.localizedDescription)
                                AlertHealth.toggle()
                            }
                        }
                    }
                    Button("or cheat !") {
                        AlertHealth.toggle()
                        HealthAllowed = true
                    }
                }
                if HealthAllowed == true {
                    Text("Swipe to continue")
                    Image(systemName: "chevron.right")
                        .imageScale(.large)
                        .frame(height: 40, alignment: .center)
                }
                }
            .frame(height: 40, alignment: .center)
            Spacer()
                .frame(width: UIScreen.main.bounds.width - 40, height: 60, alignment: .center)
    }
        .alert(isPresented: $AlertHealth) {
            Alert(title: Text("Unauthorized access to notifications !"), message: Text("You have denied access to the notification! If you want to be reminded to drink, this feature is essential! If you don't want the notification, you can slide to the left, once this alert is closed."), dismissButton: .default(Text("I understand and I close this alert")))
        }
    
    }
}
struct FirstStart_Previews: PreviewProvider {
    static var previews: some View {
            FirstStart()
    }
}
