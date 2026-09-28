const cds = require('@sap/cds');

const { uuid, exists, decodeURI, isdir, read } = cds.utils;

module.exports = cds.service.impl(async function () {

    const {
        EmployeeSrv,
        AddressSrv,
        ProductSrv
    } = this.entities;

    // Employee Salary Validation
    this.before('UPDATE', EmployeeSrv, async (req) => {

        const salaryAmt = req.data.salaryAmount;

        if (salaryAmt > 15000) {
            req.error(
                500,
                'Please get the approval from your line manager.'
            );
        }
    });

    // Phone Number Validation
    this.before('UPDATE', EmployeeSrv, async (req) => {

        const tx = cds.tx(req);

        const employee = await tx.run(
            SELECT.one
                .from(EmployeeSrv)
                .where({ ID: req.data.ID })
        );

        if (!employee) {
            req.error(404, 'Employee not found');
            return;
        }

        if (req.data.phoneNumber) {

            if (
                employee.Currency_code !== 'USA' &&
                employee.Currency_code !== 'GB'
            ) {
                req.error(
                    400,
                    'Phone number can be updated only for USA or GB employees.'
                );
            }
        }
    });

    // Create Employee
    this.on('createEmployee', async (req) => {

        const data = req.data;
        const tx = cds.tx(req);

        await tx.run(
            INSERT.into(EmployeeSrv).entries(data)
        );

        return data;
    });

    // Update Employee
    this.on('updateEmployee', async (req) => {

        const {
            ID,
            salaryAmount,
            Currency_code
        } = req.data;

        const tx = cds.tx(req);

        await tx.update(EmployeeSrv)
            .with({
                salaryAmount,
                Currency_code
            })
            .where({
                ID
            });

        return 'Successfully updated';
    });

    // Create Product
    this.on('createProduct', async (req) => {

        const tx = cds.tx(req);

        await tx.run(
            INSERT.into(ProductSrv)
                .entries(req.data)
        );

        return req.data;
    });

    // Product Validation
    this.before('UPDATE', ProductSrv, async (req) => {

        const price = req.data.PRICE;

        if (price > 2000) {
            req.error(
                400,
                'Get approval from Product Manager'
            );
        }
    });

    // Top 10 Employees
    this.on('getHighestSalariedEmployees', async (req) => {

        const tx = cds.tx(req);

        return await tx.read(EmployeeSrv)
            .orderBy({
                salaryAmount: 'desc'
            })
            .limit(10);
    });

    // Delete Employee
    this.on('deleteEmployee', async (req) => {

        const { ID } = req.data;

        const tx = cds.tx(req);

        await tx.delete(EmployeeSrv)
            .where({
                ID
            });

        return 'Successfully deleted';
    });

    // Top 20 Employees
    this.on('IncreaseSal', async (req) => {

        const { ID } = req.params[0];
        const tx = cds.tx(req);

        const employee = await tx.read(EmployeeSrv).where({ ID });

        const newSalary = employee[0].salaryAmount * 1.10;

        await tx.update(EmployeeSrv)
            .with({ salaryAmount: newSalary })
            .where({ ID });

        return await tx.read(EmployeeSrv).where({ ID });
    });

    // Increase Salary Action
    this.on('top20Employees', async (request, response) => {
        try {
            //step -1 create an object for the transaction
            const transaction = cds.tx(request);

            //step-2 : Get salaries of an employee using Transaction object
            const result = await transaction.read(EmployeeSrv).orderBy({
                salaryAmount: 'desc'

            }).limit(20);

            //step-3 : Display the employee salaries
            return result;

        }
        catch (error) {
            request.error("Error :", error)
        }
    });

    this.on('getUtilities', async (req) => {
        let vUUID = uuid(),
            vpackageContent = null,
            vInput = "%3525#",
            uri,
            dirExists = false,
            isFileExists = false;
        if (await exists('srv/request.http')) {
            isFileExists = true;
        }
        if (await isdir('app')) {
            dirExists = true;
        }
        try {
            uri = decodeURI(vInput);
            await mkdirp('srv/lib');
        } catch (err) {
            uri = vInput;
        }
        vpackageContent = await cds.utils.read('package.json');
        return {
            uuid: vUUID,
            uri: uri,
            isFileExists: isFileExists,
            dirExists: dirExists,
            description: "DINESH",
            packageInfo: vpackageContent
        };
    });


})