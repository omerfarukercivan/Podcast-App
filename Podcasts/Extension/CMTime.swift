//
//  CMTime.swift
//  Podcasts
//
//  Created by Ömer Faruk Ercivan on 7.07.2023.
//

import AVKit

extension CMTime {
    func toDisplayString() -> String {
        let totalSecond = Int(CMTimeGetSeconds(self))
        let second = totalSecond % 60
        let minutes = totalSecond / 60
        let hour = minutes / 60
        let timeFormatString = String(format: "%02d:%02d:%02d", hour, minutes, second)
//        let timeFormatString = String(format: "%02d:%02d", minutes, second)
        
        return timeFormatString
    }
}
