//
//  RWTViewController.m
//  HelloOpenGL
//
//  Created by Main Account on 3/18/14.
//  Copyright (c) 2014 Razeware LLC. All rights reserved.
//

#import "RWTViewController.h"
#import "RWTVertex.h"
#import "RWTBaseEffect.h"
#import "RWTTestScene.h"

@interface RWTViewController ()

@end

// CHANGE: Simplified view controller

@implementation RWTViewController {
  RWTBaseEffect *_shader;
  RWTTestScene *_scene;
}

- (void)setupScene {
  _shader = [[RWTBaseEffect alloc] initWithVertexShader:@"RWTSimpleVertex.glsl" fragmentShader:@"RWTSimpleFragment.glsl"];
  _scene = [[RWTTestScene alloc] initWithShader:_shader];
  _shader.projectionMatrix = GLKMatrix4MakePerspective(GLKMathDegreesToRadians(85.0), self.view.bounds.size.width / self.view.bounds.size.height, 1, 150);
}

- (void)viewDidLoad
{
  [super viewDidLoad];
	GLKView *view = (GLKView *)self.view;
  view.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
  view.drawableDepthFormat = GLKViewDrawableDepthFormat16;
  
  [EAGLContext setCurrentContext:view.context];
  
  [self setupScene];
  
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
  glClearColor(0, 104.0/255.0, 55.0/255.0, 1.0);
  glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
  glEnable(GL_DEPTH_TEST);
  glEnable(GL_CULL_FACE);
  glEnable(GL_BLEND);
  glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
  
  GLKMatrix4 viewMatrix = GLKMatrix4Identity;
  [_scene renderWithParentModelViewMatrix:viewMatrix];
  
}

- (void)update {
  [_scene updateWithDelta:self.timeSinceLastUpdate];
}

@end
