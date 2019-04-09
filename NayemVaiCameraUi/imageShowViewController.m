//
//  imageShowViewController.m
//  NayemVaiCameraUi
//
//  Created by Tawhid Joarder on 4/9/19.
//  Copyright © 2019 Tawhid Joarder. All rights reserved.
//

#import "imageShowViewController.h"

@interface imageShowViewController (){

}


@end

@implementation imageShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _imageThatCaptured.image = self.imageToSend;
    // Do any additional setup after loading the view from its nib.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
