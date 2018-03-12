#!/bin/bash
git clone git@github.com:odoo/enterprise --depth=1
git clone git@github.com:Trust-Code/odoo-brasil --depth=1
git clone git@github.com:openeducat/openeducat_erp.git openeducat_erp --depth=1
git clone git@github.com:odoo/odoo --depth=1
cp -r ./odoo/addons ./odoo/odoo