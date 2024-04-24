import UIKit
import Foundation
import MediaPlayer
import Combine

class PlayerDetailViewModel {
    
    @Published var currentDuration: Double = 0
    
    @Published var maxCurrentDuration: Double = 0
    
    @Published var isPlaying: Bool = false
    
    func startPlayback(trackIndex: Int) {
        playTrack(trackIndex: trackIndex)
    }
    
    func playTrack(trackIndex: Int) {
        isPlaying = true
        MusicService.shared.play(trackIndex: trackIndex)
        maxCurrentDuration = (MusicService.shared.player.currentItem?.asset.duration.seconds)!
        MusicService.shared.player.addPeriodicTimeObserver(forInterval: CMTime(seconds: 1, preferredTimescale: 1000), queue: DispatchQueue.main) { (time) in
            self.currentDuration = time.seconds
        }

    }
    
    func pauseTrack() {
        if MusicService.shared.player.timeControlStatus == .playing {
            MusicService.shared.pause()
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
}
