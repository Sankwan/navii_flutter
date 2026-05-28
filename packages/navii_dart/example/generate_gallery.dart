import 'dart:io';
import 'package:navii_dart/navii_dart.dart';

void main() {
  final seeds = [
    'alice@example.com',
    'bob@example.com',
    'carol@example.com',
    'david@example.com',
    'eve@example.com',
    'frank@example.com',
    'grace@example.com',
    'henry@example.com',
    'iris@example.com',
    'jack@example.com',
    'kate@example.com',
    'liam@example.com',
    'mia@example.com',
    'noah@example.com',
    'olivia@example.com',
    'peter@example.com',
    'quinn@example.com',
    'rachel@example.com',
    'user-001',
    'user-002',
    'user-003',
    'user-004',
    'user-005',
    'user-006',
    'user-007',
    'user-008',
    'test-seed-alpha',
    'test-seed-beta',
    'test-seed-gamma',
    'test-seed-delta',
  ];

  final cards = seeds.map((seed) {
    final svg = createAvatar(seed, AvatarOptions(size: 100));
    final label = seed.contains('@') ? seed.split('@').first : seed;
    return '''
      <div class="card">
        $svg
        <span>$label</span>
      </div>''';
  }).join('\n');

  final html = '''<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>navii_dart — Avatar Gallery</title>
  <style>
    * { box-sizing: border-box; margin: 0; padding: 0; }
    body {
      font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
      background: #0f172a;
      color: #e2e8f0;
      padding: 32px;
    }
    h1 {
      font-size: 24px;
      font-weight: 700;
      margin-bottom: 8px;
      color: #f8fafc;
    }
    p {
      font-size: 14px;
      color: #94a3b8;
      margin-bottom: 32px;
    }
    .grid {
      display: grid;
      grid-template-columns: repeat(auto-fill, minmax(120px, 1fr));
      gap: 16px;
    }
    .card {
      background: #1e293b;
      border-radius: 16px;
      padding: 16px 12px 12px;
      display: flex;
      flex-direction: column;
      align-items: center;
      gap: 10px;
      border: 1px solid #334155;
    }
    .card svg { display: block; }
    .card span {
      font-size: 11px;
      color: #64748b;
      text-align: center;
      overflow: hidden;
      text-overflow: ellipsis;
      white-space: nowrap;
      width: 100%;
      text-align: center;
    }
  </style>
</head>
<body>
  <h1>navii_dart — Avatar Gallery</h1>
  <p>Each avatar is deterministically generated from its seed string. Same seed = same avatar, every time.</p>
  <div class="grid">
$cards
  </div>
</body>
</html>''';

  final file = File('example/gallery.html');
  file.writeAsStringSync(html);
  print('Generated: ${file.absolute.path}');
  print('Open in browser to view ${seeds.length} avatars.');
}
