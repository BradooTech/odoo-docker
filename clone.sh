#!/bin/bash
git clone https://github.com/odoo/enterprise --depth=1
git clone https://github.com/bradootech/odoo-brasil --depth=1
git clone https://github.com/odoo/odoo --depth=1
cp -r ./odoo/addons ./odoo/odoo