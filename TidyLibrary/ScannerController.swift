//
//  ViewController.swift
//  TidyLibrary
//
//  Created by David Latil on 28/10/2019.
//  Copyright © 2019 David Latil. All rights reserved.
//
//  Inspired from : https://www.hackingwithswift.com/example-code/media/how-to-scan-a-barcode by Paul Hudson

import AVFoundation
import UIKit
import CoreData

class ScannerController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    var passedCode:String!
    //purpose: 1 if when adding album, 0 else
    var purpose: Int=0
    var passedArtist: String=""
    var passedAlbum: String=""
    var passedGenre: String=""
    
    @IBOutlet weak var infos: UILabel!
    @IBOutlet weak var viewFinder: UIImageView!
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.black
        captureSession = AVCaptureSession()

        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput

        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            fatalError("Can't access capture device")
        }

        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            fatalError("Can't add input")
        }

        let metadataOutput = AVCaptureMetadataOutput()

        if (captureSession.canAddOutput(metadataOutput)) {
            captureSession.addOutput(metadataOutput)
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.ean8, .ean13, .pdf417]
        } else {
            fatalError("Can't retrieve data")
        }

        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)

        captureSession.startRunning()
        view.bringSubviewToFront(infos)
        
        view.bringSubviewToFront(viewFinder)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if (captureSession?.isRunning == false) {
            captureSession.startRunning()
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if (captureSession?.isRunning == true) {
            captureSession.stopRunning()
        }
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        captureSession.stopRunning()

        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            passedCode=stringValue
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            if purpose==1 {
                performSegue(withIdentifier: "showAddConfirmation", sender: nil)
            } else {
                performSegue(withIdentifier: "showResults", sender: nil)
            }
        }

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if purpose == 1 {
            if segue.destination is AddConfirmationController
            {
                let vc = segue.destination as? AddConfirmationController
                vc?.code = passedCode
                vc?.name=passedAlbum
                vc?.artist=passedArtist
                vc?.genre=passedGenre
            }
        } else {
            if segue.destination is ResultPageController
            {
                let vc = segue.destination as? ResultPageController
                vc?.searchedCode = passedCode
            }
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
}
