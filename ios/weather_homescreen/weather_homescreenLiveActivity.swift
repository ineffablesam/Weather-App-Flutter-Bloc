//
//  weather_homescreenLiveActivity.swift
//  weather_homescreen
//
//  Created by Sam on 25/10/23.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct weather_homescreenAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct weather_homescreenLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: weather_homescreenAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension weather_homescreenAttributes {
    fileprivate static var preview: weather_homescreenAttributes {
        weather_homescreenAttributes(name: "World")
    }
}

extension weather_homescreenAttributes.ContentState {
    fileprivate static var smiley: weather_homescreenAttributes.ContentState {
        weather_homescreenAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: weather_homescreenAttributes.ContentState {
         weather_homescreenAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: weather_homescreenAttributes.preview) {
   weather_homescreenLiveActivity()
} contentStates: {
    weather_homescreenAttributes.ContentState.smiley
    weather_homescreenAttributes.ContentState.starEyes
}
