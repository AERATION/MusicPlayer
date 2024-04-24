
import Foundation

final class ListMusicViewModel {
    func loadListMusics() {
        MusicService.shared.loadMusic()
    }
    
    func getListMusicCount() -> Int {
        return MusicService.shared.newTracks.count
    }
    
    func getTrack() -> [Track] {
        return MusicService.shared.newTracks
    }
}
