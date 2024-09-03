//
//  ContentView.swift
//  Devote
//
//  Created by Анастасия Кутняхова on 18.07.2024.
//

import SwiftUI
import CoreData

struct ContentView: View {
    // MARK: - PROPERTY
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    @State private var task = ""
    @State private var showNewTaskItem: Bool = false
    
    // FETCHING DATA
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    // MARK: - FUNCTION
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    // MARK: - BODY
    var body: some View {
        NavigationStack {
            ZStack {
                // MARK: - MAIN VIEW
                VStack {
                    // MARK: - HEADER
                    HStack(spacing: 10) {
                        Text("Devote")
                            .font(.system(.largeTitle, design: .rounded))
                            .fontWeight(.heavy)
                            .padding(.leading, 4)
                        
                        Spacer()
                        
                        EditButton()
                            .font(.system(size: 16, weight: .semibold, design: .rounded))
                            .padding(.horizontal, 10)
                            .frame(minWidth: 70, minHeight: 24)
                            .background(
                                Capsule().stroke(Color.white, lineWidth: 2)
                            )
                        
                        // APPEARENCE BUTTON
                        Button(action: {
                            isDarkMode.toggle()
                        },
                               label: {
                            Image(systemName: isDarkMode ? "moon.circle.fill" : "moon.circle")
                                .resizable()
                                .frame(width: 24, height: 24)
                                .font(.system(.title, design: .rounded))
                        })
                        
                    } //: HSTACK
                    .padding()
                    .foregroundStyle(Color.white)
                    
                    Spacer(minLength: 80)
                    
                    // MARK: - NEW TASK BUTTON
                    Button(
                        action: {
                            showNewTaskItem = true
                        },
                        label: {
                            Image(systemName: "plus.circle")
                                .font(.system(size: 30, weight: .semibold, design: .rounded))
                            Text("New task")
                                .font(.system(size: 24, weight: .bold, design: .rounded))
                        })
                    .foregroundStyle(Color.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 15)
                    .background(
                        LinearGradient(
                            colors: [Color.pink, Color.blue],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                        .clipShape(Capsule())
                    )
                    .shadow(color: .black.opacity(0.25), radius: 8, y: 4)
                    
                    // MARK: - TASKS
                    List {
                        ForEach(items) { item in
                            VStack(alignment: .leading) {
                                Text("\(item.task ?? "")")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                
                                NavigationLink {
                                    Text("Item at \(item.timestamp!, formatter: itemFormatter)")
                                } label: {
                                    Text(item.timestamp!, formatter: itemFormatter)
                                        .font(.footnote)
                                        .foregroundStyle(.gray)
                                }
                            } //: LIST ITEM
                        }
                        .onDelete(perform: deleteItems)
                    } //: LIST
                    .scrollContentBackground(.hidden)
                    .shadow(color: .black.opacity(0.3), radius: 12)
                } //: VSTACK
                
                // MARK: - NEW TASK ITEM
                if showNewTaskItem {
                    BlanckView()
                        .onTapGesture {
                            withAnimation {
                                showNewTaskItem = false
                            }
                        }
                    
                    NewTaskItemView(isShowing: $showNewTaskItem)
                }
            } //: ZSTACK
            .navigationTitle("Daily Tasks")
            .toolbar(.hidden)
            
            .background(
                BackgroundImageView()
            )
            .background(
                backgroundGradient.ignoresSafeArea()
            )
        } //: ZSTACK
    } //: NAVIGATION
}

// MARK: - PREWIEW
#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
