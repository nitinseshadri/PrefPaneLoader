//
//  PrefPaneLoaderPrefPane.m
//  PrefPaneLoaderPrefPane
//
//  Created by Nitin Seshadri on 2/22/22.
//

#import "PrefPaneLoaderPrefPane.h"

@implementation PrefPaneLoaderPrefPane

- (BOOL)respondsToSelector:(SEL)aSelector {
    NSLog(@"[PPL] Host process is checking if pane responds to selector: %@", NSStringFromSelector(aSelector));
    
    return [super respondsToSelector:aSelector];
}

- (id)performSelector:(SEL)aSelector {
    NSLog(@"[PPL] Host process wants to perform selector: %@", NSStringFromSelector(aSelector));
    
    return [super performSelector:aSelector];
}

- (id)performSelector:(SEL)aSelector withObject:(id)object1 {
    NSLog(@"[PPL] Host process wants to perform selector: %@ , with object: %@", NSStringFromSelector(aSelector), [object1 className]);
    
    return [super performSelector:aSelector withObject:object1];
}

- (id)performSelector:(SEL)aSelector withObject:(id)object1 withObject:(id)object2 {
    NSLog(@"[PPL] Host process wants to perform selector: %@ , with object: %@ , with object: %@", NSStringFromSelector(aSelector), [object1 className], [object2 className]);
    
    return [super performSelector:aSelector withObject:object1 withObject:object2];
}

@end
