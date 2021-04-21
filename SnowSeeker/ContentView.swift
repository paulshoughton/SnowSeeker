//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Paul Houghton on 19/04/2021.
//

import SwiftUI

//struct User: Identifiable {
//    var id = "Taylor Swift"
//}
//
//struct UserView: View {
//    var body: some View {
//        Group {
//            Text("Name Paul")
//            Text("Country: England")
//            Text("Pets: Luna, Arya, and Toby")
//        }
//    }
//}

struct ContentView: View {
//    @State private var selectedUser: User? = nil
    
//    @State private var layoutVertically = false

//    @Environment(\.horizontalSizeClass) var sizeClass
    
    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    

    
    var body: some View {
     
        NavigationView {
            List(resorts) { resort in
                NavigationLink(destination: ResortView(resort: resort)) {
                    Image(resort.country)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 25)
                        .clipShape(
                            RoundedRectangle(cornerRadius: 5.0)
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 5.0)
                                .stroke(Color.black, lineWidth: 1)
                        )

                    VStack(alignment: .leading) {
                        Text(resort.name)
                            .font(.headline)

                        Text("\(resort.runs) runs")
                            .foregroundColor(.secondary)
                    }
                }

            }
            .navigationBarTitle("Resorts")
            
            WelcomeView()
        }
//        .phoneOnlyStackNavigationView()
        
//        Text("Hello, world!")
//            .padding()
        
//        Group {
//            if sizeClass == .compact {
//                VStack(content: UserView.init)
//            }
//            else {
//                HStack(content: UserView.init)
//            }
//        }
        
//        Group {
//            if layoutVertically {
//                VStack {
//                    UserView()
//                }
//            }
//            else {
//                HStack {
//                    UserView()
//                }
//            }
//        }
//        .onTapGesture {
//            self.layoutVertically.toggle()
//        }
        
//        Text("Hello, world!")
//            .padding()
        
//        Text("Hello, world!")
//            .padding()
//            .onTapGesture {
//                self.selectedUser = User()
//            }
//            .alert(item: $selectedUser) { user in
//                Alert(title: Text(user.id))
//            }
        
//        NavigationView {
//            NavigationLink(destination: Text("New secondary")) {
//                Text("Hello, world!")
//                    .padding()
//                    .navigationBarTitle("Primary")
//            }
//
//            Text("Secondary")
//        }
    }
}

extension View {
    func phoneOnlyStackNavigationView() -> some View {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return AnyView(self.navigationViewStyle(StackNavigationViewStyle()))
        }
        else {
            return AnyView(self)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
