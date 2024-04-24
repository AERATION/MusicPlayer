import UIKit
import Foundation
import MediaPlayer
import Combine

protocol PlayerDetailVMProtocol {
    func onMusicCellTapped(trackIndex: Int)
    func startPlay(trackIndex: Int)
    func pauseTrack()
    func onForwardButtonTapped()
    func onBackwordButtonTapped()
}

final class PlayerDetailViewModel: PlayerDetailVMProtocol {
    
    //MARK: Properties
    @Published var currentDuration: Double = 0
    @Published var maxCurrentDuration: Double = 0
    @Published var currentTrackIndex: Int = 0
    @Published var isPlaying: Bool = false
    
    private var subscriptions = Set<AnyCancellable>()
    
    //MARK: Initializations
    init() {
        addObservers()
    }
    
    //MARK: Functions
    func onMusicCellTapped(trackIndex: Int) {
        startPlay(trackIndex: trackIndex)
    }
    
    func startPlay(trackIndex: Int) {
        MusicService.shared.play(trackIndex: trackIndex)
        if let duration = MusicService.shared.player.currentItem?.asset.duration.seconds {
            maxCurrentDuration = duration
        }
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
        if let duration = MusicService.shared.player.currentItem?.asset.duration.seconds {
            maxCurrentDuration = duration
        }
    }
    
    func onBackwordButtonTapped() {
        MusicService.shared.previousTrack()
        if let duration = MusicService.shared.player.currentItem?.asset.duration.seconds {
            maxCurrentDuration = duration
        }
    }
    
    //MARK: Private functions
    private func addObservers() {
        MusicService.shared.$isPlaying
            .sink { [weak self] state in
                self?.isPlaying = state
            }
            .store(in: &subscriptions)
        
        MusicService.shared.$currentTrackIndex
            .sink { [weak self] index in
                self?.currentTrackIndex = index
            }
            .store(in: &subscriptions)
    }
}
