
// namespace poappliation.common;

// using { Country, Currency } from '@sap/cds/common';

// type nameStr : String(50);


// aspect adress{
//     drno : String(20);
//     street : String(50);
//     landmark : String(50);
//     city : String(100);
//     postal : Integer;
//     state : String(100);
//     country : Country;
//     region : String(20);
// }

// type amounT : Decimal(10,2) @(
//     Semantics.amount.currencyCode : 'CURRENCY_CODE',
//     sap.unit : 'CURRENCY_CODE'
// );

// type PhoneNumber : String(20) @assert.format : '^[6-9]\d{9}$';

// type Email : String(20) @assert.format : '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$';

// aspect feeasp{
//     gross_fee : amounT;
//     tax : amounT;
//     total_fee : amounT;
//     currency : Currency;
// }

// type Gender: String(20) enum{
//     F='Female';
//     M='Male';
// }

// type status: String(20) enum{
//     S='Submitted';
//     A='Approved';
//     I='Issued';
//     R='Rejected';
// }

