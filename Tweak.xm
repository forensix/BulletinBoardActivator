#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

static int visible = 0;

%hook UIStatusBar

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{    
    %orig;

    Class $SBBulletinListController
    = objc_getClass("SBBulletinListController");
    id bulletinListController
    = [$SBBulletinListController sharedInstance];

    if (visible)
    {
        [bulletinListController hideListViewAnimated:YES];
        visible = NO;
    }
    else
    {
        [bulletinListController showListViewAnimated:YES];
        visible = YES;
    }
    
    UIWindow *window
    = [[UIApplication sharedApplication] keyWindow];
    
    UIView *view = [window viewWithTag:200];

    if (!view)
    {
        UIView *listView
        = [bulletinListController listView];
        listView.tag = 200;
        
        [window addSubview:listView];
    }
}

%end

/* How to Hook with Logos
Hooks are written with syntax similar to that of an Objective-C @implementation.
You don't need to #include <substrate.h>, it will be done automatically, as will
the generation of a class list and an automatic constructor.

%hook ClassName

// Hooking a class method
+ (id)sharedInstance {
	return %orig;
}

// Hooking an instance method with an argument.
- (void)messageName:(int)argument {
	%log; // Write a message about this call, including its class, name and arguments, to the system log.

	%orig; // Call through to the original function with its original arguments.
	%orig(nil); // Call through to the original function with a custom argument.

	// If you use %orig(), you MUST supply all arguments (except for self and _cmd, the automatically generated ones.)
}

// Hooking an instance method with no arguments.
- (id)noArguments {
	%log;
	id awesome = %orig;
	[awesome doSomethingElse];

	return awesome;
}

// Always make sure you clean up after yourself; Not doing so could have grave consequences!
%end
*/
