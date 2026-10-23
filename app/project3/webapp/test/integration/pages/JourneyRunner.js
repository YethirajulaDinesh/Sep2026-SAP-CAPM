sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"project3/test/integration/pages/PurchaseOrderSrvList.gen",
	"project3/test/integration/pages/PurchaseOrderSrvObjectPage.gen"
], function (JourneyRunner, PurchaseOrderSrvListGenerated, PurchaseOrderSrvObjectPageGenerated) {
    'use strict';

    const runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('project3') + '/test/flp.html#app-preview',
        pages: {
			onThePurchaseOrderSrvListGenerated: PurchaseOrderSrvListGenerated,
			onThePurchaseOrderSrvObjectPageGenerated: PurchaseOrderSrvObjectPageGenerated
        },
        async: true
    });

    return runner;
});

