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

struct MenuView: View {
    var body: some View {
        Menu("Options") {
            Button("Order Now", action: doNothing)
            Button("Adjust Order", action: doNothing)
            Button("Cancel", action: doNothing)
        }
    }
    
    func doNothing() {
        
    }
}

struct ContentView: View {
    enum SortType: String, Equatable, CaseIterable {
        case file = "File", name = "Name", country = "Country"
    }
    
    var sortedResorts: [Resort] {
        switch sortBy {
        case .file:
            return filteredResorts
        case .name:
            return filteredResorts.sorted()
        case .country:
            return filteredResorts.sorted { $0.country < $1.country }
        }
    }
    
    var filteredResorts: [Resort] {
        return resorts.resorts.filter { resort in
            (resort.country == countryFilter ?? resort.country) &&
                (resort.price == priceFilter ?? resort.price) &&
                (resort.size == sizeFilter ?? resort.size)
        }
    }
    
//    @State private var selectedUser: User? = nil
    
//    @State private var layoutVertically = false

//    @Environment(\.horizontalSizeClass) var sizeClass
    
    @ObservedObject var favourites = Favourites()
    @State private var sortBy: SortType = .name
    @State private var countryFilter: String?
    @State private var priceFilter: Int?
    @State private var sizeFilter: Int? 
    
//    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    let resorts: Resorts = Resorts()
    
    var body: some View {
     
        NavigationView {
            List(sortedResorts) { resort in
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
                    .layoutPriority(1)
                    
                    if self.favourites.contains(resort) {
                        Spacer()
                        Image(systemName: "heart.fill")
                            .accessibility(label: Text("This is a favourite resort"))
                            .foregroundColor(.red)
                    }
                }

            }
            .navigationBarTitle("Resorts")
//            .navigationBarItems(
//                trailing:
//                    MenuView()
//            )
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Menu {
                        Picker(selection: $sortBy, label: Text("Sorting Options")) {
//                            Text("File").tag(SortType.file)
//                            Text("Name").tag(SortType.name)
//                            Text("Country").tag(SortType.country)
                            
                            ForEach(SortType.allCases, id: \.self) { value in
                                Text(value.rawValue)
                                    .tag(value)
                            }
                        }
                        
//                        Button("Order Now", action: doNothing)
//                        Button("Adjust Order", action: doNothing)
//                        Button("Cancel", action: doNothing)
                    }
                    label: {
                        Label("Filter and Sort", systemImage: "line.horizontal.3.decrease.circle")
                    }
                    
                }
            }
            
            WelcomeView()
        }
        .environmentObject(favourites)
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
    
    func doNothing() {
        
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
