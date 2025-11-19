import SwiftUI

struct RecitersListView: View {
    let reciters: [Reciter]
    @ObservedObject var audioPlayer: AudioPlayer
    @ObservedObject var appData: AppData
    @Binding var showingFullPlayer: Bool
    @State private var searchText = ""
    
    var filteredReciters: [Reciter] {
        if searchText.isEmpty {
            return reciters
        }
        return reciters.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
    }
    
    var body: some View {
        List(filteredReciters) { reciter in
            NavigationLink {
                ReciterDetailView(
                    reciter: reciter,
                    audioPlayer: audioPlayer,
                    appData: appData,
                    showingFullPlayer: $showingFullPlayer
                )
            } label: {
                ReciterRow(reciter: reciter, appData: appData)
            }
        }
        .listStyle(PlainListStyle())
        .background(Color(.systemBackground))
        .navigationTitle("القراء")
        .searchable(text: $searchText, prompt: "ابحث عن قارئ...")
        .alert("خطأ في التشغيل", isPresented: .constant(audioPlayer.errorMessage != nil)) {
            Button("حسناً", role: .cancel) {
                audioPlayer.errorMessage = nil
            }
        } message: {
            if let error = audioPlayer.errorMessage {
                Text(error)
            }
        }
    }
}
