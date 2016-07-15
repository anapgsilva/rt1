//
//  sceneController.m
//  rt1
//
//  Created by Stock Lab on 8/05/2014.
//  Copyright (c) 2014 a. All rights reserved.
//

#import "sceneController.h"
#import "vector_ops.h"
#import "cameraObject.h"
#import "sceneLoader.h"
#import "renderManager.h"
#import "randomNumberGenerator.h"
#import "colourPalette.h"

@interface sceneController () {
    renderManager *r;
    NSMutableArray *holdObjects;
}

@property (nonatomic, strong) renderManager *r;
@property (nonatomic, strong) NSMutableArray *holdObjects;

@end

@implementation sceneController

@synthesize camera, world;
@synthesize r;
@synthesize ambient_light, num_lights;
@synthesize imageSize;
@synthesize holdObjects;

- (LightSourceDef *) light_sources {
    return light_sources;
}

- (void)initScene {
    
    self.holdObjects = [NSMutableArray arrayWithCapacity:0];
    
    imageSize.width = kImageWidth;
    imageSize.height = kImageHeight;
    
    //Camera setup
    Vector viewOrigin, lookAtPoint, upOrientation;
    viewOrigin.x = 0;
    viewOrigin.y = 0;
    viewOrigin.z = -500;
    lookAtPoint.x = lookAtPoint.y = lookAtPoint.z = 0.0;
    lookAtPoint.w = 1.0;
    lookAtPoint.y = 0;
    
    upOrientation.x = upOrientation.z = upOrientation.w = 0.0;
    upOrientation.y = 1.0;
    
    self.camera = [[cameraObject alloc] initWithCameraOrigin:viewOrigin lookAt:lookAtPoint upOrientation:upOrientation windowSize:imageSize viewWidth:30 lensLength:40 aperture:0 focalLength:600];

    camera.hazeStartDistanceFromCamera = 1300;
    camera.hazeLength = 300;
    cl_float4 hazeC;
    hazeC.x = hazeC.y = hazeC.z = 0.5; hazeC.w = 0.01;
    camera.hazeColour = hazeC;
    camera.clipPlaneDistanceFromCamera = 1000;
    camera.clipPlaneEnabled = NO;
    
    //Lights setup
    num_lights = 1;
    
    light_sources[0].position.x = 0;
    light_sources[0].position.y = 0;
    light_sources[0].position.z = -500;
    light_sources[0].position.w = 1;
    light_sources[0].colour.red = 0.70;
    light_sources[0].colour.green = 0.70;
    light_sources[0].colour.blue = 0.70;

    ambient_light.red = 0.1;
    ambient_light.green = 0.1;
    ambient_light.blue = 0.1;

    //Scene setup
    initColours();

    NSLog(@"Loading data...");
    self.world = [[[sceneLoader alloc] init] loadScene];
    NSLog(@"Finished - %d atoms, %d scene lights", world.numModelData, world.numIntrinsicLights);
    
}


- (void)sceneManagementForFrame:(int)f {


}

@end