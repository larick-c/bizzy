class AppSyncQueries {
  static const String createEvent = '''
    mutation CreateEvent (\$input: EventInput!) {
      createEvent(input: \$input) {
        userId
        title
        date
      }
    }
  ''';

  static const String listEvents = '''
    query GetEvents {
      getEvents {
        userId
        created_ts
        title
      }
    }
  ''';

  static const String deleteEvent = '''
      mutation DeleteEvent (\$input: DeleteEventInput!) {
        deleteEvent(input: \$input) {
          title
        }
      }
    ''';
}
