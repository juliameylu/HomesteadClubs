//
//  ContentView.swift
//  HomesteadClubs
//
//  Created by Julia Lu on 4/26/23.
//

import SwiftUI
import CoreData

enum MenuDestination: Int, CaseIterable, Hashable {
    case option1 = 0, option2 = 1, option3 = 2, option4 = 3, option5 = 4, settings = 5

    @ViewBuilder var view: some View {
        switch self {
            case .option1: EmptyView()
            case .option2: EmptyView()
            case .option3: EmptyView()
            case .option4: EmptyView()
            case .option5: EmptyView()
            case .settings: EmptyView()
        }
    }
}

struct ContentView: View {
    @EnvironmentObject var activityViewModel : ActivityViewModel
    
    var icontexts: [(emoji: String, title: String)] = [(emoji: "👫", title: "Members")]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(activityViewModel.upcomingActivities, id: \.id) { activity in
                    NavigationLink {
                        ActivityDetailView(activity: activity)
                    } label: {
                        VStack(alignment: .leading) {
                            HStack {
                                Image("activity")
                                    .clipShape(Circle())
                                    .overlay(Circle().stroke(Color.gray, lineWidth: 2))

                                Text(activity.name ?? "")
                                    .fontWeight(.semibold)
                                    .font(.headline)
                            }
                            
                            Grid(alignment: .leadingFirstTextBaseline) {
                                GridRow {
                                    Text("From:")
                                    Text(activity.beginDateTime ?? Date.now, style: .date)
                                    Text(activity.beginDateTime ?? Date.now, style: .time)
                                }
                                GridRow {
                                    Text("To:")
                                    Text(activity.endDateTime ?? Date.now, style: .date)
                                    Text(activity.endDateTime ?? Date.now, style: .time)
                                }
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                        .padding(.bottom)
                    }
                } // ForEach
            } // List
            .navigationTitle("Upcoming Activities")
            .listStyle(.insetGrouped)
        } // NavigationStack
    } // some View
}

struct OptionView<Destination: View>: View {
    let emoji: String
    let title: String
    let destinationView: Destination
    @State var isFaceUp: Bool = true
    
    init(emoji: String, title: String, destinationView: Destination) {
        self.emoji = emoji
        self.title = title
        self.destinationView = destinationView
    }
    
    var body : some View {
        NavigationLink(destination: { destinationView }) {
            ZStack {
                let shape = RoundedRectangle(cornerRadius: 20)
                if isFaceUp {
                    shape.fill().foregroundColor(.white)
                    shape.stroke(lineWidth: 30)
                    IconText(emoji: emoji, title: title)
                } else {
                    shape.grayscale(10)
                }
            }
//            .onTapGesture {
//                isFaceUp = !isFaceUp
//            }
        }
    }
}

struct IconText: View {
    let emoji: String
    let title: String
    
    var body: some View {
        VStack {
            Text(emoji).font(.largeTitle)
            Text(title).font(.largeTitle)
        }
    }
}

//struct DatePicker: View {
//    @State private var dates: Set<DateComponents> = []
//
//    var body: some View {
//        MultiDatePicker("Pick Dates", selection: $dates)
//    }
//}




//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//            .preferredColorScheme(.dark)
//        ContentView()
//            .preferredColorScheme(.light)
//    }
//}
