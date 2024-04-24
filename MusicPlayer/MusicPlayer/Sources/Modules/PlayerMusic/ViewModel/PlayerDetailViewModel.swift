import UIKit
import Foundation
import MediaPlayer
import Combine

class PlayerDetailViewModel {
    
    @Published var currentDuration: Double = 0
    
    @Published var maxCurrentDuration: Double = 0
    
    @Published var isPlaying: Bool = false
    
    private var subscriptions = Set<AnyCancellable>()
    
    init() {
        addObserverState()
    }
    
    func onMusicCellTapped(trackIndex: Int) {
        startPlay(trackIndex: trackIndex)
    }
    
    func startPlay(trackIndex: Int) {
        MusicService.shared.play(trackIndex: trackIndex)
        maxCurrentDuration = (MusicService.shared.player.currentItem?.asset.duration.seconds)!
        MusicService.shared.player.addPeriodicTimeObserver(forInterval: CMTime(seconds: 1, preferredTimescale: 1000), queue: DispatchQueue.main) { (time) in
            self.currentDuration = time.seconds
        }
    }
    
    func pauseTrack() {
        if MusicService.shared.player.timeControlStatus == .playing {
            MusicService.shared.player.pause()
            isPlaying = false
        } else if MusicService.shared.player.timeControlStatus == .paused {
            MusicService.shared.player.play()
            isPlaying = true
        }
    }
    
    func onForwardButtonTapped() {
        MusicService.shared.nextTrack()
        maxCurrentDuration = (MusicService.shared.player.currentItem?.asset.duration.seconds)!
    }
    
    func onBackwordButtonTapped() {
        MusicService.shared.previousTrack()
        maxCurrentDuration = (MusicService.shared.player.currentItem?.asset.duration.seconds)!
    }
    
    private func addObserverState() {
        MusicService.shared.$isPlaying
            .sink { [weak self] state in
                if state {
                    self?.isPlaying = true
                } else {
                    self?.isPlaying = false
                }
            }
            .store(in: &subscriptions)
    }
}
