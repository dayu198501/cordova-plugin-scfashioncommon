//
//  CDVCommonPlugin.h
//  Scfashion
//
//  Created by MAC_DAYU on 15/10/21.
//
//

#import <Cordova/CDV.h>

@interface CDVCommonPlugin : CDVPlugin

@property (nonatomic, copy) NSString* callbackID;


//instance Method
-(void)login:(NSMutableArray*)arguments;

- (void) nativeFunction:(NSMutableArray*)arguments withDict:(NSMutableDictionary*)options;
-(void)initSession:(NSMutableArray*)arguments withDict:(NSMutableDictionary*)options;

- (void)myMethod:(CDVInvokedUrlCommand*)command;

- (void)getUserInfo:(CDVInvokedUrlCommand*)command;

- (void)setUserInfo:(CDVInvokedUrlCommand*)command;

- (void)getVersionAndRegistrationID:(CDVInvokedUrlCommand*)command;

- (void)log:(CDVInvokedUrlCommand*)command;

-(void)clearUserInfo:(CDVInvokedUrlCommand *)command;

-(void)openNewPage:(CDVInvokedUrlCommand *)command;

@end

