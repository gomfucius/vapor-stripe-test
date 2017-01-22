# VaporStripe
💰 Stripe API for Vapor Swift

Add to your `Package.swift`

```swift
.Package(url:"https://github.com/gomfucius/vapor-stripe.git", majorVersion: 0, minor: 1)
```

```swift
import VaporStripe

...

let stripe = VaporStripe(apiKey: "sk_test_...", token: "sometoken", amount: 99, currency: .usd, description: "My description")
let response = try stripe.charge()
```

Enjoy :)

