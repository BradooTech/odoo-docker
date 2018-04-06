#!/bin/bash
git clone https://github.com/BradooTech/odoo-brasil.git --depth=1
git clone https://github.com/odoo/odoo.git --depth=1
cp -r ./odoo/addons ./odoo/odoo
