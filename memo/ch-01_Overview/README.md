# Provider Overview

## 1. 프로바이더? 
- 상태관리 (State Management)

- 위젯트리상 불필요한 Inversion of control(함수는 정의하지만 실행은 다른 위젯에서 실행하는 현상)이 많아진다. 


```dart

 Provider({
    Key? key,
    required Create<T> create, 
    Dispose<T>? dispose,
    bool? lazy,
    TransitionBuilder? builder,
    Widget? child,
  })

```

- create에 전달하는 함수가 return 하는 오브젝트르 하위 위젯들이 접근 가능하다.

## 2. Provider 없이 state를 관리
- 굉장히 불필요하게 값을 전달해줘야 한다.
- 위젯트리가 깊어질수록 불필요하고 어느 위젯에서 값을 바꾸었는지 알 수가 없다.


## 3. Dependency Injection
- 오브젝트를 위젯트리 상에서 쉽게 엑세스 하게 해주는 것 
- **BLOC : Business LOgic Component**

- 공통적으로 속한 Ancestor 위젯에 Provider를 생성
- Provider 또한 위젯

- `${Provider.of<Dog>(context).name}` : context를 받아 상위 위젯으로 올라가며, Provider에서 Dog 타입의 인스턴스를 찾고 프로퍼티를 가져온다

- `Provider.of<Dog>(context, listen: false).grow();` : 버튼은 어떤 값이 변한다고 해도 다시 그려질 필요가 없으니 listen : false를 줘서 rebuild를 막는다


## 4. ChangeNotifier
- A class that can be extended or mixed in that provides a change notification API using VoidCallback for notofication

- `notifyListeners(); ` : ChangeNotifier 내의 데이터에 변동이 생겼을 때 ChangeNotifier를 Listen하고 있는 모든 오브젝트에 변동사항을 알려준다.
- `addListener( (){} ) ` : notifyListeners()가 호출되면 실행할 함수 
- Listener는 자동으로 dispose 되지 않기 때문에 수동으로 dispose 해주어야 한다. `removeListener()`

![image](https://user-images.githubusercontent.com/61898890/165437487-6819e630-82fb-4004-8420-53b23eb7006c.png)

- ChangeNotifier를 사용하면 인스턴스를 전달해줘야 하고, UI를 수동으로 그려줘야 하는 불편함이 있다.

- 이걸 해소하기 위해 나온 것이 **changeNotifierProvider**

![image](https://user-images.githubusercontent.com/61898890/165440168-8408b328-1a18-4254-bfec-78d59da21d20.png)


## 5. ChangeNotifierProvider
- 1. Create an instance of ChangeNotifier
- 2. Provide an easy way to access ChangeNotifier for widgets that need it, and rebuilds the UI if necessary

## 6. extension methodes
### 1) read
-  ` context.read<T>() -> T ` 
- Obtain a value from the nearese ancestor provider of type T : 가장 가까운 T 타입의 프로바이더를 찾는다.
- `Provider.of<T>(context,listen: false)
- 값을 읽어오기만 하고, Nofitifier를 호출하는 코드가 있어야 다시 rebuild를 진행한다.
- 변화를 listen하지 않는다. 

### 2) watch
- `context.watch<T>() -> T `
- Obtain a value from the nearest ancestor provider of type T, and subscribe to the provider : 가장 가까운 T 타입의 프로바이더를 return 하고, value change를 listen한다.
- `Provider.of<T>(context)` 
- **오브젝트 중 하나의 내용이라도 변하면 전체가 rebuild **

### 3) select 
- `context.select<T,R>(R selecttor(T value)) -> R`
- Watch a value of type T exposed from a provider, and listen only partially to changes  : 프로퍼티를 많이 가지고 있는 오브젝트의 특정 프로퍼티의 변화만 listen하고 싶을 때  사용
- listen 하고 싶은 것만 선별적으로 listen
- `context.select<Dog, String> ((Dog dog) => dog.name) : name이 변할 때만 rebuilding

## 7. MultiProvider

![image](https://user-images.githubusercontent.com/61898890/165442246-b3f5ca1a-68d7-4b2c-9fb6-02b98a4b87ed.png)


## 8. FutureProvider 
- 연속된 값으로 계속 리빌드 할 때는 Stream이 나을 수도 있다
- Future에 대해 try~catch를 작성

```dart

FutureProvider(
 Key? key,
 required Create<Future<T>?> create,
 required T initialData
),

```

- FutureProvider는 Future의 return value를 타입으로 가진다. 작성한 코드에서는 Future<int> 타입 


## 9. StreamProvider
 
 
 ```dart
 StreamProvider(
 Key? key,
 required Create<Future<T>?> create,
 required T initialData
),
```

- 만약 Provider에서 create에서 다른 데이터를 watch로 읽어와 사용한다면? `Tried to listen to an InheritedWidget in a life-cycle that will never be called again.` 에러 발생
- creat는 한 번만 호출되기 때문에 논리적으로도 맞지 않다


## 10. Consumer
- Obtains Provider<T> from its ancestors and passes its value to builder 
- The Consumer widget doesn't do any fancy work. it just class Provider.of in a new widget and delegats its build implementation to builder : 새로운 위젯에서 Provider.of를 호출하고 위젯의 build 구현을 builder에 위임한다 
- builder must not be null and may be called multiple times(such as when the provided value changes) 
- 모든 위젯을 새로 그린다? -> builder에 Nullable한 파라미터가 있어 특정 위젯을 build에서 제외시킬 수 있다. 
 
```dart
 
 Consumer(
  Key? key,
  required Widget builder(BuildContext context, T value, Widget? child),
 }
 
``` 
 


```dart

Consumer<Dog4>(
        builder: (BuildContext context, Dog4 dog, Widget? child) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                child!,
                SizedBox(height: 10.0,),
                Text(
                  '- name: ${dog.name}',
                  style: TextStyle(fontSize: 20.0),
                ),
                SizedBox(
                  height: 10.0,
                ),
                BreedAndAge(),
              ],
            ),
          );
        },
        child: Text(
          'I like dogs very much',
          style: TextStyle(fontSize: 20.0),
        ),
      ),
 
```

- child를 직접 지정해줌으로써 rebuild를 방지한다. Column 내에 Provider.of와는 무관한 위젯들이 있을 때 rebuild를 방지하기 위해 사용한다. 










































