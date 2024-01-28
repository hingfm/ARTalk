//
//  ARTalkTests.swift
//  ARTalkTests
//
//  Created by Hing Chung on 18/1/2024.
//

import XCTest
import AVFoundation

@testable import ARTalk

final class ARTalkTests: XCTestCase {
    
    var audioCaptureController: AudioCaptureController!
    var outputFormat: AVAudioFormat!
    
    override func setUpWithError() throws {
        super.setUp()
        // Define a standard output format for testing
        guard let format = AVAudioFormat(standardFormatWithSampleRate: 44100, channels: 1) else {
            XCTFail("Failed to create AVAudioFormat")
            return
        }
        outputFormat = format
        audioCaptureController = AudioCaptureController(outputFormat: format)
    }

    override func tearDownWithError() throws {
        audioCaptureController = nil
        outputFormat = nil
        super.tearDown()
    }

    func testAudioCaptureControllerInitialization() throws {
        XCTAssertNotNil(audioCaptureController, "AudioCaptureController should be initialized")
        XCTAssertEqual(audioCaptureController.captureInProgress, false, "Capture should not be in progress after initialization")
    }
    
    func testStartCapture() throws {
        let expectation = self.expectation(description: "StartCapture")
        var captureStarted = false

        audioCaptureController.startCapture {
            captureStarted = self.audioCaptureController.captureInProgress
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertTrue(captureStarted, "Capture should be started")
    }
    
    func testStopCapture() throws {
        let startExpectation = expectation(description: "StartCapture")
        let stopExpectation = expectation(description: "StopCapture")
        var captureStopped = false

        audioCaptureController.startCapture {
            startExpectation.fulfill()

            self.audioCaptureController.stopCapture { _ in
                captureStopped = !self.audioCaptureController.captureInProgress
                stopExpectation.fulfill()
            }
        }

        waitForExpectations(timeout: 10, handler: nil)
        XCTAssertTrue(captureStopped, "Capture should be stopped")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
