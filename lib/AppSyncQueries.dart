class AppSyncQueries {
  static const String createEvent =
      '''
    mutation CreateEvent (\$input: EventInput!) {
      createEvent(input: \$input) {
        title
      }
    }
  ''';

  static const String listEvents =
      '''
    query GetEvents {
      getEvents {
        userId
        created_ts
        title
      }
    }
  ''';
}
