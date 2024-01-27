//
//  CMSampleBuffer+Extensions.swift
//  ARTalk
//
//  Created by Hing Chung on 21/1/2024.
//

import AVFoundation

extension CMSampleBuffer
{
    public func convertToPCMBuffer() -> AVAudioPCMBuffer? {
        // Convert CMSampeBuffer to AVAudioPCMBuffer: https://developer.apple.com/forums/thread/123926
        let sampleBuffer = self
        if let sDescr  = CMSampleBufferGetFormatDescription(sampleBuffer) {
            let numSamples = CMSampleBufferGetNumSamples(sampleBuffer)
            let avFmt = AVAudioFormat(cmAudioFormatDescription: sDescr)
            if let pcmBuffer = AVAudioPCMBuffer(pcmFormat: avFmt, frameCapacity: AVAudioFrameCount(UInt(numSamples))) {
                pcmBuffer.frameLength = AVAudioFrameCount(UInt(numSamples))
                CMSampleBufferCopyPCMDataIntoAudioBufferList(sampleBuffer, at: 0, frameCount: Int32(numSamples), into: pcmBuffer.mutableAudioBufferList)
                return pcmBuffer
            }
        }
        print("[CMSampleBuffer] Unable to create PCM buffer")
        return nil
    }
}
