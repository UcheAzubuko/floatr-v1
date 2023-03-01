import 'package:floatr/app/features/loan/model/responses/card_response.dart';

import '../responses/loans_response.dart';
import '../responses/my_banks_response.dart';

class RequestLoanParams {
  MyBank? bank;
  Card? card;
  Loan? loan;
  String? amount;
  String? tenureInWeeks;
  String? pin;

  RequestLoanParams(
      {this.bank,
      this.card,
      this.loan,
      this.amount,
      this.tenureInWeeks,
      this.pin});

  Map<String, dynamic> toMap() => {
        "userBankId": bank!.uniqueId,
        "userCardId": card!.uniqueId,
        "loanId": loan!.uniqueId,
        "amount": amount,
        "tenureInWeeks": tenureInWeeks,
        "pin": pin
      };
}
