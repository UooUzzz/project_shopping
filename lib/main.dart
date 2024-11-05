// io => input output
import 'dart:io';

// Product class는 상품의 이름과 가격을 담을 수 있는 class
class Product {
  String name;
  int price;

  Product(this.name, this.price);
}

// ShoppingMall class안에 Product class가 포함된 List가 있다(List에 초기값 설정)
// ShoppingMall class에는 따로 생성자가 없기 때문에 기본생성자를 사용한다
class ShoppingMall {
  List<Product> products = [
    Product('원피스', 500),
    Product('코트', 400),
    Product('구두', 300),
    Product('모자', 200),
    Product('양말', 100)
  ];
  int total = 0;

  // 판매하는 상품 목록을 볼 수 있는 기능
  //for-in 반복문으로 products에서 하나하나 뽑아서 변수 product에 넣어줌
  void showProducts() {
    for (final product in products) {
      print('${product.name} / ${product.price}원');
    }
  }

  // 구매자가 구매하고 싶은 상품들을 장바구니에 담을 수 있는 기능
  void addToCart() {
    print('상품 이름을 입력해 주세요 !'); //2를 입력하면 바로 보이는 문장
    String? name = stdin.readLineSync(); //readLineSync()를 이용해서 name 변수에 할당

    print('상품 개수를 입력해 주세요 !');
    String inputCount = stdin.readLineSync() ??
        ""; // ?? 앞부분이 null일때, ""를 반환해 주라는 의미 => 여기까지 상품이름과 상품개수를 입력받음

    // 2번기능의 조건은 try-catch 로
    try {
      Product product = products.firstWhere((product) => product.name == name);
      // 매개변수 product는 Product타입임. 위에 클래스의 리스트에서 products가 Product에 속하니까.

      int count = int.parse(inputCount);
      //위에 inputCount를 parse 사용해서 int로 변경한 후 count에 넣어준다는 의미

      // 입력한 상품의 이름이 상품목록에 있지 않거나, 상품의 개수가 0이하의 값이면 장바구니에 담기지 않는 조건 if else로
      if (count > 0) {
        total += (product.price *
            count); // 위에 ShoppingMall class에 있는 total임 => total이 장바구니의 총 가격임
        print('장바구니에 상품이 담겼어요 !');
      } else {
        print('0개보다 많은 개수의 상품만 담을 수 있어요 !');
      }
    } catch (error) {
      print('입력값이 올바르지 않아요 !');
      // try {} 안에 있는 걸 시도해본다는 의미. catch 시도하다가 에러가 난걸 잡음
      // print(error); 어디 어떤 에러인지 알 수 있음(사용자들에게 보여줄 필요가 없으니까 굳이 쓰지 않음)
    }
  }

  // 구매자가 장바구니에 담은 상품들의 총 가격을 볼 수 있는 기능
  void showTotal() {
    print('장바구니에 $total원 어치를 담으셨네요 !');
    // total은 위에서 모두 계산해줬으니까 print만 해주면 됨
  }
}

// ShoppingMall 이라는 class에 인스턴스를 만들어 준다
void main() {
  ShoppingMall shoppingMall = ShoppingMall();
  bool isTerminated = false;
  while (!isTerminated) {
    print("""
-------------------------------------------------------------------------------------------------
[1] 상품 목록 보기 / [2] 장바구니에 담기 / [3] 장바구니에 담긴 상품의 총 가격 보기 / [4] 프로그램 종료
-------------------------------------------------------------------------------------------------
""");
    // std => standard / in => input (Dart에서 표준으로 제공하는 input을 받을 수 있는 라이브러리)
    String? input = stdin.readLineSync();
    // 사용자 입력이 다음과 같다면

    switch (input) {
      case '1':
        //1을 입력했을 때 할 동작
        shoppingMall.showProducts();

      case '2':
        //2을 입력했을 때 할 동작
        shoppingMall.addToCart();

      case '3':
      //3을 입력했을 때 할 동작
        shoppingMall.showTotal();

      case '4':
      //4을 입력했을 때 할 동작
        print('이용해 주셔서 감사합니다 ~ 안녕히 가세요 !');
        isTerminated = true;   
        // 쇼핑몰 프로그램을 종료할 수 있는 기능
        // 여기서 바로 종료되는 것이 아니라 위에 while(!isTerminated)로 가서 조건을 검사하는데 isTerminated가 True니까 !는 반대니까 조건이 False가 되어서 종료됨
        // while 문은 조건이 True일때 계속되는 거임


      default:
        //case를 제외한 모든 경우에 실행될 코드가 같다면 default에 입력하면 된다
        print('지원하지 않는 기능입니다 ! 다시 시도해 주세요 ..');
    }
  }
}
