//
//  ViewController.h
//  NayemVaiCameraUi
//
//  Created by Tawhid Joarder on 4/8/19.
//  Copyright © 2019 Tawhid Joarder. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface ViewController : UIViewController{
    AVCaptureVideoPreviewLayer *previewLayer;
    UIView *myView;
    AVCaptureSession *session ;
    AVCapturePhotoOutput *output;
}
@end

