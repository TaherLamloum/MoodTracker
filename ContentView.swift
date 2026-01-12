import SwiftUI

struct ContentView: View {

    @StateObject private var vm = MoodViewModel()

    var body: some View {
        VStack(spacing: 20) {

            Text("How are you feeling?")
                .font(.title2)
                .bold()

            Picker("Mood", selection: $vm.selectedMood) {
                ForEach(Mood.allCases, id: \.self) { mood in
                    Text(mood.rawValue)
                }
            }
            .pickerStyle(.segmented)

            Button("Save Mood") {
                vm.saveMood()
            }
            .buttonStyle(.borderedProminent)
            .padding(.top)

            if let mood = vm.savedMood {
                Text("Last saved mood:")
                    .foregroundColor(.gray)

                Text(mood.rawValue)
                    .font(.system(size: 60))
            }
            
            Button(action: {
                vm.clearHistory()
            }) {
                Text("Clear History")
                    .bold()
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(
                        LinearGradient(
                            colors: [Color.red, Color.orange],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .cornerRadius(10)
            }
            .padding(.vertical)

            ScrollView {
                VStack(spacing: 15) {
                    ForEach(vm.moodHistory.reversed()) { entry in
                        HStack {
                            Text(entry.mood.rawValue)
                                .font(.title2)
                                .bold()
                            Spacer()
                            Text(entry.date, style: .time)
                                .foregroundColor(.white.opacity(0.7))
                                .font(.caption)
                        }
                        .padding()
                        .background(
                            LinearGradient(
                                colors: gradient(for: entry.mood),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .cornerRadius(15)
                        .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 5)
                    }
                }
            }
            .frame(height: 300)

            Spacer()
        }
        .padding()
    }

    // Function to return Gradient based on Mood
    func gradient(for mood: Mood) -> [Color] {
        switch mood {
        case .happy:
            return [Color.yellow, Color.orange]
        case .neutral:
            return [Color.gray, Color.blue]
        case .sad:
            return [Color.blue, Color.purple]
        }
    }
}
