# cinemapedia

# Dev

1. Copy .env.template and rename it as .env
2. Change the env variable "The MovieDB"
3. When changing entities, run command:
```
dart run build_runner build
```

# Prod
Change app name
```
flutter pub run change_app_package_name:main com.new.package.name
```

Change app icon
```
flutter pub run flutter_launcher_icons
```

Change splash screen
```
dart run flutter_native_splash:create
```