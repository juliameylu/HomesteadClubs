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
//    @StateObject var contactViewModel = ContactViewModel()
//    @StateObject var activityViewModel = ActivityViewModel()
//    @StateObject var volunteerViewModel = VolunteerViewModel()
    @EnvironmentObject var activityViewModel : ActivityViewModel
    
    var icontexts: [(emoji: String, title: String)] = [(emoji: "👫", title: "Members")]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                ForEach(activityViewModel.upcomingActivities, id: \.id) { activity in
                    Text(activity.name ?? "")
                        .font(.custom("Roboto-Bold", size: 20))
                        .foregroundColor(Color.black)                }

//            VStack {
//                Text("Upcoming Activities")
                //            ForEach(icontexts, id: \.self) {
                //                icontext in OptionView(emoji: icontext.emoji,
                //                                       title: icontext.title)
                //            }
//                OptionView<ContactListView>(emoji: "👫", title: "Members", destinationView: ContactListView(contactViewModel: contactViewModel))
//                OptionView<ActivityListView>(emoji: "🚮", title: "Activities", destinationView:
//                                                ActivityListView(activityViewModel: activityViewModel, contactViewModel: contactViewModel))
//                OptionView<ActivityListView>(emoji: "🚮", title: "Activities", destinationView:
//                                                ActivityListView(activityViewModel: activityViewModel))
//                OptionView(emoji: "🕦", title: "Volunteer Hours", destinationView: VolunteerListView(volunteerViewModel: volunteerViewModel))
//                .padding(.horizontal)
//                .foregroundColor(.green)
            } // ScrollView
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
