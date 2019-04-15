//
//  SchedulesByStopCall.m
//  BostonTMap
//
//  Created by Elliot Schrock on 4/24/18.
//

#import "SchedulesByStopCall.h"
#import "NSDate+RelativeTime.h"

@implementation SchedulesByStopCall

- (NSString *)endpoint
{
    return @"schedules";
}

- (NSString *)getParams {
    NSString *params = super.getParams;
    NSString *timeFilters = [self timeFilters];
    return [NSString stringWithFormat:@"%@include=trip,route&%@&", params, timeFilters];
}

- (NSString *)timeFilters {
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"HH:mm";
    NSString *nowString = [BaseNetworkCall timeStringFrom:[formatter stringFromDate:[NSDate date]]];
    NSString *laterString = [formatter stringFromDate:[[NSDate date] incrementUnit:NSMinuteCalendarUnit by:20]];
    return [NSString stringWithFormat:@"filter[min_time]=%@", nowString/*, laterString*/];//&filter[max_time]=%@
}

- (void)configure
{
    [super configure];
    self.httpMethod = @"GET";
}

@end