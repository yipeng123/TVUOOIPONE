//
//  DeviceInfo.m
//  gameUI
//
//  Created by xubo on 6/6 星期五.
//  Copyright (c) 2014年 yibin chen. All rights reserved.
//
//
//#import "DeviceInfo.h"
//
//@implementation DeviceInfo
//+ (NSString*) getDeviceName
//{
//    UIDevice *device = [[UIDevice alloc] init];
////    NSLog(@"设备所有者的名称－－%@",device_.name);
////    NSLog(@"设备的类别－－－－－%@",device_.model);
////    NSLog(@"设备的的本地化版本－%@",device_.localizedModel);
////    NSLog(@"设备运行的系统－－－%@",device_.systemName);
////    NSLog(@"当前系统的版本－－－%@",device_.systemVersion);
////    NSLog(@"设备识别码－－－－－%@",device_.identifierForVendor.UUIDString);
//    return device.name;
//}
//
//+ (NSString*) getMac
//{
//
//    int                    mib[6];
//	size_t                len;
//	char                *buf;
//	unsigned char        *ptr;
//	struct if_msghdr    *ifm;
//	struct sockaddr_dl    *sdl;
//	
//	mib[0] = CTL_NET;
//	mib[1] = AF_ROUTE;
//	mib[2] = 0;
//	mib[3] = AF_LINK;
//	mib[4] = NET_RT_IFLIST;
//	
//	if ((mib[5] = if_nametoindex("en0")) == 0) {
//		printf("Error: if_nametoindex error/n");
//		return NULL;
//	}
//	
//	if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
//		printf("Error: sysctl, take 1/n");
//		return NULL;
//	}
//	
//	if ((buf = malloc(len)) == NULL) {
//		printf("Could not allocate memory. error!/n");
//		return NULL;
//	}
//	
//	if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
//		printf("Error: sysctl, take 2");
//		return NULL;
//	}
//	
//	ifm = (struct if_msghdr *)buf;
//	sdl = (struct sockaddr_dl *)(ifm + 1);
//	ptr = (unsigned char *)LLADDR(sdl);
//	// NSString *outstring = [NSString alloc] initWithFormat:@"%02x:%02x:%02x:%02x:%02x:%02x", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
//	NSString *outstring = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
//	free(buf);
//	return [outstring uppercaseString];   
//}
//@end
