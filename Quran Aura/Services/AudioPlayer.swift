import SwiftUI
import AVFoundation
import Combine

class AudioPlayer: ObservableObject {
    private var player: AVPlayer?
    private var cancellables = Set<AnyCancellable>()
    private var timeObserver: Any?
    
    @Published var isPlaying = false
    @Published var currentReciter: Reciter?
    @Published var currentSurah: Surah?
    @Published var isLoading = false
    @Published var currentTime: Double = 0
    @Published var duration: Double = 0
    @Published var isSeeking = false
    @Published var errorMessage: String?
    
    init() {
        setupPlayerObservers()
    }
    
    private func setupPlayerObservers() {
        $isLoading
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.objectWillChange.send()
            }
            .store(in: &cancellables)
    }
    
    func playSurah(_ surah: Surah, for reciter: Reciter) {
        currentReciter = reciter
        currentSurah = surah
        isLoading = true
        currentTime = 0
        duration = 0
        errorMessage = nil
        
        var baseURL = reciter.secureHref
        if !baseURL.hasSuffix("/") {
            baseURL += "/"
        }
        let surahNumber = surah.formattedNumber
        let audioURLString = "\(baseURL)\(surahNumber).mp3"
        
        cleanupPlayer()
        
        guard let url = URL(string: audioURLString) else {
            errorMessage = "عنوان غير صحيح للملف الصوتي"
            isLoading = false
            return
        }
        
        let playerItem = AVPlayerItem(url: url)
        player = AVPlayer(playerItem: playerItem)
        
        addTimeObserver()
        
        playerItem.publisher(for: \.status)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] status in
                switch status {
                case .readyToPlay:
                    self?.isLoading = false
                    self?.duration = self?.player?.currentItem?.duration.seconds ?? 0
                    self?.player?.play()
                    self?.isPlaying = true
                case .failed:
                    self?.isLoading = false
                    if let error = playerItem.error {
                        self?.errorMessage = "فشل في تحميل الملف الصوتي: \(error.localizedDescription)"
                    } else {
                        self?.errorMessage = "فشل في تحميل الملف الصوتي. قد يكون الخادم غير متاح أو الملف غير موجود."
                    }
                case .unknown:
                    break
                @unknown default:
                    break
                }
            }
            .store(in: &cancellables)
        
        playerItem.publisher(for: \.duration)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] newDuration in
                guard newDuration.seconds.isFinite && !newDuration.seconds.isNaN else { return }
                self?.duration = newDuration.seconds
            }
            .store(in: &cancellables)
        
        NotificationCenter.default.addObserver(
            forName: .AVPlayerItemDidPlayToEndTime,
            object: playerItem,
            queue: .main
        ) { [weak self] _ in
            self?.isPlaying = false
            self?.currentTime = 0
        }
    }
    
    private func addTimeObserver() {
        let interval = CMTime(seconds: 0.5, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        timeObserver = player?.addPeriodicTimeObserver(forInterval: interval, queue: .main) { [weak self] time in
            guard let self = self, !self.isSeeking else { return }
            self.currentTime = time.seconds
        }
    }
    
    private func cleanupPlayer() {
        if let timeObserver = timeObserver {
            player?.removeTimeObserver(timeObserver)
        }
        player?.pause()
        player = nil
        timeObserver = nil
    }
    
    func playPause() {
        guard let player = player else { return }
        
        if isPlaying {
            player.pause()
            isPlaying = false
        } else {
            player.play()
            isPlaying = true
        }
    }
    
    func seek(to time: Double) {
        guard let player = player else { return }
        let targetTime = CMTime(seconds: time, preferredTimescale: 1)
        player.seek(to: targetTime)
        currentTime = time
    }
    
    func skipForward() {
        seek(to: min(currentTime + 15, duration))
    }
    
    func skipBackward() {
        seek(to: max(currentTime - 15, 0))
    }
    
    func stop() {
        cleanupPlayer()
        isPlaying = false
        currentSurah = nil
        currentReciter = nil
        isLoading = false
        currentTime = 0
        duration = 0
        errorMessage = nil
    }
    
    deinit {
        cleanupPlayer()
        NotificationCenter.default.removeObserver(self)
    }
}