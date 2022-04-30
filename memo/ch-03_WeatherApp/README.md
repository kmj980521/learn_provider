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
