# Supabase Setup Instructions

## 1. Get Your Supabase Credentials

1. Go to [supabase.com](https://supabase.com) and sign in
2. Select your project (or create a new one)
3. Go to Settings → API
4. Copy your **anon/public** key

## 2. Configure the App

1. Copy `Config.plist.example` to `based-peak/Config.plist`
2. Open `based-peak/Config.plist`
3. Replace `YOUR_SUPABASE_ANON_KEY_HERE` with your actual anon key
4. Save the file

**Note:** The `Config.plist` file is gitignored to keep your keys secure.

## 3. Database Schema

Create a table in your Supabase project to store chat messages:

```sql
-- Create chat_messages table
CREATE TABLE chat_messages (
  id UUID PRIMARY KEY,
  content TEXT NOT NULL,
  is_user BOOLEAN NOT NULL,
  timestamp TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Add index for faster queries
CREATE INDEX idx_chat_messages_timestamp ON chat_messages(timestamp DESC);

-- Enable Row Level Security (recommended)
ALTER TABLE chat_messages ENABLE ROW LEVEL SECURITY;

-- Create policy to allow all operations (adjust based on your auth needs)
CREATE POLICY "Allow all operations" ON chat_messages
  FOR ALL
  USING (true)
  WITH CHECK (true);
```

## 4. Using Supabase in the App

The app includes a `SupabaseService` singleton that you can use:

```swift
import SupabaseService

// Save a message
Task {
    try await SupabaseService.shared.saveChatMessage(message)
}

// Fetch chat history
Task {
    let messages = try await SupabaseService.shared.fetchChatHistory()
}
```

## Security Notes

- Never commit `Config.plist` to version control
- The anon key is safe to use in client apps (it's public)
- Use Row Level Security (RLS) policies to protect your data
- For production, implement proper authentication
