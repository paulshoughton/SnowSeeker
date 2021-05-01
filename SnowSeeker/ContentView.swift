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

struct FilterView: View {
    var country: String
    var price: Int
    var size: Int
    
    var filterText: String {
        var filterArray: [String] = []
        
        if country != "All" {
            filterArray.append(country)
        }
        
        if price != 0 {
            filterArray.append(Resorts.priceToString(price))
        }
        
        if size != 0 {
            filterArray.append(Resorts.sizeToString(size))
        }
        
        print(filterArray)
        
        return ListFormatter.localizedString(byJoining: filterArray)
    }
    
    var body: some View {
        Text(filterText)
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
            (resort.country == (countryFilter != "All" ? countryFilter : resort.country)) &&
                (resort.price == (priceFilter != 0 ? priceFilter : resort.price)) &&
                    (resort.size == (sizeFilter != 0 ? sizeFilter : resort.size))
        }
    }
    
//    @State private var selectedUser: User? = nil
    
//    @State private var layoutVertically = false

//    @Environment(\.horizontalSizeClass) var sizeClass
    
    @ObservedObject var favourites = Favourites()
    @State private var sortBy: SortType = .file
    @State private var countryFilter: String = "All"
    @State private var priceFilter: Int = 0
    @State private var sizeFilter: Int = 0
    
//    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    let resorts: Resorts = Resorts()
    
    var body: some View {
     
        NavigationView {
            List {
                Section(
                    header: HStack {
                        Image(systemName: "arrow.down.square")
                            .accessibility(label: Text("Sort Ascending:"))
                        Text("\(sortBy.rawValue)")
                        if countryFilter != "All" || priceFilter != 0 || sizeFilter != 0 {
                            Spacer()
                            Image(systemName: "line.horizontal.3.decrease.circle")
                                .accessibility(label: Text("Filtered by:"))
                            FilterView(country: countryFilter, price: priceFilter, size: sizeFilter)
                        }
                    }
                ) {
                    ForEach(sortedResorts) { resort in
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
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationBarTitle("Resorts")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Menu {
                        Section {
                            Picker(selection: $sortBy, label: Text("Sorting Options")) {
                                ForEach(SortType.allCases, id: \.self) { value in
                                    Text(value.rawValue)
                                        .tag(value)
                                }
                            }
                        }
                        Section(header: Text("Filter")) {
                            Button("Clear Filters", action: clearFilters)
                            Menu("Filter by Country") {
                                Picker(selection: $countryFilter, label: Text("Filter by Country")) {
                                    Text("All").tag("All")
                                    ForEach(resorts.countries.sorted(), id: \.self) { value in
                                        Text(value).tag(value)
                                    }
                                }
                            }
                            Menu("Filter by Price") {
                                Picker(selection: $priceFilter, label: Text("Filter by Price")) {
                                    Text("All").tag(0)
                                    ForEach(resorts.prices.sorted(), id: \.self) { value in
                                        Text(Resorts.priceToString(value)).tag(value)
                                    }
                                }
                            }
                            Menu("Filter by Size") {
                                Picker(selection: $sizeFilter, label: Text("Filter by Size")) {
                                    Text("All").tag(0)
                                    ForEach(resorts.sizes.sorted(), id: \.self) { value in
                                        Text(Resorts.sizeToString(value)).tag(value)
                                    }
                                }
                            }
                        }
                    }
                    label: {
                        Label("Filter and Sort", systemImage: "ellipsis.circle")
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
    
    func clearFilters() {
        countryFilter = "All"
        priceFilter = 0
        sizeFilter = 0
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
