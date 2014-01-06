//
//  Session.h
//  
//
//  Created by Akash Aggarwal on 1/6/14.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Session : NSManagedObject

@property (nonatomic, retain) NSString * installerID;
@property (nonatomic, retain) NSString * lastDateTime;
@property (nonatomic, retain) NSString * sessionID;

@end
