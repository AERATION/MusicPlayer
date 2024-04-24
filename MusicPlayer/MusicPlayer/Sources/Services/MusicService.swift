
import Foundation
import MediaPlayer

protocol MusicServiceProtocol {
    func play(trackIndex: Int)
    func pause()
    func nextTrack()
    func previousTrack()
    func loadMusic()
}

final class MusicService: MusicServiceProtocol {
    
    static let shared = MusicService()
    
    var newTracks: [Track] = []
    
    @Published var player: AVPlayer = AVPlayer()
    
    @Published var currentTrackIndex = 0
    
    @Published var isPlaying = false
    
    func play(trackIndex: Int) {
        if currentTrackIndex == trackIndex && isPlaying == true {
            pause()
        } else {
            currentTrackIndex = trackIndex
            let playerItem = AVPlayerItem(url: URL(fileURLWithPath: newTracks[trackIndex].trackURL))
            NotificationCenter.default.addObserver(self, selector: #selector(trackDidEnded), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: player.currentItem)
            player.replaceCurrentItem(with: playerItem)
            player.play()
            isPlaying = true
        }
    }
    
    func pause() {
        player.pause()
        isPlaying = false
    }
    
    func nextTrack() {
        var newTrackIndex = currentTrackIndex
        if newTrackIndex == newTracks.count-1 {
            newTrackIndex = 0
        } else {
            newTrackIndex+=1
        }
        play(trackIndex: newTrackIndex)
    }
    
    func previousTrack() {
        var newTrackIndex = currentTrackIndex
        if newTrackIndex == 0 {
            newTrackIndex = newTracks.count-1
        } else {
            newTrackIndex-=1
        }
        play(trackIndex: newTrackIndex)
    }
    
    func loadMusic() {
        let audioFileNames = Bundle.main.paths(forResourcesOfType: "mp3", inDirectory: nil)
        
        for audioUrl in audioFileNames {
            let avp = AVPlayerItem(url: URL(fileURLWithPath: audioUrl))
            let commonMetaData = avp.asset.commonMetadata
            var title: String = ""
            var artist: String = ""
            for item in commonMetaData {
                if item.commonKey!.rawValue == "title" {
                    title = item.stringValue!
                }
                if item.commonKey!.rawValue == "artist" {
                    artist = item.stringValue!
                }
            }
            newTracks.append(Track(trackName: title, artistName: artist, trackURL: audioUrl))
        }
    }
    
    @objc func trackDidEnded() {
        nextTrack()
    }
    
}
