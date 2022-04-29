# TODO

![image](https://user-images.githubusercontent.com/61898890/165878504-f8456a45-0853-4c10-9f79-5e177a39ae94.png)

- State Pattern

![image](https://user-images.githubusercontent.com/61898890/165912810-9a71ea32-d7b6-4528-9542-360db3572741.png)


## 1. Provider를 효율적이게 사용하는 방법
1. State는 가급적 atomic 하게 만든다. 논리적으로 분리할 수 있으면 별도의 state로 만들어서 관리
2. State는 주로 class 형태로 관리하고 논리적으로 연관된 값들을 묶어서 관리한다. 또한, String, int 등 primitive type 변수도 class화 해서 관리해 type 충돌을 피한다.
3. Immutable state를 만들고 copyWith 함수를 사용해 새로운 state를 만든다.
4. Awlays extends Equatable class를 만들어 Object instance들의 equality check를 쉽게 하고 stringify 등의 편의 함수를 제공한다.

## 2. 단순한 스트링도 클래스로 관리하는 이유
- 1. 모든 State를 다루는 데에 있어서 일관성을 다룰 수 있다. 
- 2. 타입의 충돌을 피할 수 있다. 

```dart

class TodoSearchState extends Equatable{
  final String searchTerm;

  TodoSearchState({ required this.searchTerm});

  factory TodoSearchState.initial(){
    return TodoSearchState(searchTerm: '');
  }

  @override
  List<Object> get props => [searchTerm];

  @override
  bool get stringify => true;

  TodoSearchState copyWith({String? searchTerm}){
    return TodoSearchState(searchTerm: searchTerm ?? this.searchTerm);
  }

}

```

## 3. Stringify
- true를 설정함으로써 debug를 유용하게 할 수 있다. 

![image](https://user-images.githubusercontent.com/61898890/165887366-612b3c74-ebe4-4afd-b24e-b63a92f5d45a.png)


## 4. states

- Independent States : ChangeNotifierProvider
- Computed States : ChangeNotifierProxyProvider, ProxyProvider


## 5. Provider Manual
- Prefer using ProxyProvider when possible. If the created object is only a combination of other objects, without http calls or similar side-effects, then it is likely that an immutable object built using ProxyProvider will work



## 6. StateNotifierProvider
- ProxyProvider를 사용할 필요가 없다
- Riverpod에서 널리 쓰이고 있는 방식



## 7. LocatorMixin

- ProxyProvider를 만들지 않고 read(), watch()를 사용하기 위해서 LocatorMixin을 with 한다.
- 타입 지정을 할 필요가 없어진다.


```dart

// ProxyProvider를 안 만들고 read, watch를 사용하기 위해서 LocatorMixin을 with 한다.
class Counter extends StateNotifier<CounterState> with LocatorMixin{
  Counter(): super(CounterState(counter: 0));

  void increment(){
    Color currentColor = read<BgColor>().state.color;
    if(currentColor == Colors.black){
      state = state.copyWith(counter: state.counter + 10);
    }
    else if(currentColor == Colors.red){
      state = state.copyWith(counter: state.counter - 10);
    }
    else{
      state = state.copyWith(counter: state.counter + 1);
    }
  }
  // 다른 object의 update를 listening 할 수 있게 하고,
  // ProxyProvider가 provider에 하는 것과 동일하다.
  // flutter 외부에서도 사용할 수 있고, 위젯트리 밖에서도 사용할 수 있다.
  // 또한, 업데이트 함수 내에서는 read를 할 수 없고 update 함수의 argument를 이용한다.
  // object를 읽는 것 외에 변화를 watch 할 수 있다.
  @override
  void update(Locator watch) {
    super.update(watch);
  }
}

```

- ChangeNotifierProvider는 ChangeNotifier를 type으로 명시한다. 그러나 StateNotifierProvider는 2개의 타입을 명시한다. 
- **StateNotifier와 StateNotifier가 Handle하는 타입을 명시한다.**

- watch를 할 때 return 값은 state 그 자체를 return하기 때문에 코드가 더 간결해진다.

```dart

 @override
  Widget build(BuildContext context) {
    final colorState = context.watch<BgColorState>(); // state 자체를 return
    final counterState = context.watch<CounterState>();
    final levelState = context.watch<Level>();
}
```
- MultiProvider를 사용할 때는 선언하는 순서도 중요하다.








































