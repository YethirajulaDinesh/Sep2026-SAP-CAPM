sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"project2/test/integration/pages/EmployeeSrvList.gen",
	"project2/test/integration/pages/EmployeeSrvObjectPage.gen"
], function (JourneyRunner, EmployeeSrvListGenerated, EmployeeSrvObjectPageGenerated) {
    'use strict';

    const runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('project2') + '/test/flp.html#app-preview',
        pages: {
			onTheEmployeeSrvListGenerated: EmployeeSrvListGenerated,
			onTheEmployeeSrvObjectPageGenerated: EmployeeSrvObjectPageGenerated
        },
        async: true
    });

    return runner;
});

