//
//  ViewController.m
//  NayemVaiCameraUi
//
//  Created by Tawhid Joarder on 4/8/19.
//  Copyright © 2019 Tawhid Joarder. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "imageShowViewController.h"
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
         NSLog(@"changed");
        if(size.height == 375){
             self->previewLayer.connection.videoOrientation = AVCaptureVideoOrientationLandscapeRight;
        }else {
            
             previewLayer.connection.videoOrientation = AVCaptureVideoOrientationPortrait;
        }
       
        
        // after rotation
        [self->cameraView.layer addSublayer:self->previewLayer];
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"opened");
    
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
    output = [[AVCapturePhotoOutput alloc] init];
    [session addOutput:output];
   
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
    
    AVCapturePhotoSettings *settings = [[AVCapturePhotoSettings alloc]init];
    settings.flashMode =  AVCaptureFlashModeAuto ;
    [output capturePhotoWithSettings:settings delegate:self];
    
    NSLog(@"Pressed");
    
}
-(void)captureOutput:(AVCapturePhotoOutput *)captureOutput didFinishProcessingPhotoSampleBuffer:(CMSampleBufferRef)photoSampleBuffer previewPhotoSampleBuffer:(CMSampleBufferRef)previewPhotoSampleBuffer resolvedSettings:(AVCaptureResolvedPhotoSettings *)resolvedSettings bracketSettings:(AVCaptureBracketedStillImageSettings *)bracketSettings error:(NSError *)error
{
    if (error) {
        NSLog(@"error : %@", error.localizedDescription);
    }
    
    if (photoSampleBuffer) {
        NSData *data = [AVCapturePhotoOutput JPEGPhotoDataRepresentationForJPEGSampleBuffer:photoSampleBuffer previewPhotoSampleBuffer:previewPhotoSampleBuffer];
        UIImage *image = [UIImage imageWithData:data];
        imageShowViewController *imageController = [[ imageShowViewController alloc]init];
        imageController.imageToSend = image;
        [self presentViewController:imageController animated:YES completion:nil];

    }
}

@end
