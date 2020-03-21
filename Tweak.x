// GetFree - Changes the App Store's "GET" text to "Free"
// By mac-user669

// Based off Stonks by Skitty

static BOOL enabled = YES;

NSString *GetToFree(NSString *origString) {
	NSString *newString = [origString stringByReplacingOccurrencesOfString:@"GET" withString:@"Free"];
	return newString;
}
NSAttributedString *attributedGetToFree(NSAttributedString *origString) {
	NSMutableAttributedString *newString = [origString mutableCopy];
	while ([newString.mutableString containsString:@"GET"]) {
        NSRange range = [newString.mutableString rangeOfString:@"GET"];
		NSMutableAttributedString *replaceString = [[NSMutableAttributedString alloc] initWithString:@"Free"];
		[newString enumerateAttributesInRange:range options:0 usingBlock:^(NSDictionary<NSAttributedStringKey, id> *attrs, NSRange range, BOOL *stop) {
			[replaceString addAttributes:attrs range:NSMakeRange(0, replaceString.length)];
		}];
        [newString replaceCharactersInRange:range withAttributedString:replaceString];
    }
	return [newString copy];
}

// Actual hook
%hook UILabel
- (void)setText:(NSString *)text {
	if (enabled) {
		text = GetToFree(text);
	}
	%orig(text);
}
- (void)setAttributedText:(NSAttributedString *)attributedText {
	if (enabled) {
		attributedText = attributedGetToFree(attributedText);
	}
	%orig(attributedText);
}
%end
