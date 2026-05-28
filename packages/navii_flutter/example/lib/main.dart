import 'package:flutter/material.dart';
import 'package:navii_flutter/navii_flutter.dart';

void main() => runApp(const NaviiShowcaseApp());

class NaviiShowcaseApp extends StatelessWidget {
  const NaviiShowcaseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'navii_flutter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6366F1),
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: const Color(0xFF0F172A),
        cardColor: const Color(0xFF1E293B),
        dividerColor: const Color(0xFF334155),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Color(0xFFCBD5E1)),
          bodySmall: TextStyle(color: Color(0xFF94A3B8)),
        ),
      ),
      home: const _Shell(),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Shell
// ─────────────────────────────────────────────────────────────────────────────

class _Shell extends StatefulWidget {
  const _Shell();
  @override
  State<_Shell> createState() => _ShellState();
}

class _ShellState extends State<_Shell> {
  int _tab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _tab,
        children: const [
          UseCasesTab(),
          TryItTab(),
          PickerTab(),
          GalleryTab(),
          CustomizeTab(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _tab,
        onDestinationSelected: (i) => setState(() => _tab = i),
        backgroundColor: const Color(0xFF1E293B),
        indicatorColor: const Color(0xFF6366F1),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.dashboard_outlined),
            selectedIcon: Icon(Icons.dashboard),
            label: 'Use Cases',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outlined),
            selectedIcon: Icon(Icons.person),
            label: 'Try It',
          ),
          NavigationDestination(
            icon: Icon(Icons.touch_app_outlined),
            selectedIcon: Icon(Icons.touch_app),
            label: 'Picker',
          ),
          NavigationDestination(
            icon: Icon(Icons.grid_view_outlined),
            selectedIcon: Icon(Icons.grid_view),
            label: 'Gallery',
          ),
          NavigationDestination(
            icon: Icon(Icons.tune_outlined),
            selectedIcon: Icon(Icons.tune),
            label: 'Customize',
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Tab 1 — Use Cases
// ─────────────────────────────────────────────────────────────────────────────

class UseCasesTab extends StatelessWidget {
  const UseCasesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: const Color(0xFF0F172A),
        appBar: AppBar(
          backgroundColor: const Color(0xFF1E293B),
          title: RichText(
            text: const TextSpan(
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                  text: 'navii',
                  style: TextStyle(color: Color(0xFF818CF8)),
                ),
                TextSpan(
                  text: '_flutter',
                  style: TextStyle(color: Color(0xFFCBD5E1)),
                ),
                TextSpan(
                  text: '  use cases',
                  style: TextStyle(
                    color: Color(0xFF64748B),
                    fontWeight: FontWeight.normal,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          bottom: const TabBar(
            labelColor: Color(0xFF818CF8),
            unselectedLabelColor: Color(0xFF64748B),
            indicatorColor: Color(0xFF6366F1),
            tabs: [
              Tab(text: 'Chat'),
              Tab(text: 'Comments'),
              Tab(text: 'Contacts'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [_ChatDemo(), _CommentsDemo(), _ContactsDemo()],
        ),
      ),
    );
  }
}

// ── Chat Demo ────────────────────────────────────────────────────────────────

const _chatConversations = [
  _Convo('Alice Mensah', 'Sounds good, see you then! 👋', '2m', true, 3),
  _Convo('Bob Asante', 'Did you get my last message?', '14m', false, 0),
  _Convo('Carol Adjei', 'The meeting is at 3pm tomorrow', '1h', true, 1),
  _Convo(
    'David Owusu',
    'haha yeah exactly what I was thinking',
    '2h',
    false,
    0,
  ),
  _Convo(
    'Eve Boateng',
    'Can you review the PR when you get a chance?',
    '3h',
    true,
    0,
  ),
  _Convo('Frank Darko', 'On my way!', '5h', false, 0),
  _Convo('Grace Amponsah', 'Thanks for the help earlier 🙏', 'Mon', true, 0),
  _Convo(
    'Henry Acheampong',
    'I\'ll send the files by end of day',
    'Mon',
    false,
    0,
  ),
  _Convo('Iris Opoku', 'Happy birthday!! 🎉🎂', 'Sun', true, 0),
  _Convo('Jack Frimpong', 'Let me know what you think', 'Sun', false, 0),
];

class _Convo {
  final String name;
  final String message;
  final String time;
  final bool online;
  final int unread;
  const _Convo(this.name, this.message, this.time, this.online, this.unread);
}

class _ChatDemo extends StatelessWidget {
  const _ChatDemo();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _SearchBar(hint: 'Search messages...'),
        Expanded(
          child: ListView.builder(
            itemCount: _chatConversations.length,
            itemBuilder: (context, i) {
              final c = _chatConversations[i];
              return _ChatTile(convo: c);
            },
          ),
        ),
      ],
    );
  }
}

class _ChatTile extends StatelessWidget {
  final _Convo convo;
  const _ChatTile({required this.convo});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: Stack(
        children: [
          Navii(seed: convo.name, size: 48),
          if (convo.online)
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: const Color(0xFF22C55E),
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFF0F172A), width: 2),
                ),
              ),
            ),
        ],
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            convo.name,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Color(0xFFE2E8F0),
              fontSize: 15,
            ),
          ),
          Text(
            convo.time,
            style: TextStyle(
              fontSize: 12,
              color: convo.unread > 0
                  ? const Color(0xFF818CF8)
                  : const Color(0xFF64748B),
            ),
          ),
        ],
      ),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              convo.message,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 13,
                color: convo.unread > 0
                    ? const Color(0xFFCBD5E1)
                    : const Color(0xFF64748B),
              ),
            ),
          ),
          if (convo.unread > 0)
            Container(
              margin: const EdgeInsets.only(left: 8),
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
              decoration: BoxDecoration(
                color: const Color(0xFF6366F1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                '${convo.unread}',
                style: const TextStyle(
                  fontSize: 11,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// ── Comments Demo ────────────────────────────────────────────────────────────

const _comments = [
  _Comment(
    'Noah Tetteh',
    '2m ago',
    'This is exactly what I\'ve been looking for. The determinism aspect is really clever.',
    24,
  ),
  _Comment(
    'Mia Asare',
    '8m ago',
    'How does it handle unicode names like "김민준" or "محمد"?',
    7,
  ),
  _Comment(
    'Liam Antwi',
    '15m ago',
    'Replying to @Mia — yes it works! Just tested it. Every character maps correctly.',
    12,
  ),
  _Comment(
    'Olivia Mensah',
    '1h ago',
    'Just published a post about this on my blog 🎉',
    31,
  ),
  _Comment(
    'Peter Asante',
    '2h ago',
    'The offline-first approach is a big win for us. No more broken avatar images.',
    9,
  ),
  _Comment(
    'Quinn Osei',
    '3h ago',
    'Does it support custom palettes at runtime?',
    5,
  ),
];

class _Comment {
  final String name;
  final String time;
  final String text;
  final int likes;
  const _Comment(this.name, this.time, this.text, this.likes);
}

class _CommentsDemo extends StatelessWidget {
  const _CommentsDemo();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Post card
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF1E293B),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFF334155)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Navii(seed: 'Samuel Darko', size: 40),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Samuel Darko',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFE2E8F0),
                        ),
                      ),
                      Text(
                        'Just shipped navii_flutter v0.1.0 🚀',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF64748B),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Text(
                'Drop-in deterministic mascot avatars for Flutter. '
                'No database, no uploads, works offline. '
                'Same user ID → same avatar, always. '
                'Check out the package on pub.dev 👇',
                style: TextStyle(color: Color(0xFFCBD5E1), height: 1.5),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Icon(
                    Icons.favorite_border,
                    size: 18,
                    color: Color(0xFF64748B),
                  ),
                  const SizedBox(width: 4),
                  const Text(
                    '142',
                    style: TextStyle(fontSize: 13, color: Color(0xFF64748B)),
                  ),
                  const SizedBox(width: 16),
                  const Icon(
                    Icons.comment_outlined,
                    size: 18,
                    color: Color(0xFF64748B),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${_comments.length}',
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Comments',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFFE2E8F0),
            fontSize: 15,
          ),
        ),
        const SizedBox(height: 8),
        ..._comments.map((c) => _CommentTile(comment: c)),
      ],
    );
  }
}

class _CommentTile extends StatelessWidget {
  final _Comment comment;
  const _CommentTile({required this.comment});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Navii(seed: comment.name, size: 36),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      comment.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Color(0xFFE2E8F0),
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      comment.time,
                      style: const TextStyle(
                        fontSize: 11,
                        color: Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  comment.text,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFFCBD5E1),
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(
                      Icons.favorite_border,
                      size: 14,
                      color: Color(0xFF64748B),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${comment.likes}',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF64748B),
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Text(
                      'Reply',
                      style: TextStyle(fontSize: 12, color: Color(0xFF818CF8)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Contacts Demo ────────────────────────────────────────────────────────────

const _contacts = {
  'A': ['Alice Mensah', 'Ama Owusu', 'Asante Kwame'],
  'B': ['Bob Darko', 'Bright Frimpong'],
  'C': ['Carol Adjei', 'Charles Boateng', 'Cynthia Asare'],
  'D': ['David Antwi', 'Diana Tetteh'],
  'E': ['Emmanuel Osei', 'Eve Opoku'],
  'F': ['Frank Amponsah', 'Fatima Acheampong'],
  'G': ['Grace Asante', 'Gabriel Mensah'],
};

class _ContactsDemo extends StatelessWidget {
  const _ContactsDemo();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _SearchBar(hint: 'Search contacts...'),
        Expanded(
          child: ListView(
            children: _contacts.entries
                .expand(
                  (entry) => [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
                      child: Text(
                        entry.key,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF6366F1),
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                    ...entry.value.map(
                      (name) => ListTile(
                        leading: Navii(seed: name, size: 44),
                        title: Text(
                          name,
                          style: const TextStyle(
                            color: Color(0xFFE2E8F0),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        subtitle: const Text(
                          'Tap to view profile',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF64748B),
                          ),
                        ),
                        trailing: const Icon(
                          Icons.chevron_right,
                          color: Color(0xFF475569),
                        ),
                      ),
                    ),
                  ],
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Tab 2 — Try It (Auth Flow + Live Preview)
// ─────────────────────────────────────────────────────────────────────────────

class TryItTab extends StatefulWidget {
  const TryItTab({super.key});
  @override
  State<TryItTab> createState() => _TryItTabState();
}

class _TryItTabState extends State<TryItTab> {
  // Simple in-memory "users" store
  final Map<String, String> _users = {};
  String? _loggedInUser;
  String? _error;

  final _nameController = TextEditingController();
  final _liveController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _liveController.dispose();
    super.dispose();
  }

  void _signUp(String name) {
    final trimmed = name.trim();
    if (trimmed.isEmpty) return;
    if (_users.containsKey(trimmed.toLowerCase())) {
      setState(
        () => _error = 'User "$trimmed" already exists. Sign in instead.',
      );
      return;
    }
    setState(() {
      _users[trimmed.toLowerCase()] = trimmed;
      _loggedInUser = trimmed;
      _error = null;
    });
  }

  void _signIn(String name) {
    final trimmed = name.trim();
    if (trimmed.isEmpty) return;
    if (!_users.containsKey(trimmed.toLowerCase())) {
      setState(() => _error = 'No account for "$trimmed". Sign up first.');
      return;
    }
    setState(() {
      _loggedInUser = _users[trimmed.toLowerCase()];
      _error = null;
    });
  }

  void _signOut() => setState(() => _loggedInUser = null);

  @override
  Widget build(BuildContext context) {
    if (_loggedInUser != null) {
      return _ProfileScreen(
        user: _loggedInUser!,
        allUsers: _users,
        onSignOut: _signOut,
      );
    }
    return _AuthScreen(
      users: _users,
      error: _error,
      liveController: _liveController,
      nameController: _nameController,
      onSignUp: _signUp,
      onSignIn: _signIn,
    );
  }
}

class _AuthScreen extends StatefulWidget {
  final Map<String, String> users;
  final String? error;
  final TextEditingController liveController;
  final TextEditingController nameController;
  final void Function(String) onSignUp;
  final void Function(String) onSignIn;

  const _AuthScreen({
    required this.users,
    required this.error,
    required this.liveController,
    required this.nameController,
    required this.onSignUp,
    required this.onSignIn,
  });

  @override
  State<_AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<_AuthScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  String _liveSeed = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    widget.liveController.addListener(() {
      setState(() => _liveSeed = widget.liveController.text.trim());
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E293B),
        title: const Text('navii_flutter — Try It'),
        bottom: TabBar(
          controller: _tabController,
          labelColor: const Color(0xFF818CF8),
          unselectedLabelColor: const Color(0xFF64748B),
          indicatorColor: const Color(0xFF6366F1),
          tabs: const [
            Tab(text: 'Sign Up'),
            Tab(text: 'Sign In'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [_buildSignUp(), _buildSignIn()],
      ),
    );
  }

  Widget _buildSignUp() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const SizedBox(height: 16),
          // Live avatar preview
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
            child: _liveSeed.isNotEmpty
                ? Column(
                    children: [
                      Navii(seed: _liveSeed, size: 96),
                      const SizedBox(height: 8),
                      Text(
                        'This will be your avatar',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  )
                : Column(
                    children: [
                      Container(
                        width: 96,
                        height: 96,
                        decoration: BoxDecoration(
                          color: const Color(0xFF1E293B),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color(0xFF334155),
                            width: 2,
                          ),
                        ),
                        child: const Icon(
                          Icons.person,
                          size: 40,
                          color: Color(0xFF475569),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Enter your name to preview your avatar',
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xFF64748B),
                        ),
                      ),
                    ],
                  ),
          ),
          const SizedBox(height: 32),
          TextField(
            controller: widget.liveController,
            style: const TextStyle(color: Color(0xFFE2E8F0)),
            decoration: _inputDecoration('Your name', Icons.person_outline),
            textCapitalization: TextCapitalization.words,
          ),
          const SizedBox(height: 12),
          if (widget.error != null) _ErrorBanner(widget.error!),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () => widget.onSignUp(widget.liveController.text),
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFF6366F1),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text(
                'Create Account',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          const SizedBox(height: 32),
          if (widget.users.isNotEmpty) ...[
            const _Divider('Existing accounts'),
            const SizedBox(height: 12),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: widget.users.values
                  .map(
                    (name) => Column(
                      children: [
                        Navii(seed: name, size: 48),
                        const SizedBox(height: 4),
                        Text(
                          name.split(' ').first,
                          style: const TextStyle(
                            fontSize: 11,
                            color: Color(0xFF64748B),
                          ),
                        ),
                      ],
                    ),
                  )
                  .toList(),
            ),
          ],
          const SizedBox(height: 32),
          _DeterminismNote(),
        ],
      ),
    );
  }

  Widget _buildSignIn() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const SizedBox(height: 40),
          if (widget.users.isEmpty) ...[
            const Icon(
              Icons.person_add_outlined,
              size: 64,
              color: Color(0xFF334155),
            ),
            const SizedBox(height: 16),
            const Text(
              'No accounts yet.',
              style: TextStyle(color: Color(0xFF64748B)),
            ),
            const Text(
              'Create one in the Sign Up tab.',
              style: TextStyle(color: Color(0xFF475569), fontSize: 13),
            ),
            const SizedBox(height: 32),
          ] else ...[
            const Text(
              'Your accounts',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFFE2E8F0),
              ),
            ),
            const SizedBox(height: 16),
            ...widget.users.values.map(
              (name) => ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 0,
                  vertical: 4,
                ),
                leading: Navii(seed: name, size: 44),
                title: Text(
                  name,
                  style: const TextStyle(color: Color(0xFFE2E8F0)),
                ),
                subtitle: const Text(
                  'Tap to sign in',
                  style: TextStyle(fontSize: 12, color: Color(0xFF64748B)),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  size: 14,
                  color: Color(0xFF475569),
                ),
                onTap: () => widget.onSignIn(name),
              ),
            ),
            const SizedBox(height: 16),
          ],
          TextField(
            controller: widget.nameController,
            style: const TextStyle(color: Color(0xFFE2E8F0)),
            decoration: _inputDecoration(
              'Or type your name',
              Icons.person_outline,
            ),
            textCapitalization: TextCapitalization.words,
          ),
          const SizedBox(height: 12),
          if (widget.error != null) _ErrorBanner(widget.error!),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () => widget.onSignIn(widget.nameController.text),
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFF6366F1),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text('Sign In', style: TextStyle(fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileScreen extends StatelessWidget {
  final String user;
  final Map<String, String> allUsers;
  final VoidCallback onSignOut;

  const _ProfileScreen({
    required this.user,
    required this.allUsers,
    required this.onSignOut,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E293B),
        title: const Text('Profile'),
        actions: [
          TextButton(
            onPressed: onSignOut,
            child: const Text(
              'Sign Out',
              style: TextStyle(color: Color(0xFF818CF8)),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 40),
              color: const Color(0xFF1E293B),
              child: Column(
                children: [
                  Navii(seed: user, size: 100),
                  const SizedBox(height: 12),
                  Text(
                    user,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFE2E8F0),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Seed: "$user"',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF64748B),
                      fontFamily: 'monospace',
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Show avatar is stable — same user, 3 renders
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Always the same:  ',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF64748B),
                        ),
                      ),
                      ...List.generate(
                        3,
                        (i) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 3),
                          child: Navii(seed: user, size: 28),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Similar names — prove no collisions
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Similar names — all different avatars',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFE2E8F0),
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Even one character difference produces a completely unique avatar.',
                    style: TextStyle(fontSize: 12, color: Color(0xFF94A3B8)),
                  ),
                  const SizedBox(height: 16),
                  ..._buildVariants(user),
                ],
              ),
            ),
            const SizedBox(height: 24),
            if (allUsers.length > 1) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Other users',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFE2E8F0),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      children: allUsers.values
                          .where((u) => u != user)
                          .map(
                            (u) => Column(
                              children: [
                                Navii(seed: u, size: 52),
                                const SizedBox(height: 4),
                                Text(
                                  u.split(' ').first,
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: Color(0xFF64748B),
                                  ),
                                ),
                              ],
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
            ],
          ],
        ),
      ),
    );
  }

  List<Widget> _buildVariants(String name) {
    final base = name.trim();
    final variants = [
      base,
      '${base}1',
      '${base.split(' ').first} J.',
      base.toLowerCase(),
      base.toUpperCase(),
    ];
    return variants
        .map(
          (v) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Row(
              children: [
                Navii(seed: v, size: 40),
                const SizedBox(width: 12),
                Text(
                  '"$v"',
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 13,
                    color: Color(0xFFCBD5E1),
                  ),
                ),
                if (v == base)
                  Container(
                    margin: const EdgeInsets.only(left: 8),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E3A8A),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      'you',
                      style: TextStyle(fontSize: 10, color: Color(0xFF93C5FD)),
                    ),
                  ),
              ],
            ),
          ),
        )
        .toList();
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Tab 3 — Picker
// ─────────────────────────────────────────────────────────────────────────────

class PickerTab extends StatefulWidget {
  const PickerTab({super.key});
  @override
  State<PickerTab> createState() => _PickerTabState();
}

class _PickerTabState extends State<PickerTab> {
  static const _baseSeed = 'showcase-profile';
  String _currentSeed = 'showcase-profile-navii-v0';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E293B),
        title: const Text('Avatar Picker'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Current selection card
            _CurrentAvatarCard(seed: _currentSeed),
            const SizedBox(height: 28),

            // Inline picker
            const Text(
              'Inline Picker',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Color(0xFFE2E8F0),
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'NaviiPicker(baseSeed: ..., onSelected: ...)',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 11,
                color: Color(0xFF64748B),
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1E293B),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFF334155)),
              ),
              child: NaviiPicker(
                baseSeed: _baseSeed,
                initialSeed: _currentSeed,
                confirmLabel: 'Use this avatar',
                onSelected: (seed) => setState(() => _currentSeed = seed),
              ),
            ),

            const SizedBox(height: 28),

            // Bottom sheet button
            const Text(
              'Bottom Sheet',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Color(0xFFE2E8F0),
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'showNaviiPickerSheet(context, baseSeed: ...)',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 11,
                color: Color(0xFF64748B),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () async {
                  final seed = await showNaviiPickerSheet(
                    context,
                    baseSeed: _baseSeed,
                    initialSeed: _currentSeed,
                    title: 'Choose your avatar',
                    confirmLabel: 'Use this avatar',
                  );
                  if (seed != null) setState(() => _currentSeed = seed);
                },
                icon: const Icon(Icons.open_in_new, size: 16),
                label: const Text('Open picker in bottom sheet'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF818CF8),
                  side: const BorderSide(color: Color(0xFF334155)),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),

            const SizedBox(height: 28),

            // How it works note
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFF1E293B),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFF334155)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        size: 14,
                        color: Color(0xFF818CF8),
                      ),
                      SizedBox(width: 6),
                      Text(
                        'Stable seeds',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFE2E8F0),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 6),
                  Text(
                    'Each variant seed is deterministic: '
                    '"showcase-profile-navii-v0", '
                    '"showcase-profile-navii-v1", etc. Store the chosen seed '
                    'in your database and render it anywhere with '
                    'Navii(seed: storedSeed).',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF94A3B8),
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CurrentAvatarCard extends StatelessWidget {
  final String seed;
  const _CurrentAvatarCard({required this.seed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 24),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF334155)),
      ),
      child: Column(
        children: [
          Navii(
            seed: seed,
            size: 80,
            borderColor: const Color(0xFF6366F1),
            borderWidth: 2.5,
          ),
          const SizedBox(height: 10),
          const Text(
            'Current avatar',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Color(0xFFE2E8F0),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            seed,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 11,
              color: Color(0xFF64748B),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Tab 4 — Gallery
// ─────────────────────────────────────────────────────────────────────────────

class GalleryTab extends StatelessWidget {
  const GalleryTab({super.key});

  static const _seeds = [
    'alice',
    'bob',
    'carol',
    'david',
    'eve',
    'frank',
    'grace',
    'henry',
    'iris',
    'jack',
    'kate',
    'liam',
    'mia',
    'noah',
    'olivia',
    'peter',
    'quinn',
    'rachel',
    'sam',
    'tina',
    'user-001',
    'user-002',
    'user-003',
    'user-004',
    'user-005',
    'user-006',
    'alpha',
    'beta',
    'gamma',
    'delta',
    'kofi',
    'ama',
    'kwame',
    'abena',
    'yaw',
    'akosua',
    'kojo',
    'adwoa',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E293B),
        title: Text('Gallery  ·  ${_seeds.length} avatars'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          childAspectRatio: 0.85,
        ),
        itemCount: _seeds.length,
        itemBuilder: (context, i) {
          final seed = _seeds[i];
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Navii(seed: seed, size: 52),
              const SizedBox(height: 3),
              Text(
                seed,
                style: const TextStyle(fontSize: 9, color: Color(0xFF475569)),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ],
          );
        },
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Tab 5 — Customize
// ─────────────────────────────────────────────────────────────────────────────

class CustomizeTab extends StatelessWidget {
  const CustomizeTab({super.key});

  static const _palettes = [
    'indigo',
    'mint',
    'amber',
    'sky',
    'violet',
    'cyan',
    'rose',
    'lime',
    'peach',
    'teal',
    'sand',
    'plum',
    'coral',
    'forest',
    'slate',
    'fuchsia',
    'terracotta',
    'navy',
    'lavender',
    'charcoal',
    'butter',
    'aqua',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E293B),
        title: const Text('Customize'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Sizes
          const Text(
            'Sizes',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFFE2E8F0),
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Navii(seed: ..., size: 64)',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12,
              color: Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 16),
          ...[24.0, 32.0, 48.0, 64.0, 96.0, 128.0].map(
            (s) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Row(
                children: [
                  Navii(seed: 'size-demo', size: s),
                  const SizedBox(width: 16),
                  Text(
                    '${s.toInt()}px',
                    style: const TextStyle(color: Color(0xFF94A3B8)),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          const Divider(color: Color(0xFF334155), height: 32),
          // Palettes
          const Text(
            '22 Palettes',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFFE2E8F0),
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            "AvatarOptions(paletteId: 'violet')",
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12,
              color: Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 0.8,
            ),
            itemCount: _palettes.length,
            itemBuilder: (context, i) {
              final p = _palettes[i];
              return Column(
                children: [
                  Navii(
                    seed: 'palette-preview',
                    size: 56,
                    options: AvatarOptions(paletteId: p),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    p,
                    style: const TextStyle(
                      fontSize: 9,
                      color: Color(0xFF475569),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              );
            },
          ),
          const Divider(color: Color(0xFF334155), height: 40),

          // Shapes
          const Text(
            'Shapes',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFFE2E8F0),
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Navii(seed: ..., shape: NaviiShape.circle)',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12,
              color: Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Column(
                children: [
                  Navii(seed: 'shape-demo', size: 64, shape: NaviiShape.circle),
                  const SizedBox(height: 4),
                  const Text(
                    'circle',
                    style: TextStyle(fontSize: 11, color: Color(0xFF64748B)),
                  ),
                ],
              ),
              const SizedBox(width: 24),
              Column(
                children: [
                  Navii(
                    seed: 'shape-demo',
                    size: 64,
                    shape: NaviiShape.rounded,
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'rounded',
                    style: TextStyle(fontSize: 11, color: Color(0xFF64748B)),
                  ),
                ],
              ),
              const SizedBox(width: 24),
              Column(
                children: [
                  Navii(seed: 'shape-demo', size: 64, shape: NaviiShape.square),
                  const SizedBox(height: 4),
                  const Text(
                    'square',
                    style: TextStyle(fontSize: 11, color: Color(0xFF64748B)),
                  ),
                ],
              ),
            ],
          ),
          const Divider(color: Color(0xFF334155), height: 40),

          // Status dots & borders
          const Text(
            'Status & Border',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFFE2E8F0),
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Navii(seed: ..., statusColor: ..., borderColor: ...)',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12,
              color: Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 20,
            runSpacing: 16,
            children: [
              _LabelledAvatar(
                label: 'online',
                child: Navii(
                  seed: 'status-demo',
                  size: 56,
                  statusColor: const Color(0xFF22C55E),
                ),
              ),
              _LabelledAvatar(
                label: 'away',
                child: Navii(
                  seed: 'status-demo-2',
                  size: 56,
                  statusColor: const Color(0xFFF59E0B),
                  statusAlignment: Alignment.bottomRight,
                ),
              ),
              _LabelledAvatar(
                label: 'busy',
                child: Navii(
                  seed: 'status-demo-3',
                  size: 56,
                  statusColor: const Color(0xFFEF4444),
                ),
              ),
              _LabelledAvatar(
                label: 'border',
                child: Navii(
                  seed: 'border-demo',
                  size: 56,
                  borderColor: const Color(0xFF818CF8),
                  borderWidth: 3,
                ),
              ),
              _LabelledAvatar(
                label: 'both',
                child: Navii(
                  seed: 'border-demo-2',
                  size: 56,
                  borderColor: const Color(0xFF22C55E),
                  statusColor: const Color(0xFF22C55E),
                ),
              ),
            ],
          ),
          const Divider(color: Color(0xFF334155), height: 40),

          // Group avatars
          const Text(
            'Group Avatars',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFFE2E8F0),
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'NaviiGroup(seeds: [...], size: 36, maxVisible: 3)',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12,
              color: Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 16),
          NaviiGroup(
            seeds: const [
              'group-a',
              'group-b',
              'group-c',
              'group-d',
              'group-e',
              'group-f',
            ],
            size: 40,
            overlap: 12,
            maxVisible: 4,
            borderColor: const Color(0xFF0F172A),
          ),
          const SizedBox(height: 12),
          NaviiGroup(
            seeds: const ['team-1', 'team-2', 'team-3', 'team-4'],
            size: 32,
            overlap: 8,
            shape: NaviiShape.rounded,
            borderColor: const Color(0xFF0F172A),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}

class _LabelledAvatar extends StatelessWidget {
  final String label;
  final Widget child;
  const _LabelledAvatar({required this.label, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        child,
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 11, color: Color(0xFF64748B)),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Shared widgets
// ─────────────────────────────────────────────────────────────────────────────

class _SearchBar extends StatelessWidget {
  final String hint;
  const _SearchBar({required this.hint});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(12, 10, 12, 4),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFF334155)),
      ),
      child: Row(
        children: [
          const Icon(Icons.search, color: Color(0xFF475569), size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              style: const TextStyle(fontSize: 14, color: Color(0xFFCBD5E1)),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: const TextStyle(color: Color(0xFF475569)),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ErrorBanner extends StatelessWidget {
  final String message;
  const _ErrorBanner(this.message);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF450A0A),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFF7F1D1D)),
      ),
      child: Text(
        message,
        style: const TextStyle(fontSize: 13, color: Color(0xFFFCA5A5)),
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  final String label;
  const _Divider(this.label);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider(color: Color(0xFF334155))),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            label,
            style: const TextStyle(fontSize: 12, color: Color(0xFF64748B)),
          ),
        ),
        const Expanded(child: Divider(color: Color(0xFF334155))),
      ],
    );
  }
}

class _DeterminismNote extends StatelessWidget {
  const _DeterminismNote();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF334155)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Row(
            children: [
              Icon(Icons.info_outline, size: 16, color: Color(0xFF818CF8)),
              SizedBox(width: 6),
              Text(
                'How it works',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFE2E8F0),
                  fontSize: 13,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            'Pass any string as the seed — your name, a UUID, or any other unique identifier. '
            'a random avatar is generated. Picks one of 22M+ '
            'combinations. Same seed = same avatar, '
            'works offline.',
            style: TextStyle(
              fontSize: 12,
              color: Color(0xFF94A3B8),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

InputDecoration _inputDecoration(String label, IconData icon) {
  return InputDecoration(
    labelText: label,
    labelStyle: const TextStyle(color: Color(0xFF64748B)),
    prefixIcon: Icon(icon, color: const Color(0xFF475569)),
    filled: true,
    fillColor: const Color(0xFF1E293B),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Color(0xFF334155)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Color(0xFF6366F1), width: 2),
    ),
  );
}
