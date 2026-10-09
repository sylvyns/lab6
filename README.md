# Laboratory work 6 — flutter_bloc + HTTP + JSON

Приложение загружает посты с https://jsonplaceholder.typicode.com/posts и показывает их списком (title + body).
Во время загрузки — `CircularProgressIndicator`, при ошибке — сообщение и кнопка «Повторить».

## Структура

```
lib/
├── main.dart                          # MaterialApp, home: PostPage
├── models/
│   ├── get_posts.dart                 # модель Posts (@JsonSerializable)
│   └── get_posts.g.dart               # сгенерированный код (fromJson/toJson)
└── post/
    ├── posts_page.dart                # экран PostPage
    ├── bloc/
    │   ├── post_bloc.dart
    │   ├── post_event.dart
    │   └── post_state.dart
    └── repository/
        └── post_repository.dart       # HTTP-запрос к API
```

## Как запустить

1. Распакуйте архив и откройте папку `lab6` в терминале.
2. Создайте платформенные папки (android, ios, web и т.д.) — название проекта уже указано в pubspec.yaml:
   ```
   flutter create .
   ```
3. Установите зависимости:
   ```
   flutter pub get
   ```
4. (Необязательно, `get_posts.g.dart` уже лежит в проекте) Перегенерировать сериализацию:
   ```
   dart run build_runner build --delete-conflicting-outputs
   ```
5. Запустите:
   ```
   flutter run
   ```

Для Android в release-сборке проверьте, что в `android/app/src/main/AndroidManifest.xml` есть
`<uses-permission android:name="android.permission.INTERNET"/>`.
