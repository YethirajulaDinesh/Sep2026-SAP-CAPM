/*using CatalogService as service from '../../srv/cat-service';
annotate service.PurchaseOrderSrv with @(
    UI.FieldGroup #GeneratedGroup : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : GROSS_AMOUNT,
            },
            {
                $Type : 'UI.DataField',
                Value : NET_AMOUNT,
            },
            {
                $Type : 'UI.DataField',
                Value : TAX_AMOUNT,
            },
            {
                $Type : 'UI.DataField',
                Label : 'CURRENCY_code',
                Value : CURRENCY_code,
            },
            {
                $Type : 'UI.DataField',
                Value : LIFECYCLE_STATUS,
            },
            {
                $Type : 'UI.DataField',
                Value : OVERALL_STATUS,
            },
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'GeneratedFacet1',
            Label : 'General Information',
            Target : '@UI.FieldGroup#GeneratedGroup',
        },
    ],
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : GROSS_AMOUNT,
        },
        {
            $Type : 'UI.DataField',
            Value : NET_AMOUNT,
        },
        {
            $Type : 'UI.DataField',
            Value : TAX_AMOUNT,
        },
        {
            $Type : 'UI.DataField',
            Label : 'CURRENCY_code',
            Value : CURRENCY_code,
        },
        {
            $Type : 'UI.DataField',
            Value : LIFECYCLE_STATUS,
        },
    ],
);

annotate service.PurchaseOrderSrv with {
    PARTNER @Common.ValueList : {
        $Type : 'Common.ValueListType',
        CollectionPath : 'BusinessPartnerSrv',
        Parameters : [
            {
                $Type : 'Common.ValueListParameterInOut',
                LocalDataProperty : PARTNER_NODE_KEY,
                ValueListProperty : 'NODE_KEY',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'BP_ROLE',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'EMAIL',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'MOBILE',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'FAX',
            },
        ],
    }
};*/

using CatalogService as service from '../../srv/cat-service';




annotate service.PurchaseOrderSrv with {

    PO_ID @(
        Common.Text : COMPANY_NAME,
        Common.ValueList : {
            Label : 'Purchase Order',
            CollectionPath : 'PurchaseOrderSrv',
            SearchSupported : true,
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : PO_ID,
                    ValueListProperty : 'PO_ID'
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'COMPANY_NAME'
                }
            ]
        }
    );

    LSTEXT @(
        Common.ValueList : {
            Label : 'Lifecycle Status',
            CollectionPath : 'PurchaseOrderSrv',
            SearchSupported : true,
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : LSTEXT,
                    ValueListProperty : 'LSTEXT'
                }
            ]
        }
    );

    OSTEXT @(
        Common.ValueList : {
            Label : 'Overall Status',
            CollectionPath : 'PurchaseOrderSrv',
            SearchSupported : true,
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : OSTEXT,
                    ValueListProperty : 'OSTEXT'
                }
            ]
        }
    );

    COMPANY_NAME @(
        Common: {
            Text : COMPANY_NAME,
            ValueList : {
                Label : 'Company Name',
                CollectionPath : 'BusinessPartnerSrv',
                SearchSupported : True,
                Parameters : [{
                    $Type              : 'Common.ValueListParameterOut',
                    LocalDataProperty  : 'BP_ID',
                    ValueListProperty  : 'BP_ID'
                },{
                    $Type              : 'Common.ValueListParameterOut',
                    LocalDataProperty  : 'COMPANY_NAME',
                    ValueListProperty  : 'COMPANY_NAME'
                }]
            }
        }
    );

     partnerCountryDesc      @(Common: {
        Text     : COUNTRY,
        ValueList: {
            Label          : 'Country',
            CollectionPath : 'CountrySrv',
            SearchSupported: true,
            Parameters     : [{
                $Type            : 'Common.ValueListParameterOut',
                LocalDataProperty: 'partnerCountryDesc',
                ValueListProperty: 'description'
            }]
        }
    });
};



annotate service.PurchaseItemsSrv with @(

    Aggregation.ApplySupported : {

        Transformations       : [

            'aggregate',

            'groupby',

            'filter',

            'orderby',

            'top',

            'skip'

        ],

        GroupableProperties   : [

            PO_ITEM_POS,

            PRODUCT_NODE_KEY,

            CURRENCY_code

        ],

        AggregatableProperties: [

            { Property: GROSS_AMOUNT }

        ]

    },
 
    Analytics.AggregatedProperty #sumGross : {

        Name                 : 'sumGross',

        AggregationMethod    : 'sum',

        AggregatableProperty : GROSS_AMOUNT,

        ![@Common.Label]     : 'Gross Amount'

    },
 
    UI.Chart : {

        Title              : 'Gross Amount per Item',

        ChartType          : #Column,

        Dimensions         : [ PO_ITEM_POS ],

        DimensionAttributes: [

            { Dimension: PO_ITEM_POS, Role: #Category }

        ],

        DynamicMeasures    : [ '@Analytics.AggregatedProperty#sumGross' ],

        MeasureAttributes  : [

            { DynamicMeasure: '@Analytics.AggregatedProperty#sumGross', Role: #Axis1 }

        ]

    }

);

 annotate CatalogService.PurchaseItemsSrv with {
    GROSS_AMOUNT @Semantics.amount.currencyCode: 'CURRENCY_code';
    NET_AMOUNT   @Semantics.amount.currencyCode: 'CURRENCY_code';
    TAX_AMOUNT   @Semantics.amount.currencyCode: 'CURRENCY_code';
};


annotate service.PurchaseOrderSrv with @(
    UI.SelectionFields           : [
        PO_ID,
        COMPANY_NAME,
        LSTEXT,
        OSTEXT,
        partnerCountryDesc
    ],

    UI.LineItem                  : [
        {
            $Type : 'UI.DataFieldForAction',
            Action: 'CatalogService.EntityContainer/createPurchaseOrder',
            Label : 'Create'
        },
        {
            $Type : 'UI.DataFieldForAction',
            Action: 'CatalogService.EntityContainer/updatePurchaseOrder',
            Label : 'Update'
        },
        {
            $Type : 'UI.DataFieldForAction',
            Action: 'CatalogService.EntityContainer/deletePurchaseOrder',
            Label : 'Delete'
        },
        {
            $Type: 'UI.DataField',
            Value: PO_ID
        },
        {
            $Type: 'UI.DataField',
            Value: COMPANY_NAME
        },
        {
            $Type: 'UI.DataField',
            Value: GROSS_AMOUNT
        },
        {
            $Type: 'UI.DataField',
            Value: CURRENCY_code
        },
        {
            $Type : 'UI.DataFieldForAction',
            Action: 'CatalogService.discountPrice',
            Label : 'Discount',
            Inline: true
        },

        /*{
            $Type : 'UI.DataFieldForAction',
            Action : 'CatalogService.EntityContainer/createEmployee',
            Label : 'Create Employee'
        }, */

        {
            $Type      : 'UI.DataField',
            Value      : LSTEXT,
            Criticality: LSC
        },
        {
            $Type      : 'UI.DataField',
            Value      : OSTEXT,
            Criticality: OSC
        },

        {
            $Type: 'UI.DataField',
            Value: NET_AMOUNT
        },
        {
            $Type: 'UI.DataField',
            Value: TAX_AMOUNT
        },
        {
            $Type: 'UI.DataField',
            Value: partnerCountryDesc
        },
        {
            $Type: 'UI.DataField',
            Value: CITY
        }
    ],

    UI.HeaderInfo                : {
        TypeName      : 'Purchase Order',
        TypeNamePlural: 'Purchase Orders',
        Title         : {
            $Type: 'UI.DataField',
            Value: PO_ID
        },
        Description   : {
            $Type: 'UI.DataField',
            Value: COMPANY_NAME
        },
        ImageUrl      : 'https://i.pinimg.com/736x/46/97/d5/4697d53c83152a902cb3917d12b77315.jpg'


    },

    UI.HeaderFacets              : [
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Purchase Order Details',
            Target: '@UI.FieldGroup#POInfo'
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Company Information',
            Target: '@UI.FieldGroup#CompanyInfo'
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Contact Information',
            Target: '@UI.FieldGroup#ContactInfo'
        }
    ],

    UI.FieldGroup #POInfo        : {Data: [
        {
            $Type: 'UI.DataField',
            Value: PO_ID
        },
        {
            $Type: 'UI.DataField',
            Value: COMPANY_NAME
        }
    ]},

    UI.FieldGroup #CompanyInfo   : {Data: [
        {
            $Type: 'UI.DataField',
            Value: partnerName
        },
        {
            $Type: 'UI.DataField',
            Value: BP_ROLE
        }
    ]},

    UI.FieldGroup #ContactInfo   : {Data: [
        {
            $Type: 'UI.DataField',
            Value: MOBILE
        },
        {
            $Type: 'UI.DataField',
            Value: EMAIL
        }
    ]},

    UI.Facets                    : [
        {
            $Type : 'UI.CollectionFacet',
            Label : 'Other Details',
            Facets: [

                {
                    $Type : 'UI.ReferenceFacet',
                    Label : 'Price Details',
                    Target: '@UI.FieldGroup#PriceDetails'
                },

                {
                    $Type : 'UI.ReferenceFacet',
                    Label : 'Address Details',
                    Target: '@UI.FieldGroup#AddressDetails'
                },
                 {
                    $Type : 'UI.ReferenceFacet',
                    Label : 'PurchaseOrders Analysis',
                    Target: 'Items/@UI.Chart'
                }

            ]
        },
        {
            $Type  : 'UI.ReferenceFacet',
            Label  : 'Status Overview',
            Target : '@UI.Chart'
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Purchase Item Details',
            Target: 'Items/@UI.LineItem'
        }
    ],

    UI.FieldGroup #PriceDetails  : {Data: [
        {
            $Type: 'UI.DataField',
            Label: 'Gross Amount',
            Value: GROSS_AMOUNT
        },
        {
            $Type: 'UI.DataField',
            Label: 'Net Amount',
            Value: NET_AMOUNT
        },

        {
            $Type: 'UI.DataField',
            Label: 'Tax Amount',
            Value: TAX_AMOUNT
        },
        {
            $Type: 'UI.DataField',
            Label: 'Currency Code',
            Value: CURRENCY_code
        }
    ]},

    UI.FieldGroup #AddressDetails: {Data: [
        {
            $Type: 'UI.DataField',
            Label: 'Company Name',
            Value: COMPANY_NAME
        },
        {
            $Type: 'UI.DataField',
            Label: 'Building',
            Value: BUILDING
        },
        {
            $Type: 'UI.DataField',
            Label: 'Street',
            Value: STREET
        },
        {
            $Type: 'UI.DataField',
            Label: 'City',
            Value: CITY
        },
        {
            $Type: 'UI.DataField',
            Label: 'Postal Code',
            Value: POSTAL_CODE
        },
        {
            $Type: 'UI.DataField',
            Label: 'Country',
            Value: COUNTRY
        },

    ]}


);

annotate service.PurchaseItemsSrv with @(
 
    UI.SelectionFields : [
        PO_ITEM_POS,
        PRODUCT_NODE_KEY
    ],

    UI.Identification : [
        {
            $Type : 'UI.DataFieldForAction',
            Action : 'CatalogService.EntityContainer/createproduct',
            Label : 'Create'
        },
        {
            $Type : 'UI.DataFieldForAction',
            Action : 'CatalogService.EntityContainer/updateproduct',
            Label : 'Update'
        },
        {
            $Type : 'UI.DataFieldForAction',
            Action : 'CatalogService.EntityContainer/deleteproduct',
            Label : 'Delete'
        }
    ],
 
    UI.LineItem : [
        {
            $Type : 'UI.DataFieldForAction',
            Action: 'CatalogService.EntityContainer/createPurchaseItem',
            Label : 'Create'
        },
        {
            $Type : 'UI.DataFieldForAction',
            Action: 'CatalogService.EntityContainer/updatePurchaseItem',
            Label : 'Update'
        },
        {
            $Type : 'UI.DataFieldForAction',
            Action: 'CatalogService.EntityContainer/deletePurchaseItem',
            Label : 'Delete'
        },
        {
            $Type : 'UI.DataField',
            Value : PO_ITEM_POS
        },
        {
            $Type : 'UI.DataField',
            Value : PRODUCT_NODE_KEY
        },
        {
            $Type : 'UI.DataField',
            Value : GROSS_AMOUNT
        },
        {
            $Type : 'UI.DataField',
            Value : NET_AMOUNT
        },
        {
            $Type : 'UI.DataField',
            Value : TAX_AMOUNT
        }
    ],
    UI.HeaderInfo : {
        TypeName : 'Purchase Items',
        TypeNamePlural : 'Purchase Items',
        Title : {
            $Type : 'UI.DataField',
            Value : PO_ITEM_POS
        },
        Description : {
            $Type : 'UI.DataField',
            Value : PRODUCT.DESCRIPTION
        },
        ImageUrl: 'https://i.pinimg.com/736x/46/97/d5/4697d53c83152a902cb3917d12b77315.jpg'
    },
UI.Facets : [
    {
        $Type : 'UI.CollectionFacet',
        Label : 'Purchase Item Information',
 
        Facets : [
            {
                $Type : 'UI.ReferenceFacet',
                Label : 'Purchase Order Details',
                Target : '@UI.FieldGroup#PurchaseOrderInfo'
            },
            {
                $Type : 'UI.ReferenceFacet',
                Label : 'Product Details',
                Target : '@UI.FieldGroup#ProductInfo'
            }
        ]
    }
],
 
UI.FieldGroup #PurchaseOrderInfo : {
    Data : [
        {
            $Type : 'UI.DataField',
            Label : 'Purchase Item Position',
            Value : PO_ITEMS_POS
        },
        {
            $Type : 'UI.DataField',
            Label : 'Gross Amount',
            Value : GROSS_AMOUNT
        },
        {
            $Type : 'UI.DataField',
            Label : 'Net Amount',
            Value : NET_AMOUNT
        },
        {
            $Type : 'UI.DataField',
            Label : 'Tax Amount',
            Value : TAX_AMOUNT
        }
    ]
},
 
UI.FieldGroup #ProductInfo : {
    Data : [
        {
            $Type : 'UI.DataField',
            Label : 'Product ID',
            Value : PRODUCT.PRODUCT_ID
        },
        {
            $Type : 'UI.DataField',
            Label : 'Description',
            Value : PRODUCT.DESCRIPTION
        },
        {
            $Type : 'UI.DataField',
            Label : 'Category',
            Value : PRODUCT.CATEGORY
        },
        {
            $Type : 'UI.DataField',
            Label : 'Price',
            Value : PRODUCT.PRICE
        },
        {
            $Type : 'UI.DataField',
            Label : 'Code Type',
            Value : PRODUCT.TYPE_CODE
        },
        {
            $Type : 'UI.DataField',
            Label : 'Measure Unit',
            Value : PRODUCT.MEASURE_UNIT
        },
        {
            $Type : 'UI.DataField',
            Label : 'Weight Measure',
            Value : PRODUCT.WEIGHT_MEASURE
        },
        {
            $Type : 'UI.DataField',
            Label : 'Weight Unit',
            Value : PRODUCT.WEIGHT_UNIT
        },
        {
            $Type : 'UI.DataField',
            Label : 'Width',
            Value : PRODUCT.WIDTH
        },
        {
            $Type : 'UI.DataField',
            Label : 'Depth',
            Value : PRODUCT.DEPTH
        },
        {
            $Type : 'UI.DataField',
            Label : 'Height',
            Value : PRODUCT.HEIGHT
        }
    ]
}
);
 