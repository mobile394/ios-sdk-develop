//
//  ownCloudSDK.h
//  ownCloudSDK
//
//  Created by Felix Schwarz on 05.02.18.
//  Copyright © 2018 ownCloud GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>

//! Project version number for ownCloudSDK.
FOUNDATION_EXPORT double ownCloudSDKVersionNumber;

//! Project version string for ownCloudSDK.
FOUNDATION_EXPORT const unsigned char ownCloudSDKVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <ownCloudSDK/PublicHeader.h>

#import <ownCloudSDK/OCTypes.h>

#import <ownCloudSDK/OCAppIdentity.h>

#import <ownCloudSDK/OCCore.h>
#import <ownCloudSDK/OCActivity.h>

#import <ownCloudSDK/OCBookmark.h>

#import <ownCloudSDK/OCAuthenticationMethod.h>
#import <ownCloudSDK/OCAuthenticationMethodOAuth2.h>

#import <ownCloudSDK/OCConnection.h>
#import <ownCloudSDK/OCConnectionRequest.h>
#import <ownCloudSDK/OCConnectionQueue.h>

#import <ownCloudSDK/OCEvent.h>
#import <ownCloudSDK/OCEventTarget.h>

#import <ownCloudSDK/OCVault.h>
#import <ownCloudSDK/OCDatabase.h>

#import <ownCloudSDK/OCQuery.h>
#import <ownCloudSDK/OCQueryFilter.h>
#import <ownCloudSDK/OCQueryChangeSet.h>

#import <ownCloudSDK/OCItem.h>

#import <ownCloudSDK/OCShare.h>

#import <ownCloudSDK/OCSyncRecord.h>
