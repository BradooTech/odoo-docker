#!/bin/bash
git clone https://github.com/Trust-Code/odoo-brasil -b 10.0 --depth=1
git clone https://github.com/odoo/odoo -b 10.0 --depth=1
cp -r ./odoo/addons ./odoo/odoo