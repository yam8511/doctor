void main() {
  const name = '小屁孩'; // name = 名字
  double sale = 8.5; // sale = 折扣
  var flower = '金針花'; // flower = 花
  int price = 100; // price = 價格
  bool flowerIsExpensive = true; // flower Is Expensive = 鮮花很昂貴
  String display; // display = 顯示

  display = '我是 ${name}， ' // ${ } 用來塞入資料
      '今天拜拜需要買鮮花供奉，花店有賣金針花、玉蘭花。\n' // \n 是換行
      '另外，今天是中元普渡，所以店裡有優惠活動: 一律打 ${sale} 折。\n';

  if (flowerIsExpensive) {
    // if = 如果  <--- 整句就是 「如果鮮花很昂貴」
    // display = display + 就是把新的文字加到原先的句子後面
    display = display + '因為 ${flower} 賣${price}元很貴，所以不買。\n';
  } else {
    // else = 否則
    display = display + '因為 ${flower} 賣${price}元很便宜，所以決定買1束。\n';
  }

  /**
   * if (是或不是) {
   *    ...
   * } else {
   *    ...
   * }
   * 以上整句的意思就是：
   * 如果鮮花很昂貴的話，不買
   * 否則的話(表示不貴)，就買
   */

  flower = '玉蘭花';
  price = 50;
  flowerIsExpensive = false;

  if (flowerIsExpensive) {
    // if = 如果  <--- 整句就是 「如果鮮花很昂貴」
    // display += 就是 display = display +
    display += '因為 ${flower} 賣${price}元很貴，所以仍然不買。\n';
  } else {
    // else = 否則
    display += '因為 ${flower} 賣${price}元很便宜，所以決定買1束了。\n';
  }

  final total = price * sale / 10; // total = 總共
  display += '所以最後總共花了 ${total} 元。\n';

  print(display);

  /**
   * -------------
   * 以上專業術語介紹
   * -------------
   * const = 固定不能改的資料 (如果不需要計算的資料放這個)
   * final = 最後的資料，也不能改 (如果有需要計算的資料放這個)
   * var = 自動偵測資料型態
   * int = 整數
   * double = 小數點
   * String = 文字
   * bool = 是不是, true = 是, false = 不是
   */
}
