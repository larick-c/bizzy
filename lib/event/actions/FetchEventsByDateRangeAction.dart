class FetchEventsByDateRangeAction {
  final String? userId;
  final DateTime? startDate;
  final DateTime? endDate;

  FetchEventsByDateRangeAction(
      {required this.userId, required this.startDate, required this.endDate});
}
