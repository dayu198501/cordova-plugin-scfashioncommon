//
//  CDVCommonPlugin.m
//  Scfashion
//
//  Created by MAC_DAYU on 15/10/21.
//
//

#import "CDVCommonPlugin.h"
#import "APService.h"

@implementation CDVCommonPlugin

@synthesize callbackID;


const  NSString * PHONE_NUM = @"phonenum";
const  NSString * GUID = @"guid";

-(void)login:(NSMutableArray*)arguments;
{
    
    // 这是classid,在下面的PluginResult进行数据的返回时,将会用到它
    //self.callbackID = [arguments pop];
    
    // 得到Javascript端发送过来的字符串
    //NSString *stringObtainedFromJavascript = [arguments objectAtIndex:0];
    
    // 创建我们要返回给js端的字符串
    NSMutableString *stringToReturn = [NSMutableString stringWithString: @"我是返回的:"];
    
    //[stringToReturn appendString: stringObtainedFromJavascript];
    
    // Create Plugin Result
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString: stringToReturn];
    
    NSLog(@ "%@",stringToReturn);
    
    // 检查发送过来的字符串是否等于"HelloWorld",如果不等,就以PluginResult的Error形式返回
    //if ([stringObtainedFromJavascript isEqualToString:@"HelloWorld"] == YES){
    // Call the javascript success function
    [self writeJavascript: [pluginResult toSuccessCallbackString:self.callbackID]];
    //} else{
    // Call the javascript error function
    //   [self writeJavascript: [pluginResult toErrorCallbackString:self.callbackID]];
    //}
}

- (void) nativeFunction:(NSMutableArray*)arguments withDict:(NSMutableDictionary*)options;
{
    
    // 这是classid,在下面的PluginResult进行数据的返回时,将会用到它
    self.callbackID = [arguments pop];
    
    // 得到Javascript端发送过来的字符串
    NSString *stringObtainedFromJavascript = [arguments objectAtIndex:0];
    
    // 创建我们要返回给js端的字符串
    NSMutableString *stringToReturn = [NSMutableString stringWithString: @"我是返回的:"];
    
    [stringToReturn appendString: stringObtainedFromJavascript];
    
    // Create Plugin Result
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString: stringToReturn];
    
    NSLog(@ "%@",stringToReturn);
    
    // 检查发送过来的字符串是否等于"HelloWorld",如果不等,就以PluginResult的Error形式返回
    if ([stringObtainedFromJavascript isEqualToString:@"HelloWorld"] == YES){
        // Call the javascript success function
        [self writeJavascript: [pluginResult toSuccessCallbackString:self.callbackID]];
    } else{
        // Call the javascript error function
        [self writeJavascript: [pluginResult toErrorCallbackString:self.callbackID]];
    }
}

- (void)myMethod:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    NSString* myarg = [command.arguments objectAtIndex:0];
    // Retrieve the date String from the file via a utility method
    NSString *dateStr = [command.arguments objectAtIndex:0];
    
    // Create an object that will be serialized into a JSON object.
    // This object contains the date String contents and a success property.
    NSDictionary *jsonObj = [ [NSDictionary alloc]
                             initWithObjectsAndKeys :
                             dateStr, @"dateStr",
                             @"true", @"success",
                             nil
                             ];
    
    // Create an instance of CDVPluginResult, with an OK status code.
    // Set the return message as the Dictionary object (jsonObj)...
    // ... to be serialized as JSON in the browser
    CDVPluginResult *pluginResult1 = [ CDVPluginResult
                                      resultWithStatus    : CDVCommandStatus_OK
                                      messageAsDictionary : jsonObj
                                      ];
    
    if (myarg != nil) {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:myarg];
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"abc"];
    }
    [self.commandDelegate sendPluginResult:pluginResult1 callbackId:command.callbackId];
}

- (void)getUserInfo:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    @try {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *guid=[defaults objectForKey:GUID];
        NSString *phonenum = [defaults objectForKey:PHONE_NUM];
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        NSString *appCurVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
        NSString *registrationID = [APService registrationID];
        
        
        // Create an object that will be serialized into a JSON object.
        // This object contains the date String contents and a success property.
        NSDictionary *jsonObj = [ [NSDictionary alloc]
                                 initWithObjectsAndKeys :
                                 guid, @"guid",
                                 phonenum, @"phonenum",
                                 registrationID,@"registrationID",
                                 appCurVersion,@"appCurVersion",
                                 nil
                                 ];
        
        // Create an instance of CDVPluginResult, with an OK status code.
        // Set the return message as the Dictionary object (jsonObj)...
        // ... to be serialized as JSON in the browser
        pluginResult = [ CDVPluginResult resultWithStatus    : CDVCommandStatus_OK
                                         messageAsDictionary : jsonObj
                        ];
    }
    @catch (NSException *exception) {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
        NSLog(@"Method %@", @"getUserInfo Error");
    }
    @finally {
        
    }
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    NSLog(@"Method %@", @"getUserInfo");
}

- (void)setUserInfo:(CDVInvokedUrlCommand *)command
{
    CDVPluginResult* pluginResult = nil;
    NSDictionary* obj = [command.arguments objectAtIndex:0];
    NSString* phonenum = [obj objectForKey:@"phone"];
    NSString* guid = [obj objectForKey:@"guid"];
    
    @try {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:phonenum forKey:PHONE_NUM];
        [defaults setObject:guid forKey:GUID];
        [defaults synchronize];
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    }
    @catch (NSException *exception) {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
    }
    @finally {
        //
    }
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

-(void)log:(CDVInvokedUrlCommand *)command
{
    CDVPluginResult* pluginResult = nil;
    NSDictionary* obj = [command.arguments objectAtIndex:0];
    NSString* info = [obj objectForKey:@"info"];
    NSLog(@"HTML %@", info);
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

-(void)clearUserInfo:(CDVInvokedUrlCommand *)command
{
    CDVPluginResult* pluginResult = nil;
    @try {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:@"" forKey:PHONE_NUM];
        [defaults setObject:@"" forKey:GUID];
        [defaults synchronize];
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    }
    @catch (NSException *exception) {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
    }
    @finally {
        //
    }
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

-(void)openNewPage:(CDVInvokedUrlCommand *)command
{
    CDVPluginResult* pluginResult = nil;
    NSDictionary* obj = [command.arguments objectAtIndex:0];
    NSString* page = [obj objectForKey:@"page"];
    NSLog(@"HTML %@", page);
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:page]];
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)getVersionAndRegistrationID:(CDVInvokedUrlCommand*)command;
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *appCurVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    NSString* registrationID = [APService registrationID];
    CDVPluginResult* pluginResult = nil;
    @try {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *guid=[defaults objectForKey:GUID];
        
        // Create an object that will be serialized into a JSON object.
        // This object contains the date String contents and a success property.
        NSDictionary *jsonObj = [ [NSDictionary alloc]
                                 initWithObjectsAndKeys :
                                 @"902",@"Command",
                                 guid, @"GUID",
                                 registrationID,@"REGISTRATION_ID",
                                 appCurVersion,@"Version",
                                 @"",@"EncryptKey",
                                 @"IOS",@"Model",
                                 nil
                                 ];
        
        // Create an instance of CDVPluginResult, with an OK status code.
        // Set the return message as the Dictionary object (jsonObj)...
        // ... to be serialized as JSON in the browser
        pluginResult = [ CDVPluginResult resultWithStatus    : CDVCommandStatus_OK
                                         messageAsDictionary : jsonObj
                        ];
    }
    @catch (NSException *exception) {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
    }
    @finally {
        
    }
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}
@end
