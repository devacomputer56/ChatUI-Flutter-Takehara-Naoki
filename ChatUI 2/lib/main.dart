import 'package:flutter/material.dart';

void main() {
  runApp(const ChatApp());
}

// チャットアプリのメインウィジェット
class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // デバッグバナーを非表示にする
      debugShowCheckedModeBanner: false,
      // アプリのテーマを設定
      theme: ThemeData(
        // プライマリスウォッチ（基本色）を設定
        primarySwatch: Colors.blue,
      ),
      // ホーム画面としてChatScreenを表示
      home: const ChatScreen(),
    );
  }
}

// チャット画面のウィジェット
class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // MediaQueryを使って画面サイズやセーフエリアの情報を取得
    final EdgeInsets safeAreaPadding = MediaQuery.of(context).padding;

    return Scaffold(
      // Scaffoldの背景色を透明にする
      backgroundColor: Colors.transparent,
      // 本体部分
      body: Container(
        // 画面全体を覆うグラデーション背景
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF6E7E94), // グラデーションの開始色 (上部)
              Color(0xFF4A5A70), // グラデーションの終了色 (下部)
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        // Stackを使って要素を重ねて表示
        child: Stack(
          children: [
            // --- チャットメッセージリスト ---
            // Positioned.fillでStack全体に広がるようにし、
            // PaddingでカスタムAppBarと入力エリア分のスペースを確保
            Positioned.fill(
              child: Padding(
                // 上部はカスタムAppBarの高さ + マージン分、下部は入力エリアのマージン分を空ける
                padding: EdgeInsets.only(
                  top: safeAreaPadding.top + 80, // カスタムAppBarの高さ(56) + 上下マージン(12*2) + α
                  bottom: 100, // 入力エリアのおおよその高さ + マージン
                ),
                child: ListView(
                  // リストの左右にパディングを追加
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  children: const [
                    // サンプルのチャットメッセージ
                    ChatMessage(text: 'こんにちは！', isSentByMe: false),
                    ChatMessage(text: '元気ですか？', isSentByMe: true),
                    ChatMessage(
                        text: 'はい、元気です。ナオキさんはどうですか？長いメッセージのテストです。',
                        isSentByMe: false),
                    ChatMessage(text: '私も元気ですよ。', isSentByMe: true),
                    ChatMessage(text: 'それは良かった！', isSentByMe: false),
                    ChatMessage(text: 'Read', isSentByMe: true, isStatus: true), // 既読表示
                  ],
                ),
              ),
            ),

            // --- カスタムAppBar ---
            // SafeAreaを使ってステータスバーを避ける
            Positioned(
              top: safeAreaPadding.top + 12, // ステータスバー下のマージン
              left: 16,
              right: 16,
              child: _buildCustomAppBar(context),
            ),


            // --- 下部の入力エリア ---
            // Positionedを使って画面下部に配置
            Positioned(
              bottom: safeAreaPadding.bottom + 10, // 下部のセーフエリア + マージン
              left: 16,
              right: 16,
              child: _buildInputArea(context),
            ),
          ],
        ),
      ),
    );
  }

  // カスタムAppBarを構築するメソッド
  Widget _buildCustomAppBar(BuildContext context) {
    return Container(
      height: 56, // AppBarの標準的な高さ
      padding: const EdgeInsets.symmetric(horizontal: 8.0), // 左右のパディング
      decoration: BoxDecoration(
        // 背景色（少し透明な白）
        color: Colors.white.withOpacity(0.25),
        // 角を丸くする
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // 要素間のスペースを最大にする
        children: [
          // 左側のアイコン（戻るボタン）
          IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20), // アイコンの色とサイズ調整
            onPressed: () {
              // 戻るボタンが押されたときの処理
            },
            // IconButtonのデフォルトパディングを減らすための調整
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
          // 中央のタイトル
          const Expanded( // Row内でタイトルが中央に来るようにExpandedで囲む
            child: Text(
              'Takehara Naoki', // 画像に合わせて名前を設定
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17),
              textAlign: TextAlign.center, // テキストを中央揃えにする
            ),
          ),
          // 右側のスペース確保用（タイトルを中央に保つため）
          const SizedBox(width: 48), // IconButtonの幅とほぼ同じ幅を確保
        ],
      ),
    );
  }


  // 下部の入力エリアを構築するメソッド (変更なし)
  Widget _buildInputArea(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.1),
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Row(
        children: [
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'KAKER',
                hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              ),
              textInputAction: TextInputAction.send,
              onSubmitted: (text) { /* 送信処理 */ },
            ),
          ),
          const SizedBox(width: 8),
          Container(
             decoration: BoxDecoration(
               color: Colors.white.withOpacity(0.9),
               shape: BoxShape.circle,
             ),
            child: IconButton(
              icon: const Icon(Icons.arrow_upward, color: Color(0xFF4A5A70)),
              onPressed: () { /* 送信処理 */ },
            ),
          ),
        ],
      ),
    );
  }
}

// 個々のチャットメッセージを表すウィジェット (変更なし)
class ChatMessage extends StatelessWidget {
  final String text;
  final bool isSentByMe;
  final bool isStatus;

  const ChatMessage({
    super.key,
    required this.text,
    required this.isSentByMe,
    this.isStatus = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isStatus) {
      return Container(
        alignment: Alignment.centerRight,
        margin: const EdgeInsets.only(bottom: 8.0, right: 8.0),
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white.withOpacity(0.7),
            fontSize: 12.0,
          ),
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: isSentByMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Container(
            constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
            decoration: BoxDecoration(
              color: isSentByMe
                  ? Colors.white.withOpacity(0.9)
                  : Colors.white.withOpacity(0.3),
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Text(
              text,
              style: TextStyle(color: isSentByMe ? Colors.black87 : Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

