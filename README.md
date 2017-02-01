# VaporStripe

![Swift](http://img.shields.io/badge/swift-3.0.2-brightgreen.svg)
![Vapor](https://img.shields.io/badge/Vapor-1.3.11-brightgreen.svg)
[![Build Status](https://travis-ci.org/gomfucius/vapor-stripe.svg?branch=master)](https://travis-ci.org/gomfucius/vapor-stripe)
[![codecov.io](https://img.shields.io/codecov/c/github/gomfucius/vapor-stripe.svg)

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
