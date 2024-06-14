## Select state from a Provider

```dart
const classProvider = Provider.of<ProviderClass>(context)
```

With `classProvider` variable, we can do setters and getters

## Select colors from Theme Provider

```dart
Theme.of(context).colorScheme.<here_appears_all_colors>
```

## Go to a route

```dart
// go to route with no routes history
 context.go('/home')
 context.goNamed('/home')
// go to route and creates a new route in the navigation stack
 context.push('/home')
 context.pushNamed('/home')
 // go to route and the current in the navigation stack is replaced with the new route
 context.pushReplacement('/home')
 context.pushReplacementNamed('/home')
 // similar to above
 context.replace('/home')
 context.replaceNamed('/home')
 // Removes the current route from the navigation stack and returns to the previous route.
 context.pop()
```

## TODO

- [x] Set up routing
- [x] Set up Supabase in flutter
- [] Design, create tables in supabase
- [] Create classes for services and link it with providers
- [] Replace mock data with services
