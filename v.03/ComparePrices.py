#!/usr/bin/env python
# -*- coding: utf-8 -*-
from robot.libraries.BuiltIn import BuiltIn

class ComparePrices:
    """
    Custom library to demonstrate features from Robot Framework
    """
    def compare_prices_against(self, price, compared_price):
        """
        Format and compare values return if price is lower the compared_price
        """
        price = price.strip().replace('R$ ', '').replace(',', '.')
        if not price:
            return False
        price = float(price)
        if price < float(compared_price):
            return True
        else:
            return False
