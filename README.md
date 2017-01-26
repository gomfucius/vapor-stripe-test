# VaporStripe
💰 Stripe API for Vapor Swift

Add to your `Package.swift`

```swift
.Package(url:"https://github.com/gomfucius/vapor-stripe.git", majorVersion: 0, minor: 2)
```

```swift
import VaporStripe

...

let stripe = VaporStripe(apiKey: "sk_test_...", token: "sometoken")
let result = try stripe.charge(amount: 99, currency: .usd, description: "My description")
```

Enjoy :)
