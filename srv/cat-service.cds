using { poapplication.db as databae } from '../db/schema2';
using { poapplication.common2 as common } from '../db/common2';

service CatalogService {

    function getUtilities() returns String;

    
    entity EmployeeSrv as projection on databae.Employees {
        *
    }
    actions {
        action IncreaseSal() returns array of EmployeeSrv;
        function top20Employees() returns array of EmployeeSrv;
    };

    entity ProductSrv as projection on databae.master.Products;

    entity BusinessPartnerSrv as projection on databae.master.BusinessPartners;

    entity AddressSrv as projection on databae.master.Addresses;

    entity PurchaseOrderSrv as projection on databae.transaction.PurchaseOrders;

    entity PurchaseItemSrv as projection on databae.transaction.PurchaseItems;

    action createEmployee(
        Currency_code: String(3),
        ID: UUID,
        accountNumber: common.String32,
        bankId: String(16),
        bankName: common.String64,
        email: common.Email,
        gender: common.Gender,
        language: String(2),
        loginName: String(16),
        nameFirst: common.String64,
        nameInitials: common.String64,
        nameLast: common.String64,
        nameMiddle: common.String64,
        phoneNumber: common.PhoneNumber,
        salaryAmount: common.AmountT
    ) returns array of EmployeeSrv;

    action createAddress(
        NODE_KEY : UUID,
        ADDRESS_TYPE : common.String32,
        VAL_START : Date,
        VAL_END : Date,
        LATITUDE : Decimal,
        LONGITUDE : Decimal
    ) returns array of AddressSrv;

    action updateEmployee(
        ID : UUID,
        salaryAmount : common.AmountT,
        Currency_code : String(3)
    ) returns String;

    action UpdatePrice(
        ID : UUID,
        salaryAmount : Decimal(15,2),
        Currency_code : String
    );

    action createProduct(
        NODE_KEY : common.Guid,
        PRODUCT_ID : common.String32,
        TYPE_CODE : String(2),
        CATEGORY : common.String32,
        DESCRIPTION : common.String255,
        TAX_TARIF_CODE : Integer,
        MEASURE_UNIT : String(2),
        WEIGHT_MEASURE : Decimal(5,2),
)}