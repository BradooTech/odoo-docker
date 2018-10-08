#!/bin/bash
git clone https://github.com/BradooTech/odoo-brasil.git -b 11.0 --depth=1
git clone https://github.com/odoo/odoo.git -b 11.0 --depth=1
cp -r ./odoo/addons ./odoo/odoo
