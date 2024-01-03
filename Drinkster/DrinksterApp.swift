//
//  DrinksterApp.swift
//  Drinkster
//
//  Created by Zakee Tanksley on 1/3/24.
//

import SwiftUI
import CoreData

@main
struct DrinksterApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            DrinkListView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

struct DrinkListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Drink.name, ascending: true)],
        animation: .default)
    private var drinks: FetchedResults<Drink>

    var body: some View {
        NavigationView {
            List {
                ForEach(drinks) { drink in
                    NavigationLink(destination: DrinkDetailView(drink: drink)) {
                        Text(drink.name ?? "Unknown Drink")
                    }
                }
            }
            .navigationBarTitle("Drinkster")
            .navigationBarItems(trailing: NavigationLink(destination: AddDrinkView()) {
                Image(systemName: "plus")
            })
        }
    }
}

struct DrinkDetailView: View {
    @ObservedObject var drink: Drink

    var body: some View {
        VStack {
            Text(drink.name ?? "Unknown Drink")
                .font(.title)
            Text(drink.ingredients ?? "No ingredients")
                .padding()
            Text(drink.instructions ?? "No instructions")
                .padding()
        }
        .navigationBarTitle(drink.name ?? "Unknown Drink")
    }
}

struct AddDrinkView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var name = ""
    @State private var ingredients = ""
    @State private var instructions = ""
    
    var body: some View {
        Form {
            Section(header: Text("Drink Details")) {
                TextField("Name", text: $name)
                TextField("Ingredients", text: $ingredients)
                TextField("Instructions", text: $instructions)
            }
            
            Section {
                Button("Save Drink") {
                    addDrink()
                }
            }
        }
    }
}
