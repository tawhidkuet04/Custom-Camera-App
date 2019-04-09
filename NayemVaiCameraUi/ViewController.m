//
//  ViewController.m
//  NayemVaiCameraUi
//
//  Created by Tawhid Joarder on 4/8/19.
//  Copyright © 2019 Tawhid Joarder. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()<UIImagePickerControllerDelegate>{


    IBOutlet UIView *cameraView;
}
 
@end

@implementation ViewController

-(void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    [coordinator animateAlongsideTransition:^(id  _Nonnull context) {
      
        self->previewLayer.frame = self->myView.bounds;
        self->previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        
    } completion:^(id  _Nonnull context) {
        if(size.height == 375){
             self->previewLayer.connection.videoOrientation = AVCaptureVideoOrientationLandscapeLeft;
        }else {
            
             previewLayer.connection.videoOrientation = AVCaptureVideoOrientationPortrait;
        }
       
        
        // after rotation
        [self->cameraView.layer addSublayer:self->previewLayer];
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //Capture Session
    session = [[AVCaptureSession alloc]init];
    session.sessionPreset = AVCaptureSessionPresetPhoto;
    
    //Add device
    AVCaptureDevice *device =
    [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    //Input
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    
    if (!input)
    {
        NSLog(@"No Input");
    }
    
    [session addInput:input];
    
    //Output
    AVCaptureVideoDataOutput *output = [[AVCaptureVideoDataOutput alloc] init];
    [session addOutput:output];
    output.videoSettings =
    @{ (NSString *)kCVPixelBufferPixelFormatTypeKey : @(kCVPixelFormatType_32BGRA) };
    
    //Preview Layer
    previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:session];
    myView = cameraView;
    previewLayer.frame = myView.bounds;
    previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    previewLayer.connection.videoOrientation = AVCaptureVideoOrientationPortrait;
    [cameraView.layer addSublayer:previewLayer];
//    cameraView.subviews = previewLayer;
//    [self.view.layer addSublayer:previewLayer];
    
    //Start capture session
    [session startRunning];

}
- (IBAction)cameraButtonPressed:(id)sender {

    NSLog(@"Pressed");
}



@end
