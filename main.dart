import 'dart:convert';

import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;

void main() {
  // String url = 'wss://golar.herokuapp.com/wf/game?token=zz';
  String url = 'ws://localhost:8000/wf/game?token=zz';
  final channel = IOWebSocketChannel.connect(url);

  channel.stream.listen((message) {
    print(' => $message');
    Map r = jsonDecode(message);

    display(r);

    switch (r['action']) {
      case 'role_setup':
        setupRoles(channel, r);
        break;
      case 'select_number':
        selectNumber(channel, r);
        break;

      case 'take_rule':
        takeRule(channel, r);
        break;

      case 'change_room_master':
        changeRoomMaster(channel, r);
        break;

      case 'select_player':
        selectNumber(channel, r);
        break;

      case 'waiting':
        channel.sink.add(newTransfer('waiting', ''));
        break;

      case 'notify_skill':
        channel.sink.add(newTransfer('waiting', r['data']));
        break;

      case 'game_over':
        print(r);
        break;

      default:
        print('default');
        print(r['action']);
        print(r['sound']);
        print(r['display']);
        print(r['data']);
    }
  });

  print('Over');
}

void setupRoles(IOWebSocketChannel channel, Map r) {
  print('角色設定 => ${r['data']}');

  List combine = r['data']['combine'];
  Map rule = r['data']['rule'];
  print('組合 => $combine, 角色 => $rule');

  Map<String, List<String>> rules = {};
  for (var item in combine) {
    print('$item => ${item is String}');
  }

  rule.forEach((key, val) {
    print('$key => $val , ${key is String}, ${val is String}');
    if (rules[val] == null) {
      rules[val] = [];
    }

    rules[val].add(key);
  });

  print(rules);

  // 以下是給玩家輸入的資料
  var data = newTransfer(
      r['action'],
      jsonEncode({
        '平民': 1,
        '預言家': 1,
        '狼人': 1,
      }));

  channel.sink.add(data);
}

void selectNumber(IOWebSocketChannel channel, Map r) {
  print('選擇號碼 => ${r['data']}');

  List numbers = r['data'];
  for (var item in numbers) {
    print('$item => ${item is String}');
  }

  // 以下是給玩家輸入的資料
  var data = newTransfer(
    r['action'],
    '2',
  );

  channel.sink.add(data);
}

void takeRule(IOWebSocketChannel channel, Map r) {
  Map info = r['data'];
  int no = info['位子'];
  String kind = info['種族'];
  String rule = info['職業'];

  print("I'm $no, my rule is $rule, is $kind");
}

void changeRoomMaster(IOWebSocketChannel channel, Map r) {
  Map data = r['data'];
  bool gameStart = data['遊戲開始'];
  print('遊戲開始 $gameStart');

  // 以下是給玩家輸入的資料
  if (!gameStart) {
    var tf = newTransfer(
      r['action'],
      'start',
    );

    channel.sink.add(tf);
  }
}

void display(Map r) {
  String output;
  output = r['display'];
  if (output == '') {
    output = r['sound'];
  }

  print("${r['action']} : $output");
}

String newTransfer(String action, String reply) {
  return jsonEncode({
    'action': action,
    'reply': reply,
  });
}
