//
//  ContentView.swift
//  WaterReminder
//
//  Created by Rémy on 13/02/2022.
//

import SwiftUI
import UserNotifications
import HealthKit

let HealthRequired = Set([HKObjectType.quantityType(forIdentifier: .dietaryWater)!])
let healthStore = HKHealthStore()


struct reminder {
    var id: String
    var time: String
    var notify: Bool
}

struct SetYou: View {
    var body: some View {
            List{
                HStack {
                        
                }
            }
    }
}

struct SetHealth: View {
    var body: some View {
        NavigationView {
            Button("Autohrize access") {
                healthStore.requestAuthorization(toShare: HealthRequired, read: HealthRequired) { (success, error) in
                    if !success {
                    }
            }
        }
        .navigationTitle("Apple Health")
        .navigationBarTitleDisplayMode(.inline)
    }
}
}
struct SetReminder: View {
    @State private var ReminderActive = false
    var body: some View {
        List {
            Section {
                Toggle("Active reminder", isOn: $ReminderActive)
                    .onChange(of: ReminderActive) { _ReminderActive in
                        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                            if success {
                                print("All set!")
                            } else if let error = error {
                                print(error.localizedDescription)
                                ReminderActive = false
                            }
                        }
                }
            }
            Section {
                Toggle(isOn: $ReminderActive) {Text("8h00")}
                
            }
        }
        .navigationTitle("Reminder")
            .toolbar{
                EditButton()
            }
    }
}
struct SetHistory: View {
    var body: some View {
        NavigationView {
            ScrollView {
                Image(systemName: "exclamationmark.arrow.circlepath")
                    .renderingMode(.original)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 125, height: 125, alignment: .center)
                Text("No History !")
                    .font(.title2)
                    .fontWeight(.semibold)
            }
        }
        .navigationTitle("History")
    }
}

struct HomeView: View {
    @State var Objective: CGFloat = 0
    var body: some View {
        NavigationView {
            Components(progress: Objective, lineWidth: 50, gradient: Gradient(colors: [Color("Ring1"),Color("Ring2")]))
            ZStack {
                ScrollView {
                    Spacer()
                        .frame(width: 300, height: 25, alignment: .center)
                ZStack {
                    Group {
                    Circle()
                        .stroke(Color(red: 0.5, green: 0.5, blue: 0.5),style: StrokeStyle(lineWidth:20, lineCap: .round))
                        .frame(width: 150, height: 150)
                        .rotationEffect(Angle(degrees: 90))
                        .rotation3DEffect(Angle(degrees: 180), axis: (x: 1, y: 0, z: 0))
                        .opacity(0.2)
                    Circle()
                        .trim(from: 0, to: Objective)
                        .stroke(AngularGradient(gradient: Gradient(colors: [Color("Ring1"),Color("Ring2")]), center: .center, startAngle: .degrees(0), endAngle: .degrees(345)) ,style: StrokeStyle(lineWidth:20, lineCap: .round)
                                
                        )
                        .frame(width: 150, height: 150)
                        .rotationEffect(Angle(degrees: -90))
                        .shadow(color: Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)).opacity(0.3), radius: 3, x: 0, y: 3)
                        .animation(.easeOut, value: Objective)
                    Circle()
                        .frame(width: 20, height: 20)
                        .foregroundColor(Objective > 0.95 ? Color("Ring2"): Color("Ring1").opacity(0))
                        .offset(y: -75)
                        .rotationEffect(Angle.degrees(360 * Double(Objective)))
                        .shadow(color: Objective > 0.96 ? Color.black.opacity(0.1): Color.clear, radius: 3, x: 4, y: 0)
                    }
                }
                    
                    Spacer()
                        .frame(width: 300, height: 25, alignment: .center)
                    Group {
                        Text("You started well ! Continue to drinks !")
                            .font(.title)
                            .fontWeight(.bold)
                            .frame(width: UIScreen.main.bounds.width-15, height: .none, alignment: .center)
                            .multilineTextAlignment(.center)
                        Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.")
                            .lineLimit(2)
                            .frame(width: UIScreen.main.bounds.width-15, height: .none, alignment: .center)
                            .multilineTextAlignment(.center)
                    }
                    
                    Divider()
                    ScrollView (.horizontal) {
                        Group {
                            HStack {
                                Group {
                                    Spacer()
                                        .frame(width: 0, height: 170, alignment: .center)
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 10)
                                            .frame(width: 115, height: 160, alignment: .center)
                                            .foregroundColor(.white)
                                            .shadow(radius: 2)
                                        VStack {
                                            Image("Water")
                                                .resizable(resizingMode: .stretch)
                                                .aspectRatio(contentMode: .fill)
                                                .frame(width: 91, height: 91, alignment: .center)
                                            Text("Water")
                                                .font(.body)
                                                .fontWeight(.medium)
                                                .multilineTextAlignment(.center)
                                            Text("Water contenance 100%")
                                                .font(.caption2)
                                                .fontWeight(.light)
                                                .multilineTextAlignment(.center)
                                                .frame(width: 110.0)
                                            
                                        }
                                        .zIndex(200)
                                    }
                                    .onTapGesture {
                                        Objective += 0.125
                                    }
                                .frame(width: 150, height: 115, alignment: .center)
                                    
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 10)
                                            .frame(width: 115, height: 160, alignment: .center)
                                            .foregroundColor(.white)
                                            .shadow(radius: 2)
                                        VStack {
                                            Image("Thea")
                                                .resizable(resizingMode: .stretch)
                                                .aspectRatio(contentMode: .fill)
                                                .frame(width: 91, height: 91, alignment: .center)
                                            Text("Thea")
                                                .font(.body)
                                                .fontWeight(.medium)
                                                .multilineTextAlignment(.center)
                                            Text("Water contenance 250mL")
                                                .font(.caption2)
                                                .fontWeight(.light)
                                                .multilineTextAlignment(.center)
                                                .frame(width: 110.0)
                                            
                                        }
                                        .zIndex(200)
                                        
                                    }
                                    .offset(x:-20)
                                    .onTapGesture {
                                        Objective += 0.01
                                    }
                                .frame(width: 150, height: 115, alignment: .center)
                                    
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 10)
                                            .frame(width: 115, height: 160, alignment: .center)
                                            .foregroundColor(.white)
                                            .shadow(radius: 2)
                                        VStack {
                                            Image("Coffee")
                                                .resizable(resizingMode: .stretch)
                                                .aspectRatio(contentMode: .fill)
                                                .frame(width: 91, height: 91, alignment: .center)
                                            Text("Coffee")
                                                .font(.body)
                                                .fontWeight(.medium)
                                                .multilineTextAlignment(.center)
                                            Text("Water contenance 250mL")
                                                .font(.caption2)
                                                .fontWeight(.light)
                                                .multilineTextAlignment(.center)
                                                .frame(width: 110.0)
                                            
                                        }
                                        .zIndex(200)
                                        
                                    }
                                    .offset(x:-40)
                                    .onTapGesture {
                                        Objective += 0.01
                                    }
                                .frame(width: 150, height: 115, alignment: .center)
                                    
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 10)
                                            .frame(width: 115, height: 160, alignment: .center)
                                            .foregroundColor(.white)
                                            .shadow(radius: 2)
                                        VStack {
                                            Image("Orange Juice")
                                                .resizable(resizingMode: .stretch)
                                                .aspectRatio(contentMode: .fill)
                                                .frame(width: 91, height: 91, alignment: .center)
                                            Text("Orange Juice")
                                                .font(.body)
                                                .fontWeight(.medium)
                                                .multilineTextAlignment(.center)
                                            Text("Water contenance 250mL")
                                                .font(.caption2)
                                                .fontWeight(.light)
                                                .multilineTextAlignment(.center)
                                                .frame(width: 110.0)
                                            
                                        }
                                        .zIndex(200)
                                        
                                    }
                                    .offset(x:-60)
                                    .onTapGesture {
                                        Objective += 0.01
                                    }
                                .frame(width: 150, height: 115, alignment: .center)
                                    
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 10)
                                            .frame(width: 115, height: 160, alignment: .center)
                                            .foregroundColor(.white)
                                            .shadow(radius: 2)
                                        VStack {
                                            Image("Cola")
                                                .resizable(resizingMode: .stretch)
                                                .aspectRatio(contentMode: .fill)
                                                .frame(width: 91, height: 91, alignment: .center)
                                            Text("Cola")
                                                .font(.body)
                                                .fontWeight(.medium)
                                                .multilineTextAlignment(.center)
                                            Text("Water contenance 250mL")
                                                .font(.caption2)
                                                .fontWeight(.light)
                                                .multilineTextAlignment(.center)
                                                .frame(width: 110.0)
                                            
                                        }
                                        .zIndex(200)
                                        
                                    }
                                    .offset(x:-80)
                                    .onTapGesture {
                                        Objective += 0.01
                                    }
                                .frame(width: 150, height: 115, alignment: .center)
                                    
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 10)
                                            .frame(width: 115, height: 160, alignment: .center)
                                            .foregroundColor(.white)
                                            .shadow(radius: 2)
                                        VStack {
                                            Image("Beer")
                                                .resizable(resizingMode: .stretch)
                                                .aspectRatio(contentMode: .fill)
                                                .frame(width: 91, height: 91, alignment: .center)
                                            Text("Beer")
                                                .font(.body)
                                                .fontWeight(.medium)
                                                .multilineTextAlignment(.center)
                                            Text("Water contenance 250mL")
                                                .font(.caption2)
                                                .fontWeight(.light)
                                                .multilineTextAlignment(.center)
                                                .frame(width: 110.0)
                                            
                                        }
                                        .zIndex(200)
                                        
                                    }
                                    .offset(x:-100)
                                    .onTapGesture {
                                        Objective += 0.01
                                    }
                                .frame(width: 150, height: 115, alignment: .center)
                                    
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 10)
                                            .frame(width: 115, height: 160, alignment: .center)
                                            .foregroundColor(.white)
                                            .shadow(radius: 2)
                                        VStack {
                                            Image("Wine")
                                                .resizable(resizingMode: .stretch)
                                                .aspectRatio(contentMode: .fill)
                                                .frame(width: 91, height: 91, alignment: .center)
                                            Text("Wine")
                                                .font(.body)
                                                .fontWeight(.medium)
                                                .multilineTextAlignment(.center)
                                            Text("Water contenance 250mL")
                                                .font(.caption2)
                                                .fontWeight(.light)
                                                .multilineTextAlignment(.center)
                                                .frame(width: 110.0)
                                            
                                        }
                                        .zIndex(200)
                                        
                                    }
                                    .offset(x:-120)
                                    .onTapGesture {
                                        Objective += 0.01
                                    }
                                .frame(width: 150, height: 115, alignment: .center)
                                    
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 10)
                                            .frame(width: 115, height: 160, alignment: .center)
                                            .foregroundColor(.white)
                                            .shadow(radius: 2)
                                        VStack {
                                            Image("Vodka")
                                                .resizable(resizingMode: .stretch)
                                                .aspectRatio(contentMode: .fill)
                                                .frame(width: 91, height: 91, alignment: .center)
                                            Text("Vodka")
                                                .font(.body)
                                                .fontWeight(.medium)
                                                .multilineTextAlignment(.center)
                                            Text("Water contenance 250mL")
                                                .font(.caption2)
                                                .fontWeight(.light)
                                                .multilineTextAlignment(.center)
                                                .frame(width: 110.0)
                                            
                                        }
                                        .zIndex(200)
                                        
                                    }
                                    .offset(x:-140)
                                    .onTapGesture {
                                        Objective += 0.01
                                    }
                                .frame(width: 150, height: 115, alignment: .center)
                                    
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 10)
                                            .frame(width: 115, height: 160, alignment: .center)
                                            .foregroundColor(.white)
                                            .shadow(radius: 2)
                                        VStack {
                                            Image("Milk")
                                                .resizable(resizingMode: .stretch)
                                                .aspectRatio(contentMode: .fill)
                                                .frame(width: 91, height: 91, alignment: .center)
                                            Text("Milk")
                                                .font(.body)
                                                .fontWeight(.medium)
                                                .multilineTextAlignment(.center)
                                            Text("Water contenance 250mL")
                                                .font(.caption2)
                                                .fontWeight(.light)
                                                .multilineTextAlignment(.center)
                                                .frame(width: 110.0)
                                            
                                        }
                                        .zIndex(200)
                                        
                                    }
                                    .offset(x:-160)
                                    .onTapGesture {
                                        Objective += 0.01
                                    }
                                .frame(width: 150, height: 115, alignment: .center)
                                }
                            }
                        }
                    }

                    Divider()
                    Spacer()
                        .frame(width: 300, height: 25, alignment: .center)
                    Group {
                        Text("And yesterday ?")
                            .font(.title)
                            .fontWeight(.bold)
                            .frame(width: UIScreen.main.bounds.width-25, height: .none, alignment: .leading)
                        .multilineTextAlignment(.leading)
                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                            .fill(.white)
                            .frame(height: 250)
                    }
                    

                }

                .navigationBarTitle("Home")
            }
            }
        }
    }



struct GoalView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: HomeView()) {
                    HStack{
                        VStack {
                            Spacer()
                                .frame(width: 50, height: 10, alignment: .center)
                            ZStack {
                                Circle()
                                    .stroke(Color(red: 0.5, green: 0.5, blue: 0.5),style: StrokeStyle(lineWidth:10, lineCap: .round))
                                    .frame(width: 75, height: 75)
                                    .rotationEffect(Angle(degrees: 90))
                                    .rotation3DEffect(Angle(degrees: 180), axis: (x: 1, y: 0, z: 0))
                                    .opacity(0.2)
                                Circle()
                                    .trim(from: 0, to: 0.3)
                                    .stroke(
                                            LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)), Color(#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1))]), startPoint: .topTrailing, endPoint: .bottomLeading),
                                            style: StrokeStyle(lineWidth:10, lineCap: .round)
                                    )
                                    .frame(width: 75, height: 75)
                                    .rotationEffect(Angle(degrees: 90))
                                    .rotation3DEffect(Angle(degrees: 180), axis: (x: 1, y: 0, z: 0))
                                .shadow(color: Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)).opacity(0.3), radius: 3, x: 0, y: 3)
                        }
                        Spacer()
                            .frame(width: 50, height: 10, alignment: .center)
                    }
                    Spacer()
                        .frame(width: 20, height: 30, alignment: .center)
                    VStack (alignment: .leading) {
                        Text("You started well !")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.leading)
                        Text("You have a good start, continuing on this path !")
                            .font(.body)
                            .fontWeight(.regular)
                            .multilineTextAlignment(.leading)
                    }
                }
                }
                
                .navigationBarTitle("Your goals")
                .navigationBarItems(trailing:
                    Button(action: {
                        print("Add")
                    }) {
                        Image(systemName: "plus").imageScale(.large)
                    }
            )
            }
            }
          }
    }


struct StatsView: View {
    var body: some View {
        NavigationView {
            Text("Hello")
            .navigationBarTitle("Stats")
          }
    }
}

struct SettingsView: View {
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
                List{
                    Section(header: Text("General")){
                    NavigationLink(destination: SetYou()) {
                        label: do {
                            Label("You", systemImage: "person")
                        }
                    }
                    NavigationLink(destination: Text("Second View")) {
                        label: do {
                            Label("Drinks", systemImage: "drop")
                        }
                    }
                    NavigationLink(destination: SetReminder()) {
                            label: do {
                                Label("Reminder", systemImage: "bell.badge")
                            }
                        }
                    NavigationLink(destination: SetHistory()) {
                            label: do {
                                Label("History", systemImage: "clock.arrow.circlepath")
                            }
                        }
                    }
                    
                    Section(header: Text("Sync")){
                        NavigationLink(destination: SetHealth()) {
                            label: do {
                                Label("Apple Health", systemImage: "heart")
                            }
                        }
                        NavigationLink(destination: Text("Second View")) {
                            label: do {
                                Label("iCloud Sync", systemImage: "icloud")
                            }
                        }
                    }
                    
                }
                .navigationTitle("Settings")
        }
        .searchable(text: $searchText)
    }
    
}

struct ContentView: View {
    
    let defaults = UserDefaults.standard
    
    var body: some View {
        if defaults.bool(forKey: "First Launch") == true {
            TabView {
                HomeView()
                    .tabItem{
                        Text("Home")
                        Image(systemName: "house")
                    }
                GoalView()
                    .tabItem{
                        Text("Goal")
                        Image(systemName: "checkmark.seal")
                    }
                StatsView()
                    .tabItem{
                        Text("Stats")
                        Image(systemName: "chart.xyaxis.line")
                    }
                SettingsView()
                    .tabItem{
                        Text("Settings")
                        Image(systemName: "gearshape")
                    }
            }
        } else {
            FirstStart()
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
.previewInterfaceOrientation(.portrait)
            
    }
}
