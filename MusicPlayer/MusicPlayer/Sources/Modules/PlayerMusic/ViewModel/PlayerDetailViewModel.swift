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
    @Published var currentTrackName: String = ""
    @Published var currentTrackArtist: String = ""
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
    }
    
    func pauseTrack() {
        MusicService.shared.pause()
    }
    
    func onForwardButtonTapped() {
        MusicService.shared.nextTrack()
    }
    
    func onBackwordButtonTapped() {
        MusicService.shared.previousTrack()
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
                self?.currentTrackName = MusicService.shared.newTracks[index].trackName
                self?.currentTrackArtist = MusicService.shared.newTracks[index].artistName
            }
            .store(in: &subscriptions)
        
        MusicService.shared.$maxCurrentDuration
            .sink { [weak self] duration in
                self?.maxCurrentDuration = duration
            }
            .store(in: &subscriptions)
        
        MusicService.shared.$currentDuration
            .sink { [weak self] duration in
                self?.currentDuration = duration
            }
            .store(in: &subscriptions)
    }
}
