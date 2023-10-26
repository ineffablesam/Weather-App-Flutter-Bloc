//
//  weather_homescreen.swift
//  weather_homescreen
//
//  Created by Sam on 25/10/23.
//

import WidgetKit
import SwiftUI

private let widgetGroupId = "group.weather_app_group"

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(),    
                    temperature: "20",
                    weather: "Cloudy",
                    city: "demo city"
                
        )
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let data = UserDefaults.init(suiteName: widgetGroupId)
        let entry = SimpleEntry(date: Date(), temperature: data?.string(forKey: "temperature") ?? "No Temp", weather: data?.string(forKey: "weather") ?? "Nill",
            city: data?.string(forKey: "city") ?? "No City")
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>)-> ()) {
        getSnapshot(in: context){(entry) in
            let timeline = Timeline(entries: [entry], policy: .atEnd)
            completion(timeline)
        }
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let temperature: String
    let weather: String
    let city: String
}

struct weather_homescreenEntryView : View {
    var entry: Provider.Entry
    var body: some View {
    HStack(alignment: .center, spacing: 0){
        Text(entry.city)
            .fontWeight(.regular)
            .rotationEffect(Angle(degrees: -90))
            .foregroundColor(Color.white)
            
        VStack (alignment: .trailing) {
            VStack(alignment: .trailing, spacing: 0){
                Image("appIconImage")
                    .resizable()
                    .frame(width: 40, height: 40)
            }
            VStack (alignment: .leading) {
                Text("\(entry.temperature) °")
                    .fontWeight(.heavy)
                    .font(.title2)
                    .foregroundColor(Color.white)
                Text(entry.weather)
                    .fontWeight(.semibold)
                    .foregroundColor(Color(hue: 0.5, saturation: 0.0, brightness: 0.92, opacity: 0.50))
               
            }
           
        }
    }
    .padding(.leading, -25.0)
    .background(
            Image("widgetbg2")
                .resizable()
                .frame(width: 190.0, height: 190.0)
                .aspectRatio(contentMode: .fill)
                .blur(radius: 9, opaque:true)
                .scaledToFill()
        )
    }
}

struct weather_homescreen: Widget {
    let kind: String = "weather_homescreen"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            weather_homescreenEntryView(entry: entry)
                .containerBackground(
                    .blue, for: .widget)
                
        }
        .configurationDisplayName("My City Weather")
        .description("Use this Below Widget for Getting your Weather Information in Homescreen")
        .supportedFamilies([.systemSmall])
        .contentMarginsDisabled()
    }
}

extension ConfigurationAppIntent {
    fileprivate static var smiley: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "😀"
        return intent
    }
    
    fileprivate static var starEyes: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "🤩"
        return intent
    }
}

#Preview(as: .systemSmall) {
    weather_homescreen()
} timeline: {
    SimpleEntry(date: .now, temperature: "Temp",weather: "Weather", city: "City")
}
