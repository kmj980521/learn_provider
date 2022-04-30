# Weather App

- ChangeNotifierProvider + ChangeNotifierProxyProvider
- ChangeNotifierProvider + ProxyProvider
- StateNotifierProvider

## App Flow

![image](https://user-images.githubusercontent.com/61898890/165972063-eb170731-6e39-4b69-bc3d-ce9babf0cc95.png)



## 1. State
- API에 대한 return 값을 JSON 타입으로 받을 수 있고, connection에 성공하면 status 값은 200을 return 한다.


## 2. 추가 사항

- 그냥 프로바이더는 데이터나 서비스를 공유하는 데에 편리하다

- `return temperature.toStringAsFixed(2) +'℃';` : 특정 double 값을 2자리로 고정시킨다. 

- 이미지를 네트워크에서 로딩하는 동안 다른 이미지 불러오기

```dart

return FadeInImage.assetNetwork(
        placeholder: 'assets/images/loading.gif',
        image: 'https://$kHost/static/img/weather/png/64/$abbr.png',
      width: 64,
      height: 64,
    );

```

## 3. StateNotifierProvider 
- main에서 PRovider를 선언할 때는 `StateNotifierProvider<프로바이더 클래스, 관리하는 타입> ( create: )` 로 호출한다.
- 자체적으로 **state**라는 것을 가진다.

```dart

// Main
StateNotifierProvider<WeatherProvider, WeatherState>(
          create: (context) => WeatherProvider(),
        ),

// Provier 정의
class WeatherProvider extends StateNotifier<WeatherState> with LocatorMixin {

  WeatherProvider() : super(WeatherState.initial());

  Future<void> fetchWeather(String city) async{
    state = state.copyWith(status: WeatherStatus.loading);
    try{
      final Weather weather = await weatherRepository.fetchWeather(city);
      state = state.copyWith(status: WeatherStatus.loaded,weather: weather);
    } on CustomError catch (e){
      state = state.copyWith(status: WeatherStatus.error, error: e);
    }
  }
}

```

## 4. Watch / Read
- Watch는 값이 변할 때마다 새로운 UI를 그려줄 때 사용한다.
- Read는 임시로 값을 읽어와 작업을 처리하고난 후에 사용할 때 불러준다.


## 5. 값 불러오기
- `context.watch<ThemeState>().appTheme` : 특정 State를 바로 접근가능하다.
