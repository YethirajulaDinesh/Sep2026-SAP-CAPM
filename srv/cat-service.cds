using {poapplication.db as databae} from '../db/schema2';
using {poapplication.common2 as common} from '../db/common2';

service CatalogService @(require : 'authenticated-user')  {

    //Master data which is in Master Context
    @Capabilities: {
        InsertRestrictions.Insertable: true,
        UpdateRestrictions.Updatable : true,
        DeleteRestrictions.Deletable : true,
        ReadRestrictions.Readable    : true
    }
    // entity EmployeeSrv as projection on databae.master.Employees;

    // entity ProductSrv as projection on databae.master.Products;

    entity BusinessPartnerSrv as projection on databae.master.BusinessPartners;

    entity CountrySrv         as projection on databae.Countries;

    entity AddressSrv         as projection on databae.master.Addresses;

    //Transactional data which is in Transaction Context
    //entity PurchaseOrderSrv as projection on databae.transaction.PurchaseOrders;

    //    entity PurchaseItemSrv as projection on databae.transaction.PurchaseItems;


    //    type createEmployeeIP : array of {
    //     Currency_code : String(3);
    //     ID            : UUID;
    //     accountNumber : common.String32;
    //     bankId        : String(16);
    //     bankName      : common.String64;
    //     email         : common.Email;
    //     gender        : common.Gender;
    //     language      : String(2);
    //     loginName     : String(16);
    //     nameFirst     : common.String64;
    //     nameInitials  : common.String64;
    //     nameLast      : common.String64;
    //     nameMiddle    : common.String64;
    //     phoneNumber   : common.PhoneNumber;
    //     salaryAmount  : common.AmountT;
    // }

    action   createEmployee(Currency_code: String(3),
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
                            salaryAmount: common.AmountT)      returns array of EmployeeSrv;

    action   createAddress(NODE_KEY: common.Guid,
                           ADDRESS_TYPE: common.String32,
                           VAL_START: Date,
                           VAL_END: Date,
                           LATITUDE: Decimal,
                           LONGITUDE: Decimal,
                           STREET: common.String255,
                           POSTAL_CODE: String(12),
                           CITY: common.String255,
                           COUNTRY: common.String255,
                           BUILDING: common.String255)         returns array of AddressSrv;


    action   createProduct(NODE_KEY: common.Guid,
                           PRODUCT_ID: common.String32,
                           TYPE_CODE: String(2),
                           CATEGORY: common.String32,
                           DESCRIPTION: common.String255,
                           TAX_TARIF_CODE: Integer,
                           MEASURE_UNIT: String(2),
                           WEIGHT_MEASURE: Decimal(5, 2),
                           WEIGHT_UNIT: String(2),
                           PRICE: Decimal(15, 2),
                           CURRENCY_CODE: String(5),
                           WIDTH: Decimal(5, 2),
                           DEPTH: Decimal(5, 2),
                           HEIGHT: Decimal(5, 2),
                           DIM_UNIT: String(2))                returns array of ProductSrv;

    action   updateProduct(NODE_KEY: common.Guid,
                           PRICE: Decimal(15, 2))              returns String;


    // Custom Function Declaration
    function getHighestSalariedEmployees()                     returns array of EmployeeSrv;

    function getHighestPricedProduct()                         returns array of ProductSrv;

    entity PurchaseItemsSrv   as projection on databae.transaction.PurchaseItems;

    // action createEmployee(input: createEmployeeIP) returns String;

    action   updateEmployee(ID: UUID,
                            salaryAmount: common.AmountT,
                            Currency_code: String(3))          returns String;

    action   deleteEmployee(ID: UUID)                          returns String;

    action   createPurchaseOrder(PO_ID: UUID,
                                 GROSS_AMOUNT: Decimal(15, 2),
                                 NET_AMOUNT: Decimal(15, 2),
                                 TAX_AMOUNT: Decimal(15, 2),
                                 CURRENCY_code: String(3))     returns String;

    action   updatePurchaseOrder(NODE_KEY: UUID,
                                 GROSS_AMOUNT: Decimal(15, 2)) returns String;

    action   deletePurchaseOrder(NODE_KEY: UUID)               returns String;

    action   createPurchaseItem(ITEM_ID: UUID,
                                PO_ID: UUID,
                                GROSS_AMOUNT: Decimal(15, 2),
                                NET_AMOUNT: Decimal(15, 2),
                                TAX_AMOUNT: Decimal(15, 2),
                                CURRENCY_code: String(3))      returns String;

    action   updatePurchaseItem(NODE_KEY: UUID,
                                GROSS_AMOUNT: Decimal(15, 2),
                                NET_AMOUNT: Decimal(15, 2),
                                TAX_AMOUNT: Decimal(15, 2))    returns String;

    action   deletePurchaseItem(NODE_KEY: UUID)                returns String;


    @Capabilities: {
        DeleteRestrictions: {
            $Type    : 'Capabilities.DeleteRestrictionsType',
            Deletable: false
        },
        UpdateRestrictions: {
            $Type    : 'Capabilities.UpdateRestrictionsType',
            Updatable: false
        },
        InsertRestrictions: {
            $Type     : 'Capabilities.InsertRestrictionsType',
            Insertable: false
        },
    }

    entity PurchaseOrderSrv   as
        select from databae.transaction.PurchaseOrders as po
        inner join databae.master.BusinessPartners as bp
            on bp.NODE_KEY = po.PARTNER.NODE_KEY
        inner join databae.master.Addresses as addr
            on addr.NODE_KEY = bp.AD.NODE_KEY
        inner join databae.Countries as country
            on addr.COUNTRY = country.code
        inner join databae.BPRoleFltr as role
            on bp.BP_ROLE = role.code
        {
            key po.NODE_KEY,
                po.PO_ID,
                po.GROSS_AMOUNT,
                po.NET_AMOUNT,
                po.TAX_AMOUNT,
                po.CURRENCY,
                bp.COMPANY_NAME,
                bp.BP_ID,
                role.description    as BP_ROLE,
                bp.MOBILE,
                bp.FAX,
                bp.EMAIL,
                bp.WEB,
                addr.ADDRESS_TYPE,
                addr.BUILDING,
                addr.CITY,
                addr.COUNTRY,
                addr.LATITUDE,
                addr.LONGITUDE,
                addr.STREET,
                addr.POSTAL_CODE,
                po.Items,
                bp.COMPANY_NAME     as partnerName,
                bp.BP_ID            as partnerId,
                addr.COUNTRY        as partnerCountry,
                country.description as partnerCountryDesc  @(title: '{i18n>COUNTRY}'),

                case
                    po.LIFECYCLE_STATUS
                    when 'N'
                         then 2
                    when 'S'
                         then 3
                    when 'C'
                         then 3
                    else 1
                end                 as LSC    : Integer,
                case
                    po.OVERALL_STATUS
                    when 'R'
                         then 1
                    when 'P'
                         then 3
                    when 'D'
                         then 3
                    else 2
                end                 as OSC    : Integer,

                case
                    po.LIFECYCLE_STATUS
                    when 'N'
                         then 'Not Started'
                    when 'S'
                         then 'Started'
                    when 'C'
                         then 'Completed'
                    else 'Cancelled'
                end                 as LSTEXT : String(20) @(title: '{i18n>LIFECYCLE_STATUS}'),
                case
                    po.OVERALL_STATUS
                    when 'R'
                         then 'Returned'
                    when 'P'
                         then 'Processed'
                    when 'D'
                         then 'Delivered'
                    else 'New'
                end                 as OSTEXT : String(20) @(title: '{i18n>OVERALL_STATUS}'),

        }
        actions {
            action   discountPrice() returns array of PurchaseOrderSrv;
            function largestOrder()  returns array of PurchaseOrderSrv;
        };

    entity ProductSrv         as
        projection on databae.master.Products {
            *
        }
        actions {
            action   increasePrice() returns array of ProductSrv;
            function top20Products() returns array of ProductSrv;
        };


    entity EmployeeSrv        as
        projection on databae.Employees {
            *
        }
        actions {
            action   increaseSalary()           returns EmployeeSrv;
            function top20HighestPaidEmployee() returns array of EmployeeSrv;
        };

    action   createproduct(PRODUCT_ID: String(32),
                           TYPE_CODE: String(2),
                           CATEGORY: String(32),
                           DESCRIPTION: String(255),
                           PRICE: Decimal(15, 2))              returns array of ProductSrv;

    action   updateproduct(PRODUCT_ID: String(32),
                           PRICE: Decimal(15, 2),
                           DESCRIPTION: String(255))           returns String;

    action   deleteproduct(PRODUCT_ID: String(32))             returns String;

    function getUtilities()                                    returns String;

}
