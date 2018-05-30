//
//  OCTypes.h
//  ownCloudSDK
//
//  Created by Felix Schwarz on 06.02.18.
//  Copyright © 2018 ownCloud GmbH. All rights reserved.
//

/*
 * Copyright (C) 2018, ownCloud GmbH.
 *
 * This code is covered by the GNU Public License Version 3.
 *
 * For distribution utilizing Apple mechanisms please see https://owncloud.org/contribute/iOS-license-exception/
 * You should have received a copy of this license along with this program. If not, see <http://www.gnu.org/licenses/gpl-3.0.en.html>.
 *
 */

#ifndef OCTypes_h
#define OCTypes_h

typedef NSString* OCPath; //!< NSString representing the path relative to the server's root directory.

typedef NSString* OCFileID; //!< Unique identifier of the item on the server (persists over lifetime of file, incl. across modifications) (files only)
typedef NSString* OCFileETag; //!< Identifier unique to a specific combination of contents and metadata. Can be used to detect changes. (files and folders)

typedef id OCDatabaseID; //!< Object referencing the item in the database (OCDatabase-specific).

typedef NSNumber* OCSyncAnchor; //!< Sync Anchor (running number, increasing in value with every change made)

typedef void(^OCCompletionHandler)(id sender, NSError *error);

typedef void(^OCConnectionAuthenticationAvailabilityHandler)(NSError *error, BOOL authenticationIsAvailable);

#endif /* OCTypes_h */
