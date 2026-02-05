// ContentView.swift
import SwiftUI
import Segment

struct ContentView: View {
    @State private var inputText: String = ""
    @State private var statusMessage: String = ""

    var body: some View {
        VStack(spacing: 20) {
            Text("CleverTap via Segment")
                .font(.title2)
                .padding(.top, 24)

            TextField("Enter base name (e.g. Ruben)", text: $inputText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
                .autocapitalization(.none)

            Button(action: createProfilesAndTrackEvents) {
                Text("Send Profiles + Events")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .padding(.horizontal)

            Text(statusMessage)
                .foregroundColor(.gray)
                .padding(.horizontal)
                .padding(.top, 8)

            Spacer()
        }
        .padding()
    }

    func createProfilesAndTrackEvents() {
        let base = inputText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !base.isEmpty else {
            statusMessage = "Please enter a name"
            return
        }

        // PROFILE 1
        let profile1Id = "\(base)1"
        let name1Id = "\(base)1_name"
        
        // identify profile1
        Analytics.main.identify(userId: profile1Id,
                                traits: [
                                    "name": name1Id
                                ])
        // send event for profile1
        Analytics.main.track(name: "swift_servertest1", properties: ["profile": profile1Id])

        // PROFILE 2
        let profile2Id = "\(base)2"
        let name2Id = "\(base)2_name"
        
        // identify profile2
        Analytics.main.identify(userId: profile2Id,
                                traits: [
                                    "name": name2Id
                                ])
        // send event for profile2
        Analytics.main.track(name: "swift_servertest2", properties: ["profile": profile2Id])

        statusMessage = "Sent identify+event for \(profile1Id) and \(profile2Id)"
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
